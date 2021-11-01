//
//  UIView+Extensions.swift
//  MyChat
//
//

import UIKit

extension UIView {
    
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    func setRadius(corner: UIRectCorner, cornerRadii: CGSize) {
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: corner,
                                cornerRadii: cornerRadii)
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        layer.mask = maskLayer
        layer.masksToBounds = true
    }
    
    func setGradientBackground(topColor: UIColor, bottomColor: UIColor, maskColor: UIColor? = nil) {
        
        let shapeMask = CAShapeLayer()
        shapeMask.frame = bounds
        shapeMask.path = UIBezierPath(rect: bounds).cgPath
        shapeMask.fillColor = maskColor?.cgColor

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.frame = bounds
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        
        layer.insertSublayer(gradientLayer, at: 0)
        layer.insertSublayer(shapeMask, at: 1)
    }
    
}
