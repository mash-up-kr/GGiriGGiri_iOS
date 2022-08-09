//
//  PickerViewModel.swift
//  GGiriGGiri
//
//  Created by AhnSangHoon on 2022/08/05.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

protocol PickerViewModelProtocol: UIPickerViewDelegate, UIPickerViewDataSource {
    var components: Int { get set }
    var numberOfRowsInComponent: Int { get set }
    var dataSourceType: UIPickerView.DataType { get }
    var didSelectItem: ((Any?) -> ()) { get }
    
    func willDismiss()
}

final class PickerViewModel: NSObject, PickerViewModelProtocol {
    var components: Int = .zero
    var numberOfRowsInComponent: Int = .zero
    var dataSourceType: UIPickerView.DataType
    var didSelectItem: ((Any?) -> ())
    
    private var currentSelectedItem: Any?
    
    init(dataSourceType: UIPickerView.DataType, didSelectItem: @escaping ((Any?) -> ())) {
        self.dataSourceType = dataSourceType
        self.didSelectItem = didSelectItem
        
        switch dataSourceType {
        case let .title(titles):
            components = 1
            numberOfRowsInComponent = titles.count
            currentSelectedItem = titles.first
        }
    }
    
    func willDismiss() {
        didSelectItem(currentSelectedItem)
    }
}

extension PickerViewModel: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard case let .title(titles) = dataSourceType else { return nil }
        return titles[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch dataSourceType {
        case let .title(titles):
            didSelectItem(titles[row])
            currentSelectedItem = titles[row]
        }
    }
}

extension PickerViewModel: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return components
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numberOfRowsInComponent
    }
}
