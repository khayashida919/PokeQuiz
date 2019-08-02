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
    
    var point: Int!
    var onTap: (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputNameTextField.text = AppData.shared.name
    }
    
    @IBAction func sendRankingAction(_ sender: RoundButton) {
        AppData.shared.name = inputNameTextField.text ?? ""
        
        let ranking = Ranking(name: AppData.shared.name,
                              uuid: AppData.shared.uuid,
                              point: "\(point!)")
        
        Firestore.firestore().collection(Keys.ranking).addDocument(data: ranking.toDictionary())
        dismiss(animated: true) { [weak self] in
            self?.onTap?()
        }
    }
    
    @IBAction func cancelAction(_ sender: RoundButton) {
        dismiss(animated: true, completion: nil)
    }
    
}