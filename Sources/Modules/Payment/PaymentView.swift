//
//  PaymentView.swift
//  MyApp
//
//  Created by Xuan Trung on 01/11/2021.
//

protocol PaymentViewInterface: BaseView {
    func updateUI(with user: User?)
    func showAlert(content: String, action: ((UIAlertAction) -> Void)?)
}
