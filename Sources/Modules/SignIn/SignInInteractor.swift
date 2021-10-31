//
//  SignInInteractor.swift
//  MyApp
//
//  Created by Xuan Trung on 31/10/2021.
//

protocol SignInInteractorInterface {

}

final class SignInInteractor: SignInInteractorInterface {

    deinit {
        LogInfo("\(Swift.type(of: self)) Deinit")
    }

}
