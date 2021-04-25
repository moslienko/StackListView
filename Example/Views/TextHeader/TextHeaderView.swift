//
//  TextHeaderView.swift
//  Example
//
//  Created by Pavel Moslienko on 25.04.2021.
//  Copyright © 2021 moslienko. All rights reserved.
//

import AppViewUtilits
import UIKit
import StackListView

final class TextHeaderView: AppView {
    
    // MARK: - Outlet
    @IBOutlet private weak var titleLabel: UILabel!
    
    @IBOutlet private weak var viewTopConstaint: NSLayoutConstraint!
    @IBOutlet private weak var viewBottomConstaint: NSLayoutConstraint!
    @IBOutlet private weak var viewLeftConstaint: NSLayoutConstraint!
    @IBOutlet private weak var viewRightConstaint: NSLayoutConstraint!
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func updateView() {
        guard let model = self.model as? TextHeaderViewModel else {
            return
        }
        self.titleLabel.text = model.title
        
        self.viewTopConstaint.constant = model.inset.top
        self.viewBottomConstaint.constant = model.inset.bottom
        self.viewLeftConstaint.constant = model.inset.left
        self.viewRightConstaint.constant = model.inset.right
        
        self.applyStyles()
    }
    
    override func applyStyles() {
        self.backgroundColor = .clear
        
        self.titleLabel.textColor = .black
        self.titleLabel.font = .boldSystemFont(ofSize: 18.0)
        self.titleLabel.numberOfLines = 2
        self.titleLabel.textAlignment = .left
    }
}
