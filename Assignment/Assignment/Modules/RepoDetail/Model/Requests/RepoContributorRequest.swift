//
//  RepoContributorRequest.swift
//  Assignment
//
//  Created by Jasmeet Singh on 15/07/21.
//

import Foundation

final class RepoContributorRequest: BaseRequest {
    required init(repo: String, count: Int) {
        let parameters = ["per_page": count, "order": "desc"] as [String : Any]
        let basePath = ApiConstants.baseApiPath + "repos/\(repo)/contributors"
        
        super.init(url: basePath,
                   requestType: .get,
                   parameters: parameters)
    }
}

