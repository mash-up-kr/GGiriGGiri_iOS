//
//  TempButton.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/06/26.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

final class TempButton: UIButton {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(title: String,
                     state: UIControl.State) {
        self.init()
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitle(title, for: state)
        self.setTitleColor(.black, for: state)
        self.backgroundColor = .yellow
        self.layer.cornerRadius = 10
    }
}
