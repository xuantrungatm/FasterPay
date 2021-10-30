//
//  QRScannerInteractor.swift
//  MyApp
//
//  Created by Xuan Trung on 30/10/2021.
//

protocol QRScannerInteractorInterface {

}

final class QRScannerInteractor: QRScannerInteractorInterface {

    deinit {
        LogInfo("\(Swift.type(of: self)) Deinit")
    }

}
