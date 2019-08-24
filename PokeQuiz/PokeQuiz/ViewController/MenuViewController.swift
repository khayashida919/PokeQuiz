//
//  MenuViewController.swift
//  PokeQuiz
//
//  Created by khayashida on 2019/05/25.
//  Copyright © 2019 jp.co.khayashida.ARCompanyCard. All rights reserved.
//

import UIKit

final class MenuViewController: UIViewController {

    @IBOutlet private weak var versionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        versionLabel.text = "v" + (Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String)
        setGradiention()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
    
}
