//
//  SignUpRouter.swift
//  MyApp
//
//  Created by Xuan Trung on 01/11/2021.
//

import UIKit

protocol SignUpRouterInterface {
    
}

final class SignUpRouter: SignUpRouterInterface, Router {

    unowned let viewController: SignUpViewController

    required init(viewController: SignUpViewController) {
        self.viewController = viewController
        viewController.presenter = SignUpPresenter(view: viewController,
                                                   router: self,
                                                   interactor: SignUpInteractor())
    }

    deinit {
        LogInfo("\(Swift.type(of: self)) Deinit")
    }

}

