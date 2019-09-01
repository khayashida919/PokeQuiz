//
//  SettingTableViewController.swift
//  PokeQuiz
//
//  Created by Kazuki Hayashida on 2019/08/24.
//  Copyright © 2019 jp.co.khayashida.ARCompanyCard. All rights reserved.
//

import UIKit

final class SettingTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradietionImageView: UIView = {
            let gradientLayer: CAGradientLayer = {
                let gradientLayer = CAGradientLayer()
                gradientLayer.colors = [R.color.bottomBackgroundColor()!.cgColor, R.color.topBackgroundColor()!.cgColor]
                gradientLayer.frame = self.tableView.frame
                return gradientLayer
            }()
            let view = UIView(frame: tableView.frame)
            view.layer.insertSublayer(gradientLayer, at: 0)
            return view
        }()
        
        tableView.backgroundView = gradietionImageView
        
        navigationItem.title = R.string.localizable.setting()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func resetHiddenListAction(_ sender: UIButton) {
        showAlert(isCancel: false,
                  title: R.string.localizable.confirmation(),
                  message: R.string.localizable.reset()) {
                    AppData.shared.blockList = [String]()
        }
    }
}
