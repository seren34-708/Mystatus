//
//  SelectLevelViewController.swift
//  Quiz
//
//  Created by matuda naoya on 2021/10/12.
//

import UIKit

class SelectLevelViewController: UIViewController {
    @IBOutlet weak var display_date: UIButton!
    var argString = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        display_date.setTitle(argString, for: .normal)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // segueのIDを確認して特定のsegueのときのみ動作させる
            if segue.identifier == "toCalenderViewController" {
                // 遷移先のViewControllerを取得
                let next = segue.destination as? CalenderViewController
                // 遷移先のプロパティに処理ごと渡す
                next?.resultHandler = { text in
                    // 引数を使ってoutputLabelの値を更新する処理
                    self.display_date.setTitle(text, for: .normal)
                }
            }
        }
    
    @IBAction func buckButton(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
}
