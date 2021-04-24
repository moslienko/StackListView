//
//  FieldView.swift
//  Example
//
//  Created by Pavel Moslienko on 24.04.2021.
//  Copyright © 2021 moslienko. All rights reserved.
//

import AppViewUtilits
import UIKit
import StackListView

final class FieldView: AppView {
    
    // MARK: - Outlet
    @IBOutlet private weak var fieldContainerView: UIView!
    @IBOutlet private weak var textField: UITextField!
    
    @IBOutlet private weak var viewTopConstaint: NSLayoutConstraint!
    @IBOutlet private weak var viewBottomConstaint: NSLayoutConstraint!
    @IBOutlet private weak var viewLeftConstaint: NSLayoutConstraint!
    @IBOutlet private weak var viewRightConstaint: NSLayoutConstraint!
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // MARK: - Private
    private var defaultValue: String? {
        didSet {
            self.textField.text = defaultValue
        }
    }
    
    // MARK: - Public
    
    override func updateView() {
        guard let model = self.model as? FieldViewModel else {
            return
        }
        self.defaultValue = model.value
        
        self.textField.placeholder = "Enter text"
        
        self.viewTopConstaint.constant = model.inset.top
        self.viewBottomConstaint.constant = model.inset.bottom
        self.viewLeftConstaint.constant = model.inset.left
        self.viewRightConstaint.constant = model.inset.right
        
        self.applyStyles()
    }
    
    override func setupComponents() {
        self.textField.delegate = self
        self.defaultValue = nil
        
        self.textField.keyboardType = .numberPad
        self.textField.autocapitalizationType = .none
        self.textField.autocorrectionType = .no
        self.textField.keyboardAppearance = .light
    }
    
    override func setupActions() {
        self.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    override func applyStyles() {
        self.backgroundColor = .clear
        
        self.textField.textAlignment = .center
        self.textField.backgroundColor = .clear
        self.fieldContainerView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        self.fieldContainerView.layer.cornerRadius = 8.0
    }
}

extension FieldView {
    
    func reset() {
        self.textField.text = nil
        self.manualValidateField()
    }
    
    func manualValidateField() {
        self.textFieldDidChange(self.textField)
    }
    
}

extension FieldView {
    
    @objc
    private func doneAction() {
        _ = self.textFieldShouldReturn(self.textField)
        self.manualValidateField()
        self.endEditing(true)
    }
    
    @objc
    private func cancelAction() {
        self.textField.text = self.defaultValue
        self.textField.resignFirstResponder()
        self.manualValidateField()
        _ = self.textFieldShouldReturn(self.textField)
    }
    
    @objc
    private func textFieldDidChange(_ textfield: UITextField) {
        _ = self.textFieldShouldReturn(self.textField)
    }
}

extension FieldView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {}
}
