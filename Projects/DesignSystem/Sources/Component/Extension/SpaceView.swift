//
//  SpaceView.swift
//  DesignSystem
//
//  Created by Eddy on 2022/07/24.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

final class SpaceView: UIView {
    private var isClockwise: Bool
    
    override func draw(_ rect: CGRect) {
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2 ), radius: self.bounds.width / 2, startAngle: .pi / 2, endAngle: .pi * 3/2, clockwise: isClockwise)
        let circleShape = CAShapeLayer()
        circleShape.fillColor = UIColor.red.cgColor
        circleShape.path = circlePath.cgPath
        self.layer.addSublayer(circleShape)
    }
    
    init(isClockwise: Bool) {
        self.isClockwise = isClockwise
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
