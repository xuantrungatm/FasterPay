//
//  WalletViewController.swift
//  MyApp
//
//  Created by Xuan Trung on 30/10/2021.
//

import UIKit
import MJRefresh

final class WalletViewController: BaseTableViewViewController {

    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
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
        containerView.setRadius(corner: [.topLeft, .topRight], cornerRadii: CGSize(width: 20, height:  20))
        tableView.register(cellType: TransactionTableViewCell.self)
        tableView.rx.setDelegate(self) ~ disposeBag
    }
    
    override func tableViewNoData() -> UIView {
        let label = UILabel(frame: tableView.bounds)
        label.text = "No data"
        label.textColor = Asset.Colors.text.color
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }
    
    override func tableViewFooter() -> MJRefreshFooter? {
        return nil
    }

    override func bindDatas() {
        super.bindDatas()
        
        presenter.bind(isLoading: isLoading)
        presenter.bind(paggingable: self)
        
        Observable.just(())
            ~> presenter.userTrigger
            ~ disposeBag
        
        Observable.merge(
            .just(()),
            headerRefreshTrigger.asObservable()
        )
        ~> presenter.trigger
        ~ disposeBag
        
        presenter.elements
            .map({ $0.isEmpty })
            ~> isEmptyData
            ~ disposeBag
        
        presenter.elements
            .bind(to: tableView.rx.items(
                    cellIdentifier: TransactionTableViewCell.reuseIdentifier,
                    cellType: TransactionTableViewCell.self)) { _, element, cell in
                cell.config(transaction: element)
            }
            ~ disposeBag
    }
}

extension WalletViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

extension WalletViewController: WalletViewInterface {
    func updateUI(with user: User?) {
        currencyLabel.text = user?.currency.symbol
        balanceLabel.text = user?.balance.toCurrencyFormat()
    }
}
