//
//  SignInRouter.swift
//  MyApp
//
//  Created by Xuan Trung on 31/10/2021.
//

import UIKit

protocol SignInRouterInterface {
    func moveToHome()
    func moveToSignUp()
}

final class SignInRouter: SignInRouterInterface, Router {

    unowned let viewController: SignInViewController

    required init(viewController: SignInViewController) {
        self.viewController = viewController
        viewController.presenter = SignInPresenter(
            view: viewController,
            router: self,
            interactor: SignInInteractor()
        )
    }
    
    func moveToHome() {
        let mainVC = AppScenes.main.viewController
        UIWindow.shared?.rootViewController = mainVC
    }
    
    func moveToSignUp() {
        let vc = AppScenes.signUp.viewController
        viewController.navigationController?.pushViewController(vc, animated: true)
    }

    deinit {
        LogInfo("\(Swift.type(of: self)) Deinit")
    }

}

