//
//  QRScannerRouter.swift
//  MyApp
//
//  Created by Xuan Trung on 30/10/2021.
//

import UIKit

protocol QRScannerRouterInterface {
    func moveToPayment(with info: PaymentInfo)
}

final class QRScannerRouter: QRScannerRouterInterface, Router {

    unowned let viewController: QRScannerViewController

    required init(viewController: QRScannerViewController) {
        self.viewController = viewController
        viewController.presenter = QRScannerPresenter(
            view: viewController,
            router: self,
            interactor: QRScannerInteractor()
        )
    }
    
    func moveToPayment(with info: PaymentInfo) {
        let vc = AppScenes.payment(info: info).viewController
        viewController.navigationController?.pushViewController(vc, animated: true)
    }

    deinit {
        LogInfo("\(Swift.type(of: self)) Deinit")
    }

}

