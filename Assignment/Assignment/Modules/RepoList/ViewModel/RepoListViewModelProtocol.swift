//
//  RepoListViewModelProtocol.swift
//  Assignment
//
//  Created by Jasmeet Singh on 15/07/21.
//

import Foundation

protocol RepoListViewModelProtocol {
    var language: String { get set }
    var sortBy: String? { get set } 
    var repos: [Repo]? { get set }
    var didFetchRepos: (([Repo]?) -> ())? { get set }
    init(language: String)
    func fetchRepos()
}

