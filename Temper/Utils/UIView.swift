//
//  UIView.swift
//  Temper
//
//  Created by Abbas on 5/5/21.
//

import UIKit

extension UIView{
    func defineShadow(){
        DispatchQueue.main.asyncAfter(deadline: .now()+0.02) {
            guard let superView = self.superview else {return}
            let maskPath = (self.layer.mask as? CAShapeLayer)?.path
            let hasMask = maskPath != nil
            let displacement = hasMask ? CGSize(width: self.frame.minX, height: self.frame.minY) : CGSize(width: 0, height: 0)
            guard let finalPath = hasMask ? maskPath : CGPath(roundedRect: self.layer.bounds, cornerWidth: self.layer.cornerRadius, cornerHeight: self.layer.cornerRadius, transform: nil) /*CGPath(rect:self.layer.bounds,transform: nil)*/ else {return}
            let modifiedPath = UIBezierPath(cgPath: finalPath.copy(strokingWithWidth: 2, lineCap: .round, lineJoin: .round, miterLimit: 1))
            let shadowTarget = hasMask ? superView : self
            if (!hasMask){
                self.clipsToBounds = false
                shadowTarget.layer.cornerRadius = self.layer.cornerRadius
            }
            
            shadowTarget.layer.shadowPath = modifiedPath.cgPath
            shadowTarget.layer.shadowOffset = displacement
            shadowTarget.layer.shadowColor = UIColor.darkGray.cgColor
            shadowTarget.layer.shadowOpacity = 0.4
        }
    }
}
