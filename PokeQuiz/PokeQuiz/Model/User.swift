//
//  Ranking.swift
//  PokeQuiz
//
//  Created by Kazuki Hayashida on 2019/08/02.
//  Copyright © 2019 jp.co.khayashida.ARCompanyCard. All rights reserved.
//

import Foundation

struct User {
    let name: String
    let uuid: String
    let point: Int
    
    func toDictionary() -> [String: String] {
        let dictionary = ["name": name, "uuid": uuid, "point": String(point)]
        return dictionary
    }
}
