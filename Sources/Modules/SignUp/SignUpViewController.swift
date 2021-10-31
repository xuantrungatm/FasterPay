//
//  SignUpViewController.swift
//  MyApp
//
//  Created by Xuan Trung on 01/11/2021.
//

import UIKit

final class SignUpViewController: BaseViewController {
    
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

    override func bindDatas() {
        super.bindDatas()
        
        presenter.bind(isLoading: isLoading)
    }
    
}

extension SignUpViewController: SignUpViewInterface {}
