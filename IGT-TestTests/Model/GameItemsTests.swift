//
//  GameItemsTests.swift
//  IGT-TestTests
//
//  Created by Miguel Santiago Rodríguez on 25/11/17.
//  Copyright © 2017 Miguel Santiago Rodríguez. All rights reserved.
//

import XCTest

@testable import IGT_Test

class GameItemsTests: XCTestCase {
    
    func testShouldParseAllGames() {
        guard let sut = GameItems(json: GameItemsTests.json) else {
            XCTFail()
            return
        }
        XCTAssertEqual("GBP", sut.currency)
        XCTAssertTrue(sut.items.count == 8)
    }
}

extension GameItemsTests {
    fileprivate static let json = try! JSONSerialization.jsonObject(with: Mocks.gamesJSONString.data(using: .utf8)!, options: []) as! [String: Any]
    
}
