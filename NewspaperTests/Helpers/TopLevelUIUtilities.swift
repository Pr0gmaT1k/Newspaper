//
//  TopLevelUIUtilities.swift
//  NewspaperTests
//
//  Created by azerty on 06/10/2019.
//  Copyright © 2019 azerty. All rights reserved.
//

import XCTest
import UIKit
@testable import Newspaper

class TopLevelUIView<T: UIView> {
    
    private var rootWindow: UIWindow!
    
    func setupTopLevelUI(with view: T) {
        rootWindow = UIWindow(frame: UIScreen.main.bounds)
        rootWindow.isHidden = false
        rootWindow.rootViewController = UIStoryboard(name: "TopLevelUIUtilities", bundle: Bundle(for: TopLevelUIView.self))
            .instantiateViewController(withIdentifier: "TopLevelUIViewController")
        
        let rootView = rootWindow.rootViewController!.view!
        rootView.addSubview(view)
        rootWindow.rootViewController!.viewWillAppear(false)
        rootWindow.rootViewController!.viewDidAppear(false)
    }
    
    func tearDownTopLevelUI() {
        let topViewController = rootWindow?.rootViewController

        guard let viewController = topViewController
            else {
                XCTFail("tearDownTopLevelUI() was called without setupTopLevelUI() being called first")
                return
        }

        viewController.viewWillDisappear(false)
        viewController.viewDidDisappear(false)
        rootWindow.rootViewController = nil
        rootWindow.isHidden = true
        self.rootWindow = nil
    }
}


class TopLevelUIViewController<T: UIViewController> {
    
    private var rootWindow: UIWindow!
    private var navigationControllerAsRoot: Bool = false
    
    
    func setupTopLevelUI(with viewController: T, inNavigationController: Bool = false) {
        navigationControllerAsRoot = inNavigationController
        rootWindow = UIWindow(frame: UIScreen.main.bounds)
        rootWindow.isHidden = false
        if navigationControllerAsRoot {
            rootWindow.rootViewController = UINavigationController(rootViewController: viewController)
        } else {
            rootWindow.rootViewController = viewController
        }
        _ = viewController.view
        viewController.viewWillAppear(false)
        viewController.viewDidAppear(false)
    }
    
    func tearDownTopLevelUI() {
        var topViewController: UIViewController?
        
        if navigationControllerAsRoot {
            let navigationController = rootWindow?.rootViewController as? UINavigationController
            topViewController = navigationController?.viewControllers.first as? T
        } else {
            topViewController = rootWindow?.rootViewController as? T
        }
        
        guard let viewController = topViewController as? T
            else {
                XCTFail("tearDownTopLevelUI() was called without setupTopLevelUI() being called first")
                return
        }
        
        viewController.viewWillDisappear(false)
        viewController.viewDidDisappear(false)
        rootWindow.rootViewController = nil
        rootWindow.isHidden = true
        self.rootWindow = nil
    }
}
