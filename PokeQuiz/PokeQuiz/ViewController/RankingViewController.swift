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
    
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rankingTableView.dataSource = self
        rankingTableView.delegate = self
        
        navigationItem.title = R.string.localizable.ranking()
        setGradiention()
        
        getRanking() {
            self.rankingTableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }
    
    private func getRanking(_ completion: (() -> Void)? = nil) {
        Firestore.firestore().collection(Keys.ranking).getDocuments { [weak self] (querySnapshot, error) in
            guard let self = self else { return }
            let users = querySnapshot!.documents
                .compactMap { $0.data() as? [String: String] }
                .map { User(name: $0["name"]!, uuid: $0["uuid"]!, point: $0["point"]!) }
                .filter { !AppData.shared.blockList.contains($0.uuid) }     //ブロックされていたら非表示
                .sorted { $0.point > $1.point }     //ポイントが高い順にソート
            
            self.users = users
            completion?()
        }
    }
    
    private func reportAction(_ user: User) {
        Firestore.firestore().collection(Keys.report).addDocument(data: ["uuid": user.uuid])
    }
    
    private func hiddenAction(_ user: User) {
        let blocks = AppData.shared.blockList
        guard !blocks.contains(user.uuid) else { return }  //既に登録されていたらreturn
        AppData.shared.blockList = blocks + [user.uuid]
        
        getRanking() {
            self.rankingTableView.reloadData()
        }
    }
    
}

extension RankingViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let reportButton: UITableViewRowAction = {
            let reportButton = UITableViewRowAction(style: .default, title: R.string.localizable.report()) { [weak self] (tableViewRowAction, indexPath) in
                guard let self = self else { return }
                
                let user = self.users[indexPath.row]
                self.showAlert(isCancel: true,
                               title: R.string.localizable.confirmation(),
                               message: R.string.localizable.do_you_really_want_to_report_it()) {
                                self.reportAction(user)
                }
            }
            reportButton.backgroundColor = R.color.pokeRed()
            return reportButton
        }()
        
        let hiddenButton: UITableViewRowAction = {
            let hiddenButton = UITableViewRowAction(style: .default, title: R.string.localizable.hidden()) { [weak self] (tableViewRowAction, indexPath) in
                guard let self = self else { return }
                
                let user = self.users[indexPath.row]
                self.showAlert(isCancel: true,
                               title: R.string.localizable.confirmation(),
                               message: R.string.localizable.are_you_sure_you_want_to_hide_it()) {
                                self.hiddenAction(user)
                }
            }
            hiddenButton.backgroundColor = R.color.normal()
            return hiddenButton
        }()
        
        return [reportButton, hiddenButton]
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) { }
    
}

extension RankingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let rankingTableViewCell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.rankingTableViewCell, for: indexPath) else {
            return UITableViewCell(frame: .zero)
        }
        rankingTableViewCell.set(order: indexPath.row + 1,
                                 name: users[indexPath.row].name,
                                 point: users[indexPath.row].point)
        return rankingTableViewCell
    }
    
}

final class RankingTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var orderLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var pointLabel: UILabel!
    
    func set(order: Int, name: String, point: String) {
        orderLabel.text = "\(order)"
        nameLabel.text = name
        pointLabel.text = point
    }
    
}
