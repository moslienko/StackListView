//
//  Extension+Hashable.swift
//  StackListView-iOS
//
//  Created by Pavel Moslienko on 01.05.2021.
//  Copyright © 2021 moslienko. All rights reserved.
//

import Foundation

extension Hashable where Self: AnyObject{
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}
