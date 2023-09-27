//
//  UIView+Ext.swift
//  GatewayAssignment
//
//  Created by Aaditya Singh on 27/09/23.
//

import UIKit

extension UIView {
    func round() {
        layer.cornerRadius = min(bounds.width, bounds.height) / 2
        layer.masksToBounds = true
    }
    
    func roundCorners(with cornerRadius: CGFloat) {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
    }
    
    func roundCorners(at corners: UIRectCorner, withRadius radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func roundCorners(at corners: CACornerMask, withRadius radius: CGFloat) {
        layer.cornerRadius = radius
        layer.maskedCorners = corners
    }
}

extension UIView {
    
    enum Location {
        case bottom(offset: CGSize? = nil)
        case top(offset: CGSize? = nil)
        case left(offset: CGSize? = nil)
        case right(offset: CGSize? = nil)
        case custom(offset: CGSize? = nil)
        case custom2(offset: CGSize? = nil)

        var offset: CGSize {
            switch self {
            case .bottom(let offset):
                return offset ?? CGSize(width: 0, height: 10)
            case .top(let offset):
                return offset ?? CGSize(width: 0, height: -10)
            case .left(let offset):
                return offset ?? CGSize(width: -10, height: 0)
            case .right(let offset):
                return offset ?? CGSize(width: 10, height: 0)
            case .custom(let offset):
                return offset ?? CGSize(width: -5, height: 5)
            case .custom2(let offset):
                return offset ?? CGSize(width: 5, height: -5)
            }
        }
    }
    
    func addShadow(location: Location, color: UIColor, opacity: Float, radius: CGFloat, setPathManually: Bool = false) {
        addShadow(offset: location.offset, color: color, opacity: opacity, radius: radius, setPathManually: setPathManually)
    }

    func addShadow(offset: CGSize, color: UIColor, opacity: Float, radius: CGFloat, setPathManually: Bool = false) {
        
        if setPathManually {
            layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        }
        
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
    }
    
    func removeShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: -3.0)
        layer.shadowOpacity = 0
        layer.shadowRadius = 3.0
        layer.shadowPath = nil
    }
}

// MARK: - Gradient Border
extension UIView {
    
    final class GradientBorder {
        
        let gradientLayer: CAGradientLayer
        let shapeLayer: CAShapeLayer
        
        init(gradientLayer: CAGradientLayer, shapeLayer: CAShapeLayer) {
            self.gradientLayer = gradientLayer
            self.shapeLayer = shapeLayer
        }
        
    }
    
    func addGradientBorder(gradientColors: [CGColor]) -> GradientBorder {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame =  bounds
        gradientLayer.colors = gradientColors

        let shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = 1
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.frame = bounds
        gradientLayer.mask = shapeLayer
        
        clipsToBounds = true
        layer.addSublayer(gradientLayer)
        return GradientBorder(gradientLayer: gradientLayer, shapeLayer: shapeLayer)
    }
}

