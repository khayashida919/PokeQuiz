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
import Instructions

final class QuizViewController: UIViewController {
    
    var modeType: Mode = .advanced
    
    var totalCount = 0
    var correctCount = 0
    var mistakeCount = 0
    
    var success: Int = 0    //サーバ上の問題回答に成功した合計回数
    var failure: Int = 0    //サーバ上の問題回答に失敗した合計回数
    
    @IBOutlet private weak var bannerView: GADBannerView!
    
    @IBOutlet private weak var backView: RoundView!
    @IBOutlet private weak var countLabel: UILabel!
    @IBOutlet private weak var questionCountLabel: UILabel!
    @IBOutlet private weak var quizLabel: LTMorphingLabel!
    
    @IBOutlet private weak var pointLabel: UILabel!
    @IBOutlet private var lifeImages: [UIImageView]!
    
    @IBOutlet private weak var rateLabel: UILabel!
    @IBOutlet private weak var selectTypeCollectionView: UICollectionView!
    @IBOutlet private weak var confirmButton: RoundButton!
    
    private var quizPokeType: PokeType!
    private var selectedTypes = Set<PokeType>()
    
    private var timer: PokeTimer?
    
    private let coachMarksController = CoachMarksController()
    private let feedbackGenerator: UIImpactFeedbackGenerator? = {
        if #available(iOS 10.0, *) {
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.prepare()
            return generator
        } else {
            return nil
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannerView.start(viewController: self, id: Keys.BannerUnitID.quizViewController)
        
        selectTypeCollectionView.delegate = self
        selectTypeCollectionView.dataSource = self
        coachMarksController.dataSource = self
        
        setGradiention()

        timer = PokeTimer() { [weak self] in self?.update(title: $0) }
        reloadQuiz()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if AppData.shared.isFirstLaunch {
            coachMarksController.start(in: .window(over: self))
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        coachMarksController.stop(immediately: true)
    }
    
    private func reloadQuiz() {
        success = 0     //問題をリロード時に0へ
        failure = 0     //問題をリロード時に0へ
        totalCount += 1
        questionCountLabel.text = "Question \(totalCount)"
        
        switch mistakeCount {
        case 4...:
            showGameOver()
            return
        case 1...3:
            UIView.animate(withDuration: 1.5) {
                self.lifeImages.dropFirst(self.mistakeCount-1).first?.alpha = 0.0
            }
        default: break
        }
        
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
            
            /// 初回時はタイマーをスタートさせずにチュートリアルを表示する
            if AppData.shared.isFirstLaunch {
                AppData.shared.isFirstLaunch = false
            } else {
                self.timer?.start()
            }
        }
        
        selectedTypes.removeAll()
        selectTypeCollectionView.reloadData()
        
        Firestore.firestore().collection(quizPokeType.key).document(Keys.result).getDocument { [weak self] (documentSnapshot, error) in
            
            guard let self = self else { return }
            if error != nil {
                return
            }
            
            guard
                let result = documentSnapshot!.data() as? [String: Int],
                let failure = result[Keys.failure],
                let success = result[Keys.success] else {
                    return
            }
            self.failure = failure
            self.success = success
            let sum = failure + success
            
            if sum == 0 {
                self.rateLabel.text = R.string.localizable.accuracy_rate(Double(success)) + R.string.localizable.percent()
            } else {
                let rate = (Double(success) / Double(sum)) * 100
                self.rateLabel.text = R.string.localizable.accuracy_rate(rate) + R.string.localizable.percent()
            }
        }
    }
    
    private func update(title: Int) {
        DispatchQueue.main.async {
            self.countLabel.text = title.description
            switch title {
            case 1...5:
                UIView.animate(withDuration: 0.1, animations: { [weak self] in
                    self?.countLabel.transform = CGAffineTransform(scaleX: 2, y: 2)
                }) { [weak self] (_) in
                    self?.countLabel.transform = CGAffineTransform(scaleX: 1, y: 1)
                }
            case 0:
                self.showResult()
                self.timer?.stop()
            default: break
            }
        }
    }
    
    private func showResult() {
        let result = Poke.checkAttack(to: quizPokeType)
        guard let resultViewController = R.storyboard.main.resultViewController() else {
            return
        }
        resultViewController.result = result
        resultViewController.success = success
        resultViewController.failure = failure
        resultViewController.selectedTypes = selectedTypes
        resultViewController.quizPokeType = quizPokeType
        resultViewController.reload = { [weak self] in self?.reloadQuiz() }
        resultViewController.countup = { [weak self] correct in
            guard let self = self else { return }
            if correct {
                self.correctCount += 1
                self.pointLabel.text = "\(self.correctCount)pt"
            } else {
                self.mistakeCount += 1
            }
        }
        present(resultViewController, animated: true)
    }
    
    private func showGameOver() {
        guard let gameOverViewController = R.storyboard.main.gameOverViewController() else { return }
        gameOverViewController.correctCount = correctCount
        present(gameOverViewController, animated: true, completion: nil)
    }
    
    @IBAction private func confirmAction(_ sender: RoundButton) {
        timer?.stop()
        sender.isEnabled = false
        showResult()
    }
    
}

extension QuizViewController: UICollectionViewDelegate { }

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
    
    @IBAction private func selectTypeAction(_ sender: RoundButton) {
        isSelected.toggle()
        onTap?(isSelected)
        selectedStatus(active: isSelected)
    }
    
}

extension QuizViewController: CoachMarksControllerDataSource, CoachMarksControllerDelegate {
    
    func numberOfCoachMarks(for coachMarksController: CoachMarksController) -> Int {
        return 3
    }
    
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkAt index: Int) -> CoachMark {
        switch index {
        case 0: return coachMarksController.helper.makeCoachMark(for: quizLabel)
        case 1: return coachMarksController.helper.makeCoachMark(for: selectTypeCollectionView)
        case 2: return coachMarksController.helper.makeCoachMark(for: lifeImages.first?.superview)
        default: return coachMarksController.helper.makeCoachMark(for: view)
        }
    }
    
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkViewsAt index: Int, madeFrom coachMark: CoachMark) -> (bodyView: CoachMarkBodyView, arrowView: CoachMarkArrowView?) {
        let coachViews = coachMarksController.helper.makeDefaultCoachViews(withArrow: true, arrowOrientation: coachMark.arrowOrientation)
        coachViews.bodyView.nextLabel.text = R.string.localizable.ok()
        switch index {
        case 0:
            coachViews.bodyView.hintLabel.text = R.string.localizable.quizLabel_tutorial()
        case 1:
            coachViews.bodyView.hintLabel.text = R.string.localizable.selectTypeCollectionView_tutorial()
        case 2:
            coachViews.bodyView.hintLabel.text = R.string.localizable.lifeImages_tutorial()
        default: break
        }
        return (bodyView: coachViews.bodyView, arrowView: coachViews.arrowView)
    }
    
}
