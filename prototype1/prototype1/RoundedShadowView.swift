//
//  RoundedShadowView.swift
//  prototype1
//
//  Created by Esjay Hong on 22/04/2018.
//  Copyright © 2018 Minkyung Kim. All rights reserved.
//

import UIKit
@IBDesignable
class RoundedShadowView: UIView {
    
    @IBInspectable var borderRadius:CGFloat = 0.2 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var borderWidth:CGFloat = 0 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var borderColor:UIColor = UIColor.lightGray {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var shadowColor:UIColor = UIColor.black {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var shadowWidth:CGFloat = 0 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var shadowHeight:CGFloat = 1 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var shadowOpacity:Float = 0.25 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var shadowRadius:CGFloat = 1.7 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    override func awakeFromNib() {
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = CGSize(width: shadowWidth, height: shadowHeight)
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
        self.layer.cornerRadius = borderRadius
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        super.awakeFromNib()
    }
    
}

