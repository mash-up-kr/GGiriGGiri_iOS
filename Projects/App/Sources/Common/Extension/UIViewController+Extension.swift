//
//  UIViewController+Extension.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/07.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

extension UIViewController {
    func alert(title: String = "알림",
               message: String,
               okTitle: String = "확인",
               cancelHander: ((UIAlertAction) -> Void)? = nil,
               okHandler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if let _ = cancelHander {
            let cancelAction = UIAlertAction(title: "취소", style: .cancel)
            alert.addAction(cancelAction)
        }
        
        let okAction = UIAlertAction(title: okTitle, style: .default, handler: okHandler)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
}
