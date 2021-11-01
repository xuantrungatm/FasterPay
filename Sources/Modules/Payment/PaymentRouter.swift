//
//  PaymentRouter.swift
//  MyApp
//
//  Created by Xuan Trung on 01/11/2021.
//

import UIKit

protocol PaymentRouterInterface {
    func presentPaymentSuccess()
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
    
    func presentPaymentSuccess() {
        let vc = AppScenes.paymentSuccess.viewController
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        viewController.present(vc, animated: true, completion: nil)
    }

    deinit {
        LogInfo("\(Swift.type(of: self)) Deinit")
    }

}

