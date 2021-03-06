//
//  Extensions.swift
//  PokeQuiz
//
//  Created by khayashida on 2019/05/26.
//  Copyright © 2019 jp.co.khayashida.ARCompanyCard. All rights reserved.
//

import UIKit
import Firebase

extension UIViewController {
    
    func showAlert(isCancel: Bool, title: String, message: String, handler: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: R.string.localizable.ok(), style: .default) { (_) in
            handler?()
        }
        alert.addAction(action)
        if isCancel {
            let cancelAction = UIAlertAction(title: R.string.localizable.cancel(), style: .cancel, handler: nil)
            alert.addAction(cancelAction)
        }
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func setGradiention() {
        let gradientLayer: CAGradientLayer = {
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [R.color.bottomBackgroundColor()!.cgColor, R.color.topBackgroundColor()!.cgColor]
            gradientLayer.frame = self.view.bounds
            return gradientLayer
        }()
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}

extension GADBannerView {
    
    func start<T: UIViewController>(viewController: T, id: String) {
        self.adUnitID = id
        self.rootViewController = viewController
        self.load(GADRequest())
    }
    
}

extension UILabel {
    
    @objc var substituteFontName: String {
        get {
            return font.fontName
        }
        set {
            font = UIFont(name: newValue, size: font.pointSize)
        }
    }
    
}
