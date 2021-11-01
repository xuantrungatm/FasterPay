//
//  SignInPresenter.swift
//  MyApp
//
//  Created by Xuan Trung on 31/10/2021.
//

protocol SignInPresenterInterface: Presenter {
    var view: SignInViewInterface { get }
    var router: SignInRouterInterface { get }
    var interactor: SignInInteractorInterface { get }
    func handleSignUp()
}

final class SignInPresenter: SignInPresenterInterface, HasActivityIndicator, HasDisposeBag {
    
    struct LoginInfo {
        var email: String
        var pass: String
    }

    unowned let view: SignInViewInterface
    let router: SignInRouterInterface
    let interactor: SignInInteractorInterface

    let activityIndicator = ActivityIndicator()
    let trigger = PublishRelay<LoginInfo>()

    init(view: SignInViewInterface,
         router: SignInRouterInterface,
         interactor: SignInInteractorInterface) {
        self.view = view
        self.router = router
        self.interactor = interactor
        
        let loginReuslt = trigger
            .flatMapLatest({ [weak self] user -> Driver<Bool> in
                guard let self = self, self.isValid(user: user) else { return .empty() }
                return self.interactor.login(email: user.email, pass: user.pass)
                    .asDriver(onErrorJustReturn: false)
            })
            .asDriver(onErrorJustReturn: false)
            
        loginReuslt
            .filter({ $0 })
            .withLatestFrom(trigger.asDriverOnErrorJustComplete())
            .drive(onNext: { [weak self] user in
                guard let self = self else { return }
                self.interactor.saveUser(email: user.email)
                self.router.moveToHome()
            })
            ~ disposeBag
        
        loginReuslt
            .filter({ !$0 })
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.view.showAlert(content: "Login fail!")
            })
            ~ disposeBag
    }

    func handleSignUp() {
        router.moveToSignUp()
    }
    
    func isValid(user: LoginInfo) -> Bool {
        if user.email.isEmpty {
            view.showAlert(content: "Email is empty.")
            return false
        }
        if !user.email.isValidEmail() {
            view.showAlert(content: "Email is invalid.")
            return false
        }
        if user.pass.isEmpty {
            view.showAlert(content: "Password is empty.")
            return false
        }
        if !user.pass.isValidPassword() {
            view.showAlert(content: "Password is invalid.")
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
