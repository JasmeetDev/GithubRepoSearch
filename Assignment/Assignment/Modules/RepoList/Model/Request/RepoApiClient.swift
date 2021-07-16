//
//  RepoApiClient.swift
//  Assignment
//
//  Created by Jasmeet Singh on 15/07/21.
//

import Foundation

protocol RepoApiClientProtocol {
    func fetchRepos(language: String, sortBy sort: String, completion: @escaping (VDResult<RepoListResponse>) -> Void)
}

final class RepoApiClient: RepoApiClientProtocol {

    private var api: GithubApiService?

    required init(api: GithubApiService) {
        self.api = api
    }

    func fetchRepos(language: String, sortBy sort: String = SortBy.stars.rawValue,
                    completion: @escaping (VDResult<RepoListResponse>) -> Void) {
        let repoListRequest = RepoListRequest(language: language, sortBy: sort)
        api?.startService(baseRequest: repoListRequest, completion: { (result: VDResult<RepoListResponse>) in
            completion(result)
        })
    }

}
