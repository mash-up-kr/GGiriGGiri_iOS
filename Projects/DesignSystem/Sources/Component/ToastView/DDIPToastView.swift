//
//  DDIPToastView.swift
//  DesignSystem
//
//  Created by Eddy on 2022/07/02.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

public class DDIPToastView: UIView {
    public let style: DDIPToastViewStyle
    
    public let titleLabel: UILabel = {
        let titlelabel = UILabel()
        titlelabel.translatesAutoresizingMaskIntoConstraints = false
        titlelabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        return titlelabel
    }()
    
    public let iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return iconImageView
    }()
    
    public let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        
        return descriptionLabel
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(frame: CGRect = .zero, style: DDIPToastViewStyle) {
        self.style = style
        super.init(frame: .zero)
        setUI()
    }
    
    private func setUI() {
        self.titleLabel.text = self.style.title
        self.iconImageView.image = UIImage(systemName: self.style.image)
        self.descriptionLabel.text = self.style.description
        
        self.backgroundColor = .gray
        self.layer.cornerRadius = 12
        
        self.addSubview(titleLabel)
        self.addSubview(iconImageView)
        self.addSubview(descriptionLabel)
        
        setToastViewLayout()
    }
    
    private func setToastViewLayout() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 111.5),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -111.5),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 28),
            titleLabel.bottomAnchor.constraint(equalTo: self.iconImageView.topAnchor, constant: -16),
            titleLabel.heightAnchor.constraint(equalToConstant: 24),
            
            iconImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            iconImageView.bottomAnchor.constraint(equalTo: self.descriptionLabel.topAnchor, constant: -16),
            iconImageView.widthAnchor.constraint(equalToConstant: 128),
            iconImageView.heightAnchor.constraint(equalToConstant: 128),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -28)
        ])
    }
}
