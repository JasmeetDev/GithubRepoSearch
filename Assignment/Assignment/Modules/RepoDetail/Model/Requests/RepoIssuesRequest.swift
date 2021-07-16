//
//  RepoIssuesRequest.swift
//  Assignment
//
//  Created by Jasmeet Singh on 15/07/21.
//

import Foundation

final class RepoIssuesRequest: BaseRequest {
    required init(repo: String, sort: String, count: Int) {
        let parameters = ["per_page": count, "order": "desc", "sort": sort] as [String : Any]
        let basePath = ApiConstants.baseApiPath + "repos/\(repo)/issues"
        
        super.init(url: basePath,
                   requestType: .get,
                   parameters: parameters)
    }
}

