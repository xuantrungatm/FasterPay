//
//  WalletInteractor.swift
//  MyApp
//
//  Created by Xuan Trung on 30/10/2021.
//

protocol WalletInteractorInterface {
    func getUserInfo() -> Single<User?>
    func getTransactions() -> Single<[Transaction]>
}

final class WalletInteractor: WalletInteractorInterface {
    
    @Injected var auth: AuthManagerInterface
    @Injected var database: RealmDataBaseInterface
    
    func getUserInfo() -> Single<User?> {
        guard let email = auth.currentUser else { return .just(nil) }
        return database.getUserInfo(email: email).map { $0?.asDomain() }
    }
    
    func getTransactions() -> Single<[Transaction]> {
        guard let email = auth.currentUser else { return .just([]) }
        return database.allTransactions(email: email).map { obj -> [Transaction] in
            obj.map { $0.asDomain() }
        }
    }

    deinit {
        LogInfo("\(Swift.type(of: self)) Deinit")
    }

}
