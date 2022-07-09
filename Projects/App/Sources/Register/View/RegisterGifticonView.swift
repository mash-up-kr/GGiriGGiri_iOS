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
    
    override func setUI() {
        backgroundColor = .white
        
        addSubview(scrollView)
        
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}
