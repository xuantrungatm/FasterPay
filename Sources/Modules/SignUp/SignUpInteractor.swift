//
//  SignUpInteractor.swift
//  MyApp
//
//  Created by Xuan Trung on 01/11/2021.
//

protocol SignUpInteractorInterface {

}

final class SignUpInteractor: SignUpInteractorInterface {

    deinit {
        LogInfo("\(Swift.type(of: self)) Deinit")
    }

}
