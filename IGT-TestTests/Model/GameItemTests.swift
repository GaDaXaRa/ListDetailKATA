//
//  GameItemTests.swift
//  IGT-TestTests
//
//  Created by Miguel Santiago Rodríguez on 25/11/17.
//  Copyright © 2017 Miguel Santiago Rodríguez. All rights reserved.
//

import XCTest

@testable import IGT_Test

extension GameItemTests {
    fileprivate static let gameName = "Game 1"
    fileprivate static let gameJackpot = 34000000
    fileprivate static let gameDate = "2015-01-25T20:20:30+01:00"
    
    fileprivate static let gameItemJSON = """
                                {
                                "name": "\(GameItemTests.gameName)",
                                "jackpot": \(GameItemTests.gameJackpot),
                                "date": "\(GameItemTests.gameDate)"
                                }
                                """
    
    fileprivate static let json = try! JSONSerialization.jsonObject(with: GameItemTests.gameItemJSON.data(using: .utf8)!, options: []) as! [String: Any]
}

class GameItemTests: XCTestCase {
    
    func testShouldParseGameItem() {
        guard let sut = GameItem(json: GameItemTests.json) else {
            XCTFail()
            return
        }
        XCTAssertEqual(GameItemTests.gameName, sut.name)
        XCTAssertEqual(GameItemTests.gameJackpot, sut.jackpot)
        XCTAssertEqual(DateFormatter.rfc3339Formatter().date(from: GameItemTests.gameDate), sut.date)
    }
    
}
