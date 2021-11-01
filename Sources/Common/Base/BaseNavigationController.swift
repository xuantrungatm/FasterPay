//
//  BaseNavigationController.swift
//  MyApp
//
//

import Foundation

final class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isNavigationBarHidden = true
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = UIColor(named: "main")
        navigationBar.tintColor = .white
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
}
