//
//  InputViewController.swift
//  Quiz
//
//  Created by matuda naoya on 2021/12/29.
//

import UIKit

class InputViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
}
