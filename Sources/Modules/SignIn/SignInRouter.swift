//
//  SignInRouter.swift
//  MyApp
//
//  Created by Xuan Trung on 31/10/2021.
//

import UIKit

protocol SignInRouterInterface {
    
}

final class SignInRouter: SignInRouterInterface, Router {

    unowned let viewController: SignInViewController

    required init(viewController: SignInViewController) {
        self.viewController = viewController
        viewController.presenter = SignInPresenter(view: viewController,
                                                   router: self,
                                                   interactor: SignInInteractor())
    }

    deinit {
        LogInfo("\(Swift.type(of: self)) Deinit")
    }

}

