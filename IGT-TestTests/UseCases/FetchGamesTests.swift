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
    fileprivate static let gamesFromCache = Games(json: Mocks.cachedGamesJSON)
    
    struct MockedFetchGamesTask: FetchGamesTask {
        func fetchGames(_ completion: @escaping ([String: Any]?) -> ()) {
            completion(Mocks.gamesJSON)
        }
    }
    
    fileprivate struct EmptyCache: GamesCache {
        func store(games: Games) {}
        
        func fetch(_ completion: @escaping (Games?) -> ()) {
            completion(nil)
        }
    }
    
    fileprivate struct FullCache: GamesCache {
        func store(games: Games) {}
        
        func fetch(_ completion: @escaping (Games?) -> ()) {
            completion(Games(json: Mocks.cachedGamesJSON))
        }
    }
}

class FetchGamesTests: XCTestCase {
    
    func testShouldCallTaskIfNotCached() {
        let sut = FetchGames(fetchGamesTask: MockedFetchGamesTask(), cache: EmptyCache())
        let sutExpectation = expectation(description: "Expect task is called")
        sut.fetchGames { (games) in
            XCTAssertEqual(games, FetchGamesTests.gamesFromHttp)
            sutExpectation.fulfill()
        }
        
        waitForExpectations()
    }
    
    func testShouldReturnCacheIfCached() {
        let sut = FetchGames(fetchGamesTask: MockedFetchGamesTask(), cache: FullCache())
        let sutExpectation = expectation(description: "Expect result from cache")
        sut.fetchGames { (games) in
            XCTAssertEqual(games, FetchGamesTests.gamesFromCache)
            sutExpectation.fulfill()
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
