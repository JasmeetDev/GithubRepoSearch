//
//  RepoDetailViewModel.swift
//  Assignment
//
//  Created by Jasmeet Singh on 15/07/21.
//

import Foundation

enum Section: Int, CaseIterable, CustomStringConvertible {
    case contributors = 0
    case issues
    case comments
    
    var description: String {
        switch self {
          case .contributors:
            return "Contributors"
          case .issues:
            return "Issues"
          case .comments:
            return "Comments"
        }
    }
}

class RepoDetailViewModel: RepoDetailViewModelProtocol {
    var repo: String
    private var apiClient: RepoDetailApiClientProtocol

    static let limit = 3
    
    var didFetchContributors: (() -> ())?
    var didFetchComments: (() -> ())?
    var didFetchIssues: (() -> ())?

    var contributors: [RepoContributor]? {
        didSet {
            self.didFetchContributors?()
        }
    }
    var comments: [RepoComment]? {
        didSet {
            self.didFetchComments?()
        }
    }
    var issues: [RepoIssue]? {
        didSet {
            self.didFetchIssues?()
        }
    }

    required init(repo: String) {
        self.repo = repo
        apiClient = RepoDetailApiClient(api: GithubApiService.shared)
    }
    
    func fetchContributors() {
        apiClient.fetchContributors(repo: repo, limit: RepoDetailViewModel.limit) { [weak self] result in
            switch result {
            
            case .success(let contributors):
                self?.contributors = contributors
                
            case .failure(let error):
                debugPrint(error)
                break
            }
        }
    }
    
    func fetchComments() {
        apiClient.fetchComments(repo: repo, limit: RepoDetailViewModel.limit) { [weak self] result in
            switch result {
            
            case .success(let comments):
                self?.comments = comments
                
            case .failure(let error):
                debugPrint(error)
                break
            }
        }

    }
    
    func fetchIssues() {
        apiClient.fetchIssues(repo: repo, limit: RepoDetailViewModel.limit) { [weak self] result in
            switch result {
            
            case .success(let issues):
                self?.issues = issues
                
            case .failure(let error):
                debugPrint(error)
                break
            }
        }
    }
    
}
