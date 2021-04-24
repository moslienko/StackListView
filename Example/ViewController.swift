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
    var sections: [StackSectionModel] = []
    
    lazy var contentView: StackListView = {
        let contentView = StackListView()
        contentView.stackView.alignment = .fill
        contentView.stackView.distribution = .fill
        contentView.stackView.axis = .vertical
        contentView.spacing = 16.0
        contentView.isCenterAligment = false
        
        contentView.dataSource = self
        
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
        for i in 0...2 {
            var rows: [AppViewModel] = []
            for j in 0...4 {
                let model = FieldViewModel(value: "\(i) - \(j) = Hello!")
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    if j % 3 == 0, i == 1 {
                        model.value = "^_^ \(j)"
                        if let modelPresentable = model as? AppViewModelPresentable, let indexPath = self.sections.getIndexPatch(for: modelPresentable) {
                            self.contentView.updateComponentModel(model, in: indexPath)
                        }
                        //self.contentView.reloadData()
                    }
                }
                rows += [model]
            }
            let section = StackSectionModel()
            section.rows += rows
            
            self.sections.append(section)
        }
        print("sections - \(self.sections)")
        
        self.contentView.reloadData()
    }
    
}

// MARK: - StackListViewDataSource
extension ViewController: StackListViewDataSource {
    
    func stackList(_ view: StackListView, numberOfRowsInSection: Int) -> Int {
        return self.sections[numberOfRowsInSection].rows.count
    }
    
    func numberOfSections(in view: StackListView) -> Int {
        return self.sections.count
    }
    
    func stackList(in view: StackListView, cellForRowAt indexPath: IndexPath) -> AppView {
        return (self.sections[indexPath.section].rows[indexPath.row] as? AppViewModelPresentable)?.view ?? AppView()
    }
    
    func stackList(_ view: StackListView, cellForRowAt indexPath: IndexPath) -> AppViewModel {
        return self.sections[indexPath.section].rows[indexPath.row]
    }
}
