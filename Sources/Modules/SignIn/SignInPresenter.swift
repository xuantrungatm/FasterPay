//
//  SignInPresenter.swift
//  MyApp
//
//  Created by Xuan Trung on 31/10/2021.
//

protocol SignInPresenterInterface: Presenter {
    var view: SignInViewInterface { get }
    var router: SignInRouterInterface { get }
    var interactor: SignInInteractorInterface { get }
}

final class SignInPresenter: SignInPresenterInterface, HasActivityIndicator, HasDisposeBag {

    unowned let view: SignInViewInterface
    let router: SignInRouterInterface
    let interactor: SignInInteractorInterface

    let activityIndicator = ActivityIndicator()
    let trigger = PublishRelay<Void>()

    init(view: SignInViewInterface,
         router: SignInRouterInterface,
         interactor: SignInInteractorInterface) {
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
