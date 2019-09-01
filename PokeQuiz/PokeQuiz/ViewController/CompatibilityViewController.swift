//
//  CompatibilityViewController.swift
//  PokeQuiz
//
//  Created by Kazuki Hayashida on 2019/08/04.
//  Copyright © 2019 jp.co.khayashida.ARCompanyCard. All rights reserved.
//

import UIKit
import WebKit
import Firebase

final class CompatibilityViewController: UIViewController {

    @IBOutlet private weak var webView: WKWebView!
    @IBOutlet private weak var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannerView.start(viewController: self, id: Keys.BannerUnitID.compatibilityViewController)
        
        webView.load(URLRequest(url: URL(string: "https://www.pokemon.co.jp/ex/sun_moon/common/images/fight/161215_01/img_01.png")!))
        
        navigationItem.title = R.string.localizable.compatibility_table()
        setGradiention()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }

    @IBAction func referenceAction(_ sender: UIButton) {
        let alert = UIAlertController(title: R.string.localizable.confirmation(), message:  R.string.localizable.open_the_reference_URL_in_Safari(), preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: R.string.localizable.cancel(), style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: R.string.localizable.ok(), style: .default, handler: { _ in
            UIApplication.shared.open(URL(string: "https://www.pokemon.co.jp/ex/sun_moon/fight/161215_01.html")!)
        })
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
