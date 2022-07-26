//
//  DashedLine.swift
//  DesignSystem
//
//  Created by Eddy on 2022/07/26.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

final class DashedLine: UIView {
    override func draw(_ rect: CGRect) {
        let caShapeLayer = CAShapeLayer()
        caShapeLayer.strokeColor = UIColor.black.cgColor
        caShapeLayer.lineWidth = 1
        caShapeLayer.lineDashPattern = [3.5, 3.5]
        let cgPath = CGMutablePath()
        let cgPoint = [CGPoint(x: 0, y: 0), CGPoint(x: self.frame.width, y: 0)]
        cgPath.addLines(between: cgPoint)
        caShapeLayer.path = cgPath
        layer.addSublayer(caShapeLayer)
    }
}
