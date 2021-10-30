//
//  Optional+Extensions.swift
//  MyApp
//
//  Created by Xuan Trung on 19/08/2021.
//

import Foundation

extension Optional {
    func neverIfNil<T>() -> Single<T> where Wrapped == Single<T> {
        guard let self = self else {
            return Single.never()
        }
        return self
    }
}
