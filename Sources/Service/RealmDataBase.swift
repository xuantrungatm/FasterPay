//
//  RealmDataBase.swift
//  MyApp
//
//  Created by Xuan Trung on 01/11/2021.
//

import Foundation
import RealmSwift

protocol RealmDataBaseInterface {
    func createUser(user: RMUser) -> Single<Bool>
    func getUserInfo(email: String) -> Single<RMUser?>
    func login(email: String, pass: String) -> Single<Bool>
}

final class RealmDataBase: RealmDataBaseInterface {
    
    let realm = try? Realm()
    
    func createUser(user: RMUser) -> Single<Bool> {
        Single<Bool>.create { [weak self] single in
            if self?.realm?.object(ofType: RMUser.self, forPrimaryKey: user.email) != nil {
                single(.success(false))
            } else {
                try? self?.realm?.write {
                    self?.realm?.add(user)
                    single(.success(true))
                }
            }
            return Disposables.create()
        }
    }
    
    func getUserInfo(email: String) -> Single<RMUser?> {
        Single<RMUser?>.create { [weak self] single in
            if let user = self?.realm?.object(ofType: RMUser.self, forPrimaryKey: email) {
                single(.success(user))
            } else {
                single(.success(nil))
            }
            return Disposables.create()
        }
    }
    
    func login(email: String, pass: String) -> Single<Bool> {
        Single<Bool>.create { [weak self] single in
            if let user = self?.realm?.object(ofType: RMUser.self, forPrimaryKey: email),
               user.password ==  pass {
                single(.success(true))
            } else {
                single(.success(false))
            }
            return Disposables.create()
        }
    }
    
}
