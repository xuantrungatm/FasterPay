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
        let path = UIBezierPath(
            roundedRect: containView.bounds,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: 20, height:  20)
        )
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        containView.layer.mask = maskLayer
        containView.layer.masksToBounds = true
    }    

    override func bindDatas() {
        super.bindDatas()
        
        presenter.bind(isLoading: isLoading)
    }
    
    @IBAction func logout(_ sender: UIButton) {
        
    }
}

extension ProfileViewController: ProfileViewInterface {}
