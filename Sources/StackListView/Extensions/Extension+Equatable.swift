//
//  Extension+Equatable.swift
//  StackListView-iOS
//
//  Created by Pavel Moslienko on 01.05.2021.
//  Copyright © 2021 moslienko. All rights reserved.
//

import Foundation

extension Equatable where Self: AnyObject{
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs === rhs
    }
}
