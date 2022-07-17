//
//  DDIPListViewer.swift
//  DesignSystem
//
//  Created by Eddy on 2022/07/06.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

public class DDIPListViewer: UIView {
    private var viewerLabel: UILabel = UILabel()
    private var viewerImageView: UIImageView = UIImageView()
    
    private let viwerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    public init(frame: CGRect = .zero, viewLabel: String) {
        self.viewerLabel.text = "\(viewLabel)명"
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
        
        viewerImageView.image = UIImage(systemName: "swift")
        viewerImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        viewerLabel.textColor = .white
    }
    
    private func setLayout() {
        self.addSubview(viwerStackView)
        viwerStackView.addArrangedSubview(viewerImageView)
        viwerStackView.addArrangedSubview(viewerLabel)
        
        NSLayoutConstraint.activate([
            viwerStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            viwerStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 6),
            viwerStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            viwerStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -6)
        ])
    }
}
