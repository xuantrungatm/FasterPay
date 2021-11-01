//
//  PaymentSuccessInteractor.swift
//  MyApp
//
//  Created by Xuan Trung on 01/11/2021.
//

protocol PaymentSuccessInteractorInterface {

}

final class PaymentSuccessInteractor: PaymentSuccessInteractorInterface {

    deinit {
        LogInfo("\(Swift.type(of: self)) Deinit")
    }

}
