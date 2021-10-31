//
//  MainViewController.swift
//  My Project
//
//

import UIKit

final class TabBar: UITabBar {
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height += 15
        return sizeThatFits
    }
}

final class MainViewController: UITabBarController, HasDisposeBag {
    
    var presenter: MainPresenter!

    private let sizeIcon = CGSize(width: 32, height: 32)
    
    init() {
        super.init(nibName: nil, bundle: nil)
        object_setClass(self.tabBar, TabBar.self)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.shadowImage = UIImage() // remove top line
        tabBar.backgroundImage = UIImage()
        tabBar.isTranslucent = true
        
        let layer = CAShapeLayer()
        let tabbarHeight = tabBar.frame.height + (UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0) + 15
        layer.path = UIBezierPath(
            roundedRect: CGRect(x: 0, y: 0, width: tabBar.bounds.width, height: tabbarHeight),
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: 15, height: 15)
        ).cgPath
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: -2)
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.08
        layer.isHidden = false
        layer.masksToBounds = false
        layer.borderColor = UIColor.white.cgColor
        layer.fillColor = UIColor.white.cgColor
        tabBar.layer.insertSublayer(layer, at: 0)
        
        tabBar.barTintColor = .white
        tabBar.tintColor = .white
        UITabBar.appearance().tintColor = Asset.Colors.main.color
        UITabBarItem.appearance().setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 14)], for: .normal)
        
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
        
        viewControllers?.forEach({
            $0.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -3)
        })
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
