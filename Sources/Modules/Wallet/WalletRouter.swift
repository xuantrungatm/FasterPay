//
//  WalletRouter.swift
//  MyApp
//
//  Created by Xuan Trung on 30/10/2021.
//

import UIKit

protocol WalletRouterInterface {
    
}

final class WalletRouter: WalletRouterInterface, Router {

    unowned let viewController: WalletViewController

    required init(viewController: WalletViewController) {
        self.viewController = viewController
        viewController.presenter = WalletPresenter(
            view: viewController,
            router: self,
            interactor: WalletInteractor()
        )
    }

    deinit {
        LogInfo("\(Swift.type(of: self)) Deinit")
    }

}

