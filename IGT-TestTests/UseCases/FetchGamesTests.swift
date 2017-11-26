//
//  FetchGamesTests.swift
//  IGT-TestTests
//
//  Created by Miguel Santiago Rodríguez on 25/11/17.
//  Copyright © 2017 Miguel Santiago Rodríguez. All rights reserved.
//

import XCTest

@testable import IGT_Test

extension FetchGamesTests {
    
    fileprivate static let gamesFromHttp = Games(json: Mocks.gamesJSON)
    
    class MockedFetchGamesTask: FetchGamesTask {
        var called = false
        func fetchGames(_ completion: @escaping ([String: Any]?) -> ()) {
            called = true
            completion(Mocks.gamesJSON)
        }
    }
    
    fileprivate class MockedCache: GamesCache {
        var games: Games?
        func store(games: Games) {
            self.games = games
        }
        
        func fetch(_ completion: @escaping (Games?) -> ()) {
            completion(games)
        }
    }
}

class FetchGamesTests: XCTestCase {
    
    fileprivate let mockedCache = MockedCache()
    fileprivate let mockedTask = MockedFetchGamesTask()
    
    func testShouldCallTaskIfNotCached() {
        let sut = FetchGames(fetchGamesTask: mockedTask, cache: mockedCache)
        let sutExpectation = expectation(description: "Expect task is called")
        sut.fetchGames { (games) in
            XCTAssertEqual(games, FetchGamesTests.gamesFromHttp)
            XCTAssertTrue(self.mockedTask.called)
            sutExpectation.fulfill()
        }
        
        waitForExpectations()
    }
    
    func testShouldNotCallTaskIfIfCached() {
        var sut = FetchGames(fetchGamesTask: MockedFetchGamesTask(), cache: mockedCache)
        let sutExpectation = expectation(description: "Expect result from cache")
        sut.fetchGames { (games) in
            sut = FetchGames(fetchGamesTask: self.mockedTask, cache: self.mockedCache)
            sut.fetchGames({ (games) in
                XCTAssertEqual(games, FetchGamesTests.gamesFromHttp)
                XCTAssertFalse(self.mockedTask.called)
                sutExpectation.fulfill()
            })
        }
        
        waitForExpectations()
    }
    
    private func waitForExpectations() {
        waitForExpectations(timeout: 0.5) { (error) in
            if error != nil {
                XCTFail()
            }
        }
    }
}
