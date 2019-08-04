//
//  RankingViewController.swift
//  PokeQuiz
//
//  Created by Kazuki Hayashida on 2019/07/26.
//  Copyright © 2019 jp.co.khayashida.ARCompanyCard. All rights reserved.
//

import UIKit
import Firebase

final class RankingViewController: UIViewController {

    @IBOutlet private weak var rankingTableView: UITableView!
    
    var rankings = [Ranking]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rankingTableView.dataSource = self
        
        navigationItem.title = "ランキング"
        setGradiention()
        
        Firestore.firestore().collection(Keys.ranking).getDocuments { [weak self] (querySnapshot, error) in
            let rankings = querySnapshot!.documents
                .compactMap { $0.data() as? [String: String] }
                .compactMap { Ranking(name: $0["name"]!, uuid: $0["uuid"]!, point: $0["point"]!) }
                .sorted { $0.point > $1.point }
            
            self?.rankings = rankings
            self?.rankingTableView.reloadData()
        }
        
        
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
        rankingTableViewCell.set(order: indexPath.row + 1,
                                 name: rankings[indexPath.row].name,
                                 point: rankings[indexPath.row].point)
        return rankingTableViewCell
    }
    
}

final class RankingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var orderLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    
    
    func set(order: Int, name: String, point: String) {
        orderLabel.text = "\(order)"
        nameLabel.text = name
        pointLabel.text = point
    }
    
}
