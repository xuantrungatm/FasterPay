//
//  ProfileRouter.swift
//  MyApp
//
//  Created by Xuan Trung on 30/10/2021.
//

import UIKit

protocol ProfileRouterInterface {
    
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

    deinit {
        LogInfo("\(Swift.type(of: self)) Deinit")
    }

}

