//
//  PaymentRouter.swift
//  MyApp
//
//  Created by Xuan Trung on 01/11/2021.
//

import UIKit

protocol PaymentRouterInterface {
    
}

final class PaymentRouter: PaymentRouterInterface, Router {

    unowned let viewController: PaymentViewController

    required init(viewController: PaymentViewController) {
        self.viewController = viewController
        viewController.presenter = PaymentPresenter(
            view: viewController,
            router: self,
            interactor: PaymentInteractor()
        )
    }

    deinit {
        LogInfo("\(Swift.type(of: self)) Deinit")
    }

}

