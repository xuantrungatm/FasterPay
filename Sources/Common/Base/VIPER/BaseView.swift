//
//  BaseView.swift
//  MyApp
//
//

protocol BaseView: AnyObject {
    func showAlert(title: String, message: String) -> Observable<Void>
    func showAlertConfirm(title: String, message: String) -> Observable<Void>
    func showRetryAlert(title: String, message: String?, action: ((UIAlertAction) -> Void)?)
    func showConfirmAlert(title: String, message: String?, action: ((UIAlertAction) -> Void)?)
}

extension BaseView {
    func showAlert(title: String, message: String) -> Observable<Void> {
        AppHelper.shared.showAlert(title: title, message: message)
    }
    func showAlertConfirm(title: String, message: String) -> Observable<Void> {
        AppHelper.shared.showAlertConfirm(title: title, message: message)
    }
    func showRetryAlert(title: String, message: String?, action: ((UIAlertAction) -> Void)?) {
        AppHelper.shared.showRetryAlert(title: title, message: message, action: action)
    }
    func showConfirmAlert(title: String, message: String?, action: ((UIAlertAction) -> Void)? = nil) {
        AppHelper.shared.showConfirmAlert(title: title, message: message, action: action)
    }
}
