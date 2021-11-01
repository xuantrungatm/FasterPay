//
//  DomainConvertibleType.swift
//  MyApp
//
//  Created by Xuan Trung on 01/11/2021.
//

import Foundation

protocol DomainConvertibleType {
    associatedtype DomainType
    func asDomain() -> DomainType
}
