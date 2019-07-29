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

        //テストコード
        rankings.append("@")
        rankings.append("@")
        rankings.append("@")
        rankings.append("@")
        
        navigationItem.title = "ランキング"
        setGradiention()
        
        rankingTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }

}

extension RankingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rankings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let rankingTableViewCell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.rankingTableViewCell, for: indexPath) else {
            return UITableViewCell(frame: .zero)
        }
        rankingTableViewCell.set(order: indexPath.row, name: "T##String", point: 999)
        return rankingTableViewCell
    }
    
}

final class RankingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var orderLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    
    
    func set(order: Int, name: String, point: Int) {
        orderLabel.text = "\(order)"
        nameLabel.text = name
        pointLabel.text = "\(point)"
    }
    
}
