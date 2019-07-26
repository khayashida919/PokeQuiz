//
//  RankingViewController.swift
//  PokeQuiz
//
//  Created by Kazuki Hayashida on 2019/07/26.
//  Copyright © 2019 jp.co.khayashida.ARCompanyCard. All rights reserved.
//

import UIKit

final class RankingViewController: UIViewController {

    @IBOutlet private weak var rankingTableView: UITableView!
    
    var rankings = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setGradiention()
        
        rankingTableView.dataSource = self
    }

}

extension RankingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rankings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let rankingTableViewCell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.typeTableViewCell, for: indexPath) else {
            return UITableViewCell(frame: .zero)
        }
//        return rankingTableViewCell
        return UITableViewCell()
    }
    
    
}

final class RankingTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var rankingImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var pointLabel: UILabel!
    
    func set(type: PokeType) {

    }
    
}
