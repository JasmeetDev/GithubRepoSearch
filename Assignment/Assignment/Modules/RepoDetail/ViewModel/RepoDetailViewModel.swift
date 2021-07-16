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
    
    var didFetchRepoDetail: (() -> ())?

    var contributors: [RepoContributor]?
    var comments: [RepoComment]?
    var issues: [RepoIssue]?

    required init(repo: String) {
        self.repo = repo
        apiClient = RepoDetailApiClient(api: GithubApiService.shared)
    }
    
    func fetchRepoDetail() {
        let dispatchQueue = DispatchQueue(label: "com.assignment.background", qos: .userInitiated, attributes: .concurrent)
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        fetchContributors(dispatchGroup)
        
        dispatchGroup.enter()
        fetchComments(dispatchGroup)
        
        dispatchGroup.enter()
        fetchIssues(dispatchGroup)
        
        dispatchGroup.notify(queue: dispatchQueue) { [weak self] in
            self?.didFetchRepoDetail?()
        }
    }
    
    private func fetchContributors(_ dispatchGroup: DispatchGroup) {
        apiClient.fetchContributors(repo: repo, limit: RepoDetailViewModel.limit) { [weak self] result in
            switch result {
            
            case .success(let contributors):
                self?.contributors = contributors
                
            case .failure(let error):
                debugPrint(error)
                break
            }
            dispatchGroup.leave()
        }
    }
    
    private func fetchComments(_ dispatchGroup: DispatchGroup) {
        apiClient.fetchComments(repo: repo, limit: RepoDetailViewModel.limit) { [weak self] result in
            switch result {
            
            case .success(let comments):
                self?.comments = comments
                
            case .failure(let error):
                debugPrint(error)
                break
            }
            dispatchGroup.leave()
        }

    }
    
    private func fetchIssues(_ dispatchGroup: DispatchGroup) {
        apiClient.fetchIssues(repo: repo, limit: RepoDetailViewModel.limit) { [weak self] result in
            switch result {
            
            case .success(let issues):
                self?.issues = issues
                
            case .failure(let error):
                debugPrint(error)
                break
            }
            dispatchGroup.leave()
        }
    }
    
}
