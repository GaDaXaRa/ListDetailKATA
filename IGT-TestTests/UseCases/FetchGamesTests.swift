//
//  FetchGamesTests.swift
//  IGT-TestTests
//
//  Created by Miguel Santiago Rodríguez on 25/11/17.
//  Copyright © 2017 Miguel Santiago Rodríguez. All rights reserved.
//

import XCTest

@testable import IGT_Test

class FetchGamesTests: XCTestCase {
    
    struct MockedFetchGamesTask: FetchGamesTask {}
    
    func testShouldFetchGames() {
        let sut = FetchGames(fetchGamesTask: MockedFetchGamesTask())
        let sutExpectation = expectation(description: "Expect task is called")
        sut.fetchGames { (games) in
            XCTAssertEqual(8, games?.items.count)
            sutExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 0.5) { (error) in
            if error != nil {
                XCTFail()
            }
        }
    }
    
}

extension FetchGamesTask {
    func fetchGames(_ completion: @escaping ([String: Any]?) -> ()) {
        completion(try! JSONSerialization.jsonObject(with: Mocks.gamesJSONString.data(using: .utf8)!, options: []) as? [String: Any])
    }
}
