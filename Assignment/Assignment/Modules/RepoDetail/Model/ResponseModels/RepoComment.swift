//
//  RepoComment.swift
//  Assignment
//
//  Created by Jasmeet Singh on 16/07/21.
//

import Foundation

struct RepoComment: Decodable {
    var id: Int?
    var body: String?
    var state: String?

    enum RepoContributorKeys: String, CodingKey {
        case id
        case body
        case state
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RepoContributorKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        body = try container.decodeIfPresent(String.self, forKey: .body)
        state = try container.decodeIfPresent(String.self, forKey: .state)
    }
}
