//
//  GameOverViewController.swift
//  PokeQuiz
//
//  Created by khayashida on 2019/06/16.
//  Copyright © 2019 jp.co.khayashida.ARCompanyCard. All rights reserved.
//

import UIKit
import Firebase

final class GameOverViewController: UIViewController {

    var modeType: Mode = .advanced
    var correctCount: Int!
    
    @IBOutlet private weak var correctCountLabel: UILabel!
    @IBOutlet private weak var sendRankingButton: RoundButton!
    @IBOutlet private weak var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannerView.start(viewController: self, id: Keys.BannerUnitID.gameOverViewController)
        correctCountLabel.text = "\(correctCount.description)pt"
    }
    
    
    @IBAction private func sendRankingAction(_ sender: RoundButton) {
        guard let inputNameViewController = R.storyboard.main.inputNameViewController() else {
            return
        }
        inputNameViewController.modeType = modeType
        inputNameViewController.point = correctCount
        inputNameViewController.onTap = { [weak self] in
            self?.sendRankingButton.setTitle(R.string.localizable.send_complete(), for: .normal)
            self?.sendRankingButton.isEnabled = false
            self?.sendRankingButton.backgroundColor = R.color.pokeBlack()!
        }
        present(inputNameViewController, animated: true, completion: nil)
    }
    
    @IBAction private func menuButtonAction(_ sender: RoundButton) {
        guard let navigationController = presentingViewController as? UINavigationController else {
            return
        }
        dismiss(animated: true) {
            navigationController.popViewController(animated: true)
        }
    }

}
