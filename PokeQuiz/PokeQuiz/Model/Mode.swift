//
//  Mode.swift
//  PokeQuiz
//
//  Created by Kazuki Hayashida on 2020/02/04.
//  Copyright © 2020 jp.co.khayashida.ARCompanyCard. All rights reserved.
//

import Foundation


/// 相性のチェック基準を決めるモード
enum Mode {
    /// 1つでも相性があっていれば正解
    case beginner
    /// 3つ以上相性があっていれば正解
    case intermediate
    /// 全て相性があっていれば正解
    case advanced
}
