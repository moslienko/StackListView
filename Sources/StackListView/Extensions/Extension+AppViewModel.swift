//
//  Extension+AppViewModel.swift
//  StackListView-iOS
//
//  Created by Pavel Moslienko on 01.05.2021.
//  Copyright © 2021 moslienko. All rights reserved.
//

import AppViewUtilits

public extension Array where Element == AppViewModel {
    
    func getIndex(for model: AppViewModelPresentable) -> Int? {
        guard let index = self.firstIndex(where: { ($0 as? AppViewModelPresentable)?.presentable.id == model.presentable.id }) else {
            return nil
        }
        return index
    }
    
}
