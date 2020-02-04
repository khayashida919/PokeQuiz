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

    var modeType: Mode = .advanced
    
    @IBOutlet private weak var bannerView: GADBannerView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var typeTableView: UITableView!
    
    var success: Int = 0   //サーバ上の問題回答に成功した合計回数 Quiz画面から値を上書きされる想定
    var failure: Int = 0   //サーバ上の問題回答に失敗した合計回数 Quiz画面から値を上書きされる想定
    
    var quizPokeType: PokeType!
    var result: PokeResult!
    var selectedTypes: Set<PokeType>!
    var reload: (() -> Void)?
    var countup: ((Bool) -> Void)?
    
    private let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bannerView.start(viewController: self, id: Keys.BannerUnitID.resultViewController)
        
        typeTableView.dataSource = self
        typeTableView.delegate = self
        
        judgment()
    }

    @IBAction private func doneButtonAction(_ sender: RoundButton) {
        dismiss(animated: true) {
            self.reload?()
        }
    }
    
    private func judgment() {
        var judg: Bool
        switch modeType {
        case .beginner:
            //選んだ相性かつ正解の相性の個数が1以上の場合にtrue
            judg = result.superiority.intersection(selectedTypes) >= 1
        case .intermediate:
            //選んだ相性かつ正解の相性の個数が3以上の場合にtrue
            judg = result.superiority.intersection(selectedTypes) >= 3
        case .advanced:
            //選んだ相性が正解の相性ちと完全一致している場合true
            judg = result.superiority == selectedTypes
        }
        if judg {
            titleLabel.text = R.string.localizable.good()

            db.collection(quizPokeType.key).document(Keys.result).setData(
                [Keys.success: success + 1,
                 Keys.failure: failure]
            )
            countup?(true)
        } else {
            titleLabel.text = R.string.localizable.bad()
            db.collection(quizPokeType.key).document(Keys.result).setData(
                [Keys.success: success,
                 Keys.failure: failure + 1]
            )
            countup?(false)
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
        cell.set(title: R.string.localizable.this_is_excellent_for(quizPokeType.title))
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
