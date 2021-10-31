//
//  SignInViewController.swift
//  MyApp
//
//  Created by Xuan Trung on 31/10/2021.
//

import UIKit

final class SignInViewController: BaseViewController {
    
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

    override func bindDatas() {
        super.bindDatas()
        
        presenter.bind(isLoading: isLoading)
    }
    
}

extension SignInViewController: SignInViewInterface {}
