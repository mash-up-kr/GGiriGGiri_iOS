//
//  ImageCollectionViewCell.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/08.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import SnapKit

final class ImageCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "ImageCollectionViewCell"

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private let checkmarkImageView: UIImageView = {
        let image = UIImage(systemName: "checkmark.circle.fill")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    func configure(with image: UIImage?) {
        imageView.image = image
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                checkmarkImageView.isHidden = false
            } else {
                checkmarkImageView.isHidden = true
            }
        }
    }
    
    private func configure() {
        imageView.addSubview(checkmarkImageView)
        checkmarkImageView.isHidden = true
        checkmarkImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
