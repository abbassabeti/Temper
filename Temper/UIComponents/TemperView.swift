//
//  TemperView.swift
//  Temper
//
//  Created by Abbas on 5/5/21.
//

import UIKit

@IBDesignable
public class TemperView: UIView {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable var hasShadow : Bool  = false{
        didSet{
            setupView()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    override public func layoutSubviews() {
        setupView()
        super.layoutSubviews()
    }
    
    func setupView(){
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
        self.clipsToBounds = true
        
        if (hasShadow){
            defineShadow()
        }
    }
}
