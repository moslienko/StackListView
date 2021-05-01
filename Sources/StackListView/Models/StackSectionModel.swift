//
//  StackSectionModel.swift
//  StackListView-iOS
//
//  Created by Pavel Moslienko on 24.04.2021.
//  Copyright © 2021 moslienko. All rights reserved.
//

import AppViewUtilits
import UIKit

public protocol StackSectionModelRepresentable {
    var id: Int { get }
    var header: AppViewModel? { get set }
    var rows: [AppViewModel] { get set }
    var footer: AppViewModel? { get set }
}

open class StackSectionModel: StackSectionModelRepresentable, Hashable {
    
    // MARK: - Props
    public let id: Int
    
    open var header: AppViewModel?
    open var rows: [AppViewModel]
    open var footer: AppViewModel?
    
    // MARK: - Initialization
    public init() {
        self.id = Int(arc4random())
        self.rows = []
    }
}
