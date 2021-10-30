//
//  Observable+Operators.swift
//  MyApp
//
//

import Foundation

extension ObservableType {

    func asDriverOnErrorJustComplete() -> Driver<Element> {
        return asDriver { _ in
            return Driver.empty()
        }
    }
    
    func asDriverOnErrorNeverComplete() -> Driver<Element> {
        asDriver { _ in
            Driver.never()
        }
    }

    func asSignalOnErrorJustComplete() -> Signal<Element> {
        return asSignal { _ in
            return Signal.empty()
        }
    }

}
