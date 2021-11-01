//
//  QRScannerPresenter.swift
//  MyApp
//
//  Created by Xuan Trung on 30/10/2021.
//

protocol QRScannerPresenterInterface: Presenter {
    var view: QRScannerViewInterface { get }
    var router: QRScannerRouterInterface { get }
    var interactor: QRScannerInteractorInterface { get }
    func scanQRSuccess(info: PaymentInfo)
}

final class QRScannerPresenter: QRScannerPresenterInterface, HasActivityIndicator, HasDisposeBag {

    unowned let view: QRScannerViewInterface
    let router: QRScannerRouterInterface
    let interactor: QRScannerInteractorInterface

    let activityIndicator = ActivityIndicator()
    let trigger = PublishRelay<Void>()

    init(view: QRScannerViewInterface,
         router: QRScannerRouterInterface,
         interactor: QRScannerInteractorInterface) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func scanQRSuccess(info: PaymentInfo) {
        router.moveToPayment(with: info)
    }

    deinit {
        LogInfo("\(Swift.type(of: self)) Deinit")
        LeakDetector.instance.expectDeallocate(object: router as AnyObject)
        LeakDetector.instance.expectDeallocate(object: interactor as AnyObject)
    }

}
