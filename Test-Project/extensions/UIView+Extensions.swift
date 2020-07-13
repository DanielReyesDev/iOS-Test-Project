//
//  UIView+Extensions.swift
//  Test-Project
//
//  Created by Victor Uriel Pacheco Garcia on 04/07/20.
//  Copyright © 2020 Victor Uriel Pacheco Garcia. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    static let space1x: CGFloat = 8
    static let space2x = UIView.space1x * 2
    static let space3x = UIView.space1x * 3
    static let space4x = UIView.space1x * 4
    
    func setConstaints(trailing: NSLayoutXAxisAnchor? = nil,
                       leading: NSLayoutXAxisAnchor? = nil,
                       top: NSLayoutYAxisAnchor? = nil,
                       bottom: NSLayoutYAxisAnchor? = nil,
                       width: CGFloat? = nil,
                       height: CGFloat? = nil,
                       marginTop: CGFloat = 0,
                       marginBottom: CGFloat = 0,
                       marginLeading: CGFloat = 0,
                       marginTrailing: CGFloat = 0,
                       widthAnchor: NSLayoutDimension? = nil,
                       heightAnchor: NSLayoutDimension? = nil) {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let trailing = trailing {
            self.trailingAnchor.constraint(equalTo: trailing, constant: -marginTrailing).isActive = true
        }
        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: leading, constant: marginLeading).isActive = true
        }
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: marginTop).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -marginBottom).isActive = true
        }
        if let width = width {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let height = height {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if let widthAnchor = widthAnchor {
            self.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        }
        
        if let heightAnchor = heightAnchor {
            self.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1).isActive = true
        }
        
    }
    
    func fillSuperviewSafeArea() {
        self.translatesAutoresizingMaskIntoConstraints = false
        guard let superView = superview else { return }
        let safeArea = superView.safeAreaLayoutGuide
        self.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
    }
    
    func fillSuperview() {
        self.translatesAutoresizingMaskIntoConstraints = false
        guard let superView = superview else { return }
        self.topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
    }
    
    func centerInSuperView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        guard let superView = superview else { return }
        self.centerYAnchor.constraint(equalTo: superView.centerYAnchor).isActive = true
        self.centerXAnchor.constraint(equalTo: superView.centerXAnchor).isActive = true
    }
}
