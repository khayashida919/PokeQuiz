//
//  QuizViewController.swift
//  PokeQuiz
//
//  Created by khayashida on 2019/05/25.
//  Copyright © 2019 jp.co.khayashida.ARCompanyCard. All rights reserved.
//

import UIKit

final class QuizViewController: UIViewController {
    
    @IBOutlet weak var quizLabel: UILabel!
    @IBOutlet private weak var selectTypeCollectionView: UICollectionView!
    var quizPokeType: PokeType!
    var selectedTypes = Set<PokeType>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectTypeCollectionView.delegate = self
        selectTypeCollectionView.dataSource = self
        reloadQuiz()
    }
    
    private func reloadQuiz() {
        quizPokeType = PokeType.allCases.shuffled().first!
        quizLabel.text = quizPokeType.title
        selectedTypes.removeAll()
        selectTypeCollectionView.reloadData()
    }
    
    @IBAction func confirmAction(_ sender: RoundButton) {
        let result = Poke.checkAttack(to: quizPokeType)
        if result.superiority == selectedTypes {
            let superiority = result.superiority.map { $0.title }
            showAlert(isCancel: false, title: "", message: "正解\n\(superiority)") {
                self.reloadQuiz()
            }
        } else {
            let superiority = result.superiority.map { $0.title }
            showAlert(isCancel: false, title: "", message: "不正解\n\(superiority)") {
                self.reloadQuiz()
            }
        }
    }
    
}

extension QuizViewController: UICollectionViewDelegate {
    
}

extension QuizViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PokeType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.selectTypeCollectionViewCell, for: indexPath) else {
            return UICollectionViewCell(frame: .zero)
        }
        cell.setPokeType(pokeType: PokeType.allCases[indexPath.row])
        cell.onTap = { (selected) -> Void in
            if selected { self.selectedTypes.insert(PokeType.allCases[indexPath.row])
            } else { self.selectedTypes.remove(PokeType.allCases[indexPath.row]) }
        }
        cell.selectedStatus(active: selectedTypes.contains(PokeType.allCases[indexPath.row]))
        return cell
    }
    
}

final class SelectTypeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var selectTypeButton: RoundButton!
    private(set) var pokeType: PokeType?
    var onTap: ((Bool) -> Void)?
    
    func setPokeType(pokeType: PokeType) {
        self.pokeType = pokeType
        selectTypeButton.setTitle(pokeType.title, for: .normal)
        selectTypeButton.backgroundColor = pokeType.color
    }
    
    func selectedStatus(active: Bool) {
        isSelected = active
        if active {
            selectTypeButton.borderWidth = 5
            selectTypeButton.borderColor = .red
        } else {
            selectTypeButton.borderWidth = 0
        }
    }
    
    @IBAction func selectTypeAction(_ sender: RoundButton) {
        isSelected.toggle()
        onTap?(isSelected)
        selectedStatus(active: isSelected)
    }

}
