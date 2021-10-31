//
//  GradientView.swift
//  MyApp
//
//  Created by Xuan Trung on 31/10/2021.
//

import Foundation

@IBDesignable
final class GradientView: UIView {
    
    private var _topColor = UIColor(red: 48.0 / 255.0, green: 35.0 / 255.0, blue: 174.0 / 255.0, alpha: 1)
    private var _bottomColor = UIColor(red: 200.0 / 255.0, green: 109.0 / 255.0, blue: 215.0 / 255.0, alpha: 1)
    private var _maskColor = UIColor(red: 28.0 / 255.0, green: 28.0 / 255.0, blue: 28.0 / 255.0, alpha: 1)
    
    @IBInspectable var topColor: UIColor {
        get {
            return _topColor
        }
        set {
            _topColor = newValue
            layer.sublayers?.removeAll(where: {
                $0 is CAGradientLayer || $0 is CAShapeLayer
            })
            setGradientBackground(
                topColor: newValue,
                bottomColor: _bottomColor,
                maskColor: _maskColor
            )
        }
    }
    
    @IBInspectable var bottomColor: UIColor {
        get {
            return _bottomColor
        }
        set {
            _bottomColor = newValue
            layer.sublayers?.removeAll(where: {
                $0 is CAGradientLayer || $0 is CAShapeLayer
            })
            setGradientBackground(
                topColor: _topColor,
                bottomColor: newValue,
                maskColor: _maskColor
            )
        }
    }
    
    @IBInspectable var maskColor: UIColor {
        get {
            return _maskColor
        }
        set {
            _maskColor = newValue
            layer.sublayers?.removeAll(where: {
                $0 is CAGradientLayer || $0 is CAShapeLayer
            })
            setGradientBackground(
                topColor: _topColor,
                bottomColor: _bottomColor,
                maskColor: newValue
            )
        }
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        commonInit()
      }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        layer.sublayers?.removeAll(where: {
            $0 is CAGradientLayer || $0 is CAShapeLayer
        })
        setGradientBackground(topColor: _topColor, bottomColor: _bottomColor, maskColor: _maskColor)
    }
    
}
