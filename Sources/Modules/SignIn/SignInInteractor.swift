//
//  SignInInteractor.swift
//  MyApp
//
//  Created by Xuan Trung on 31/10/2021.
//

protocol SignInInteractorInterface {
    func login(email: String, pass: String) -> Single<Bool>
    func saveUser(email: String)
}

final class SignInInteractor: SignInInteractorInterface {
    
    @Injected var database: RealmDataBaseInterface
    @Injected var auth: AuthManagerInterface
    
    func login(email: String, pass: String) -> Single<Bool> {
        database.login(email: email, pass: pass)
    }
    
    func saveUser(email: String) {
        auth.currentUser = email
    }

    deinit {
        LogInfo("\(Swift.type(of: self)) Deinit")
    }

}
