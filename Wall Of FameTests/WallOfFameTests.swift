//
//  Wall_Of_FameTests.swift
//  Wall Of FameTests
//
//  Created by Tarek Abdallah on 24/9/19.
//  Copyright © 2019 Tarek. All rights reserved.
//

import XCTest
import OHHTTPStubs

@testable import Wall_Of_Fame

class WallOfFameTests: XCTestCase {
    var trendingViewModel: TrendingViewModel!
    override func setUp() {
        trendingViewModel = TrendingViewModel(webService: WebService.shared)
    }

    override func tearDown() {
    }

    func testSuccess() {
        stub(condition: isHost("api.github.com")) { _  in
            let stubPath = OHPathForFile("Sucess.json", type(of: self))

            return OHHTTPStubsResponse(fileAtPath: stubPath!, statusCode: 200, headers: nil)
        }
        let responseArrived = self.expectation(description: "Network Call expectation arrived")
        trendingViewModel.fetchTrendingRepositories() { (_, _) in
            responseArrived.fulfill()
        }
        waitForExpectations(timeout: 2) { (_) in
            XCTAssertTrue(self.trendingViewModel.getTrendingRepoCount() == 30, "did not read them all")
            for repo in self.trendingViewModel.trendingGitRepositories {
                XCTAssertNotNil(repo.owner.avatar)
                XCTAssertNotNil(repo.name)
                XCTAssertNotNil(repo.stars)
                XCTAssertNotNil(repo.owner.name)
            }

        }
        let responsePage2Arrived = self.expectation(description: "Network Call expectation arrived page 2")

        trendingViewModel.fetchTrendingRepositories() { (_, _) in
            responsePage2Arrived.fulfill()
        }
        waitForExpectations(timeout: 2) { (_) in
            XCTAssertTrue(self.trendingViewModel.getTrendingRepoCount() == 60, "did not read them all")
            for repo in self.trendingViewModel.trendingGitRepositories {
                XCTAssertNotNil(repo.owner.avatar)
                XCTAssertNotNil(repo.name)
                XCTAssertNotNil(repo.stars)
                XCTAssertNotNil(repo.owner.name)
            }

        }
    }

    func test404Failure() {
        OHHTTPStubs.removeAllStubs()
        stub(condition: isHost("api.github.com")&&isPath("/search/repositories")) { _  in
            return OHHTTPStubsResponse(fileAtPath: "", statusCode: 404, headers: nil)
        }
        let responseArrived = self.expectation(description: "Network Call expectation arrived")
        var responseMessage: String?
        trendingViewModel.fetchTrendingRepositories() { (_, message) in
            responseMessage = message
            responseArrived.fulfill()
        }
        waitForExpectations(timeout: 2) { (_) in
            XCTAssertNotNil(responseMessage)
            XCTAssertTrue(self.trendingViewModel.getTrendingRepoCount() == 0)
        }
    }

    func testNoNetwork() {
        OHHTTPStubs.removeAllStubs()
        stub(condition: isHost("api.github.com")&&isPath("/search/repositories")) { _  in
            let notConnectedError = NSError(domain: NSURLErrorDomain, code: URLError.notConnectedToInternet.rawValue)
            return OHHTTPStubsResponse(error: notConnectedError)
        }
        let responseArrived = self.expectation(description: "Network Call expectation arrived")
        var responseMessage: String?
        trendingViewModel.fetchTrendingRepositories() { (_, message) in
            responseMessage = message
            responseArrived.fulfill()
        }
        waitForExpectations(timeout: 2) { (_) in
            XCTAssertNotNil(responseMessage)
            XCTAssertTrue(self.trendingViewModel.getTrendingRepoCount() == 0)
        }

    }
    
    func testFailure() {
        OHHTTPStubs.removeAllStubs()
        stub(condition: isHost("api.github.com")&&isPath("/search/repositories")) { _  in
            let stubPath = OHPathForFile("Failure.json", type(of: self))
            return OHHTTPStubsResponse(fileAtPath: stubPath!, statusCode: 403, headers: nil)
        }
        let responseArrived = self.expectation(description: "Network Call expectation arrived")
        var responseMessage: String?
        trendingViewModel.fetchTrendingRepositories() { (_, message) in
            responseMessage = message
            responseArrived.fulfill()
        }
        waitForExpectations(timeout: 2) { (_) in
            XCTAssertNotNil(responseMessage)
            XCTAssertTrue(self.trendingViewModel.getTrendingRepoCount() == 0)
        }

    }
}
