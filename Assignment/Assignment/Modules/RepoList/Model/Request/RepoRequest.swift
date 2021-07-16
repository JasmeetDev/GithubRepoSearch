//
//  RepoRequest.swift
//  Assignment
//
//  Created by Jasmeet Singh on 15/07/21.
//

import Foundation

final class RepoListRequest: BaseRequest {
    required init(language: String, sortBy sort: String) {
        let parameters = ["q": "language:\(language)", "sort": sort, "order": "desc"]
        let basePath = ApiConstants.baseApiPath + "search/repositories"
        
        super.init(url: basePath,
                   requestType: .get,
                   parameters: parameters)
    }

}

