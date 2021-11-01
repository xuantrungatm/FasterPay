//
//  SignUpViewController.swift
//  MyApp
//
//  Created by Xuan Trung on 01/11/2021.
//

import UIKit

final class SignUpViewController: BaseViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var termSwitch: UISwitch!
    var presenter: SignUpPresenter!

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
        presenter.handleSignIn()
    }
    
    @IBAction func clickSignUp(_ sender: UIButton) {
        if termSwitch.isOn {
            let count = Currency.allCases.count
            let user = User(
                email: emailTextField.text ?? "",
                password: pwTextField.text ?? "",
                firstName: firstNameTextField.text ?? "",
                lastName: lastNameTextField.text ?? "",
                transactions: [],
                balance: Double(Int.random(in: 1000...10000)),
                currency: Currency(rawValue: Int.random(in: 0..<count)) ?? .vnd
            )
            Observable.just(user)
            ~> presenter.trigger
            ~ disposeBag
        } else {
            AppHelper.shared.showConfirmAlert(title: "Please agree term and policy.", message: nil, action: nil)
        }
    }

    override func bindDatas() {
        super.bindDatas()
        
        presenter.bind(isLoading: isLoading)
    }
    
}

extension SignUpViewController: SignUpViewInterface {
    func showAlert(content: String) {
        AppHelper.shared.showConfirmAlert(title: content, message: nil, action: nil)
    }
    
    func showAlert(content: String, action: ((UIAlertAction) -> Void)? = nil) {
        AppHelper.shared.showConfirmAlert(title: content, message: nil, action: action)
    }
}
