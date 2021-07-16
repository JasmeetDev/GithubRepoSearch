//
//  AssignmentTests.swift
//  AssignmentTests
//
//  Created by Jasmeet Singh on 15/07/21.
//

import XCTest
@testable import Assignment

class AssignmentTests: XCTestCase {

    var repoClient: RepoApiClientProtocol!
    var repoDetailClient: RepoDetailApiClientProtocol!

    var languages = ["swift", "java", "objective c", "c", "erlang"]
    
    override func setUpWithError() throws {
        repoClient = RepoApiClient(api: GithubApiService.shared)
        repoDetailClient = RepoDetailApiClient(api: GithubApiService.shared)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchRepos() throws {
        for language in languages {
            let expectation = XCTestExpectation(description: "Fetch repos for \(language)")
            repoClient.fetchRepos(language: language, sortBy: SortBy.forks.description) { result in
                switch result {
                case .success(let response):
                    XCTAssert(response.items!.count > 0)
                case .failure:
                    XCTFail("fetch failed")
                }
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 5)
        }
    }
    
    func testRepoContributors() throws {
        
        let fetchRepoContributorsExpectation = XCTestExpectation(description: "Fetch contributors for \("vsouza/awesome-ios")")
        repoDetailClient.fetchContributors(repo: "vsouza/awesome-ios", limit: 3) { result in
            switch result {
            case .success(let response):
                XCTAssert(response.count > 0)
            case .failure:
                XCTFail("fetch contributors failed")
            }
            fetchRepoContributorsExpectation.fulfill()
        }
        wait(for: [fetchRepoContributorsExpectation], timeout: 2)
    }
    
    func testRepoIssues() throws {
        let fetchRepoIssuesExpectation = XCTestExpectation(description: "Fetch issues for \("vsouza/awesome-ios")")
        repoDetailClient.fetchIssues(repo: "vsouza/awesome-ios", limit: 3) { result in
            switch result {
            case .success(let response):
                XCTAssert(response.count > 0)
            case .failure:
                XCTFail("fetch issues failed")
            }
            fetchRepoIssuesExpectation.fulfill()
        }
        wait(for: [fetchRepoIssuesExpectation], timeout: 2)
    }

    func testRepoComments() throws {
        let fetchRepoCommentsExpectation = XCTestExpectation(description: "Fetch comments for \("vsouza/awesome-ios")")
        repoDetailClient.fetchComments(repo: "vsouza/awesome-ios", limit: 3) { result in
            switch result {
            case .success(let response):
                XCTAssert(response.count > 0)
            case .failure:
                XCTFail("fetch failed")
            }
            fetchRepoCommentsExpectation.fulfill()
        }
        wait(for: [fetchRepoCommentsExpectation], timeout: 2)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            repoClient.fetchRepos(language: languages.first!, sortBy: SortBy.forks.rawValue) { result in
            }
        }
    }

}
