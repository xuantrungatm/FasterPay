//
//  MainPresenter.swift
//  MyApp
//
//

protocol MainPresenterInterface: Presenter {
    var view: MainViewInterface { get }
    var router: MainRouterInterface { get }
    var interactor: MainInteractorInterface { get }
}

final class MainPresenter: MainPresenterInterface, HasDisposeBag {
    
    unowned let view: MainViewInterface
    let router: MainRouterInterface
    let interactor: MainInteractorInterface
    
    init(view: MainViewInterface,
         router: MainRouterInterface,
         interactor: MainInteractorInterface) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }

    deinit {
        LogInfo("\(type(of: self)) Deinit")
        LeakDetector.instance.expectDeallocate(object: router as AnyObject)
        LeakDetector.instance.expectDeallocate(object: interactor as AnyObject)
    }

}
