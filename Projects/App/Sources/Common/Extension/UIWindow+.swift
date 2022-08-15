//
//  UIWindow+.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/08/15.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

extension UIWindow {
    func replaceRootViewController(_ replacementViewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        let snapshotImageView = UIImageView(image: self.snapshot())
        self.addSubview(snapshotImageView)
        
        let dismissCompletion = { () -> Void in
            self.rootViewController = replacementViewController
            self.bringSubviewToFront(snapshotImageView)
            
            if animated {
                UIView.animate(withDuration: 0.4, animations: { () -> Void in
                    snapshotImageView.alpha = 0
                }, completion: { success -> Void in
                    snapshotImageView.removeFromSuperview()
                    completion?()
                })
            } else {
                snapshotImageView.removeFromSuperview()
                completion?()
            }
        }
        
        guard let _ = self.rootViewController?.presentedViewController else {
            dismissCompletion()
            return
        }
        
        self.rootViewController?.dismiss(animated: true, completion: dismissCompletion)
    }
    
    func snapshot() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        drawHierarchy(in: bounds, afterScreenUpdates: true)
        
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage.init() }
        UIGraphicsEndImageContext()
        
        return image
    }
}
