//
//  UIView+Constraints.swift
//  GatewayAssignment
//
//  Created by Aaditya Singh on 27/09/23.
//

import UIKit

@inline(__always)
func getKeyWindow() -> UIWindow? {
    UIApplication.shared.windows.first(where: \.isKeyWindow)
}

public enum Edge {
    case safeAreaTop(padding: CGFloat)
    case top(padding: CGFloat)
    case safeAreaLeading(padding: CGFloat)
    case leading(padding: CGFloat)
    case safeAreaTrailing(padding: CGFloat)
    case trailing(padding: CGFloat)
    case safeAreaBottom(padding: CGFloat)
    case bottom(padding: CGFloat)
    
    case lessThanTrailing(padding: CGFloat)
    case greaterThanLeading(padding: CGFloat)
    case greaterThanTop(padding: CGFloat)
    case lessThanBottom(padding: CGFloat)
    
    case leadingGreaterThanTrailing(padding: CGFloat)
    
    var rawValue: String {
        switch self {
        case .safeAreaTop:
            return "safeAreaTop"
        case .top:
            return "top"
        case .safeAreaLeading:
            return "safeAreaLeading"
        case .leading:
            return "leading"
        case .safeAreaTrailing:
            return "safeAreaTrailing"
        case .trailing:
            return "trailing"
        case .safeAreaBottom:
            return "safeAreaBottom"
        case .bottom:
            return "bottom"
            
        case .lessThanTrailing:
            return "lessThanTrailing"
        case .greaterThanLeading:
            return "greaterThanLeading"
        case .greaterThanTop:
            return "greaterThanTop"
        case .lessThanBottom:
            return "lessThanBottom"
            
        case .leadingGreaterThanTrailing:
            return "leadingGreaterThanTrailing"
        }
    }
}

public extension UIView {
    // MARK: All Edges
    
    @discardableResult func pin(edges: Edge..., to view: UIView? = nil) -> [String: NSLayoutConstraint] {
        
        var constraints = [String: NSLayoutConstraint]()
        let constraintToView: UIView
        
        if let view = view {
            constraintToView = view
        } else {
            guard let superview = superview else { fatalError("Both view and superview are nil") }
            constraintToView = superview
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        for edge in edges {
            
            let constraint: NSLayoutConstraint
            
            switch edge {
            
            case .safeAreaTop(let padding):
                constraint = topAnchor.constraint(equalTo: constraintToView.safeAreaLayoutGuide.topAnchor, constant: padding)
            
            case .top(let padding):
                constraint = topAnchor.constraint(equalTo: constraintToView.topAnchor, constant: padding)
                
            case .safeAreaLeading(let padding):
                constraint = leadingAnchor.constraint(equalTo: constraintToView.safeAreaLayoutGuide.leadingAnchor, constant: padding)
            
            case .leading(let padding):
                constraint = leadingAnchor.constraint(equalTo: constraintToView.leadingAnchor, constant: padding)
                
            case .safeAreaTrailing(let padding):
                constraint = trailingAnchor.constraint(equalTo: constraintToView.safeAreaLayoutGuide.trailingAnchor, constant: padding)
            
            case .trailing(let padding):
                constraint = trailingAnchor.constraint(equalTo: constraintToView.trailingAnchor, constant: padding)
                
            case .safeAreaBottom(let padding):
                constraint = bottomAnchor.constraint(equalTo: constraintToView.safeAreaLayoutGuide.bottomAnchor, constant: padding)
            
            case .bottom(let padding):
                constraint = bottomAnchor.constraint(equalTo: constraintToView.bottomAnchor, constant: padding)
                
            case .lessThanTrailing(let padding):
                constraint = trailingAnchor.constraint(lessThanOrEqualTo: constraintToView.trailingAnchor, constant: padding)
                
            case .greaterThanLeading(let padding):
                constraint = leadingAnchor.constraint(greaterThanOrEqualTo: constraintToView.leadingAnchor, constant: padding)
                
            case .greaterThanTop(let padding):
                constraint = topAnchor.constraint(greaterThanOrEqualTo: constraintToView.topAnchor, constant: padding)
            
            case .lessThanBottom(let padding):
                constraint = bottomAnchor.constraint(lessThanOrEqualTo: constraintToView.bottomAnchor, constant: padding)
                
            case .leadingGreaterThanTrailing(let padding):
                constraint = leadingAnchor.constraint(greaterThanOrEqualTo: constraintToView.trailingAnchor, constant: padding)
            }
            
            constraint.isActive = true
            constraints[edge.rawValue] = constraint
            
        }
        
        return constraints
        
    }
    
    
    @discardableResult func pinAllEdgesSafely(to view: UIView? = nil, withPadding padding: CGFloat = 0) -> [String: NSLayoutConstraint] {
        return pin(edges: .safeAreaTop(padding: padding), .safeAreaLeading(padding: padding), .safeAreaTrailing(padding: -padding), .safeAreaBottom(padding: -padding), to: view)
    }
    
    @discardableResult func pinAllEdges(to view: UIView? = nil, withPadding padding: CGFloat = 0) -> [String: NSLayoutConstraint] {
        return pin(edges: .top(padding: padding), .leading(padding: padding), .trailing(padding: -padding), .bottom(padding: -padding), to: view)
    }
    
    // MARK: Top
    
    @discardableResult func pinTopToSafeArea(of view: UIView? = nil, withPadding padding: CGFloat) -> NSLayoutConstraint {
        let edge: Edge = .safeAreaTop(padding: padding)
        return pinEdge(edge, to: view)
    }
    
    @discardableResult func pinTop(to view: UIView? = nil, withPadding padding: CGFloat) -> NSLayoutConstraint {
        
        let edge: Edge = .top(padding: padding)
        return pinEdge(edge, to: view)
        
    }
    
    // MARK: Leading
    
    @discardableResult func pinLeadingToSafeArea(of view: UIView? = nil, withPadding padding: CGFloat) -> NSLayoutConstraint {
        let edge: Edge = .safeAreaLeading(padding: padding)
        return pinEdge(edge, to: view)
    }
    
    @discardableResult func pinLeading(to view: UIView? = nil, withPadding padding: CGFloat) -> NSLayoutConstraint {
        let edge: Edge = .leading(padding: padding)
        return pinEdge(edge, to: view)
    }
    
    // MARK: Trailing
    
    @discardableResult func pinTrailingToSafeArea(of view: UIView? = nil, withPadding padding: CGFloat) -> NSLayoutConstraint {
        let edge: Edge = .safeAreaTrailing(padding: padding)
        return pinEdge(edge, to: view)
    }
    
    @discardableResult func pinTrailing(to view: UIView? = nil, withPadding padding: CGFloat) -> NSLayoutConstraint {
        let edge: Edge = .trailing(padding: padding)
        return pinEdge(edge, to: view)
    }
    
    // MARK: Bottom
    
    @discardableResult func pinBottomToSafeArea(of view: UIView? = nil, withPadding padding: CGFloat) -> NSLayoutConstraint {
        let edge: Edge = .safeAreaBottom(padding: padding)
        return pinEdge(edge, to: view)
    }
    
    @discardableResult func pinBottom(to view: UIView? = nil, withPadding padding: CGFloat) -> NSLayoutConstraint {
        let edge: Edge = .bottom(padding: padding)
        return pinEdge(edge, to: view)
    }
    
    // MARK: Other Vertical
    
    @discardableResult func pinTopToBottom(of view: UIView, withSpacing spacing: CGFloat) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = topAnchor.constraint(equalTo: view.bottomAnchor, constant: spacing)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult func pinTopToCenter(of view: UIView, withSpacing spacing: CGFloat) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = topAnchor.constraint(equalTo: view.centerYAnchor, constant: spacing)
        constraint.isActive = true
        return constraint
    }
 
    @discardableResult func pinBottomToTop(of view: UIView, withSpacing spacing: CGFloat) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = bottomAnchor.constraint(equalTo: view.topAnchor, constant: spacing)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult func constrainTopToCenterY(of view: UIView, withConstant constant: CGFloat) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = topAnchor.constraint(equalTo: view.centerYAnchor, constant: constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult func constrainBottomToCenterY(of view: UIView, withConstant constant: CGFloat) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: constant)
        constraint.isActive = true
        return constraint
    }
    
    // MARK: Other Horizontal
    
    @discardableResult func pinLeadingToTrailing(of view: UIView, withSpacing spacing: CGFloat) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: spacing)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult func pinTrailingToLeading(of view: UIView, withSpacing spacing: CGFloat) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: spacing)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult func constrainLeadingToCenterX(of view: UIView, withConstant constant: CGFloat) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult func constrainTrailingToCenterX(of view: UIView, withConstant constant: CGFloat) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: constant)
        constraint.isActive = true
        return constraint
    }
    
    // MARK: Center
    
    @discardableResult func centerX(_ padding: CGFloat = 0, to view: UIView? = nil) -> NSLayoutConstraint {
        
        let constraint: NSLayoutConstraint
        let constraintToView: UIView
        
        if let view = view {
            constraintToView = view
        } else {
            guard let superview = superview else { fatalError("Both view and superview are nil") }
            constraintToView = superview
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        constraint = centerXAnchor.constraint(equalTo: constraintToView.centerXAnchor, constant: padding)
        
        constraint.isActive = true
        return constraint
        
    }
    
    @discardableResult func centerY(to view: UIView? = nil, withConstant constant: CGFloat = 0) -> NSLayoutConstraint {
        
        let constraint: NSLayoutConstraint
        let constraintToView: UIView
        
        if let view = view {
            constraintToView = view
        } else {
            guard let superview = superview else { fatalError("Both view and superview are nil") }
            constraintToView = superview
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        constraint = centerYAnchor.constraint(equalTo: constraintToView.centerYAnchor, constant: constant)
        
        constraint.isActive = true
        return constraint
        
    }
    
    @discardableResult func center(to view: UIView? = nil) -> [String: NSLayoutConstraint] {
        let centerXConstraint = centerX(to: view)
        let centerYConstraint = centerY(to: view)
        
        return [
            "centerX": centerXConstraint,
            "centerY": centerYConstraint
        ]
    }
    
    // MARK: Dimensions
    
    @discardableResult func constrainHeight(equalTo constant: CGFloat) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = heightAnchor.constraint(equalToConstant: constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult func constrainHeight(to view: UIView? = nil, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint {
        
        let constraint: NSLayoutConstraint
        let constraintToView: UIView
        
        if let view = view {
            constraintToView = view
        } else {
            guard let superview = superview else { fatalError("Both view and superview are nil") }
            constraintToView = superview
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        constraint = heightAnchor.constraint(equalTo: constraintToView.heightAnchor, multiplier: multiplier, constant: constant)
        constraint.isActive = true
        
        return constraint
        
    }
    
    @discardableResult func constrainHeight(greaterThanEqualTo constant: CGFloat) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = heightAnchor.constraint(greaterThanOrEqualToConstant: constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult func constrainWidth(equalTo constant: CGFloat) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = widthAnchor.constraint(equalToConstant: constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult func constrainWidth(lessThanEqualTo constant: CGFloat) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = widthAnchor.constraint(lessThanOrEqualToConstant: constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult func constrainWidth(greaterThanEqualTo constant: CGFloat) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = widthAnchor.constraint(greaterThanOrEqualToConstant: constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult func constrainWidth(equalTo constant: CGFloat, multiplier: CGFloat, to view: UIView? = nil) -> NSLayoutConstraint {
        
        let constraint: NSLayoutConstraint
        let constraintToView: UIView
        
        if let view = view {
            constraintToView = view
        } else {
            guard let superview = superview else { fatalError("Both view and superview are nil") }
            constraintToView = superview
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        constraint = widthAnchor.constraint(equalTo: constraintToView.widthAnchor, multiplier: multiplier, constant: constant)
        constraint.isActive = true
        
        return constraint
        
    }
    
    
    /// Sets aspect ratio of the view
    /// - Parameter ratio: ratio in width / height
    /// - Returns: The constraint created
    @discardableResult func setAspectRatio(to ratio: CGFloat) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = widthAnchor.constraint(equalTo: heightAnchor, multiplier: ratio)
        constraint.isActive = true
        return constraint
    }
    
}

extension UIView {
    func pinEdge(_ edge: Edge, to view: UIView? = nil) -> NSLayoutConstraint {
        return pin(edges: edge, to: view)[edge.rawValue]!
    }
    
    func anchor(top: NSLayoutYAxisAnchor? = nil, topConstant: CGFloat = 0,
                left: NSLayoutXAxisAnchor? = nil, leftConstant: CGFloat = 0,
                bottom: NSLayoutYAxisAnchor? = nil, bottomConstant: CGFloat = 0,
                right: NSLayoutXAxisAnchor? = nil, rightConstant: CGFloat = 0,
                widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) {
       translatesAutoresizingMaskIntoConstraints = false
       
       var anchors = [NSLayoutConstraint]()
       
       if let top = top {
          let topAnchor = topAnchor.constraint(equalTo: top, constant: topConstant)
          topAnchor.identifier = "topAnchor"
          anchors.append(topAnchor)
       }
       
       if let left = left {
          let leftAnchor = leftAnchor.constraint(equalTo: left, constant: leftConstant)
          leftAnchor.identifier = "leftAnchor"
          anchors.append(leftAnchor)
       }
       
       if let bottom = bottom {
          let bottomAnchor = bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant)
          bottomAnchor.identifier = "bottomAnchor"
          anchors.append(bottomAnchor)
       }
       
       if let right = right {
          let rightAnchor = rightAnchor.constraint(equalTo: right, constant: -rightConstant)
          rightAnchor.identifier = "rightAnchor"
          anchors.append(rightAnchor)
       }
       
       if widthConstant > 0 {
          let widthAnchor = widthAnchor.constraint(equalToConstant: widthConstant)
          widthAnchor.identifier = "widthAnchor"
          anchors.append(widthAnchor)
       }
       
       if heightConstant > 0 {
          let heightAnchor = heightAnchor.constraint(equalToConstant: heightConstant)
          heightAnchor.identifier = "heightAnchor"
          anchors.append(heightAnchor)
       }
       
       anchors.forEach({$0.isActive = true})
    }
    
    func fillSuperview(toSafeArea: Bool = false) {
       guard let superview = self.superview else { return }
       translatesAutoresizingMaskIntoConstraints = false
       let constraints: [NSLayoutConstraint]
       let guide = superview.safeAreaLayoutGuide
       if toSafeArea {
          let topAnchor = topAnchor.constraint(equalTo: guide.topAnchor)
          topAnchor.identifier = "topAnchor"
          let leftAnchor = leftAnchor.constraint(equalTo: guide.leftAnchor)
          leftAnchor.identifier = "leftAnchor"
          let bottomAnchor = bottomAnchor.constraint(equalTo: guide.bottomAnchor)
          bottomAnchor.identifier = "bottomAnchor"
          let rightAnchor = rightAnchor.constraint(equalTo: guide.rightAnchor)
          rightAnchor.identifier = "rightAnchor"
          constraints = [leftAnchor, rightAnchor, topAnchor, bottomAnchor]
       } else {
          let topAnchor = topAnchor.constraint(equalTo: superview.topAnchor)
          topAnchor.identifier = "topAnchor"
          let leftAnchor = leftAnchor.constraint(equalTo: superview.leftAnchor)
          leftAnchor.identifier = "leftAnchor"
          let bottomAnchor = bottomAnchor.constraint(equalTo: superview.bottomAnchor)
          bottomAnchor.identifier = "bottomAnchor"
          let rightAnchor = rightAnchor.constraint(equalTo: superview.rightAnchor)
          rightAnchor.identifier = "rightAnchor"
          constraints = [leftAnchor, rightAnchor, topAnchor, bottomAnchor]
       }
       NSLayoutConstraint.activate(constraints)
    }
}

extension NSLayoutConstraint {
   func withPriority(_ constant:Float) -> NSLayoutConstraint {
      self.priority = UILayoutPriority(constant)
      return self
   }
   func activate() {
      self.isActive = true
   }
   func deactivate() {
      self.isActive = false
   }
}

