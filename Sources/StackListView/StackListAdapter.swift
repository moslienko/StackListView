//
//  StackListAdapter.swift
//  StackListView
//
//  Created by Pavel Moslienko on 25.04.2021.
//  Copyright © 2021 moslienko. All rights reserved.
//

import AppViewUtilits
import UIKit

public final class StackListAdapter<T: StackSectionModel>: StackSectionModel {
    var models: [T]
    
    public init(models: [T]) {
        self.models = models
    }
    
    @discardableResult
    public func updateModel(_ model: AppViewModel, in stackView: StackListView) -> Bool {
        guard let indexPath = self.getIndexPatch(for: model) else {
            return false
        }
        stackView.updateComponentModel(model, in: indexPath)
        return true
    }
    
    @discardableResult
    public func removeModel(_ model: AppViewModel, in stackView: StackListView) -> Bool {
        guard let indexPath = self.getIndexPatch(for: model) else {
            return false
        }
        self.models[indexPath.section].rows.remove(at: indexPath.row)
        stackView.removeComponentModel(in: indexPath)
        return true
    }
    
    @discardableResult
    public func addModels(_ models: [AppViewModel], after model: AppViewModel, in stackView: StackListView) -> Bool {
        guard var indexPath = self.getIndexPatch(for: model) else {
            return false
        }
        indexPath.row += 1
        self.models[indexPath.section].rows.insert(contentsOf: models, at:  indexPath.row)
        
        return stackView.addModels(models, after: indexPath)
    }
    
    @discardableResult
    public func updateViewVisible(for model: AppViewModel, isHidden: Bool, in stackView: StackListView) -> Bool {
        guard let indexPath = self.getIndexPatch(for: model) else {
            return false
        }
        return stackView.updateViewVisible(isHidden, index: indexPath)
    }
    
    @discardableResult
    public func updateSectionVisible(for section: StackSectionModel, isHidden: Bool, in stackView: StackListView) -> Bool {
        guard let indexPath = self.getIndexPatch(for: section) else {
            return false
        }
        return stackView.updateSectionVisible(isHidden, index: indexPath)
    }
    
    private func getIndexPatch(for model: AppViewModel) -> IndexPath? {
        guard let modelPresentable = model as? AppViewModelPresentable, let indexPath = (self.models as [StackSectionModel]).getIndexPatch(for: modelPresentable) else {
            return nil
        }
        
        return indexPath
    }
    
    private func getIndexPatch(for section: StackSectionModel) -> IndexPath? {
        guard let indexPath = (self.models as [StackSectionModel]).getIndexPatch(for: section) else {
            return nil
        }
        
        return indexPath
    }
}

extension StackListAdapter: StackListViewDataSource {
    
    public func stackList(_ view: StackListView, numberOfRowsInSection: Int) -> Int {
        return self.models[numberOfRowsInSection].rows.count
    }
    
    public func numberOfSections(in view: StackListView) -> Int {
        return self.models.count
    }
    
    public func stackList(in view: StackListView, cellForRowAt indexPath: IndexPath) -> AppView {
        return (self.models[indexPath.section].rows[indexPath.row] as? AppViewModelPresentable)?.presentable.view ?? AppView()
    }
    
    public func stackList(_ view: StackListView, cellForRowAt indexPath: IndexPath) -> AppViewModel {
        return self.models[indexPath.section].rows[indexPath.row]
    }
    
    public func stackList(_ view: StackListView, viewForHeaderInSection section: Int) -> AppView? {
        return (self.models[section].header as? AppViewModelPresentable)?.presentable.view
    }
    
    public func stackList(_ view: StackListView, viewForFooterInSection section: Int) -> AppView? {
        return (self.models[section].footer as? AppViewModelPresentable)?.presentable.view
    }
    
    public func stackList(in view: StackListView, modelForHeaderInSection section: Int) -> AppViewModel? {
        return self.models[section].header
    }
    
    public func stackList(in view: StackListView, modelForFooterInSection section: Int) -> AppViewModel? {
        return self.models[section].footer
    }
}
