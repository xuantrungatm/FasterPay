//
//  UIViewFromNib.swift
//  MyApp
//
//  Created by Xuan Trung on 19/08/2021.
//

import UIKit

open class UIViewFromNib: UIView {
    override public init(frame: CGRect) {
        super.init(frame: frame)

        nibInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        nibInit()
    }

    // MARK: - Private Methods

    open func nibInit() {
        guard let view = UINib(nibName: className, bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView else {
            return
        }

        addCoverView(view)
    }
}

extension UIView {
    func addCoverView(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false

        addSubview(view)

        let constraints = [
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topAnchor.constraint(equalTo: view.topAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]

        constraints.forEach { $0.isActive = true }
    }
}
