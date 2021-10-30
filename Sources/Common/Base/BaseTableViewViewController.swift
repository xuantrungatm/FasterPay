//
//  BaseTableViewViewController.swift
//  MyApp
//
//

import UIKit
import MJRefresh

class BaseTableViewViewController: BaseViewController, ViewControllerPageable { // swiftlint:disable:this final_class

    let headerRefreshTrigger = PublishRelay<Void>()
    let footerLoadMoreTrigger = PublishRelay<Void>()
    let isEnableLoadMore = PublishRelay<Bool>()
    let isHeaderLoading = PublishRelay<Bool>()
    let isFooterLoading = PublishRelay<Bool>()
    let isEmptyData = PublishRelay<Bool>()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupUI() {
        super.setupUI()
        
        tableView.tableFooterView = UIView()
    }
        
    override func bindDatas() {
        super.bindDatas()
        
        // header
        tableView.mj_header = tableViewHeader()
        isHeaderLoading
            .bind(to: rx.isAnimatingHeader)
            .disposed(by: disposeBag)
        
        // footer
        tableView.mj_footer = tableViewFooter()

        // check logic animation footer
        Observable
            .combineLatest(isFooterLoading, isEnableLoadMore) { value, isEnable in
                return isEnable ? value : nil
            }
            .compactMap { $0 }
            .asDriverOnErrorJustComplete()
            .drive(rx.isAnimatingFooter)
            .disposed(by: disposeBag)

        // no data
        isEmptyData
            .bind(to: rx.isEmpyData)
            .disposed(by: disposeBag)

        // loadmore
        isEnableLoadMore
            .bind(to: rx.isEnableLoadMoreBinder)
            .disposed(by: disposeBag)
    }
    
    func tableViewHeader() -> MJRefreshHeader? {
        let header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            self?.headerRefreshTrigger.accept(())
        })
        header.lastUpdatedTimeLabel?.isHidden = true
        header.stateLabel?.isHidden = true
        return header
    }
    
    func tableViewFooter() -> MJRefreshFooter? {
        let footer = MJRefreshAutoNormalFooter(refreshingBlock: { [weak self] in
            self?.footerLoadMoreTrigger.accept(())
        })
        footer.setTitle("", for: .noMoreData)
        footer.setTitle("", for: .willRefresh)
        footer.setTitle("", for: .pulling)
        footer.setTitle("Loading...", for: .refreshing)
        footer.setTitle("", for: .idle)
        return footer
    }
    
    func tableViewNoData() -> UIView {
        return UIView()
    }
    
    fileprivate func setNoDataView() {
        tableView.backgroundView = tableViewNoData()
    }
    
    fileprivate func removeNoDataView() {
        tableView.backgroundView = nil
    }
    
}

extension Reactive where Base: BaseTableViewViewController {
    
    var isEnableLoadMoreBinder: Binder<Bool> {
        return Binder(base) { viewController, enable in
            if enable {
                viewController.tableView.mj_footer?.resetNoMoreData()
            } else {
                viewController.tableView.mj_footer?.endRefreshingWithNoMoreData()
            }
        }
    }
    
    var isAnimatingHeader: Binder<Bool> {
        return Binder(base) { viewController, loading in
            if loading {
            } else {
                viewController.tableView.mj_header?.endRefreshing()
            }
        }
    }

    var isAnimatingFooter: Binder<Bool> {
        return Binder(base) { viewController, loading in
            if loading {
            } else {
                viewController.tableView.mj_footer?.endRefreshing()
            }
        }
    }
    
    var isEmpyData: Binder<Bool> {
        return Binder(base) { viewController, emptyData in
            if emptyData {
                viewController.setNoDataView()
            } else {
                viewController.removeNoDataView()
            }
        }
    }
}
