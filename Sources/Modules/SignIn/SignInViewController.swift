//
//  SignInViewController.swift
//  MyApp
//
//  Created by Xuan Trung on 31/10/2021.
//

import UIKit

final class SignInViewController: BaseViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    var presenter: SignInPresenter!

    deinit {
        LogInfo("\(Swift.type(of: self)) Deinit")
        LeakDetector.instance.expectDeallocate(object: presenter as AnyObject)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setupUI() {
        super.setupUI()
    }

    @IBAction func clickSignIn(_ sender: UIButton) {
        let info = SignInPresenter.LoginInfo(
            email: emailTextField.text ?? "",
            pass: passTextField.text ?? ""
        )
        Observable.just(info)
            ~> presenter.trigger
            ~ disposeBag
    }
    
    @IBAction func clickSignUp(_ sender: UIButton) {
        presenter.handleSignUp()
    }

    override func bindDatas() {
        super.bindDatas()
        
        presenter.bind(isLoading: isLoading)
    }
    
}

extension SignInViewController: SignInViewInterface {
    func showAlert(content: String) {
        AppHelper.shared.showConfirmAlert(title: content, message: nil, action: nil)
    }
}
