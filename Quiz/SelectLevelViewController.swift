import UIKit

class SelectLevelViewController: UIViewController {
    @IBOutlet weak var display_date: UIButton!
    var argString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        display_date.setTitle(argString, for: .normal)
    }
    
    
    
    //　遷移先に日付の存在チェック年月日を渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "toCalenderViewController" {
                let next = segue.destination as? CalenderViewController
                next?.resultHandler = { text in
                    self.display_date.setTitle(text, for: .normal)
                    self.argString = text
                    }

                let arr:[String] = argString.components(separatedBy: "/")
                next?.chooseYear = Int(arr[0])!
                next?.chooseMonth = Int(arr[1])!
                next?.chooseDate = Int(arr[2])!
                next?.selection = argString
            }
        }
    
    @IBAction func buckButton(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
}
