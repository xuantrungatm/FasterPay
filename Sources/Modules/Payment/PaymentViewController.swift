//
//  PaymentViewController.swift
//  MyApp
//
//  Created by Xuan Trung on 01/11/2021.
//

import UIKit

final class PaymentViewController: BaseViewController {
    
    @IBOutlet weak var containerView: UIView!
    
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
        containerView.setRadius(corner: [.topLeft, .topRight], cornerRadii: CGSize(width: 20, height:  20))
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
