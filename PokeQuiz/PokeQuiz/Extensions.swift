//
//  Extensions.swift
//  PokeQuiz
//
//  Created by khayashida on 2019/05/26.
//  Copyright © 2019 jp.co.khayashida.ARCompanyCard. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(isCancel: Bool, title: String, message: String, handler: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: R.string.localized_ja.ok(), style: .default) { (_) in
            handler?()
        }
        alert.addAction(action)
        if isCancel {
            let cancelAction = UIAlertAction(title: R.string.localized_ja.cancel(), style: .cancel, handler: nil)
            alert.addAction(cancelAction)
        }
        present(alert, animated: true, completion: nil)
    }
    
}
