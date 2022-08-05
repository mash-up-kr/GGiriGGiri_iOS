//
//  ToastView.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/08/05.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import DesignSystem

final class ToastView {
    private let toastView = DDIPToastView()
    private let wrapperView = UIView()
    private let dimView = UIView()
    
    func configureToastView(with view: UIView, style: DDIPToastView.ToastViewOptions, image: DDIPAsset.name) {
        toastView.setTitleLabel(style)
        toastView.setDescriptionLabel(style)
        toastView.setIconImageView(image)
        
        dimView.backgroundColor = UIColor.black.withAlphaComponent(0.25)
        dimView.addSubview(toastView)
        wrapperView.addSubview(dimView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissPopupView(_:)))
        wrapperView.addGestureRecognizer(tapGesture)
        wrapperView.isUserInteractionEnabled = true
        
        view.addSubview(wrapperView)
        wrapperView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        dimView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        toastView.snp.makeConstraints {
            $0.width.equalTo(289)
            $0.height.equalTo(295)
            $0.centerX.centerY.equalToSuperview()
        }

        toastView.alpha = 0
    }
    
    func showToastView(with view: UIView) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
            UIView.transition(with: view, duration: 0.3, options: [.curveEaseInOut], animations: {
                self.toastView.alpha = 1
            }, completion: nil)
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 4) {
            UIView.transition(with: view, duration: 0.3, options: [.curveEaseInOut], animations: {
                self.toastView.alpha = 0
            }, completion: { _ in
                self.dimView.removeFromSuperview()
                self.wrapperView.removeFromSuperview()
            })
        }
    }
    
    @objc private func dismissPopupView(_ gesture: UITapGestureRecognizer) {
        toastView.alpha = 0
        dimView.removeFromSuperview()
        wrapperView.removeFromSuperview()
    }
}
