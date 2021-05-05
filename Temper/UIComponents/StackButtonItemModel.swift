//
//  StackButtonItemModel.swift
//  Temper
//
//  Created by Abbas on 5/5/21.
//

import UIKit

struct StackButtonItemModel {
    let icon: UIImage?
    let name: String
    let action: (String)->()
    let backgroundColor: UIColor?
    let cornerRadius : CGFloat?
    let borderWidth : CGFloat?
    let borderColor : UIColor?
    
    init(icon: UIImage?,name: String,action: @escaping (String)->()) {
        self.icon = icon
        self.name = name
        self.action = action
        self.backgroundColor = nil
        self.cornerRadius = nil
        self.borderWidth = nil
        self.borderColor = nil
    }
    
    init(icon: UIImage?,name: String,action: @escaping (String)->(),backgroundColor: UIColor,cornerRadius: CGFloat?,borderWidth: CGFloat?,borderColor: UIColor?) {
        self.icon = icon
        self.name = name
        self.action = action
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
        self.borderColor = borderColor
    }
}
