//
//  UIPickerView+.swift
//  GGiriGGiri
//
//  Created by AhnSangHoon on 2022/08/05.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

extension UIPickerView {
    /// UIPickerView에 노출될 Data의 타입.
    /// - 해당 타입에 따라 적절하게 피커의 내용을 표시하는 UIPickerViewDelegate Method를 구현하면됨.
    enum DataType {
        case title([String])
    }
}
