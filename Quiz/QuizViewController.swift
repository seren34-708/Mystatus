//
//  QuizViewController.swift
//  Quiz
//
//  Created by matuda naoya on 2021/10/02.
//

import UIKit
import GoogleMobileAds

class QuizViewController: UIViewController {
    @IBOutlet weak var quizNumberLabel: UILabel!
    @IBOutlet weak var back_button: UIButton!
    
    var bannerView: GADBannerView!
    var csvArray:[String] = []
    var quizArray:[String] = []
    var quizCount = 0
    var correctCount = 0
    var selectLebel = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannerView = GADBannerView(adSize:  GADAdSizeBanner)
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
//        addBannerViewToView(bannerView)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let scoreVC = segue.destination as! ScoreViewController
        scoreVC.correct = correctCount
    }
    
    
    @IBAction func back_button(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }

}
