//
//  Word_GameTests.swift
//  Word GameTests
//
//  Created by Asad on 03/11/2022.
//

import XCTest
@testable import Word_Game

class Word_GameTests: XCTestCase {
    
    
    func testGetValidResponseForJson() {
        
        let localRepository = LocalRepository()

        let expectation = self.expectation(description: " ✅ test_Get_Valid_Response_Json")
        localRepository.fetch { (result: Response<[WordPair]>) in
            expectation.fulfill()
            switch result{
            case .success(let responseModel):
                XCTAssertNotNil(responseModel)
                XCTAssert((responseModel as Any) is [WordPair])
            case .failure(_):
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 15, handler: nil)
    }
    
    func testGetInValidResponseForJson() {
        
        let localRepository = LocalRepository(fileName: "abc", fileExtansion: "json")

        let expectation = self.expectation(description: " ❌ test_Get_InValid_Response_Json")
        
        localRepository.fetch { (result: Response<[WordPair]>) in
            expectation.fulfill()
            switch result{
            case .success(_):
                XCTExpectFailure("File not found.")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
        waitForExpectations(timeout: 15, handler: nil)
    }
}
