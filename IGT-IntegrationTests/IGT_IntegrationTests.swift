//
//  IGT_IntegrationTests.swift
//  IGT-IntegrationTests
//
//  Created by Miguel Santiago Rodríguez on 25/11/17.
//  Copyright © 2017 Miguel Santiago Rodríguez. All rights reserved.
//

import XCTest

@testable import IGT_Test

class IGT_IntegrationTests: XCTestCase {
    
    override func tearDown() {
        guard let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {fatalError("could not open documents folder")}
        try! FileManager.default.removeItem(at: documentsUrl.appendingPathComponent("games.json"))
    }
    
    func testHttpFetch() {
        let sut = FetchGames()
        let fetchGamesExpectation = expectation(description: "fetch http games expectation")
        sut.fetchGames { (games) in
            defer {fetchGamesExpectation.fulfill()}
            guard let games = games else {
                XCTFail()
                return
            }
            let persistedGames: Games? = TimedCodableCache<Games>().fetch(at: Date())
            XCTAssertEqual(games, persistedGames)
        }
        
        waitForExpectations(timeout: 30) { (error) in
            if error != nil {
                XCTFail()
            }
        }
    }
    
}
