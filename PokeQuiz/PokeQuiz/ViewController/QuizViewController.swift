//
//  QuizViewController.swift
//  PokeQuiz
//
//  Created by khayashida on 2019/05/25.
//  Copyright © 2019 jp.co.khayashida.ARCompanyCard. All rights reserved.
//

import UIKit
import LTMorphingLabel
import Firebase

final class QuizViewController: UIViewController {
    
    @IBOutlet private weak var backView: RoundView!
    @IBOutlet private weak var quizLabel: LTMorphingLabel!
    @IBOutlet private weak var correctCountLabel: UILabel!
    @IBOutlet private weak var rateLabel: UILabel!
    @IBOutlet private weak var selectTypeCollectionView: UICollectionView!
    @IBOutlet private weak var confirmButton: RoundButton!
    
    var quizPokeType: PokeType!
    var selectedTypes = Set<PokeType>()
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectTypeCollectionView.delegate = self
        selectTypeCollectionView.dataSource = self
        
        let gradientLayer: CAGradientLayer = {
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [R.color.bottomBackgroundColor()!.cgColor, R.color.topBackgroundColor()!.cgColor]
            gradientLayer.frame = self.view.bounds
            return gradientLayer
        }()
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        reloadQuiz()
    }
    
    private func reloadQuiz() {
        quizPokeType = PokeType.allCases.shuffled().first!
        
        quizLabel.morphingEffect = .sparkle
        quizLabel.pause()
        quizLabel.text = ""
        UIView.transition(with: quizLabel, duration: 1.5, options: [.transitionCurlUp], animations: nil) { [weak self] (result) in
            guard let self = self else { return }
            self.quizLabel.text = self.quizPokeType.title
            self.quizLabel.updateProgress(progress: 0)
            self.backView.borderColor = self.quizPokeType.color!
            self.confirmButton.isEnabled = true
        }
        
        selectedTypes.removeAll()
        selectTypeCollectionView.reloadData()
        
        db.collection(quizPokeType.key).getDocuments { (querySnapshot, error) in
            var correctAnswer = 0
            querySnapshot!.documents.forEach {
                guard
                    let dictioary = $0.data() as? [String: Bool],
                    let value = dictioary[Keys.document] else {
                        return
                }
                if value {
                    correctAnswer += 1
                }
            }
            if correctAnswer == 0 {
                self.rateLabel.text = String(format: "正解率：%.1f", correctAnswer) + "%"
            } else {
                let rate = (Double(correctAnswer) / Double(querySnapshot!.documents.count)) * 100
                self.rateLabel.text = String(format: "正解率：%.1f%", rate) + "%"
            }
        }
    }
    
    @IBAction func confirmAction(_ sender: RoundButton) {
        sender.isEnabled = false
        let result = Poke.checkAttack(to: quizPokeType)
        if result.superiority == selectedTypes {
            let superiority = result.superiority.map { $0.title }
            showAlert(isCancel: false, title: "", message: "正解\n\(superiority)") {
                self.reloadQuiz()
            }
            db.collection(quizPokeType.key).addDocument(data: [Keys.document : true])
        } else {
            let superiority = result.superiority.map { $0.title }
            showAlert(isCancel: false, title: "", message: "不正解\n\(superiority)") {
                self.reloadQuiz()
            }
            db.collection(quizPokeType.key).addDocument(data: [Keys.document : false])
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
            selectTypeButton.borderColor = R.color.pokeBlack() ?? .black
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
