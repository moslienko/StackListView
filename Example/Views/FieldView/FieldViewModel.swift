//
//  FieldViewModel.swift
//  Example
//
//  Created by Pavel Moslienko on 24.04.2021.
//  Copyright © 2021 moslienko. All rights reserved.
//

import AppViewUtilits
import UIKit
import StackListView

class FieldViewModel: AppViewModel, AppViewModelPresentable {
    
    var value: String?
    var fieldCallback: ((_ value: String?, _ isValid: Bool) -> Void)?
    
    init(value: String?, insets: UIEdgeInsets = .zero) {
        self.value = value
        super.init()
        self.inset = insets
    }
    
    var presentable: AppViewModelPresentableObject = AppViewModelPresentableObject(view: FieldView.loadNib())
}

