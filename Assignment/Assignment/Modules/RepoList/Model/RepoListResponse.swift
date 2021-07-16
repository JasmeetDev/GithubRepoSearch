//
//  RepoListResponse.swift
//  Assignment
//
//  Created by Jasmeet Singh on 15/07/21.
//

import Foundation

struct RepoListResponse: Decodable {
    var totalCount: Int?
    var items: [Repo]?

    enum RepoListKeys: String, CodingKey {
        case totalCount = "total_count"
        case items
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RepoListKeys.self)
        totalCount = try container.decodeIfPresent(Int.self, forKey: .totalCount)
        items = try container.decodeIfPresent([Repo].self, forKey: .items)
    }
}

struct Repo: Decodable {
    var id: Int?
    var name: String?
    var fullName: String?
    var description: String?
    var owner: RepoOwner?

    enum RepoKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name"
        case description
        case owner
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RepoKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        fullName = try container.decodeIfPresent(String.self, forKey: .fullName)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        owner = try container.decodeIfPresent(RepoOwner.self, forKey: .owner)
    }

}

struct RepoOwner: Decodable {
    var id: Int?
    var avatarUrl: String?
    
    enum RepoOwnerKeys: String, CodingKey {
        case id
        case avatarUrl = "avatar_url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RepoOwnerKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        avatarUrl = try container.decodeIfPresent(String.self, forKey: .avatarUrl)
    }
}
