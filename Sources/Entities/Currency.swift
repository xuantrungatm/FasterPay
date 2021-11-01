//
//  Currency.swift
//  MyApp
//
//  Created by Xuan Trung on 01/11/2021.
//

import Foundation
import RealmSwift

@objc
enum Currency: Int, PersistableEnum, Codable {
    case vnd
    case yen
    case baht
    case usd
    case euro
    
    init?(code: String) {
        switch code.uppercased() {
        case "JPY":
            self = .yen
        case "THB":
            self = .baht
        case "VND":
            self = .vnd
        case "USD":
            self = .usd
        case "EUR":
            self = .euro
        default:
            return nil
        }
    }
    
    var valuePerUSD: Double {
        switch self {
        case .vnd:
            return 22755
        case .yen:
            return 114.01
        case .baht:
            return 33.29
        case .usd:
            return 1
        case .euro:
            return 0.86
        }
    }
    
    var code: String {
        switch self {
        case .yen:
            return "JPY"
        case .baht:
            return "THB"
        case .vnd:
            return "VND"
        case .usd:
            return "USD"
        case .euro:
            return "EUR"
        }
    }
    
    var symbol: String {
        switch self {
        case .yen:
            return "¥"
        case .baht:
            return "฿"
        case .vnd:
            return "₫"
        case .usd:
            return "$"
        case .euro:
            return "€"
        }
    }
}
