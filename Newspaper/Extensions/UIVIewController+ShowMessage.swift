//
//  UIVIewController+ShowMessage.swift
//  Newspaper
//
//  Created by azerty on 16/11/2019.
//  Copyright © 2019 azerty. All rights reserved.
//

import UIKit

extension UIViewController {
    func showToast(message: String,
                   font: UIFont = UIFont.systemFont(ofSize: 14),
                   backgroundColor: UIColor = UIColor.black.withAlphaComponent(0.6)) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = backgroundColor
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 0.5, delay: 1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
