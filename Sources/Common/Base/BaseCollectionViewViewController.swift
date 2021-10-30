//
//  BaseCollectionViewViewController.swift
//  MyApp
//
//

import UIKit
import MJRefresh

class BaseCollectionViewViewController: BaseViewController, ViewControllerPageable { // swiftlint:disable:this final_class

    let headerRefreshTrigger = PublishRelay<Void>()
    let footerLoadMoreTrigger = PublishRelay<Void>()
    let isEnableLoadMore = PublishRelay<Bool>()
    let isEmptyData = PublishRelay<Bool>()
    let isHeaderLoading = PublishRelay<Bool>()
    let isFooterLoading = PublishRelay<Bool>()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func bindDatas() {
        super.bindDatas()
                
        // header
        collectionView.mj_header = viewForHeaderOfCollectionView()
        isHeaderLoading
            .bind(to: rx.isAnimatingHeaderBinder)
            .disposed(by: disposeBag)
        
        // footer
        collectionView.mj_footer = viewForFooterOfCollectionView()
        
        // check logic animation footer
        Observable
            .combineLatest(isFooterLoading, isEnableLoadMore) { value, isEnable in
                return isEnable ? value : nil
            }
            .compactMap { $0 }
            .asDriverOnErrorJustComplete()
            .drive(rx.isAnimatingFooterBinder)
            .disposed(by: disposeBag)
        
        // loadmore
        isEnableLoadMore
            .bind(to: rx.isEnableLoadMoreBinder)
            .disposed(by: disposeBag)
                
        // empty data
        isEmptyData
            .asDriverOnErrorJustComplete()
            .drive(rx.isEmpyDataBinder)
            .disposed(by: disposeBag)
    }
    
    func viewForHeaderOfCollectionView() -> MJRefreshHeader? {
        let header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            self?.headerRefreshTrigger.accept(())
        })
        header.lastUpdatedTimeLabel?.isHidden = true
        header.stateLabel?.isHidden = true
        return header
    }
    
    func viewForFooterOfCollectionView() -> MJRefreshFooter? {
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
    
    func viewForEmptyDataOfCollectionView() -> UIView {
        return UIView()
    }
    
    func setNoDataView() {
        collectionView.backgroundView = viewForEmptyDataOfCollectionView()
    }
    
    func removeNoDataView() {
        collectionView.backgroundView = nil
    }
    
}

extension Reactive where Base: BaseCollectionViewViewController {
    
    var isEnableLoadMoreBinder: Binder<Bool> {
        return Binder(base) { viewController, enable in
            if enable {
                viewController.collectionView.mj_footer?.resetNoMoreData()
            } else {
                viewController.collectionView.mj_footer?.endRefreshingWithNoMoreData()
            }
        }
    }
    
    var isAnimatingHeaderBinder: Binder<Bool> {
        return Binder(base) { viewController, loading in
            if loading {
                
            } else {
                viewController.collectionView.mj_header?.endRefreshing()
            }
        }
    }

    var isAnimatingFooterBinder: Binder<Bool> {
        return Binder(base) { viewController, loading in
            if loading {
                
            } else {
                viewController.collectionView.mj_footer?.endRefreshing()
            }
        }
    }
    
    var isEmpyDataBinder: Binder<Bool> {
        return Binder(base) { viewController, emptyData in
            if emptyData {
                viewController.setNoDataView()
            } else {
                viewController.removeNoDataView()
            }
        }
    }
    
}
