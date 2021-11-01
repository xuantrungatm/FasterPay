//
//  PaymentViewController.swift
//  MyApp
//
//  Created by Xuan Trung on 01/11/2021.
//

import UIKit

final class PaymentViewController: BaseViewController {
    
    var presenter: PaymentPresenter!
    var info: PaymentInfo?

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

    @IBAction func clickBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

    override func bindDatas() {
        super.bindDatas()
        
        presenter.bind(isLoading: isLoading)
    }
    
}

extension PaymentViewController: PaymentViewInterface {}
