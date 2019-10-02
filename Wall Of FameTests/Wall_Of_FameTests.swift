//
//  Wall_Of_FameTests.swift
//  Wall Of FameTests
//
//  Created by Tarek Abdallah on 24/9/19.
//  Copyright © 2019 Tarek. All rights reserved.
//

import XCTest
@testable import Wall_Of_Fame

class Wall_Of_FameTests: XCTestCase {
    var trendingViewModel:TrendingViewModel!

    override func setUp() {
        trendingViewModel = TrendingViewModel(webService: WebService.shared)
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        trendingViewModel = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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

}
