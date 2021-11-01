//
//  PaymentPresenter.swift
//  MyApp
//
//  Created by Xuan Trung on 01/11/2021.
//

protocol PaymentPresenterInterface: Presenter {
    var view: PaymentViewInterface { get }
    var router: PaymentRouterInterface { get }
    var interactor: PaymentInteractorInterface { get }
}

final class PaymentPresenter: PaymentPresenterInterface, HasActivityIndicator, HasDisposeBag {

    unowned let view: PaymentViewInterface
    let router: PaymentRouterInterface
    let interactor: PaymentInteractorInterface

    let activityIndicator = ActivityIndicator()
    let trigger = PublishRelay<Void>()

    init(view: PaymentViewInterface,
         router: PaymentRouterInterface,
         interactor: PaymentInteractorInterface) {
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
