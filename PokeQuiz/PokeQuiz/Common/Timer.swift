//
//  Timer.swift
//  PokeQuiz
//
//  Created by khayashida on 2019/06/18.
//  Copyright © 2019 jp.co.khayashida.ARCompanyCard. All rights reserved.
//

import Foundation

class PokeTimer {
    
    /// 実際にカウントダウンされる変数
    lazy var time = initialCount
    
    /// カウントダウンが始まる初期値
    private var initialCount = 600
    private var timer: Timer?
    
    typealias TimeAction = (Int) -> Void
    private var timeAction: TimeAction
    
    init(_ timeAction: @escaping TimeAction) {
        self.timeAction = timeAction
    }
    
    func start() {
        if 6 < initialCount {
            initialCount -= 2   //startし直した時に何秒減らすかを指定
        }
        time = initialCount
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction(_:)), userInfo: nil, repeats: true)
    }
    
    func stop() {
        timer?.invalidate()
    }
    
    @objc private func timerAction(_ sender: Timer) {
        time -= 1
        timeAction(time)
    }
    
}
