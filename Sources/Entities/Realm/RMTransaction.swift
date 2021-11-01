//
//  RMTransaction.swift
//  MyApp
//
//  Created by Xuan Trung on 01/11/2021.
//

import Foundation
import RealmSwift

final class RMTransaction: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var amount: Double
    @Persisted var currency: Currency
    @Persisted var content: String
    @Persisted var date: Date
}

extension RMTransaction: DomainConvertibleType {
    func asDomain() -> Transaction {
        Transaction(id: id, amount: amount, currency: currency, content: content, date: date)
    }
}

extension Transaction: RealmRepresentable {
    func asRealm() -> RMTransaction {
        let transaction = RMTransaction()
        transaction.id = id
        transaction.amount = amount
        transaction.currency = currency
        transaction.content = content
        transaction.date = date
        return transaction
    }
}
