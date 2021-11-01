//
//  PaymentSuccessPresenter.swift
//  MyApp
//
//  Created by Xuan Trung on 01/11/2021.
//

protocol PaymentSuccessPresenterInterface: Presenter {
    var view: PaymentSuccessViewInterface { get }
    var router: PaymentSuccessRouterInterface { get }
    var interactor: PaymentSuccessInteractorInterface { get }
    func completeTransaction()
}

final class PaymentSuccessPresenter: PaymentSuccessPresenterInterface, HasActivityIndicator, HasDisposeBag {

    unowned let view: PaymentSuccessViewInterface
    let router: PaymentSuccessRouterInterface
    let interactor: PaymentSuccessInteractorInterface

    let activityIndicator = ActivityIndicator()
    let trigger = PublishRelay<Void>()

    init(view: PaymentSuccessViewInterface,
         router: PaymentSuccessRouterInterface,
         interactor: PaymentSuccessInteractorInterface) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func completeTransaction() {
        router.dismiss()
    }

    deinit {
        LogInfo("\(Swift.type(of: self)) Deinit")
        LeakDetector.instance.expectDeallocate(object: router as AnyObject)
        LeakDetector.instance.expectDeallocate(object: interactor as AnyObject)
    }

}
