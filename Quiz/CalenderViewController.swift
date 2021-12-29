//
//  CalenderViewController.swift
//  Quiz
//
//  Created by matuda naoya on 2021/12/26.
//

import UIKit
import FSCalendar
import CalculateCalendarLogic


class CalenderViewController: UIViewController,FSCalendarDelegate,FSCalendarDataSource,FSCalendarDelegateAppearance{

    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var labelDate: UILabel!
    
    var resultHandler: ((String) -> Void)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.calendarWeekdayView.weekdayLabels[0].text = "日"
        calendar.calendarWeekdayView.weekdayLabels[1].text = "月"
        calendar.calendarWeekdayView.weekdayLabels[2].text = "火"
        calendar.calendarWeekdayView.weekdayLabels[3].text = "水"
        calendar.calendarWeekdayView.weekdayLabels[4].text = "木"
        calendar.calendarWeekdayView.weekdayLabels[5].text = "金"
        calendar.calendarWeekdayView.weekdayLabels[6].text = "土"
        self.calendar.dataSource = self
        self.calendar.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    fileprivate let gregorian: Calendar = Calendar(identifier: .gregorian)
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    // 祝日判定を行い結果を返すメソッド(True:祝日)
    func judgeHoliday(_ date : Date) -> Bool {
        //祝日判定用のカレンダークラスのインスタンス
        let tmpCalendar = Calendar(identifier: .gregorian)

        // 祝日判定を行う日にちの年、月、日を取得
        let year = tmpCalendar.component(.year, from: date)
        let month = tmpCalendar.component(.month, from: date)
        let day = tmpCalendar.component(.day, from: date)

        // CalculateCalendarLogic()：祝日判定のインスタンスの生成
        let holiday = CalculateCalendarLogic()

        return holiday.judgeJapaneseHoliday(year: year, month: month, day: day)
    }
    // date型 -> 年月日をIntで取得
    func getDay(_ date:Date) -> (Int,Int,Int){
        let tmpCalendar = Calendar(identifier: .gregorian)
        let year = tmpCalendar.component(.year, from: date)
        let month = tmpCalendar.component(.month, from: date)
        let day = tmpCalendar.component(.day, from: date)
        return (year,month,day)
    }

    //曜日判定(日曜日:1 〜 土曜日:7)
    func getWeekIdx(_ date: Date) -> Int{
        let tmpCalendar = Calendar(identifier: .gregorian)
        return tmpCalendar.component(.weekday, from: date)
    }

    // 土日や祝日の日の文字色を変える
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        //祝日判定をする（祝日は赤色で表示する）
        if self.judgeHoliday(date){
            return UIColor.red
        }

        //土日の判定を行う（土曜日は青色、日曜日は赤色で表示する）
        let weekday = self.getWeekIdx(date)
        if weekday == 1 {   //日曜日
            return UIColor.red
        }
        else if weekday == 7 {  //土曜日
            return UIColor.blue
        }

        return nil
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition){
        let tmpDate = Calendar(identifier: .gregorian)
        let year = tmpDate.component(.year, from: date)
        let month = tmpDate.component(.month, from: date)
        let day = tmpDate.component(.day, from: date)
        labelDate.text = "\(year)/\(month)/\(day)"
    }
    
    @IBAction func buckButton(_ sender: Any) {
        guard let text = self.labelDate.text else { return }

        // 用意したクロージャに関数がセットされているか確認する
        if let handler = self.resultHandler {
            // 入力値を引数として渡された処理の実行
            handler(text)
        }
        print("CalenderViewController:\(text)")
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func todayButton(_ sender: Any) {
        let date = Date()
        let formatter_date = DateFormatter()
        formatter_date.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy年MM月dd日", options: 0, locale: Locale(identifier: "ja_JP"))
        formatter_date.timeZone = TimeZone(identifier:  "Asia/Tokyo")
        
        if let handler = self.resultHandler {
            handler((formatter_date.string(from: date)))
        }
        self.dismiss(animated: true, completion: nil)
    }
}
