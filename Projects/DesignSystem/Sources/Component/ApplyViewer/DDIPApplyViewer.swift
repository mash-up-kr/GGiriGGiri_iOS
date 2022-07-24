//
//  DDIPListViewer.swift
//  DesignSystem
//
//  Created by Eddy on 2022/07/06.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

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
    
    public init(frame: CGRect = .zero, viewLabel: String) {
        applyViewerLabel.text = "\(viewLabel)명"
        super.init(frame: frame)
        setLayout()
        setAttribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setAttribute() {
        self.backgroundColor = .black
        self.layer.cornerRadius = 8
        
        applyViewerImageView.image = UIImage(systemName: "swift")
        applyViewerImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        applyViewerLabel.textColor = .white
    }
    
    private func setLayout() {
        self.addSubview(applyViewerStackView)
        applyViewerStackView.addArrangedSubview(applyViewerImageView)
        applyViewerStackView.addArrangedSubview(applyViewerLabel)
        
        NSLayoutConstraint.activate([
            applyViewerStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            applyViewerStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            applyViewerStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            applyViewerStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
        ])
    }
}
