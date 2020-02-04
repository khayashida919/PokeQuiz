//
//  SelectModeViewController.swift
//  PokeQuiz
//
//  Created by Kazuki Hayashida on 2020/02/04.
//  Copyright © 2020 jp.co.khayashida.ARCompanyCard. All rights reserved.
//

import UIKit

final class SelectModeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = R.string.localizable.select_mode()
        setGradiention()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }

}
