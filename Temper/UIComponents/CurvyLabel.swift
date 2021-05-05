//
//  UIView.swift
//  Temper
//
//  Created by Abbas on 5/4/21.
//

import UIKit

class CurvyLabel : UILabel {
    
    var allInsets: CGFloat = 0.0 {
        didSet{
            topInset = allInsets
            bottomInset = allInsets
            leftInset = allInsets
            rightInset = allInsets
        }
    }

    @IBInspectable var topInset: CGFloat = 5.0
    @IBInspectable var bottomInset: CGFloat = 5.0
    @IBInspectable var leftInset: CGFloat = 7.0
    @IBInspectable var rightInset: CGFloat = 7.0

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        let rect = rect.inset(by: insets)
        super.drawText(in: rect)
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }

    override var bounds: CGRect {
        didSet {
            // ensures this works within stack views if multi-line
            preferredMaxLayoutWidth = bounds.width - (leftInset + rightInset)
        }
    }
        
    override func layoutSubviews() {
        super.layoutSubviews()
        makeLeftSideCurvy()
    }
    func makeLeftSideCurvy(){
        let corner = self.frame.height / 2.5
        let offset = self.frame.height
        self.clipsToBounds = true
        let originalFrame = UIBezierPath(arcCenter: CGPoint(x:self.bounds.minX + offset ,y:self.bounds.minY + corner), radius: corner, startAngle: .pi * 1.15, endAngle: .pi * 1.5, clockwise: true)
        originalFrame.addLine(to: CGPoint(x:self.bounds.maxX,y:self.bounds.minY))
        originalFrame.addLine(to: CGPoint(x:self.bounds.maxX,y:self.bounds.maxY))
        originalFrame.addLine(to: CGPoint(x:self.bounds.minX,y:self.bounds.maxY))

        originalFrame.addArc(withCenter: CGPoint(x:self.bounds.minX,y:self.bounds.maxY - corner), radius: corner, startAngle: .pi/2, endAngle: 0.15 * .pi, clockwise: false)
        originalFrame.close()
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = originalFrame.cgPath
        layer.mask = maskLayer1
    }
}
