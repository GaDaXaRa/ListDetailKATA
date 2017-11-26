//
//  UserTests.swift
//  IGT-TestTests
//
//  Created by Miguel Santiago Rodríguez on 26/11/17.
//  Copyright © 2017 Miguel Santiago Rodríguez. All rights reserved.
//

import XCTest

@testable import IGT_Test

class UserTests: XCTestCase {
    
    func testShouldParseUser() {
        let sut = User(json: Mocks.userJSON)
        XCTAssertNotNil(sut?.lastLoginDate)
        XCTAssertNotNil(sut?.avatarURL)
        XCTAssertNotNil(sut?.name)
        XCTAssertNotNil(sut?.balance)
    }
}
