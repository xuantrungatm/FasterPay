//
//  PaymentSuccessViewController.swift
//  MyApp
//
//  Created by Xuan Trung on 01/11/2021.
//

import UIKit

final class PaymentSuccessViewController: BaseViewController {
    
    @IBOutlet weak var containerView: UIView!
    
    var presenter: PaymentSuccessPresenter!

    deinit {
        LogInfo("\(Swift.type(of: self)) Deinit")
        LeakDetector.instance.expectDeallocate(object: presenter as AnyObject)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setupUI() {
        super.setupUI()
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 20
    }

    @IBAction func completeTransaction(_ sender: UIButton) {
        presenter.completeTransaction()
    }

    override func bindDatas() {
        super.bindDatas()
        
        presenter.bind(isLoading: isLoading)
    }

}

extension PaymentSuccessViewController: PaymentSuccessViewInterface {}
