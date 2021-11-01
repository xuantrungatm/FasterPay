//
//  PaymentInteractor.swift
//  MyApp
//
//  Created by Xuan Trung on 01/11/2021.
//

protocol PaymentInteractorInterface {
    func getUserInfo() -> Single<User?>
    func add(transaction: Transaction) -> Single<Bool>
}

final class PaymentInteractor: PaymentInteractorInterface {

    @Injected var auth: AuthManagerInterface
    @Injected var database: RealmDataBaseInterface
    
    func getUserInfo() -> Single<User?> {
        guard let email = auth.currentUser else { return .just(nil) }
        return database.getUserInfo(email: email).map { $0?.asDomain() }
    }
    
    func add(transaction: Transaction) -> Single<Bool> {
        guard let email = auth.currentUser else { return .just(false) }
        return database.createTransaction(email: email, transaction: transaction.asRealm())
    }
    
    deinit {
        LogInfo("\(Swift.type(of: self)) Deinit")
    }

}
