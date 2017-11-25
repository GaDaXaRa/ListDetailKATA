//
//  GamesCacheTests.swift
//  IGT-TestTests
//
//  Created by Miguel Santiago Rodríguez on 25/11/17.
//  Copyright © 2017 Miguel Santiago Rodríguez. All rights reserved.
//

import XCTest

@testable import IGT_Test

class GamesCacheTests: XCTestCase {
    
    private static let games = Games(json: Mocks.gamesJSON)!
    let oneMinute = TimeInterval(60)
    
    let sut = GamesCache(interval: oneMinute)
    
    func testShouldReturnGamesIfNotTimeintervalReached() {
        let startDate = Date()
        var oneMinuteButASecond = DateComponents()
        oneMinuteButASecond.second = 59
        let endDate = Calendar.current.date(byAdding: oneMinuteButASecond, to: startDate)!
        sut.store(games: GamesCacheTests.games, at: startDate)
        XCTAssertEqual(GamesCacheTests.games, sut.fetch(at: endDate))
    }
    
    func testShouldReturnNilIfTimeIntervalReached() {
        let startDate = Date()
        var twoMinutes = DateComponents()
        twoMinutes.minute = 2
        let endDate = Calendar.current.date(byAdding: twoMinutes, to: startDate)!
        sut.store(games: GamesCacheTests.games, at: startDate)
        XCTAssertNil(sut.fetch(at: endDate))
    }
}
