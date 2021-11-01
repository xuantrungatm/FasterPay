//
//  CameraOverlayView.swift
//  MyApp
//
//  Created by Xuan Trung on 01/11/2021.
//

import UIKit

final class CameraOverlayView: UIView {
    
    lazy var clearFrame: CGRect = {
        let width: CGFloat = 260
        let height: CGFloat = 250
        let x = center.x - width / 2
        let y = center.y - height / 2 - 30
        return CGRect(x: x, y: y, width: width, height: height)
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        backgroundColor?.setFill()

        let path = UIBezierPath(roundedRect: clearFrame, cornerRadius: 0)
        UIColor.white.setStroke()
        path.lineWidth = 3
        path.stroke()
        path.append(UIBezierPath(rect: rect))
        
        path.usesEvenOddFillRule = true
        path.fill()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
