//
//  RepoDetailApiClient.swift
//  Assignment
//
//  Created by Jasmeet Singh on 15/07/21.
//

import Foundation

protocol RepoDetailApiClientProtocol {
    func fetchContributors(repo: String, limit: Int, completion: @escaping (VDResult<[RepoContributor]>) -> Void)
    func fetchComments(repo: String, limit: Int, completion: @escaping (VDResult<[RepoComment]>) -> Void)
    func fetchIssues(repo: String, limit: Int, completion: @escaping (VDResult<[RepoIssue]>) -> Void)
}

final class RepoDetailApiClient: RepoDetailApiClientProtocol {

    private var api: GithubApiService?

    required init(api: GithubApiService) {
        self.api = api
    }

    func fetchContributors(repo: String, limit: Int, completion: @escaping (VDResult<[RepoContributor]>) -> Void) {
        let repoContributorRequest = RepoContributorRequest(repo: repo, count: limit)
        api?.startService(baseRequest: repoContributorRequest, completion: { (result: VDResult<[RepoContributor]>) in
            completion(result)
        })
    }
    
    func fetchComments(repo: String, limit: Int, completion: @escaping (VDResult<[RepoComment]>) -> Void) {
        let repoCommentsRequest = RepoCommentsRequest(repo: repo, count: limit)
        api?.startService(baseRequest: repoCommentsRequest, completion: { (result: VDResult<[RepoComment]>) in
            completion(result)
        })
    }

    func fetchIssues(repo: String, limit: Int, completion: @escaping (VDResult<[RepoIssue]>) -> Void) {
        let repoIssuesRequest = RepoIssuesRequest(repo: repo, sort: "comments", count: limit)
        api?.startService(baseRequest: repoIssuesRequest, completion: { (result: VDResult<[RepoIssue]>) in
            completion(result)
        })
    }

}
