//
//  UIWindow+Extensions.swift
//  MyApp
//
//

import UIKit

extension UIWindow {
    
    static var shared: UIWindow? {
        return AppDelegate.keyWindow
    }
    
}
