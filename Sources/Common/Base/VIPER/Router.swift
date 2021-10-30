//
//  Router.swift
//  MyApp
//
//

protocol Router: AnyObject {
    associatedtype ViewController
    var viewController: ViewController { get }
    init(viewController: ViewController)
}
