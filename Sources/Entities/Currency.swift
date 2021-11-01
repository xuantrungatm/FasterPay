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
    
    private var factor: Double {
        switch self {
        case .vnd:
            return 207.55
        case .yen:
            return 1
        case .baht:
            return 0.3
        }
    }
    
    var toVNDFactor: Double {
        switch self {
        case .vnd:
            return 1
        case .yen:
            return  Currency.vnd.factor / Currency.yen.factor
        case .baht:
            return Currency.vnd.factor / Currency.baht.factor
        }
    }
    
    var vndToCurrencyFactor: Double {
        switch self {
        case .vnd:
            return 1
        case .yen:
            return  Currency.yen.factor / Currency.vnd.factor
        case .baht:
            return Currency.baht.factor / Currency.vnd.factor
        }
    }
    
    var description: String {
        switch self {
        case .yen:
            return "Japanese Yen"
        case .baht:
            return "Thai Baht"
        case .vnd:
            return "Vietnamese Dong"
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
        }
    }
}
