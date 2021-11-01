//
//  ProfileViewController.swift
//  MyApp
//
//  Created by Xuan Trung on 30/10/2021.
//

import UIKit

final class ProfileViewController: BaseViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
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
        containView.clipsToBounds = true
        containView.layer.cornerRadius = 20
    }    

    override func bindDatas() {
        super.bindDatas()
        
        presenter.bind(isLoading: isLoading)
        Observable.just(())
            ~> presenter.trigger
            ~ disposeBag
    }
    
    @IBAction func logout(_ sender: UIButton) {
        presenter.handleLogOut()
    }
}

extension ProfileViewController: ProfileViewInterface {
    func updateUI(with user: User?) {
        nameLabel.text = "\(user?.firstName ?? "") \(user?.lastName ?? "")"
    }
}
