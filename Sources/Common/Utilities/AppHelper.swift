//
//  AppHelper.swift
//  VIPER
//
//

import UIKit

final class AppHelper {
    
    static let shared = AppHelper()
    
    private init() {}
    
    @Atomic var isShowAlert = false
    
    func showRetryAlert(title: String, message: String?, action: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "Retry", style: .default, handler: action))
        self.isShowAlert = true
        AppHelper.shared.topViewController()?.present(alert, animated: true, completion: nil)
    }
    
    func showConfirmAlert(title: String, message: String?, action: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .default, handler: action))
        self.isShowAlert = true
        AppHelper.shared.topViewController()?.present(alert, animated: true, completion: nil)
    }
    
    func showAlert(title: String, message: String, ok: String = "OK") -> Observable<Void> {
        guard !isShowAlert else { return .empty() }
        return Observable<Void>.create { [weak self] observer in
            guard let self = self else { return Disposables.create() }
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(.init(title: ok, style: .default, handler: { [weak self] _ in
                self?.isShowAlert = false
                observer.onNext(())
                observer.onCompleted()
            }))
            self.isShowAlert = true
            AppHelper.shared.topViewController()?.present(alert, animated: true, completion: nil)
            return Disposables.create {
                alert.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func showAlertConfirm(title: String, message: String, cancel: String = "Cancel", ok: String = "OK") -> Observable<Void> {
        guard !isShowAlert else { return .empty() }
        return Observable<Void>.create { [weak self] observer in
            guard let self = self else { return Disposables.create() }
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(.init(title: cancel, style: .cancel, handler: { [weak self] _ in
                self?.isShowAlert = false
                observer.onCompleted()
            }))
            alert.addAction(.init(title: ok, style: .default, handler: { [weak self] _ in
                self?.isShowAlert = false
                observer.onNext(())
                observer.onCompleted()
            }))
            self.isShowAlert = true
            AppHelper.shared.topViewController()?.present(alert, animated: true, completion: nil)
            return Disposables.create {
                alert.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func topViewController(_ viewController: UIViewController? = UIWindow.shared?.rootViewController) -> UIViewController? {
        if let nav = viewController as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = viewController as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = viewController?.presentedViewController {
            return topViewController(presented)
        }
        return viewController
    }
    
}
