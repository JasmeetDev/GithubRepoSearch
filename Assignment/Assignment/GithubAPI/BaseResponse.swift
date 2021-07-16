//
//  BaseResponse.swift
//  Assignment
//
//  Created by Jasmeet Singh on 15/07/21.
//

import Foundation

struct BaseResponse<T: Codable>: Codable {
    let statusCode: Int?
    let message: String?
    let data: T?
    
    enum CodingKeys: String, CodingKey {
        case statusCode
        case message
        case data
    }
}

