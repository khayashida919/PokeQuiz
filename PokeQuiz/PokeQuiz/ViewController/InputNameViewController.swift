//
//  InputNameViewController.swift
//  PokeQuiz
//
//  Created by Kazuki Hayashida on 2019/07/29.
//  Copyright © 2019 jp.co.khayashida.ARCompanyCard. All rights reserved.
//

import UIKit
import Firebase

final class InputNameViewController: UIViewController {
    
    @IBOutlet private weak var inputNameTextField: UITextField!
    
    var modeType: Mode = .advanced
    var point: Int!
    var onTap: (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputNameTextField.text = AppData.shared.name
    }
    
    @IBAction func sendRankingAction(_ sender: RoundButton) {
        guard let name = inputNameTextField.text, !name.isEmpty else {
            showAlert(isCancel: false, title: R.string.localizable.confirmation(), message: R.string.localizable.please_enter_your_name())
            return
        }
        
        AppData.shared.name = name
        
        let ranking = User(name: AppData.shared.name,
                              uuid: AppData.shared.uuid,
                              point: point)
        
        Firestore.firestore().collection(Keys.advancedRanking).addDocument(data: ranking.toDictionary())
        dismiss(animated: true) { [weak self] in
            self?.onTap?()
        }
    }
    
    @IBAction func cancelAction(_ sender: RoundButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
