//
//  UIButton+.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/27.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

extension UIButton {
    func setBackgroundColor(_ color: UIColor?, for state: UIControl.State) {
        
        UIGraphicsBeginImageContext(CGSize(width: 1.0, height: 1.0))
        guard let context = UIGraphicsGetCurrentContext() else { return }
        guard let color = color else { return }

        context.setFillColor(color.cgColor)
        context.fill(CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0))
        
        let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
         
        self.setBackgroundImage(backgroundImage, for: state)
    }
}
