//
//  PaymentSuccessRouter.swift
//  MyApp
//
//  Created by Xuan Trung on 01/11/2021.
//

import UIKit

protocol PaymentSuccessRouterInterface {
    func dismiss()
}

final class PaymentSuccessRouter: PaymentSuccessRouterInterface, Router {

    unowned let viewController: PaymentSuccessViewController

    required init(viewController: PaymentSuccessViewController) {
        self.viewController = viewController
        viewController.presenter = PaymentSuccessPresenter(
            view: viewController,
            router: self,
            interactor: PaymentSuccessInteractor()
        )
    }
    
    func dismiss() {
        viewController.dismiss(animated: true) {
            let rootVC = UIApplication.shared.keyWindow?.rootViewController
            let tabbarVC = rootVC as? MainViewController
            AppHelper.shared.topViewController()?.navigationController?.popToRootViewController(animated: false)
            tabbarVC?.selectedIndex = 0
        }
    }

    deinit {
        LogInfo("\(Swift.type(of: self)) Deinit")
    }

}

