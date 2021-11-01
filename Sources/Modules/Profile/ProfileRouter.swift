//
//  ProfileRouter.swift
//  MyApp
//
//  Created by Xuan Trung on 30/10/2021.
//

import UIKit

protocol ProfileRouterInterface {
    func moveToSignIn()
}

final class ProfileRouter: ProfileRouterInterface, Router {

    unowned let viewController: ProfileViewController

    required init(viewController: ProfileViewController) {
        self.viewController = viewController
        viewController.presenter = ProfilePresenter(
            view: viewController,
            router: self,
            interactor: ProfileInteractor()
        )
    }
    
    func moveToSignIn() {
        let vc = AppScenes.signIn.viewController
        UIWindow.shared?.rootViewController = BaseNavigationController(rootViewController: vc)
    }

    deinit {
        LogInfo("\(Swift.type(of: self)) Deinit")
    }

}

