//
//  User.swift
//  MyApp
//
//  Created by Xuan Trung on 01/11/2021.
//

import Foundation

struct User {
    var email: String
    var password: String
    var firstName: String
    var lastName: String
    var transactions: [Transaction]
    var balance: Double
    var currency: Currency
}
