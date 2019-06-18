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
        typeTableView.delegate = self
        
        if result.superiority == selectedTypes {
            titleLabel.text = "せいかい"
            db.collection(quizPokeType.key).addDocument(data: [Keys.document: true])
            
            guard let quizViewController = presentingViewController as? QuizViewController else { fatalError() }
            quizViewController.correctCount += 1
        } else {
            titleLabel.text = "ざんねん"
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}

extension ResultViewController: UITableViewDelegate {
 
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.header.identifier) as? HeaderTableViewCell else { return nil }
        cell.set(title: "\(quizPokeType.title) へはこれが効果抜群だ！")
        return cell.contentView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
}

final class HeaderTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    func set(title: String) {
        titleLabel.text = title
    }
    
}

final class TypeTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    func set(type: PokeType) {
        titleLabel.text = type.title
        titleLabel.backgroundColor = type.color
    }
    
}
