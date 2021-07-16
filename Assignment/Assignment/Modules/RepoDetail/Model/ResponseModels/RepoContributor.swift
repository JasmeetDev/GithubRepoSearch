//
//  RepoContributor.swift
//  Assignment
//
//  Created by Jasmeet Singh on 16/07/21.
//

import Foundation

struct RepoContributor: Decodable {
    var id: Int?
    var avatarUrl: String?
    var name: String?
    var contributions: Int?

    enum RepoContributorKeys: String, CodingKey {
        case id
        case avatarUrl = "avatar_url"
        case name = "login"
        case contributions
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RepoContributorKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        avatarUrl = try container.decodeIfPresent(String.self, forKey: .avatarUrl)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        contributions = try container.decodeIfPresent(Int.self, forKey: .contributions)
    }
}
