import UIKit

class RecordTimeViewController: UIViewController {

    @IBOutlet weak var activityBtn: UIButton!
    
//    var outputValue : String?
    
    var outputValue:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityBtn.setTitle(outputValue, for: .normal)
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
}
