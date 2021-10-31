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
        view.setGradientBackground(
            topColor: UIColor(red: 48.0 / 255.0, green: 35.0 / 255.0, blue: 174.0 / 255.0, alpha: 1),
            bottomColor: UIColor(red: 200.0 / 255.0, green: 109.0 / 255.0, blue: 215.0 / 255.0, alpha: 1),
            maskColor: UIColor(red: 28.0 / 255.0, green: 28.0 / 255.0, blue: 28.0 / 255.0, alpha: 1)
        )
        
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
