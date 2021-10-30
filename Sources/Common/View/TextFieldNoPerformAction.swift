//
//  TextFieldNoPerformAction.swift
//  MyApp
//
//  Created by Manh Pham on 8/16/21.
//

import Foundation

class TextFieldNoPerformAction: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        tintColor = .clear
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tintColor = .clear
    }

    // swiftlint:disable lower_acl_than_parent
    override open func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        false
    }
}
