//
//  AppScenes.swift
//  MyApp
//
//

enum AppScenes {
    case main
    case wallet
    case scanner
    case profile
    
    var viewController: UIViewController {
        switch self {
        case .main:
            let vc = MainViewController()
            return MainRouter(viewController: vc).viewController
        case .wallet:
            let vc = StoryboardScene.WalletViewController.initialScene.instantiate()
            let vcInjected = WalletRouter(viewController: vc).viewController
            return vcInjected
        case .scanner:
            let vc = StoryboardScene.QRScannerViewController.initialScene.instantiate()
            let vcInjected = QRScannerRouter(viewController: vc).viewController
            return vcInjected
        case .profile:
            let vc = StoryboardScene.ProfileViewController.initialScene.instantiate()
            let vcInjected = ProfileRouter(viewController: vc).viewController
            return vcInjected
        }
    }
}
