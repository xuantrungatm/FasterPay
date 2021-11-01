//
//  ProfileInteractor.swift
//  MyApp
//
//  Created by Xuan Trung on 30/10/2021.
//

protocol ProfileInteractorInterface {
    func getUserInfo() -> Single<User?>
    func logOut()
}

final class ProfileInteractor: ProfileInteractorInterface {
    
    @Injected var auth: AuthManagerInterface
    @Injected var database: RealmDataBaseInterface
    
    func getUserInfo() -> Single<User?> {
        guard let email = auth.currentUser else { return .just(nil) }
        return database.getUserInfo(email: email).map { $0?.asDomain() }
    }
    
    func logOut() {
        auth.logOut()
    }

    deinit {
        LogInfo("\(Swift.type(of: self)) Deinit")
    }

}
