//
//  ProfilePresenter.swift
//  MyApp
//
//  Created by Xuan Trung on 30/10/2021.
//

protocol ProfilePresenterInterface: Presenter {
    var view: ProfileViewInterface { get }
    var router: ProfileRouterInterface { get }
    var interactor: ProfileInteractorInterface { get }
    func handleLogOut()
}

final class ProfilePresenter: ProfilePresenterInterface, HasActivityIndicator, HasDisposeBag {

    unowned let view: ProfileViewInterface
    let router: ProfileRouterInterface
    let interactor: ProfileInteractorInterface

    let activityIndicator = ActivityIndicator()
    let trigger = PublishRelay<Void>()

    init(view: ProfileViewInterface,
         router: ProfileRouterInterface,
         interactor: ProfileInteractorInterface) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }

    deinit {
        LogInfo("\(Swift.type(of: self)) Deinit")
        LeakDetector.instance.expectDeallocate(object: router as AnyObject)
        LeakDetector.instance.expectDeallocate(object: interactor as AnyObject)
    }

    func handleLogOut() {
        interactor.logOut()
        router.moveToSignIn()
    }

}
