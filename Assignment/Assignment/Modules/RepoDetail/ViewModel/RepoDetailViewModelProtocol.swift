//
//  RepoDetailViewModelProtocol.swift
//  Assignment
//
//  Created by Jasmeet Singh on 15/07/21.
//

import Foundation

protocol RepoDetailViewModelProtocol {
    var repo: String { get set }
    var contributors: [RepoContributor]? { get set }
    var comments: [RepoComment]? { get set }
    var issues: [RepoIssue]? { get set }
    var didFetchContributors: (() -> ())? { get set }
    var didFetchComments: (() -> ())? { get set }
    var didFetchIssues: (() -> ())? { get set }
    init(repo: String)
    func fetchContributors()
    func fetchComments()
    func fetchIssues()
}
