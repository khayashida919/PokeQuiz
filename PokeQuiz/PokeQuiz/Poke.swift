//
//  Poke.swift
//  PokeQuiz
//
//  Created by khayashida on 2019/05/25.
//  Copyright © 2019 jp.co.khayashida.ARCompanyCard. All rights reserved.
//

struct Poke {

    static func checkAttack(to pokeType: PokeType) -> PokeResult {
        
        var superiority: [PokeType]
        var inferiority: [PokeType]
        var none: [PokeType]
        
        switch pokeType {
        case .normal:
            superiority = [.kakutou, ]
            inferiority = []
            none = [.ghost]
        case .hono:
            superiority = [.mizu, .jimen, .iwa, ]
            inferiority = [.hono, .kusa, .koori, .musi, .hagane, .fairy, ]
            none = []
        case .mizu:
            superiority = [.denki, .kusa, ]
            inferiority = [.hono, .mizu, .koori, .hagane, ]
            none = []
        case .denki:
            superiority = [.jimen, ]
            inferiority = [.denki, .hikou, .hagane, ]
            none = []
        case .kusa:
            superiority = [.hono, .koori, .doku, .hikou, .musi, ]
            inferiority = [.mizu, .denki, .kusa, .jimen, ]
            none = []
        case .koori:
            superiority = [.hono, .kakutou, .iwa, .hagane]
            inferiority = [.koori, ]
            none = []
        case .kakutou:
            superiority = [.hikou, .esper, .fairy]
            inferiority = [.musi, .iwa, .aku]
            none = []
        case .doku:
            superiority = [.jimen, .esper]
            inferiority = [.kusa, .kakutou, .doku, .musi, .fairy]
            none = []
        case .jimen:
            superiority = [.mizu, .kusa, .koori]
            inferiority = [.doku, .iwa]
            none = [.denki]
        case .hikou:
            superiority = [.denki, .koori, .iwa]
            inferiority = [.kusa, .kakutou, .musi]
            none = [.jimen]
        case .esper:
            superiority = [.musi, .ghost, .aku]
            inferiority = [.kakutou, .esper]
            none = []
        case .musi:
            superiority = [.hono, .hikou, .iwa]
            inferiority = [.kusa, .kakutou, .jimen]
            none = []
        case .iwa:
            superiority = [.mizu, .kusa, .kakutou, .jimen, .hagane]
            inferiority = [.normal, .hono, .doku, .hikou]
            none = []
        case .ghost:
            superiority = [.ghost, .aku]
            inferiority = [.doku, .musi]
            none = [.normal, .kakutou]
        case .dragon:
            superiority = [.koori, .dragon, .fairy]
            inferiority = [.hono, .mizu, .denki, .kusa]
            none = []
        case .aku:
            superiority = [.kakutou, .kusa, .fairy]
            inferiority = [.ghost, .aku]
            none = [.esper]
        case .hagane:
            superiority = [.hono, .kakutou, .jimen]
            inferiority = [.normal, .kusa, .koori, .hikou, .esper, .musi, .iwa, .dragon, .hagane, .fairy]
            none = [.ghost]
        case .fairy:
            superiority = [.doku, .hagane]
            inferiority = [.kakutou, .musi, .aku]
            none = [.dragon]
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
}

struct PokeResult {
    let superiority: [PokeType]
    let inferiority: [PokeType]
    let none: [PokeType]
}
