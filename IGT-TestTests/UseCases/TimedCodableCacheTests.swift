//
//  GamesCacheTests.swift
//  IGT-TestTests
//
//  Created by Miguel Santiago Rodríguez on 25/11/17.
//  Copyright © 2017 Miguel Santiago Rodríguez. All rights reserved.
//

import XCTest

@testable import IGT_Test

class TimedCodableCacheTests: XCTestCase {
    
    private static let games = Games(json: Mocks.gamesJSON)!
    
    class MockedPersistence: CodableCachePersistence {
        var storage: Codable?
        func persist(_ codable: Codable) {
            storage = codable
        }
        
        func fetch() -> Codable? {
            return storage
        }
    }
    
    func testShouldReturnGamesIfNotTimeintervalReached() {
        let sut = TimedCodableCache(interval: 60, persistence: MockedPersistence())
        let startDate = Date()
        var oneMinuteButASecond = DateComponents()
        oneMinuteButASecond.second = 59
        let endDate = Calendar.current.date(byAdding: oneMinuteButASecond, to: startDate)!
        sut.store(games: TimedCodableCacheTests.games, at: startDate)
        XCTAssertEqual(TimedCodableCacheTests.games, sut.fetch(at: endDate))
    }
    
    func testShouldReturnNilIfTimeExpired() {
        let sut = TimedCodableCache(interval: 60, persistence: MockedPersistence())
        let startDate = Date()
        var twoMinutes = DateComponents()
        twoMinutes.minute = 2
        let endDate = Calendar.current.date(byAdding: twoMinutes, to: startDate)!
        sut.store(games: TimedCodableCacheTests.games, at: startDate)
        XCTAssertNil(sut.fetch(at: endDate))
    }
    
    func testShouldReturnGamesBetweenExecutions() {
        let persistence = MockedPersistence()
        var sut = TimedCodableCache(interval: 60, persistence: persistence)
        sut.store(games: TimedCodableCacheTests.games, at: Date())
        sut = TimedCodableCache(interval: 60, persistence: persistence)
        XCTAssertEqual(TimedCodableCacheTests.games, sut.fetch(at: Date()))
    }
    
    func testShouldReturnNilBetweenExecutionsIfTimeExpired() {
        let persistence = MockedPersistence()
        let startDate = Date()
        var twoMinutes = DateComponents()
        twoMinutes.minute = 2
        let endDate = Calendar.current.date(byAdding: twoMinutes, to: startDate)!
        var sut = TimedCodableCache(interval: 60, persistence: persistence)
        sut.store(games: TimedCodableCacheTests.games, at: startDate)
        sut = TimedCodableCache(interval: 60, persistence: persistence)
        XCTAssertNil(sut.fetch(at: endDate))
    }
}
