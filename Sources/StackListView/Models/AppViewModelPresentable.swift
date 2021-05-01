//
//  AppViewModelPresentable.swift
//  StackListView-iOS
//
//  Created by Pavel Moslienko on 01.05.2021.
//  Copyright © 2021 moslienko. All rights reserved.
//

import AppViewUtilits

public protocol AppViewModelPresentable {
    var presentable: AppViewModelPresentableObject { get }
}

public struct AppViewModelPresentableObject: Hashable {
    public let id: Int
    public var view: AppView
    
    public init(view: AppView) {
        self.id = Int(arc4random())
        self.view = view
    }
    
    public static func == (lhs: AppViewModelPresentableObject, rhs: AppViewModelPresentableObject) -> Bool {
        return lhs.id == rhs.id
    }
    
}
