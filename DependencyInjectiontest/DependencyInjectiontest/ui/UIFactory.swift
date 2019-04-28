//
//  UIFactory.swift
//  DependencyInjectiontest
//
//  Created by Jacob Just on 27/04/2019.
//  Copyright © 2019 Jacob Just. All rights reserved.
//

import Foundation
import UIKit

fileprivate enum ConstraintIdentifiers: String  {
    case MARGIN_RIGHT = "ConstraintIdentifiers_MARGIN_RIGHT"
    case MARGIN_LEFT = "ConstraintIdentifiers_MARGIN_LEFT"
    case MARGIN_TOP = "ConstraintIdentifiers_MARGIN_TOP"
    case MARGIN_BOTTOM = "ConstraintIdentifiers_MARGIN_BOTTOM"
    case HEIGHT = "ConstraintIdentifiers_HEIGHT"
    case WIDTH = "ConstraintIdentifiers_WIDTH"
    case LEFT_FROM = "ConstraintIdentifiers_LEFT_FROM"
    case RIGHT_FROM = "ConstraintIdentifiers_RIGHT_FROM"
    case TOP_FROM = "ConstraintIdentifiers_TOP_FROM"
    case BOTTOM_FROM = "ConstraintIdentifiers_BOTTOM_FROM"
    case CENTER_Y = "ConstraintIdentifiers_CENTER_Y"
}

extension UILabel {
    public func textColor(_ color: UIColor) -> UILabel {
        self.textColor = color
        return self
    }
}

extension UITableView {
    public func withDelegate(_ delegate: UITableViewDelegate) -> UITableView {
        self.delegate = delegate
        return self
    }
    
    public func withSource(_ source: UITableViewDataSource) -> UITableView {
        self.dataSource = source
        return self
    }
    
    public func with(cell: AnyClass, identifier: String) -> UITableView {
        self.register(cell, forCellReuseIdentifier: identifier)
        return self
    }
}

extension UIView {
    
    public func addLargeTitle(text: String? = nil) -> UILabel {
        let label = UILabel()
        self.addSubview(label)
        label.text = text
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textColor = UIColor.black
        return label
    }
    
    public func addMediumTitle(text: String? = nil) -> UILabel {
        let label = UILabel()
        self.addSubview(label)
        label.text = text
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.black
        return label
    }
    
    public func addButtonWithRoundBorder(text: String, backgroundColor: UIColor, foregroundColor: UIColor, selectedBackgroundColor: UIColor? = nil) -> UIButton {
        let button = UIButton()
        self.addSubview(button)
        
        button.setTitle(text, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 2
        button.layer.borderColor = foregroundColor.cgColor
        button.backgroundColor = backgroundColor
        button.tintColor = foregroundColor
        button.setTitleColor(foregroundColor, for: .normal)
        
        button.backgroundColor = backgroundColor
        return button
    }
    
    public func addView() -> UIView {
        let v = UIView()
        self.addSubview(v)
        return v
    }
    
    public func addImage(image: UIImage?) -> UIImageView {
        let imageView = UIImageView(image: image)
        self.addSubview(imageView)
        #if swift(>=4.2)
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        #else
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        #endif
        
        return imageView
    }
    
    public func addTableVIew() -> UITableView {
        let view = UITableView()
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }
    
    var safeTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.topAnchor
        } else {
            return self.topAnchor
        }
    }
    
    var safeLeftAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.leftAnchor
        } else {
            return self.leftAnchor
        }
    }
    
    var safeRightAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.rightAnchor
        } else {
            return self.rightAnchor
        }
    }
    
    var safeBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.bottomAnchor
        } else {
            return self.bottomAnchor
        }
    }
    
    @discardableResult
    public func anchorCenterSuperview() -> UIView {
        anchorCenterXToSuperview()
        anchorCenterYToSuperview()
        return self
    }
    
    @discardableResult
    public func anchorCenterXToSuperview(constant: CGFloat = 0) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        if let anchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        }
        return self
    }
    
    @discardableResult
    public func anchorCenterYToSuperview(constant: CGFloat = 0) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        if let anchor = superview?.centerYAnchor {
            let constraint = centerYAnchor.constraint(equalTo: anchor, constant: constant)
            constraint.isActive = true
            constraint.identifier = ConstraintIdentifiers.CENTER_Y.rawValue
        }
        return self
    }
    
    @discardableResult
    public func anchorCenterXToView(view: UIView, constant: CGFloat = 0) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: constant).isActive = true
        return self
    }
    
    @discardableResult
    public func anchorCenterYToView(view: UIView, constant: CGFloat = 0) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
        return self
    }
    
    @discardableResult
    public func anchorCenterToView(view: UIView) -> UIView {
        anchorCenterXToView(view: view)
        anchorCenterYToView(view: view)
        return self
    }
    
    @discardableResult
    public func anchorFillSuperview(withinSafeArea: Bool = true) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            if !withinSafeArea {
                leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
                rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
                topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
                bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
            } else {
                leftAnchor.constraint(equalTo: superview.safeLeftAnchor).isActive = true
                rightAnchor.constraint(equalTo: superview.safeRightAnchor).isActive = true
                topAnchor.constraint(equalTo: superview.safeTopAnchor).isActive = true
                bottomAnchor.constraint(equalTo: superview.safeBottomAnchor).isActive = true
            }
        }
        return self
    }
    
    @discardableResult
    public func marginLeftFromView(margin: CGFloat, view: UIView) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = leftAnchor.constraint(equalTo: view.safeRightAnchor, constant: margin)
        constraint.isActive = true
        constraint.identifier = ConstraintIdentifiers.LEFT_FROM.rawValue
        return self
    }
    
    @discardableResult
    public func marginTopFromView(margin: CGFloat, view: UIView) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = topAnchor.constraint(equalTo: view.safeBottomAnchor, constant: margin)
        constraint.isActive = true
        constraint.identifier = ConstraintIdentifiers.TOP_FROM.rawValue
        
        return self
    }
    
    @discardableResult
    public func marginRightFromView(margin: CGFloat, view: UIView) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = rightAnchor.constraint(equalTo: view.safeLeftAnchor, constant: margin)
        constraint.isActive = true
        constraint.identifier = ConstraintIdentifiers.RIGHT_FROM.rawValue
        return self
    }
    
    @discardableResult
    public func marginBottomFromView(margin: CGFloat, view: UIView) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = bottomAnchor.constraint(equalTo: view.safeTopAnchor, constant: margin)
        constraint.isActive = true
        constraint.identifier = ConstraintIdentifiers.BOTTOM_FROM.rawValue
        
        
        return self
    }
    
    @discardableResult
    public func marginFromView(left: CGFloat, top: CGFloat, right: CGFloat, bottom: CGFloat, view: UIView) -> UIView {
        marginLeftFromView(margin: left, view: view)
        marginTopFromView(margin: top, view: view)
        marginRightFromView(margin: right, view: view)
        marginBottomFromView(margin: bottom, view: view)
        return self
    }
    
    @discardableResult
    public func marginLeft(_ margin: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            let constraint = leftAnchor.constraint(equalTo: superview.safeLeftAnchor, constant: margin)
            constraint.isActive = true
            constraint.identifier = ConstraintIdentifiers.MARGIN_LEFT.rawValue
        }
        
        assert(superview != nil)
        
        return self
    }
    
    @discardableResult
    public func marginTop(_ margin: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            let constraint = topAnchor.constraint(equalTo: superview.safeTopAnchor, constant: margin)
            constraint.isActive = true
            constraint.identifier = ConstraintIdentifiers.MARGIN_TOP.rawValue
        }
        return self
    }
    
    @discardableResult
    public func marginRight(_ margin: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            let constraint = rightAnchor.constraint(equalTo: superview.safeRightAnchor, constant: margin)
            constraint.isActive = true
            constraint.identifier = ConstraintIdentifiers.MARGIN_RIGHT.rawValue
        }
        
        return self
    }
    
    private func getConstraint(view: UIView, identifier: String) -> NSLayoutConstraint? {
        let match = view.constraints.first( where: {
            if let constraintView = $0.firstItem as? UIView, constraintView == self, let constraintIdentier = $0.identifier, constraintIdentier == identifier {
                return true
            } else {
                return false
            }
        })
        
        #if DEBUG
        if match != nil {
            //Can be removed later, just to be sure we only have one constraint, since self.constraints is the constraint tree
            
            let matches = view.constraints.filter({
                if let constraintView = $0.firstItem as? UIView, constraintView == self, let constraintIdentier = $0.identifier, constraintIdentier == identifier {
                    return true
                } else {
                    return false
                }
            })
            
            assert(matches.count <= 1)
        }
        #endif
        
        return match
    }
    
    private func getConstraint(_ identifier: String) -> NSLayoutConstraint {
        var match = getConstraint(view: self, identifier: identifier)
        
        if match == nil, let parent = self.superview {
            match = getConstraint(view: parent, identifier: identifier)
        }
        
        assert(match != nil)
        
        return match ?? NSLayoutConstraint()
    }
    
    @discardableResult
    public func marginBottom(_ margin: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            let constraint = bottomAnchor.constraint(equalTo: superview.safeBottomAnchor, constant: margin)
            constraint.isActive = true
            constraint.identifier = ConstraintIdentifiers.MARGIN_BOTTOM.rawValue
            
        }
        return self
    }
    
    @discardableResult
    public func margin(left: CGFloat, top: CGFloat, right: CGFloat, bottom: CGFloat) -> UIView {
        marginLeft(left)
        marginTop(top)
        marginRight(right)
        marginBottom(bottom)
        return self
    }
    
    @discardableResult
    public func ancherSize(width: CGFloat, height: CGFloat) -> UIView {
        return setWidth(width).setHeight(height)
    }
    
    @discardableResult
    public func setWidth(_ width: CGFloat) -> UIView  {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = widthAnchor.constraint(equalToConstant: width)
        constraint.isActive = true
        constraint.identifier = ConstraintIdentifiers.WIDTH.rawValue
        return self
    }
    
    @discardableResult
    public func setHeight(_ height: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        let heightConstraint = heightAnchor.constraint(equalToConstant: height)
        heightConstraint.isActive = true
        heightConstraint.identifier = ConstraintIdentifiers.HEIGHT.rawValue
        return self
    }
    
    public func getMarginLeftContraint() -> NSLayoutConstraint {
        return getConstraint(ConstraintIdentifiers.MARGIN_LEFT.rawValue)
    }
    
    public func getMarginRigtContraint() -> NSLayoutConstraint {
        return getConstraint(ConstraintIdentifiers.MARGIN_RIGHT.rawValue)
    }
    
    public func getMarginTopContraint() -> NSLayoutConstraint {
        return getConstraint(ConstraintIdentifiers.MARGIN_TOP.rawValue)
    }
    
    public func getMarginBottomContraint() -> NSLayoutConstraint {
        return getConstraint(ConstraintIdentifiers.MARGIN_BOTTOM.rawValue)
    }
    
    public func getHeightContraint() -> NSLayoutConstraint {
        return getConstraint(ConstraintIdentifiers.HEIGHT.rawValue)
    }
    
    public func getWidthContraint() -> NSLayoutConstraint {
        return getConstraint(ConstraintIdentifiers.WIDTH.rawValue)
    }
    
    public func getMarginBottomFromViewConstraint() -> NSLayoutConstraint {
        return getConstraint(ConstraintIdentifiers.BOTTOM_FROM.rawValue)
    }
    
    public func getMarginTopFromViewConstraint() -> NSLayoutConstraint {
        return getConstraint(ConstraintIdentifiers.TOP_FROM.rawValue)
    }
    
    public func getMarginLeftFromViewConstraint() -> NSLayoutConstraint {
        return getConstraint(ConstraintIdentifiers.LEFT_FROM.rawValue)
    }
    
    public func getMarginRigthFromViewConstraint() -> NSLayoutConstraint {
        return getConstraint(ConstraintIdentifiers.RIGHT_FROM.rawValue)
    }
    
    public func getCenterYConstraint() -> NSLayoutConstraint {
        return getConstraint(ConstraintIdentifiers.CENTER_Y.rawValue)
    }
}
