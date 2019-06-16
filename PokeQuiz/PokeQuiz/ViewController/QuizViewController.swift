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
    
    @IBOutlet private weak var bannerView: GADBannerView!
    @IBOutlet private weak var backView: RoundView!
    @IBOutlet private weak var countLabel: UILabel!
    @IBOutlet private weak var quizLabel: LTMorphingLabel!
    @IBOutlet private weak var correctCountLabel: UILabel!
    @IBOutlet private weak var rateLabel: UILabel!
    @IBOutlet private weak var selectTypeCollectionView: UICollectionView!
    @IBOutlet private weak var confirmButton: RoundButton!
    
    private var quizPokeType: PokeType!
    private var selectedTypes = Set<PokeType>()
    private let db = Firestore.firestore()
    
    private let feedbackGenerator: UIImpactFeedbackGenerator? = {
        if #available(iOS 10.0, *) {
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.prepare()
            return generator
        } else {
            return nil
        }
    }()
    
    private var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        selectTypeCollectionView.delegate = self
        selectTypeCollectionView.dataSource = self
        
        setGradiention()
        
        confirmButton.isEnabled = false
        DispatchQueue.main.async {
            self.reloadQuiz()
        }
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
            
            self.timerCount -= 1
            self.countLabel.text = "\(self.timerCount)"
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.timerAction(_:)), userInfo: nil, repeats: true)
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
    private var time = 7
    private lazy var timerCount = time
    private var rate = 1
    @objc private func timerAction(_ sender: Timer) {
        timerCount -= 1
        countLabel.text = "\(timerCount)"
        switch timerCount {
        case 1...5:
            UIView.animate(withDuration: 0.1, animations: {
                self.countLabel.transform = CGAffineTransform(scaleX: 2, y: 2)
            }) { (_) in
                self.countLabel.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        case 0:
            guard let gameOverViewController = R.storyboard.main.gameOverViewController() else { return }
            present(gameOverViewController, animated: true, completion: nil)
            timer.invalidate()
        default:
            break
        }
    }
    
    @IBAction func confirmAction(_ sender: RoundButton) {
        timer.invalidate()
        if 5 < timerCount {
            time -= rate
            timerCount = time
        }
        sender.isEnabled = false
        let result = Poke.checkAttack(to: quizPokeType)
        guard let resultViewController = R.storyboard.main.resultViewController() else {
            return
        }
        resultViewController.result = result
        resultViewController.selectedTypes = selectedTypes
        resultViewController.quizPokeType = quizPokeType
        resultViewController.reload = { self.reloadQuiz() }
        present(resultViewController, animated: true)
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
        cell.onTap = { [weak self] (selected) -> Void in
            guard let self = self else { return }
            if selected { self.selectedTypes.insert(PokeType.allCases[indexPath.row])
            } else { self.selectedTypes.remove(PokeType.allCases[indexPath.row]) }
            self.feedbackGenerator?.impactOccurred()
        }
        cell.selectedStatus(active: selectedTypes.contains(PokeType.allCases[indexPath.row]))
        return cell
    }
    
}

final class SelectTypeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var selectTypeButton: RoundButton!
    private var pokeType: PokeType?
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
