//
//  PaymentInteractor.swift
//  MyApp
//
//  Created by Xuan Trung on 01/11/2021.
//

protocol PaymentInteractorInterface {

}

final class PaymentInteractor: PaymentInteractorInterface {

    deinit {
        LogInfo("\(Swift.type(of: self)) Deinit")
    }

}
