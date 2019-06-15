//
//  ResultViewController.swift
//  PokeQuiz
//
//  Created by khayashida on 2019/06/10.
//  Copyright © 2019 jp.co.khayashida.ARCompanyCard. All rights reserved.
//

import UIKit
import Firebase

final class ResultViewController: UIViewController {

    @IBOutlet private weak var bannerView: GADBannerView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var typeTableView: UITableView!
    
    var quizPokeType: PokeType!
    var result: PokeResult!
    var selectedTypes: Set<PokeType>!
    var reload: (() -> Void)?
    
    private let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        typeTableView.dataSource = self
        
        if result.superiority == selectedTypes {
            titleLabel.text = "正解"
            db.collection(quizPokeType.key).addDocument(data: [Keys.document: true])
        } else {
            titleLabel.text = "不正解"
            db.collection(quizPokeType.key).addDocument(data: [Keys.document: false])
        }
    }

    @IBAction private func doneButtonAction(_ sender: RoundButton) {
        dismiss(animated: true) {
            self.reload?()
        }
    }
}

extension ResultViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.superiority.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let typeTableViewCell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.typeTableViewCell, for: indexPath) else {
            return UITableViewCell(frame: .zero)
        }
        typeTableViewCell.set(type: Array(result.superiority)[indexPath.row])
        return typeTableViewCell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(quizPokeType.title)の効果抜群相性"
    }
    
}

final class TypeTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    func set(type: PokeType) {
        titleLabel.text = type.title
        titleLabel.backgroundColor = type.color
    }
    
}
