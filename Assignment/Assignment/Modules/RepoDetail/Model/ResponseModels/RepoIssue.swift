//
//  RepoIssue.swift
//  Assignment
//
//  Created by Jasmeet Singh on 16/07/21.
//

import Foundation

struct RepoIssue: Decodable {
    var id: Int?
    var title: String?
    var state: String?

    enum RepoContributorKeys: String, CodingKey {
        case id
        case title
        case state
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RepoContributorKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        state = try container.decodeIfPresent(String.self, forKey: .state)
    }
}
