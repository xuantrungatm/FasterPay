//
//  PaymentViewController.swift
//  MyApp
//
//  Created by Xuan Trung on 01/11/2021.
//

import UIKit

final class PaymentViewController: BaseViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var feeLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var paymentButton: UIButton!
    
    var presenter: PaymentPresenter!
    var info: PaymentInfo?

    deinit {
        LogInfo("\(Swift.type(of: self)) Deinit")
        LeakDetector.instance.expectDeallocate(object: presenter as AnyObject)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        Observable.just(())
            ~> presenter.trigger
            ~ disposeBag
    }

    override func setupUI() {
        super.setupUI()
        containerView.setRadius(corner: [.topLeft, .topRight], cornerRadii: CGSize(width: 20, height:  20))
        nameLabel.text = info?.name
        let currency = Currency(code: info?.currencyCode ?? "")
        totalAmountLabel.text = "\(currency?.symbol ?? "") \((info?.amount ?? 0).toCurrencyFormat())"
        subtotalLabel.text = "\(currency?.symbol ?? "") \((info?.amount ?? 0).toCurrencyFormat()) \(currency?.code ?? "")"
        feeLabel.text = "\(currency?.symbol ?? "") 0.00 \(currency?.code ?? "")"
        paymentButton.setTitle("Pay \(currency?.symbol ?? "") \((info?.amount ?? 0).toCurrencyFormat())", for: .normal)
    }

    @IBAction func clickBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func clickPayment(_ sender: UIButton) {
        guard let info = info else {
            AppHelper.shared.showConfirmAlert(title: "Payment Info is invalid.", message: nil, action: nil)
            return
        }
        presenter.pay(info: info)
    }

    override func bindDatas() {
        super.bindDatas()
        
        presenter.bind(isLoading: isLoading)
    }
    
}

extension PaymentViewController: PaymentViewInterface {
    func updateUI(with user: User?) {
        guard let user = user else { return }
        balanceLabel.text = user.currency.symbol + " " + user.balance.toCurrencyFormat()
    }
    
    func showAlert(content: String, action: ((UIAlertAction) -> Void)? = nil) {
        AppHelper.shared.showConfirmAlert(title: content, message: nil, action: action)
    }
}
