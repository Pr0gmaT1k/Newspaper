//
//  LoaderView.swift
//  Newspaper
//
//  Created by azerty on 06/10/2019.
//  Copyright © 2019 azerty. All rights reserved.
//

import UIKit

/// A simple loader view. Integrated in UIViewController with showNPLoader: & hideNPLoader:
final class NPLoaderView: UIView {
    override init(frame: CGRect) {
        let center = CGPoint(x: frame.size.width  / 2,
        y: frame.size.height / 2)
        let activityIndicator = UIActivityIndicatorView(frame: CGRect(origin: center, size: CGSize(width: 30, height: 30)))
        activityIndicator.style = .large
        activityIndicator.color = .white
        super.init(frame: frame)
        self.backgroundColor = Color.systemGray.withAlphaComponent(0.5)
        self.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        self.alpha = 0
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    /// Fade in
    func show() {
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 1.0
        })
    }
    
    /// Fade out
    func hide() {
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 0.0
        }, completion: { _ in
            self.removeFromSuperview()
        })
    }
}

// MARK:- Add default management to UIVC
extension UIViewController {
    
    /// Fade in
    func showNPLoader() {
        let loader = NPLoaderView(frame: self.view.frame)
        self.view.addSubview(loader)
        loader.show()
    }
    
    /// Fade out
    func hideNPLoader() {
        let loaderViews = self.view.subviews.filter { $0 is NPLoaderView }
        _ = loaderViews.map { ($0 as? NPLoaderView)?.hide() }
    }
}
