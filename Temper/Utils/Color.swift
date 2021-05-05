//
//  Color.swift
//  Temper
//
//  Created by Abbas on 5/4/21.
//

import UIKit

extension UIColor {
    static func  make(_ r:Int,_ g:Int,_ b:Int,_ alpha:Int = 100) -> UIColor{
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: CGFloat(alpha)/100)
    }
    static let addressLabel = make(133,74,228)
    static let delimitterColor = make(228,228,228)
    static let temperGreen = make(0,255,135)
}

extension CGColor {
    static func  make(_ r:Int,_ g:Int,_ b:Int,_ alpha:Int = 100) -> CGColor{
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: CGFloat(alpha)/100).cgColor
    }
}
