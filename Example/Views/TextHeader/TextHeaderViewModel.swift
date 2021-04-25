//
//  TextHeaderViewModel.swift
//  Example
//
//  Created by Pavel Moslienko on 25.04.2021.
//  Copyright © 2021 moslienko. All rights reserved.
//

import AppViewUtilits
import UIKit
import StackListView

class TextHeaderViewModel: AppViewModel, AppViewModelPresentable {
    
    var title: String
    
    init(title: String, insets: UIEdgeInsets = .zero) {
        self.title = title
        super.init()
        self.inset = insets
    }
    
    var presentable: AppViewModelPresentableObject = AppViewModelPresentableObject(view: TextHeaderView.loadNib())
}

