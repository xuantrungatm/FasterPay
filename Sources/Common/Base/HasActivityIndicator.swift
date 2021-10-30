//
//  HasActivityIndicator.swift
//  MyApp
//
//

import Foundation

protocol HasActivityIndicator {
    associatedtype ElementType
    var trigger: PublishRelay<ElementType> { get }
    var activityIndicator: ActivityIndicator { get }
}

extension HasActivityIndicator where Self: HasDisposeBag {
    func bind(isLoading: PublishRelay<Bool>) {
        activityIndicator.asSignalOnErrorJustComplete() ~> isLoading ~ disposeBag
    }
}
