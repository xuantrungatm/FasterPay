//
//  SignUpView.swift
//  MyApp
//
//  Created by Xuan Trung on 01/11/2021.
//

protocol SignUpViewInterface: BaseView {
    func showAlert(content: String)
    func showAlert(content: String, action: ((UIAlertAction) -> Void)?)
}
