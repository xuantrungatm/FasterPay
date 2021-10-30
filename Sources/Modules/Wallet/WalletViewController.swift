//
//  WalletViewController.swift
//  MyApp
//
//  Created by Xuan Trung on 30/10/2021.
//

import UIKit

final class WalletViewController: BaseViewController {
    
    var presenter: WalletPresenter!

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

extension WalletViewController: WalletViewInterface {}
