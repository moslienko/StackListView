//
//  StackListView.swift
//  StackListView
//
//  Created by Moslienko Pavel on 24 апр. 2021 г..
//  Copyright © 2021 moslienko. All rights reserved.
//

// Include Foundation
@_exported import Foundation
import AppViewUtilits
import UIKit

@IBDesignable
public class StackListView: UIView, StackListViewDelegate {
    
    fileprivate var didSetupConstraints = false
    @IBInspectable open var spacing: CGFloat = 8
    @IBInspectable open var isCenterAligment: Bool = false
    open var durationForAnimations: TimeInterval = 1.45
    
    public lazy var scrollView: UIScrollView = {
        let instance = UIScrollView(frame: .zero)
        instance.translatesAutoresizingMaskIntoConstraints = false
        instance.layoutMargins = .zero
        instance.delegate = self
        return instance
    }()
    
    public lazy var stackView: UIStackView = {
        let instance = UIStackView(frame: .zero)
        instance.translatesAutoresizingMaskIntoConstraints = false
        instance.axis = .vertical
        instance.spacing = self.spacing
        instance.distribution = .equalSpacing
        return instance
    }()
    
    weak public var dataSource: StackListViewDataSource?
    
    //MARK: View life cycle
    
    override public func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        setupUI()
    }
    
    public func reloadData() {
        self.stackView.removeAllArrangedSubviews()
        
        guard let sectionsCount = self.dataSource?.numberOfSections(in: self) else { return }
        for i in 0...sectionsCount - 1 {
            let sectionStack = self.createStackView()
            
            // Header
            if let headerView = self.dataSource?.stackList(self, viewForHeaderInSection: i) {
                if let headerModel = self.dataSource?.stackList(in: self, modelForHeaderInSection: i) {
                    headerView.model = headerModel
                }
                sectionStack.addArrangedSubview(headerView)
            }
            
            // Rows
            let rowsCount = self.dataSource?.stackList(self, numberOfRowsInSection: i) ?? 0
            for j in 0...rowsCount - 1 {
                guard let cell = self.dataSource?.stackList(in: self, cellForRowAt: IndexPath(item: j, section: i)) else {
                    return
                }
                if let model = self.dataSource?.stackList(self, cellForRowAt: IndexPath(item: j, section: i)) {
                    cell.model = model
                }
                
                sectionStack.addArrangedSubview(cell)
            }
            
            // Footer
            if let footerView = self.dataSource?.stackList(self, viewForFooterInSection: i) {
                if let footerModel = self.dataSource?.stackList(in: self, modelForFooterInSection: i) {
                    footerView.model = footerModel
                }
                sectionStack.addArrangedSubview(footerView)
            }
            
            self.stackView.addArrangedSubview(sectionStack)
        }
    }
    
    //MARK: Update model
    
    @discardableResult
    public func updateModel(_ model: AppViewModel) -> Bool {
        if let modelPresentable = model as? AppViewModelPresentable, let indexPath = (self.dataSource as? StackListAdapter)?.models.getIndexPatch(for: modelPresentable) {
            self.updateComponentModel(model, in: indexPath)
            return true
        }
        return false
    }
    
    @discardableResult
    public func updateComponentModel(_ model: AppViewModel, in index: IndexPath) -> Bool {
        guard let view = self.getView(index: index) else {
            return false
        }
        view.model = model
        return true
    }
    
    
    public func removeComponentModel(in index: IndexPath) {
        let sectionStack = self.getSectionView(index: index)
        
        let indexOffset = self.dataSource?.stackList(self, viewForHeaderInSection: index.section) == nil ? 0 : 1
        guard let view = sectionStack?.arrangedSubviews[safe: index.row + indexOffset] as? AppView else { return }
        view.removeFromSuperview()
    }
    
    //MARK: Add model
    
    @discardableResult
    public func addModels(_ models: [AppViewModel], after index: IndexPath) -> Bool {
        guard let sectionStack = self.getSectionView(index: index) else { return false }
        
        let indexOffset = self.dataSource?.stackList(self, viewForHeaderInSection: index.section) == nil ? 0 : 1
        
        models.enumerated().forEach({ (modelIndex, model) in
            if let view = (model as? AppViewModelPresentable)?.presentable.view {
                view.model = model
                sectionStack.insertArrangedSubview(view, at: indexOffset + modelIndex + 1)
            }
        })
        
        return true
    }
    
    //MARK: Visible
    
    @discardableResult
    public func updateViewVisible(_ isHidden: Bool, index: IndexPath) -> Bool {
        guard let view = self.getView(index: index) else {
            return false
        }
        view.isHidden = isHidden
        return true
    }
    
    
    @discardableResult
    public func updateSectionVisible(_ isHidden: Bool, index: IndexPath) -> Bool {
        guard let view = self.getSectionView(index: index) else {
            return false
        }
        view.isHidden = isHidden
        return true
    }
    
    //MARK: Utilits
    
    private func getView(index: IndexPath) -> AppView? {
        let sectionStack = self.getSectionView(index: index)
        
        let indexOffset = self.dataSource?.stackList(self, viewForHeaderInSection: index.section) == nil ? 0 : 1
        let view = sectionStack?.arrangedSubviews[safe: index.row + indexOffset] as? AppView
        
        return view
    }
    
    private func getSectionView(index: IndexPath) -> UIStackView? {
        let sectionStacks: [UIStackView] = self.stackView.arrangedSubviews.filter({ $0 is UIStackView }) as? [UIStackView] ?? []
        let sectionStack = sectionStacks[safe: index.section]
        
        return sectionStack
    }
    
    //MARK: UI
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        setNeedsUpdateConstraints() // Bootstrap auto layout
    }
    
    // Scrolls to item at index
    public func scrollToItem(index: Int) {
        if stackView.arrangedSubviews.count > 0 {
            let view = stackView.arrangedSubviews[index]
            
            UIView.animate(withDuration: durationForAnimations, animations: {
                self.scrollView.setContentOffset(CGPoint(x: 0, y:view.frame.origin.y), animated: true)
            })
        }
    }
    
    // Used to scroll till the end of scrollview
    public func scrollToBottom() {
        if stackView.arrangedSubviews.count > 0 {
            UIView.animate(withDuration: durationForAnimations, animations: {
                self.scrollView.scrollToBottom(true)
            })
        }
    }
    
    // Scrolls to top of scrollable area
    public func scrollToTop() {
        if stackView.arrangedSubviews.count > 0 {
            UIView.animate(withDuration: durationForAnimations, animations: {
                self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            })
        }
    }
    
    override public func updateConstraints() {
        super.updateConstraints()
        
        if !didSetupConstraints {
            scrollView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            
            if !isCenterAligment {
                stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
            }
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
            if !isCenterAligment {
                stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
            }
            
            // Set the width of the stack view to the width of the scroll view for vertical scrolling
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
            
            if isCenterAligment {
                stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
                stackView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor).isActive = true
            }
            
            didSetupConstraints = true
        }
    }
    
    private func createStackView() -> UIStackView {
        let instance = UIStackView(frame: .zero)
        instance.translatesAutoresizingMaskIntoConstraints = false
        instance.axis = .vertical
        instance.spacing = self.spacing
        instance.distribution = .equalSpacing
        instance.backgroundColor = .clear
        
        return instance
    }
}

extension StackListView: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        for view in self.stackView.arrangedSubviews {
            if scrollView.contentOffset.y > view.frame.origin.y + view.frame.size.height { }
        }
    }
    
}
