//
//  PeselSwiftTests.swift
//  PeselSwiftTests
//
//  Created by Lukasz Szarkowicz on 23.06.2017.
//  Copyright © 2017 Łukasz Szarkowicz. All rights reserved.
//

import XCTest
@testable import PeselSwift

class PeselSwiftTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testProperPesel() {
        
        // Arrange
        let peselString = "91040910558"
        let expectedValidationResult = Pesel.ValidateResult.success
        let pesel = Pesel(pesel: peselString)
        // Act
        let result = pesel.validate()
        // Asserts
        assert(result == expectedValidationResult, "Should be proper pesel")
    }
    
    func testTooLongPesel() {
        
        // Arrange
        let peselString = "910409105583"
        let expectedValidationResult = Pesel.ValidateResult.error(error: Pesel.ValidateError.wrongLength)
        let pesel = Pesel(pesel: peselString)
        // Act
        let result = pesel.validate()
        // Asserts
        assert(result == expectedValidationResult, "Should be wrong length pesel")
    }
    
    func testNotOnlyDigitInPesel() {
        
        // Arrange
        let peselString = "91040910fdw"
        let expectedValidationResult = Pesel.ValidateResult.error(error: Pesel.ValidateError.otherThanDigits)
        let pesel = Pesel(pesel: peselString)
        // Act
        let result = pesel.validate()
        // Asserts
        assert(result == expectedValidationResult, "Should be other than digits pesel")
    }
}
