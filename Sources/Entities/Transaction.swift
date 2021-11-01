//
//  Transaction.swift
//  MyApp
//
//  Created by Xuan Trung on 01/11/2021.
//

import Foundation

struct Transaction {
    var id: String
    var amount: Double
    var currency: Currency
    var content: String
    var date: Date
}

extension Transaction: Equatable {
    static func == (lhs: Transaction, rhs: Transaction) -> Bool {
        return lhs.id == rhs.id
    }
}

