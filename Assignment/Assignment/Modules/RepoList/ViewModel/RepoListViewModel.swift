//
//  RepoListViewModel.swift
//  Assignment
//
//  Created by Jasmeet Singh on 15/07/21.
//

import Foundation

enum SortBy: String, CustomStringConvertible {
    case stars
    case forks
    case help
    
    var description: String {
        switch self {
        case .help:
            return "help-wanted-issues"
        default:
            return rawValue.lowercased()
        }
    }
}

class RepoListViewModel: RepoListViewModelProtocol {
    
    var language: String
    var sortBy: String? {
        didSet {
            fetchRepos()
        }
    }
    private var apiClient: RepoApiClientProtocol

    var didFetchRepos: (([Repo]?) -> ())?
    
    var repos: [Repo]? {
        didSet {
            self.didFetchRepos?(repos)
        }
    }
    
    required init(language: String) {
        self.language = language
        apiClient = RepoApiClient(api: GithubApiService.shared)
    }
    
    func fetchRepos() {
        apiClient.fetchRepos(language: self.language, sortBy: self.sortBy ?? SortBy.stars.description) { [weak self] result in
            switch result {
            
            case .success(let repoListResponse):
                self?.repos = repoListResponse.items
                
            case .failure(let error):
                debugPrint(error)
                break
            }
        }
    }
}
