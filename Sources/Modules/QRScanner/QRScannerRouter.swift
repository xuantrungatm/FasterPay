//
//  QRScannerRouter.swift
//  MyApp
//
//  Created by Xuan Trung on 30/10/2021.
//

import UIKit

protocol QRScannerRouterInterface {
    
}

final class QRScannerRouter: QRScannerRouterInterface, Router {

    unowned let viewController: QRScannerViewController

    required init(viewController: QRScannerViewController) {
        self.viewController = viewController
        viewController.presenter = QRScannerPresenter(view: viewController,
                                                   router: self,
                                                   interactor: QRScannerInteractor())
    }

    deinit {
        LogInfo("\(Swift.type(of: self)) Deinit")
    }

}

