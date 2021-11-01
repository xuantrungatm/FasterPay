//
//  ProfileViewController.swift
//  MyApp
//
//  Created by Xuan Trung on 30/10/2021.
//

import UIKit

final class ProfileViewController: BaseViewController {
    
    @IBOutlet weak var containView: UIView!
    
    var presenter: ProfilePresenter!

    deinit {
        LogInfo("\(Swift.type(of: self)) Deinit")
        LeakDetector.instance.expectDeallocate(object: presenter as AnyObject)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setupUI() {
        super.setupUI()
        containView.setRadius(corner: [.topLeft, .topRight], cornerRadii: CGSize(width: 20, height:  20))
    }    

    override func bindDatas() {
        super.bindDatas()
        
        presenter.bind(isLoading: isLoading)
    }
    
    @IBAction func logout(_ sender: UIButton) {
        
    }
}

extension ProfileViewController: ProfileViewInterface {}
