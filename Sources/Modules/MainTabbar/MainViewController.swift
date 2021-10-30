//
//  MainViewController.swift
//  My Project
//
//

import UIKit

final class MainViewController: UITabBarController, HasDisposeBag {
    
    var presenter: MainPresenter!

    private let sizeIcon = CGSize(width: 24, height: 24)

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.tintColor = .white
        UITabBar.appearance().tintColor = Asset.Colors.main.color
        
        let wallet = AppScenes.wallet.viewController as! WalletViewController
        let walletNav = BaseNavigationController(rootViewController: wallet)
        walletNav.delegate = self
        walletNav.tabBarItem = UITabBarItem(
            title: "Wallet",
            image: Asset.Assets.icWallet.image,
            selectedImage: Asset.Assets.icWallet.image.tint(with: Asset.Colors.main.color)
        )
        
        let scanner = AppScenes.scanner.viewController as! QRScannerViewController
        let scannerNav = BaseNavigationController(rootViewController: scanner)
        scannerNav.delegate = self
        scannerNav.tabBarItem = UITabBarItem(
            title: "Scan",
            image: Asset.Assets.icScan.image,
            selectedImage: Asset.Assets.icScan.image.tint(with: Asset.Colors.main.color)
        )
        
        let profile = AppScenes.profile.viewController as! ProfileViewController
        let profileNav = BaseNavigationController(rootViewController: profile)
        profileNav.delegate = self
        profileNav.tabBarItem = UITabBarItem(
            title: "Profile",
            image: Asset.Assets.icProfile.image,
            selectedImage: Asset.Assets.icProfile.image.tint(with: Asset.Colors.main.color)
        )
        
        viewControllers = [walletNav, scannerNav, profileNav]
    }
    
    deinit {
        LogInfo("\(type(of: self)) Deinit")
        LeakDetector.instance.expectDeallocate(object: presenter as AnyObject)
    }
}

extension MainViewController: MainViewInterface {}

extension MainViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        let notNeedHiddenTabbar = viewController.isKind(of: WalletViewController.self) || viewController.isKind(of: QRScannerViewController.self) || viewController.isKind(of: ProfileViewController.self)
        let isHiddenNavi = notNeedHiddenTabbar
        tabBar.isHidden = !notNeedHiddenTabbar
        navigationController.setNavigationBarHidden(isHiddenNavi, animated: true)
        if let coordinator = navigationController.topViewController?.transitionCoordinator {
            coordinator.notifyWhenInteractionChanges { [weak self] context in
                if context.isCancelled {
                    self?.tabBar.isHidden = true
                }
            }
        }
    }
}
