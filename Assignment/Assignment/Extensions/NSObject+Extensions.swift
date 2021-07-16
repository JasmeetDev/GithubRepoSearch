//
//  NSObject+Extensions.swift
//  Assignment
//
//  Created by Jasmeet Singh on 15/07/21.
//

import Foundation

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }

    class var className: String {
        return String(describing: self)
    }
}
