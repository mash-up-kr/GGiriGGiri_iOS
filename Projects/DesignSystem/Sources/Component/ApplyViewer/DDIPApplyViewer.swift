//
//  DDIPListViewer.swift
//  DesignSystem
//
//  Created by Eddy on 2022/07/06.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import SnapKit

public class DDIPApplyViewer: UIView {
    private var applyViewerLabel: UILabel = UILabel()
    private var applyViewerImageView: UIImageView = UIImageView()
    
    private let applyViewerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    public override var alignmentRectInsets: UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    public init() {
        super.init(frame: .zero)
        setLayout()
        setAttribute()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setAttribute() {
        self.backgroundColor = .designSystem(.neutralGray500)
        self.layer.cornerRadius = 8

        applyViewerLabel.font = .designSystem(.pretendard, family: .regular, size: ._10)
        
        applyViewerImageView.image = .designSystem(.iconPersonEmpty10)
        applyViewerLabel.textColor = .white
    }
    
    private func setLayout() {
        self.addSubview(applyViewerStackView)
        applyViewerStackView.addArrangedSubviews(applyViewerImageView, applyViewerLabel)
        
        applyViewerStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.top.bottom.equalToSuperview().inset(6)
        }
    }
}

// MARK: - 외부 주입 메서드

extension DDIPApplyViewer {
    public func setViewer(viewer: Int) {
        self.applyViewerLabel.text = "\(viewer)명"
    }
}
