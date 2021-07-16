//
//  String+Extension.swift
//  Assignment
//
//  Created by Jasmeet Singh on 15/07/21.
//

import Foundation

extension String {
    var nsdata: Data {
        return self.data(using: String.Encoding.utf8)!
    }
}

