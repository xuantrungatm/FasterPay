//
//  MainRouter.swift
//  MyApp
//
//

import UIKit

protocol MainRouterInterface {
    
}

final class MainRouter: MainRouterInterface, Router {

    unowned let viewController: MainViewController

    required init(viewController: MainViewController) {
        self.viewController = viewController
        viewController.presenter = MainPresenter(
            view: viewController,
            router: self,
            interactor: MainInteractor()
        )
    }

    deinit {
        LogInfo("\(type(of: self)) Deinit")
    }

}

