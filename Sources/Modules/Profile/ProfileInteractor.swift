//
//  ProfileInteractor.swift
//  MyApp
//
//  Created by Xuan Trung on 30/10/2021.
//

protocol ProfileInteractorInterface {

}

final class ProfileInteractor: ProfileInteractorInterface {

    deinit {
        LogInfo("\(Swift.type(of: self)) Deinit")
    }

}
