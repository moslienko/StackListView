//
//  StackListViewProtocols.swift
//  Example
//
//  Created by Pavel Moslienko on 24.04.2021.
//  Copyright © 2021 moslienko. All rights reserved.
//

import AppViewUtilits
import UIKit

public protocol StackListViewDataSource: AnyObject {
    func stackList(_ view: StackListView, numberOfRowsInSection: Int) -> Int
    func numberOfSections(in view: StackListView) -> Int
    func stackList(in view: StackListView, cellForRowAt indexPath: IndexPath) -> AppView
    func stackList(_ view: StackListView, cellForRowAt indexPath: IndexPath) -> AppViewModel
    
    func stackList(_ view: StackListView, viewForHeaderInSection section: Int) -> AppView?
    func stackList(_ view: StackListView, viewForFooterInSection section: Int) -> AppView?
    func stackList(in view: StackListView, modelForHeaderInSection section: Int) -> AppViewModel?
    func stackList(in view: StackListView, modelForFooterInSection section: Int) -> AppViewModel?
}

public protocol StackListViewDelegate: AnyObject {
    func reloadData()
    @discardableResult
    func updateModel(_ model: AppViewModel) -> Bool
    @discardableResult
    func updateComponentModel(_ model: AppViewModel, in index: IndexPath) -> Bool
    func removeComponentModel(in index: IndexPath)
    @discardableResult
    func addModels(_ models: [AppViewModel], after index: IndexPath) -> Bool
    @discardableResult
    func updateViewVisible(_ isHidden: Bool, index: IndexPath) -> Bool
    @discardableResult
    func updateSectionVisible(_ isHidden: Bool, index: IndexPath) -> Bool
}
