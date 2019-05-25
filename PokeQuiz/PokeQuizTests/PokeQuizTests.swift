//
//  PokeQuizTests.swift
//  PokeQuizTests
//
//  Created by khayashida on 2019/05/25.
//  Copyright © 2019 jp.co.khayashida.ARCompanyCard. All rights reserved.
//

import XCTest
@testable import PokeQuiz

class PokeQuizTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_checkCompatibilityAttack_normal() {
        let result = Poke.checkAttack(to: .normal)
        XCTAssertEqual(result.superiority.count, 1)
        XCTAssertEqual(result.inferiority.count, 0)
        XCTAssertEqual(result.none.count, 1)
    }
    
    func test_checkCompatibilityAttack_hono() {
        let result = Poke.checkAttack(to: .hono)
        XCTAssertEqual(result.superiority.count, 3)
        XCTAssertEqual(result.inferiority.count, 6)
        XCTAssertEqual(result.none.count, 0)
    }
    
    func test_checkCompatibilityAttack_mizu() {
        let result = Poke.checkAttack(to: .mizu)
        XCTAssertEqual(result.superiority.count, 2)
        XCTAssertEqual(result.inferiority.count, 4)
        XCTAssertEqual(result.none.count, 0)
    }

    func test_checkCompatibilityAttack_denki() {
        let result = Poke.checkAttack(to: .denki)
        XCTAssertEqual(result.superiority.count, 1)
        XCTAssertEqual(result.inferiority.count, 3)
        XCTAssertEqual(result.none.count, 0)
    }
    
    func test_checkCompatibilityAttack_kusa() {
        let result = Poke.checkAttack(to: .kusa)
        XCTAssertEqual(result.superiority.count, 5)
        XCTAssertEqual(result.inferiority.count, 4)
        XCTAssertEqual(result.none.count, 0)
    }
    
    func test_checkCompatibilityAttack_koori() {
        let result = Poke.checkAttack(to: .koori)
        XCTAssertEqual(result.superiority.count, 4)
        XCTAssertEqual(result.inferiority.count, 1)
        XCTAssertEqual(result.none.count, 0)
    }
    
    func test_checkCompatibilityAttack_kakutou() {
        let result = Poke.checkAttack(to: .kakutou)
        XCTAssertEqual(result.superiority.count, 3)
        XCTAssertEqual(result.inferiority.count, 3)
        XCTAssertEqual(result.none.count, 0)
    }
    
    func test_checkCompatibilityAttack_doku() {
        let result = Poke.checkAttack(to: .doku)
        XCTAssertEqual(result.superiority.count, 2)
        XCTAssertEqual(result.inferiority.count, 5)
        XCTAssertEqual(result.none.count, 0)
    }
    
    func test_checkCompatibilityAttack_jimen() {
        let result = Poke.checkAttack(to: .jimen)
        XCTAssertEqual(result.superiority.count, 3)
        XCTAssertEqual(result.inferiority.count, 2)
        XCTAssertEqual(result.none.count, 1)
    }
    
    func test_checkCompatibilityAttack_hikou() {
        let result = Poke.checkAttack(to: .hikou)
        XCTAssertEqual(result.superiority.count, 3)
        XCTAssertEqual(result.inferiority.count, 3)
        XCTAssertEqual(result.none.count, 1)
    }
    
    func test_checkCompatibilityAttack_esper() {
        let result = Poke.checkAttack(to: .esper)
        XCTAssertEqual(result.superiority.count, 3)
        XCTAssertEqual(result.inferiority.count, 2)
        XCTAssertEqual(result.none.count, 0)
    }
    
    func test_checkCompatibilityAttack_musi() {
        let result = Poke.checkAttack(to: .musi)
        XCTAssertEqual(result.superiority.count, 3)
        XCTAssertEqual(result.inferiority.count, 3)
        XCTAssertEqual(result.none.count, 0)
    }
    
    func test_checkCompatibilityAttack_iwa() {
        let result = Poke.checkAttack(to: .iwa)
        XCTAssertEqual(result.superiority.count, 5)
        XCTAssertEqual(result.inferiority.count, 4)
        XCTAssertEqual(result.none.count, 0)
    }
    
    func test_checkCompatibilityAttack_ghost() {
        let result = Poke.checkAttack(to: .ghost)
        XCTAssertEqual(result.superiority.count, 2)
        XCTAssertEqual(result.inferiority.count, 2)
        XCTAssertEqual(result.none.count, 2)
    }
    
    func test_checkCompatibilityAttack_dragon() {
        let result = Poke.checkAttack(to: .dragon)
        XCTAssertEqual(result.superiority.count, 3)
        XCTAssertEqual(result.inferiority.count, 4)
        XCTAssertEqual(result.none.count, 0)
    }
    
    func test_checkCompatibilityAttack_aku() {
        let result = Poke.checkAttack(to: .aku)
        XCTAssertEqual(result.superiority.count, 3)
        XCTAssertEqual(result.inferiority.count, 2)
        XCTAssertEqual(result.none.count, 1)
    }
    
    func test_checkCompatibilityAttack_hagane() {
        let result = Poke.checkAttack(to: .hagane)
        XCTAssertEqual(result.superiority.count, 3)
        XCTAssertEqual(result.inferiority.count, 10)
        XCTAssertEqual(result.none.count, 1)
    }
    
    func test_checkCompatibilityAttack_fairy() {
        let result = Poke.checkAttack(to: .fairy)
        XCTAssertEqual(result.superiority.count, 2)
        XCTAssertEqual(result.inferiority.count, 3)
        XCTAssertEqual(result.none.count, 1)
    }
    
}
