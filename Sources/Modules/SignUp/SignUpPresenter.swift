//
//  SignUpPresenter.swift
//  MyApp
//
//  Created by Xuan Trung on 01/11/2021.
//

protocol SignUpPresenterInterface: Presenter {
    var view: SignUpViewInterface { get }
    var router: SignUpRouterInterface { get }
    var interactor: SignUpInteractorInterface { get }
    func handleSignIn()
    func isValid(user: User) -> Bool
}

final class SignUpPresenter: SignUpPresenterInterface, HasActivityIndicator, HasDisposeBag {

    unowned let view: SignUpViewInterface
    let router: SignUpRouterInterface
    let interactor: SignUpInteractorInterface

    let activityIndicator = ActivityIndicator()
    let trigger = PublishRelay<User>()

    init(view: SignUpViewInterface,
         router: SignUpRouterInterface,
         interactor: SignUpInteractorInterface) {
        self.view = view
        self.router = router
        self.interactor = interactor
        
        trigger
            .flatMapLatest({ [weak self] user -> Driver<Bool> in
                guard let self = self, self.isValid(user: user) else { return .empty() }
                return self.interactor.createUser(user: user)
                    .asDriver(onErrorJustReturn: false)
            })
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: { [weak self] result in
                guard let self = self else { return }
                if result {
                    self.view.showAlert(content: "Register user successfully.")
                    self.router.backToSignIn()
                } else {
                    self.view.showAlert(content: "Email existed!")
                }
            })
            ~ disposeBag
    }

    func handleSignIn() {
        router.backToSignIn()
    }
    
    func isValid(user: User) -> Bool {
        if user.email.isEmpty {
            view.showAlert(content: "Email is empty.")
            return false
        }
        if !user.email.isValidEmail() {
            view.showAlert(content: "Email is invalid.")
            return false
        }
        if user.password.isEmpty {
            view.showAlert(content: "Password is empty.")
            return false
        }
        if !user.password.isValidPassword() {
            view.showAlert(content: "Password is invalid.")
            return false
        }
        if user.firstName.isEmpty {
            view.showAlert(content: "First name is empty.")
            return false
        }
        if user.lastName.isEmpty {
            view.showAlert(content: "Last name is empty.")
            return false
        }
        return true
    }

    deinit {
        LogInfo("\(Swift.type(of: self)) Deinit")
        LeakDetector.instance.expectDeallocate(object: router as AnyObject)
        LeakDetector.instance.expectDeallocate(object: interactor as AnyObject)
    }

}
