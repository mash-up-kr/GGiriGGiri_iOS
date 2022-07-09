//
//  RegisterGifticonView.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/09.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import SnapKit

final class RegisterGifticonView: CommonView {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .systemPink
        return scrollView
    }()
    
    private let registerGiftionImageWrapperView = RegisterGiftionImageWrapperView()
    
    private let registerGifticonInfoMessageWrapperView = RegisterGifticonInfoMessageWrapperView()
    
    override func setUI() {
        backgroundColor = .white
        
        addSubview(scrollView)
        
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
        
        scrollView.contentLayoutGuide.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
        
        scrollView.addSubview(registerGiftionImageWrapperView)
        scrollView.addSubview(registerGifticonInfoMessageWrapperView)
        
        registerGiftionImageWrapperView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(294)
        }
        
        registerGifticonInfoMessageWrapperView.snp.makeConstraints {
            $0.top.equalTo(registerGiftionImageWrapperView.snp.bottom)
            $0.leading.equalTo(16)
            $0.trailing.equalTo(-16)
            $0.height.equalTo(108)
        }
    }
}
