//
//  WalletPresenter.swift
//  MyApp
//
//  Created by Xuan Trung on 30/10/2021.
//

protocol WalletPresenterInterface: Presenter {
    var view: WalletViewInterface { get }
    var router: WalletRouterInterface { get }
    var interactor: WalletInteractorInterface { get }
}

final class WalletPresenter: WalletPresenterInterface, HasActivityIndicator, HasDisposeBag {

    unowned let view: WalletViewInterface
    let router: WalletRouterInterface
    let interactor: WalletInteractorInterface

    let activityIndicator = ActivityIndicator()
    let trigger = PublishRelay<Void>()

    init(view: WalletViewInterface,
         router: WalletRouterInterface,
         interactor: WalletInteractorInterface) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }

    deinit {
        LogInfo("\(Swift.type(of: self)) Deinit")
        LeakDetector.instance.expectDeallocate(object: router as AnyObject)
        LeakDetector.instance.expectDeallocate(object: interactor as AnyObject)
    }

}
