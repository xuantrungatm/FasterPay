//
//  Presenter.swift
//  MyApp
//
//

import Foundation

protocol Presenter: AnyObject {
    associatedtype View
    associatedtype Router
    associatedtype Interactor
    var view: View { get }
    var router: Router { get }
    var interactor: Interactor { get }
    init(view: View, router: Router, interactor: Interactor)
}
