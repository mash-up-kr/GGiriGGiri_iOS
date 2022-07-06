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
               handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: okTitle, style: .default, handler: handler)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
}
