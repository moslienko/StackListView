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

extension Hashable where Self: AnyObject{
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}


extension Equatable where Self: AnyObject{
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs === rhs
    }
}

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

private extension Array where Element == AppViewModel {
    
    func getIndex(for model: AppViewModelPresentable) -> Int? {
        guard let index = self.firstIndex(where: { ($0 as? AppViewModelPresentable)?.presentable.id == model.presentable.id }) else {
            return nil
        }
        return index
    }
    
}
