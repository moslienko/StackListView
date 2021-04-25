//
//  ViewController.swift
//  Example
//
//  Created by Moslienko Pavel on 24 апр. 2021 г..
//  Copyright © 2021 moslienko. All rights reserved.
//

import UIKit
import AppViewUtilits
import StackListView

// MARK: - ViewController

/// The ViewController
class ViewController: AppViewController {
    
    // MARK: Properties
    var stackContainer = StackListAdapter<StackSectionModel>(models: [])

    lazy var contentView: StackListView = {
        let contentView = StackListView()
        contentView.stackView.alignment = .fill
        contentView.stackView.distribution = .fill
        contentView.stackView.axis = .vertical
        contentView.spacing = 16.0
        contentView.isCenterAligment = false
                
        contentView.stackView.layoutMargins = UIEdgeInsets(top: 16.0, left: 24.0, bottom: 16.0, right: 24.0)
        contentView.stackView.isLayoutMarginsRelativeArrangement = true
        contentView.scrollView.showsHorizontalScrollIndicator = false
        contentView.scrollView.showsVerticalScrollIndicator = false
        
        return contentView
    }()
    
    public class var fromXib: ViewController {
        ViewController(nibName: "ViewController", bundle: nil)
    }
    
    override func reloadData() {
        self.view.backgroundColor = .white
        view.addSubview(self.contentView)
        self.contentView.setConstraintsToViewEdges(view: view, insets: .zero)
        self.makeSections()
    }
    
    private func makeSections() {
        var sections: [StackSectionModel] = []
        
        for i in 0...2 {
            let section = StackSectionModel()
            var rows: [AppViewModel] = []
            for j in 0...4 {
                let model = FieldViewModel(value: "\(i) - \(j) = Hello!")
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    if j % 3 == 0, i == 1 {
                        model.value = "^_^ \(j)"
                        self.stackContainer.updateModel(model, in: self.contentView)
                        //self.contentView.updateModel(model)
                        self.contentView.reloadData()
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            self.stackContainer.removeModel(model, in: self.contentView)
                        }
                    }
                }
                rows += [model]
            }
            section.rows += rows
            sections.append(section)
        }
        
        self.stackContainer = StackListAdapter<StackSectionModel>(models: sections)
        self.contentView.dataSource = self.stackContainer
        self.contentView.reloadData()
    }
    
}
