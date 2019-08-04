//
//  CompatibilityViewController.swift
//  PokeQuiz
//
//  Created by Kazuki Hayashida on 2019/08/04.
//  Copyright © 2019 jp.co.khayashida.ARCompanyCard. All rights reserved.
//

import UIKit

final class CompatibilityViewController: UIViewController {

    
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 4.0
        scrollView.delegate = self
        
        navigationItem.title = "相性表"
        setGradiention()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }

    @IBAction func referenceAction(_ sender: UIButton) {
        let alert = UIAlertController(title: "確認", message: "Safariで参考元URLを開きます", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
            UIApplication.shared.open(URL(string: "https://www.pokemon.co.jp/ex/sun_moon/fight/161215_01.html")!)
        })
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

extension CompatibilityViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
}
