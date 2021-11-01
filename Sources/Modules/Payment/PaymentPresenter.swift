//
//  PaymentPresenter.swift
//  MyApp
//
//  Created by Xuan Trung on 01/11/2021.
//

protocol PaymentPresenterInterface: Presenter {
    var view: PaymentViewInterface { get }
    var router: PaymentRouterInterface { get }
    var interactor: PaymentInteractorInterface { get }
    func pay(info: PaymentInfo)
}

final class PaymentPresenter: PaymentPresenterInterface, HasActivityIndicator, HasDisposeBag {

    unowned let view: PaymentViewInterface
    let router: PaymentRouterInterface
    let interactor: PaymentInteractorInterface

    let activityIndicator = ActivityIndicator()
    let trigger = PublishRelay<Void>()
    let transactionTrigger = PublishRelay<PaymentInfo>()
    private var user: User?

    init(view: PaymentViewInterface,
         router: PaymentRouterInterface,
         interactor: PaymentInteractorInterface) {
        self.view = view
        self.router = router
        self.interactor = interactor
        
        trigger
            .flatMapLatest({ [weak self] () -> Driver<User?> in
                guard let self = self else { return .empty() }
                return self.interactor.getUserInfo()
                    .asDriver(onErrorJustReturn: nil)
            })
            .asDriver(onErrorJustReturn: nil)
            .drive(onNext: { [weak self] user in
                guard let self = self else { return }
                self.user = user
                self.view.updateUI(with: user)
            })
            ~ disposeBag
        
        let transactionResult = transactionTrigger
            .map({ [weak self] in self?.toTransaction(from: $0) })
            .unwrap()
            .flatMapLatest({ [weak self] value -> Driver<Bool> in
                guard let self = self else { return .empty() }
                return self.interactor.add(transaction: value)
                    .trackActivity(self.activityIndicator)
                    .asDriver(onErrorJustReturn: false)
            })
            .asDriver(onErrorJustReturn: false)
            
        transactionResult
            .filter({ $0 })
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.paySuccess()
            })
            ~ disposeBag
        
        transactionResult
            .filter({ !$0 })
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.view.showAlert(content: "Transaction failed!", action: nil)
            })
            ~ disposeBag
    }
    
    func pay(info: PaymentInfo) {
        let paymentAmount = convertToCurrencyOfUser(info: info)
        if canPay(amount: paymentAmount) {
            transactionTrigger.accept(info)
        } else {
            view.showAlert(content: "The amount to be paid exceeds the balance.") { [weak self] _ in
                guard let self = self else { return }
                self.router.backToScanQR()
            }
        }
    }
    
    private func toTransaction(from paymentInfo: PaymentInfo) -> Transaction {
        return Transaction(
            id: UUID().uuidString,
            amount: paymentInfo.amount ?? 0,
            currency: Currency(code: paymentInfo.currencyCode ?? "") ?? .vnd,
            content: paymentInfo.name ?? "",
            date: Date()
        )
    }
    
    private func convertToCurrencyOfUser(info: PaymentInfo) -> Double {
        let userCurrency = user?.currency ?? .vnd
        var paymentAmount = info.amount ?? 0
        let paymentCurrency = Currency(code: info.currencyCode ?? "") ?? .vnd
        paymentAmount = paymentAmount / paymentCurrency.valuePerUSD * userCurrency.valuePerUSD
        return paymentAmount
    }
    
    private func canPay(amount: Double) -> Bool {
        let balance = user?.balance ?? 0
        return amount <= balance
    }
    
    private func paySuccess() {
        router.presentPaymentSuccess()
    }

    deinit {
        LogInfo("\(Swift.type(of: self)) Deinit")
        LeakDetector.instance.expectDeallocate(object: router as AnyObject)
        LeakDetector.instance.expectDeallocate(object: interactor as AnyObject)
    }

}
