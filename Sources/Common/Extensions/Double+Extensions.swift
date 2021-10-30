//
//  Double+Extensions.swift
//  MyApp
//
//  Created by Xuan Trung on 20/08/2021.
//

import Foundation

extension Double {
    func toCurrencyFormat() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        let string = formatter.string(from: self as NSNumber)!
        if self >= 0 {
            return String(string.dropFirst())
        } else {
            return "-" + String(string.dropFirst(2))
        }
        
    }

}
