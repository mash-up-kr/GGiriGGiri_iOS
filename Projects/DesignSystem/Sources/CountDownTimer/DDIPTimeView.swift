//
//  DDIPTimeView.swift
//  DesignSystem
//
//  Created by AhnSangHoon on 2022/08/02.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import SnapKit

final class DDIPTimeView: UIView {
    /// TimeView가 보여주는 시간, hour은 기본 노출
    enum DisplayType {
        case minute
        case second
        
        var size: CGSize {
            switch self {
            case .minute: return .init(width: 28, height: 34)
            case .second: return .init(width: 39, height: 48)
            }
        }
        
        var radius: CGFloat {
            switch self {
            case .minute: return 5
            case .second: return 12
            }
        }
    }
    private let displayType: DisplayType
    
    public let numberLabel: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.textAlignment = .center

        return label
    }()
    
    init(displayType: DisplayType) {
        self.displayType = displayType
        super.init(frame: .zero)
        self.backgroundColor = .designSystem(.secondarySkyblue100)
        setValue()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setValue() {
        self.numberLabel.font = .designSystem(.chakrapeth, family: .bold, size: ._28)
        self.layer.cornerRadius = displayType.radius
    }
    
    private func setUI() {
        addSubview(numberLabel)
        snp.makeConstraints {
            $0.width.equalTo(displayType.size.width)
            $0.height.equalTo(displayType.size.height)
        }
        
        numberLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func update(text: String) {
        numberLabel.text = text
    }
}
