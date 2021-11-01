//
//  RMUser.swift
//  MyApp
//
//  Created by Xuan Trung on 01/11/2021.
//

import Foundation
import RealmSwift

final class RMUser: Object {
    @Persisted(primaryKey: true) var email: String
    @Persisted var password: String
    @Persisted var firstName: String
    @Persisted var lastName: String
    @Persisted var transactions: List<RMTransaction>
    @Persisted var balance: Double
    @Persisted var currency: Currency
}

extension RMUser: DomainConvertibleType {
    func asDomain() -> User {
        User(email: email,
             password: password,
             firstName: firstName,
             lastName: lastName,
             transactions: transactions.map { $0.asDomain() },
             balance: balance,
             currency: currency
        )
    }
}

extension User: RealmRepresentable {
    func asRealm() -> RMUser {
        let user = RMUser()
        user.email = email
        user.password = password
        user.firstName = firstName
        user.lastName = lastName
        user.transactions.append(objectsIn: transactions.map { $0.asRealm() })
        user.balance = balance
        user.currency = currency
        return user
    }
}
