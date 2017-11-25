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
        guard let sut = Games(json: Mocks.gamesJSON) else {
            XCTFail()
            return
        }
        XCTAssertEqual("GBP", sut.currency)
        XCTAssertTrue(sut.items.count == 8)
    }
}
