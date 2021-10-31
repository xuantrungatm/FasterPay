//
//  BaseViewController.swift
//  MyApp
//
//

import UIKit
import PKHUD

class BaseViewController: UIViewController, HasDisposeBag { // swiftlint:disable:this final_class

    let isLoading = PublishRelay<Bool>()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        bindDatas()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.backBarButtonItem = BackBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func setupUI() {
        
    }

    func bindDatas() {
        isLoading ~> PKHUD.rx.isAnimating ~ disposeBag
    }

}

final class BackBarButtonItem: UIBarButtonItem {
    @available(iOS 14.0, *)
    override var menu: UIMenu? {
        get {
            return nil
        }
        set {
            super.menu = nil
        }
        
    }
}
