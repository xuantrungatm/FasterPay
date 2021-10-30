//
//  WalletInteractor.swift
//  MyApp
//
//  Created by Xuan Trung on 30/10/2021.
//

protocol WalletInteractorInterface {

}

final class WalletInteractor: WalletInteractorInterface {

    deinit {
        LogInfo("\(Swift.type(of: self)) Deinit")
    }

}
