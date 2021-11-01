//
//  String+Extensions.swift
//  MyApp
//
//

import UIKit

extension String {
    var isNotEmpty: Bool {
        !isEmpty
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: self)
    }

    func isValidPassword() -> Bool {
        let passwordRegEx = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$"
        let password = trimmingCharacters(in: .whitespacesAndNewlines)
        let pwPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return pwPredicate.evaluate(with: password)
    }
}
