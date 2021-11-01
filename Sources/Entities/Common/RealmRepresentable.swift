//
//  RealmRepresentable.swift
//  MyApp
//
//  Created by Xuan Trung on 01/11/2021.
//

import Foundation

protocol RealmRepresentable {
    associatedtype RealmType: DomainConvertibleType
    func asRealm() -> RealmType
}
