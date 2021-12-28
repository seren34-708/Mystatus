//
//  SelectLevelViewController.swift
//  Quiz
//
//  Created by matuda naoya on 2021/10/12.
//

import UIKit

class SelectLevelViewController: UIViewController {
    @IBOutlet weak var buck_button: UIButton!
    
    var selectTag = 0

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func buck_button(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
}
