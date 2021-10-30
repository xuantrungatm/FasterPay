//
//  Configs.swift
//  MyApp
//
//

import Foundation

final class Configs {
    
    static let shared = Configs()

    let loggingEnabled = false
    var env: Environment {
        #if DEBUG
        return .develop
        #else
        return .product
        #endif
    }

}
