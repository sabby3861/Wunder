//
//  WunderTests.swift
//  WunderTests
//
//  Created by sanjay on 02/08/18.
//  Copyright © 2018 sanjay. All rights reserved.
//

import XCTest
@testable import Wunder

class WunderTests: XCTestCase {
    
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
      
      let parser = WUJSONParser()
      let service = WUCarInfo()
      parser.request(resource: service.carInfoService) { result in
        switch result {
        case .success(let data):
          XCTAssertFalse(data.placemarks.isEmpty)
        case .failure(let missing):
          let error = missing.localizedDescription
          XCTFail(error)
        }
      }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
