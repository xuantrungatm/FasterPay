//
//  WalletPresenter.swift
//  MyApp
//
//  Created by Xuan Trung on 30/10/2021.
//

protocol WalletPresenterInterface: Presenter {
    var view: WalletViewInterface { get }
    var router: WalletRouterInterface { get }
    var interactor: WalletInteractorInterface { get }
}

final class WalletPresenter: WalletPresenterInterface, PresenterPageable {

    unowned let view: WalletViewInterface
    let router: WalletRouterInterface
    let interactor: WalletInteractorInterface

    let activityIndicator = ActivityIndicator()
    let headerRefreshTrigger = PublishRelay<Void>()
    let footerLoadMoreTrigger = PublishRelay<Void>()
    let isEnableLoadMore = BehaviorRelay<Bool>(value: true)
    let isEmptyData = BehaviorRelay<Bool>(value: true)
    let headerActivityIndicator = ActivityIndicator()
    let footerActivityIndicator = ActivityIndicator()

    let trigger = PublishRelay<Void>()
    let userTrigger = PublishRelay<Void>()
    var currentPage: Int = 1
    let elements = BehaviorRelay<[Transaction]>(value: [])

    init(view: WalletViewInterface,
         router: WalletRouterInterface,
         interactor: WalletInteractorInterface) {
        self.view = view
        self.router = router
        self.interactor = interactor
        
        userTrigger
            .flatMapLatest({ [weak self] () -> Driver<User?> in
                guard let self = self else { return .empty() }
                return self.interactor.getUserInfo()
                    .asDriver(onErrorJustReturn: nil)
            })
            .asDriver(onErrorJustReturn: nil)
            .drive(onNext: { [weak self] user in
                guard let self = self else { return }
                self.view.updateUI(with: user)
            })
            ~ disposeBag
        
        trigger
            .flatMapLatest({ [weak self] () -> Driver<[Transaction]> in
                guard let self = self else { return .empty() }
                return self.interactor.getTransactions()
                    .trackActivity(self.headerActivityIndicator)
                    .asDriver(onErrorJustReturn: [])
            })
            ~> elements
            ~ disposeBag
    }

    deinit {
        LogInfo("\(Swift.type(of: self)) Deinit")
        LeakDetector.instance.expectDeallocate(object: router as AnyObject)
        LeakDetector.instance.expectDeallocate(object: interactor as AnyObject)
    }

}
