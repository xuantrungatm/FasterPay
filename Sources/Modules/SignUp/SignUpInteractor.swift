//
//  SignUpInteractor.swift
//  MyApp
//
//  Created by Xuan Trung on 01/11/2021.
//

protocol SignUpInteractorInterface {
    func createUser(user: User) -> Single<Bool>
}

final class SignUpInteractor: SignUpInteractorInterface {
    
    @Injected var database: RealmDataBaseInterface
    
    func createUser(user: User) -> Single<Bool> {
        database.createUser(user: user.asRealm())
    }

    deinit {
        LogInfo("\(Swift.type(of: self)) Deinit")
    }

}
