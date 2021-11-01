//
//  ProfileInteractor.swift
//  MyApp
//
//  Created by Xuan Trung on 30/10/2021.
//

protocol ProfileInteractorInterface {
    func logOut()
}

final class ProfileInteractor: ProfileInteractorInterface {
    
    @Injected var auth: AuthManagerInterface
    
    func logOut() {
        auth.logOut()
    }

    deinit {
        LogInfo("\(Swift.type(of: self)) Deinit")
    }

}
