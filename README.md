<p align="center">
   <img width="200" src="https://moslienko.github.io/Assets/StackListView/sdk.png" alt="StackListView Logo">
</p>

<p align="center">
   <a href="https://developer.apple.com/swift/">
      <img src="https://img.shields.io/badge/Swift-5.2-orange.svg?style=flat" alt="Swift 5.2">
   </a>
   <a href="https://github.com/apple/swift-package-manager">
      <img src="https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg" alt="SPM">
   </a>
</p>

# StackListView

<p align="center">
Library to build a user interface based on the scrolled UIStack view's.
Please note that the reusable view is not used (such as in the UITableView), so the library is not recommended to use for large lists.
</p>

The library requires a dependency [AppViewUtilits](https://github.com/moslienko/AppViewUtilits/).

## Example

The example application is the best way to see `StackListView` in action. Simply open the `StackListView.xcodeproj` and run the `Example` scheme.

## Installation

### Swift Package Manager

To integrate using Apple's [Swift Package Manager](https://swift.org/package-manager/), add the following as a dependency to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/moslienko/StackListView.git", from: "1.0.0")
]
```

Alternatively navigate to your Xcode project, select `Swift Packages` and click the `+` icon to search for `StackListView`.

### Manually

If you prefer not to use any of the aforementioned dependency managers, you can integrate StackListView into your project manually. Simply drag the `Sources` Folder into your Xcode project.

## Usage

There are two ways to control the list - through a delegate or adapter. In most cases, it is recommended to use the adapter, since it simplifies the interaction with the library.

### Delegate

Provide support for your screen protocol *StackListViewDataSource*

```swift
 let contentView = StackListView()
 contentView.dataSource = self
```


```swift
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
```

### StackListAdapter

Create adapter

```swift
 var stackContainer = StackListAdapter<StackSectionModel>(models: [])
```

Set the adapter in *dataSource* for StackListView object

```swift
 let contentView = StackListView()
 contentView.dataSource = stackContainer
```

### Create section
All UIView's that will be added to the list must match the *AppView* class.
ViewModel must match the *AppViewModel* class and *AppViewModelPresentable* protocol.

```swift
   var sections: [StackSectionModel] = []

   let section = StackSectionModel()
   section.header = TextHeaderViewModel(title: "Section №1", insets: UIEdgeInsets(top: 8.0, left: 0.0, bottom: 8.0, right: 0.0))
   section.footer = LineFooterViewModel(insets: UIEdgeInsets(top: 8.0, left: 0.0, bottom: 8.0, right: 0.0))

   var rows: [AppViewModel] = []
               
   let model = FieldViewModel(value: "First value field")
    model.fieldCallback = { newVal, isValid in
                            self.saveButton.isEnabled = isValid
                        }
	 rows += [model]

   section.rows += rows
   sections.append(section)
   
    //If use adapter
    self.stackContainer = StackListAdapter<StackSectionModel>(models: sections)
    self.contentView.dataSource = self.stackContainer
    //
    self.contentView.reloadData()
```

### Actions with models and sections

### Through appeals directly to StackListView object

```swift
 public protocol StackListViewDelegate: AnyObject {
    func reloadData()
    func updateModel(_ model: AppViewModel) -> Bool
    func updateComponentModel(_ model: AppViewModel, in index: IndexPath) -> Bool
    func removeComponentModel(in index: IndexPath)
    func addModels(_ models: [AppViewModel], after index: IndexPath) -> Bool
    func updateViewVisible(_ isHidden: Bool, index: IndexPath) -> Bool
    func updateSectionVisible(_ isHidden: Bool, index: IndexPath) -> Bool
}
```


### Via StackListAdapter

```swift
 func updateModel(_ model: AppViewModel, in stackView: StackListView) -> Bool
 func removeModel(_ model: AppViewModel, in stackView: StackListView) -> Bool
 func addModels(_ models: [AppViewModel], after model: AppViewModel, in stackView: StackListView) -> Bool
 func updateViewVisible(for model: AppViewModel, isHidden: Bool, in stackView: StackListView) -> Bool
 func updateSectionVisible(for section: StackSectionModel, isHidden: Bool, in stackView: StackListView) -> Bool
 ```

### Settings
*isCenterAligment* parameter centers the list that the elements in it always were in the center of your screen. By default, it is disabled.

```swift
  let contentView = StackListView()
  contentView.isCenterAligment = true
```

## License

```
StackListView
Copyright (c) 2021 Moslienko Pavel 8676976+moslienko@users.noreply.github.com

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
```
