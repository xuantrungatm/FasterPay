//
//  MainInteractor.swift
//  MyApp
//
//

protocol MainInteractorInterface {}

final class MainInteractor: MainInteractorInterface {
    
    deinit {
        LogInfo("\(type(of: self)) Deinit")
    }

}
