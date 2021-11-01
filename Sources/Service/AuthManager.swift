//
//  AuthManager.swift
//  MyApp
//
//  Created by Xuan Trung on 01/11/2021.
//

import Foundation
import SwiftyUserDefaults

protocol AuthManagerInterface: AnyObject {
    var currentUser: String? { get set }
    var isLogin: Bool { get }
    func logOut()
}

extension DefaultsKeys {
    var currentUser: DefaultsKey<String?> {
        .init("currentUser", defaultValue: nil)
    }
}

final class AuthManager: AuthManagerInterface {

    @SwiftyUserDefault(keyPath: \.currentUser, options: .cached)
    var currentUser: String?
    
    var isLogin: Bool {
        return currentUser != nil
    }
    
    func logOut() {
        currentUser = nil
        Defaults.removeAll()
    }
}
