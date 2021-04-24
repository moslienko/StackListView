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
    var header: AppViewModel? { get set }
    var rows: [AppViewModel] { get set }
    var footer: AppViewModel? { get set }
}

open class StackSectionModel: StackSectionModelRepresentable {
    
    // MARK: - Props
    open var header: AppViewModel?
    open var rows: [AppViewModel]
    open var footer: AppViewModel?
    
    // MARK: - Initialization
    public init() {
        self.rows = []
    }
    
}


public protocol AppViewModelPresentable {
    var id: Int { get }
    var view: AppView { get }
}


public extension Array where Element == StackSectionModel {
    
    func getIndexPatch(for model: AppViewModelPresentable) -> IndexPath? {
        var indexPath = IndexPath(item: 0, section: 0)
        
        let sectionIndex: Int? = self.firstIndex(where: { sectionModel in
            guard let rowIndex = sectionModel.rows.getIndex(for: model) else {
                return false
            }
            indexPath.item = rowIndex
            return true
        })
        
        guard let index = sectionIndex else {
            return nil
        }
        indexPath.section = index
        return indexPath
    }
    
}

private extension Array where Element == AppViewModel {
    
    func getIndex(for model: AppViewModelPresentable) -> Int? {
        guard let index = self.firstIndex(where: { ($0 as? AppViewModelPresentable)?.id == model.id }) else {
            return nil
        }
        return index
    }
    
}
