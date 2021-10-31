//
//  SignUpPresenter.swift
//  MyApp
//
//  Created by Xuan Trung on 01/11/2021.
//

protocol SignUpPresenterInterface: Presenter {
    var view: SignUpViewInterface { get }
    var router: SignUpRouterInterface { get }
    var interactor: SignUpInteractorInterface { get }
}

final class SignUpPresenter: SignUpPresenterInterface, HasActivityIndicator, HasDisposeBag {

    unowned let view: SignUpViewInterface
    let router: SignUpRouterInterface
    let interactor: SignUpInteractorInterface

    let activityIndicator = ActivityIndicator()
    let trigger = PublishRelay<Void>()

    init(view: SignUpViewInterface,
         router: SignUpRouterInterface,
         interactor: SignUpInteractorInterface) {
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
