//
//  Poke.swift
//  PokeQuiz
//
//  Created by khayashida on 2019/05/25.
//  Copyright © 2019 jp.co.khayashida.ARCompanyCard. All rights reserved.
//

import UIKit

struct Poke {

    static func checkAttack(to pokeType: PokeType) -> PokeResult {
        
        var superiority: Set<PokeType>
        var inferiority: Set<PokeType>
        var none: Set<PokeType>
        
        switch pokeType {
        case .normal:
            superiority = Set<PokeType>(arrayLiteral: .kakutou)
            inferiority = Set<PokeType>()
            none = Set<PokeType>(arrayLiteral: .ghost)
        case .hono:
            superiority = Set<PokeType>(arrayLiteral: .mizu, .jimen, .iwa)
            inferiority = Set<PokeType>(arrayLiteral: .hono, .kusa, .koori, .musi, .hagane, .fairy)
            none = Set<PokeType>()
        case .mizu:
            superiority = Set<PokeType>(arrayLiteral: .denki, .kusa)
            inferiority = Set<PokeType>(arrayLiteral: .hono, .mizu, .koori, .hagane)
            none = Set<PokeType>()
        case .denki:
            superiority = Set<PokeType>(arrayLiteral: .jimen)
            inferiority = Set<PokeType>(arrayLiteral: .denki, .hikou, .hagane)
            none = Set<PokeType>()
        case .kusa:
            superiority = Set<PokeType>(arrayLiteral: .hono, .koori, .doku, .hikou, .musi)
            inferiority = Set<PokeType>(arrayLiteral: .mizu, .denki, .kusa, .jimen)
            none = Set<PokeType>()
        case .koori:
            superiority = Set<PokeType>(arrayLiteral: .hono, .kakutou, .iwa, .hagane)
            inferiority = Set<PokeType>(arrayLiteral: .koori)
            none = Set<PokeType>()
        case .kakutou:
            superiority = Set<PokeType>(arrayLiteral: .hikou, .esper, .fairy)
            inferiority = Set<PokeType>(arrayLiteral: .musi, .iwa, .aku)
            none = Set<PokeType>()
        case .doku:
            superiority = Set<PokeType>(arrayLiteral: .jimen, .esper)
            inferiority = Set<PokeType>(arrayLiteral: .kusa, .kakutou, .doku, .musi, .fairy)
            none = Set<PokeType>()
        case .jimen:
            superiority = Set<PokeType>(arrayLiteral: .mizu, .kusa, .koori)
            inferiority = Set<PokeType>(arrayLiteral: .doku, .iwa)
            none = Set<PokeType>(arrayLiteral: .denki)
        case .hikou:
            superiority = Set<PokeType>(arrayLiteral: .denki, .koori, .iwa)
            inferiority = Set<PokeType>(arrayLiteral: .kusa, .kakutou, .musi)
            none = Set<PokeType>(arrayLiteral: .jimen)
        case .esper:
            superiority = Set<PokeType>(arrayLiteral: .musi, .ghost, .aku)
            inferiority = Set<PokeType>(arrayLiteral: .kakutou, .esper)
            none = Set<PokeType>()
        case .musi:
            superiority = Set<PokeType>(arrayLiteral: .hono, .hikou, .iwa)
            inferiority = Set<PokeType>(arrayLiteral: .kusa, .kakutou, .jimen)
            none = Set<PokeType>()
        case .iwa:
            superiority = Set<PokeType>(arrayLiteral: .mizu, .kusa, .kakutou, .jimen, .hagane)
            inferiority = Set<PokeType>(arrayLiteral: .normal, .hono, .doku, .hikou)
            none = Set<PokeType>()
        case .ghost:
            superiority = Set<PokeType>(arrayLiteral: .ghost, .aku)
            inferiority = Set<PokeType>(arrayLiteral: .doku, .musi)
            none = Set<PokeType>(arrayLiteral: .normal, .kakutou)
        case .dragon:
            superiority = Set<PokeType>(arrayLiteral: .koori, .dragon, .fairy)
            inferiority = Set<PokeType>(arrayLiteral: .hono, .mizu, .denki, .kusa)
            none = Set<PokeType>()
        case .aku:
            superiority = Set<PokeType>(arrayLiteral: .kakutou, .kusa, .fairy)
            inferiority = Set<PokeType>(arrayLiteral: .ghost, .aku)
            none = Set<PokeType>(arrayLiteral: .esper)
        case .hagane:
            superiority = Set<PokeType>(arrayLiteral: .hono, .kakutou, .jimen)
            inferiority = Set<PokeType>(arrayLiteral: .normal, .kusa, .koori, .hikou, .esper, .musi, .iwa, .dragon, .hagane, .fairy)
            none = Set<PokeType>(arrayLiteral: .ghost)
        case .fairy:
            superiority = Set<PokeType>(arrayLiteral: .doku, .hagane)
            inferiority = Set<PokeType>(arrayLiteral: .kakutou, .musi, .aku)
            none = Set<PokeType>(arrayLiteral: .dragon)
        }
        return PokeResult(superiority: superiority, inferiority: inferiority, none: none)
    }
    
}

enum PokeType: CaseIterable {
    case normal
    case hono
    case mizu
    case denki
    case kusa
    case koori
    case kakutou
    case doku
    case jimen
    case hikou
    case esper
    case musi
    case iwa
    case ghost
    case dragon
    case aku
    case hagane
    case fairy
    
    var title: String {
        switch self {
        case .normal:   return R.string.localized_ja.normal()
        case .hono:     return R.string.localized_ja.hono()
        case .mizu:     return R.string.localized_ja.mizu()
        case .denki:    return R.string.localized_ja.denki()
        case .kusa:     return R.string.localized_ja.kusa()
        case .koori:    return R.string.localized_ja.koori()
        case .kakutou:  return R.string.localized_ja.kakutou()
        case .doku:     return R.string.localized_ja.doku()
        case .jimen:    return R.string.localized_ja.jimen()
        case .hikou:    return R.string.localized_ja.hikou()
        case .esper:    return R.string.localized_ja.esper()
        case .musi:     return R.string.localized_ja.musi()
        case .iwa:      return R.string.localized_ja.iwa()
        case .ghost:    return R.string.localized_ja.ghost()
        case .dragon:   return R.string.localized_ja.dragon()
        case .aku:      return R.string.localized_ja.aku()
        case .hagane:   return R.string.localized_ja.hagane()
        case .fairy:    return R.string.localized_ja.fairy()
        }
    }
    
    var color: UIColor? {
        switch self {
        case .normal:   return R.color.normal()
        case .hono:     return R.color.hono()
        case .mizu:     return R.color.mizu()
        case .denki:    return R.color.denki()
        case .kusa:     return R.color.kusa()
        case .koori:    return R.color.koori()
        case .kakutou:  return R.color.kakutou()
        case .doku:     return R.color.doku()
        case .jimen:    return R.color.jimen()
        case .hikou:    return R.color.hikou()
        case .esper:    return R.color.esper()
        case .musi:     return R.color.musi()
        case .iwa:      return R.color.iwa()
        case .ghost:    return R.color.ghost()
        case .dragon:   return R.color.dragon()
        case .aku:      return R.color.aku()
        case .hagane:   return R.color.hagane()
        case .fairy:    return R.color.fairy()
        }
    }
    
    var key: String {
        switch self {
        case .normal:   return R.string.localized_ja.normal.key
        case .hono:     return R.string.localized_ja.hono.key
        case .mizu:     return R.string.localized_ja.mizu.key
        case .denki:    return R.string.localized_ja.denki.key
        case .kusa:     return R.string.localized_ja.kusa.key
        case .koori:    return R.string.localized_ja.koori.key
        case .kakutou:  return R.string.localized_ja.kakutou.key
        case .doku:     return R.string.localized_ja.doku.key
        case .jimen:    return R.string.localized_ja.jimen.key
        case .hikou:    return R.string.localized_ja.hikou.key
        case .esper:    return R.string.localized_ja.esper.key
        case .musi:     return R.string.localized_ja.musi.key
        case .iwa:      return R.string.localized_ja.iwa.key
        case .ghost:    return R.string.localized_ja.ghost.key
        case .dragon:   return R.string.localized_ja.dragon.key
        case .aku:      return R.string.localized_ja.aku.key
        case .hagane:   return R.string.localized_ja.hagane.key
        case .fairy:    return R.string.localized_ja.fairy.key
        }
    }
}

struct PokeResult {
    let superiority: Set<PokeType>
    let inferiority: Set<PokeType>
    let none: Set<PokeType>
}
