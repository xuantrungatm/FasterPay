//
//  AppDelegate.swift
//  MyApp
//
//

import UIKit
@_exported import RxBinding
import IQKeyboardManagerSwift

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    @LazyInjected var auth: AuthManagerInterface
    
    static var keyWindow: UIWindow? {
        return UIApplication.shared.windows.first(where: { $0.isKeyWindow })
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = auth.isLogin ? AppScenes.main.viewController : BaseNavigationController(rootViewController: AppScenes.signIn.viewController)
        window?.makeKeyAndVisible()
        
        IQKeyboardManager.shared.enable = true
        
        return true
    }

}

