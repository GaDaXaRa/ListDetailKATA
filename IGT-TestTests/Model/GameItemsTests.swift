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
    fileprivate static let json = try! JSONSerialization.jsonObject(with: GameItemsTests.jsonString.data(using: .utf8)!, options: []) as! [String: Any]
    
    fileprivate static let jsonString = """
                    {
                    "response": "success",
                    "currency" : "GBP",
                    "data" : [
                    {
                    "name": "Game 1",
                    "jackpot": 34000000,
                    "date": "2015-01-25T20:20:30+01:00"
                    },
                    {
                    "name": "Game 2",
                    "jackpot": 100000000,
                    "date": "2015-02-16T08:40:30+01:00"
                    },
                    {
                    "name": "Game 3",
                    "jackpot": 100000,
                    "date": "2015-11-09T10:25:30+01:00"
                    },
                    {
                    "name": "Game 4",
                    "jackpot": 45000000,
                    "date": "2015-03-10T18:55:30+01:00"
                    },
                    {
                    "name": "Game 5",
                    "jackpot": 60000000,
                    "date": "2015-07-20T03:45:30+01:00"
                    },
                    {
                    "name": "Game 6",
                    "jackpot": 95000000,
                    "date": "2015-06-22T09:40:30+01:00"
                    },
                    {
                    "name": "Game 7",
                    "jackpot": 100000000,
                    "date": "2015-10-19T08:30:30+01:00"
                    },
                    {
                    "name": "Game 8",
                    "jackpot": 12000,
                    "date": "2015-12-06T07:20:30+01:00"
                    }
                    ]
                    }
                    """
}
