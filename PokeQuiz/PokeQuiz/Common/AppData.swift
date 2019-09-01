//
//  AppData.swift
//  PokeQuiz
//
//  Created by Kazuki Hayashida on 2019/08/02.
//  Copyright © 2019 jp.co.khayashida.ARCompanyCard. All rights reserved.
//

import Foundation
import UIKit

final class AppData {
    static let shared = AppData()
    
    let uuid = UIDevice.current.identifierForVendor!.uuidString
    
    var name: String {
        get { return UserDefaults.standard.string(forKey: "name") ?? "" }
        set { UserDefaults.standard.set(newValue, forKey: "name") }
    }
    
    var isFirstLaunch: Bool {
        set { UserDefaults.standard.set(newValue, forKey: "isFirstLaunch") }
        get { return UserDefaults.standard.bool(forKey: "isFirstLaunch") }
    }
    
    var blockList: [String] {
        get { return UserDefaults.standard.array(forKey: "block") as! [String] }
        set { UserDefaults.standard.set(newValue, forKey: "block") }
    }
    
    private init() {
        UserDefaults.standard.register(defaults: ["isFirstLaunch": true])
        UserDefaults.standard.register(defaults: ["block": [String]()])
    }
    
}
