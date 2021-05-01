//
//  Extension+StackSectionModel.swift
//  StackListView-iOS
//
//  Created by Pavel Moslienko on 01.05.2021.
//  Copyright © 2021 moslienko. All rights reserved.
//

import Foundation

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
    
    func getIndexPatch(for section: StackSectionModel) -> IndexPath? {
        guard let sectionIndex = self.firstIndex(where: { $0.id == section.id }) else {
            return nil
        }
        return IndexPath(item: 0, section: sectionIndex)
    }
}
