//
//  NSObject+Extensions.swift
//  MyApp
//
//  Created by Xuan Trung on 19/08/2021.
//

import UIKit

extension NSObject {
    class var name: String {
        String(describing: self)
    }

    class var className: String {
        NSStringFromClass(self).components(separatedBy: ".").last!
    }

    var className: String {
        NSStringFromClass(type(of: self)).components(separatedBy: ".").last!
    }
}

