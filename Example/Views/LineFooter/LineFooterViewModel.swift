//
//  LineFooterViewModel.swift
//  Example
//
//  Created by Pavel Moslienko on 25.04.2021.
//  Copyright © 2021 moslienko. All rights reserved.
//

import AppViewUtilits
import UIKit
import StackListView

class LineFooterViewModel: AppViewModel, AppViewModelPresentable {
        
    init(insets: UIEdgeInsets = .zero) {
        super.init()
        self.inset = insets
    }
    
    var presentable: AppViewModelPresentableObject = AppViewModelPresentableObject(view: LineFooterView.loadNib())
}

