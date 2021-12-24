//
//  ViewController.swift
//  Quiz
//
//  Created by matuda naoya on 2021/10/02.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var current_time: UILabel!
    
    var mytimer : Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        startButton.layer.borderWidth = 2
        startButton.layer.borderColor = UIColor.black.cgColor
      
        timecheck()
        mytimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timecheck), userInfo: nil, repeats: true)
    }
    
    @objc func timecheck(){
        let date = Date()
        let formatterJP = DateFormatter()
        formatterJP.dateFormat = DateFormatter.dateFormat(fromTemplate: "HH:mm:ss", options: 0, locale: Locale(identifier: "ja_JP"))
        formatterJP.timeZone = TimeZone(identifier:  "Asia/Tokyo")
        current_time.text = (formatterJP.string(from: date))
    }
}
