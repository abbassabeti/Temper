//
//  Font.swift
//  Temper
//
//  Created by Abbas on 5/4/21.
//

import UIKit

extension UIFont {
    var bold: UIFont {
        if #available(iOS 8.2, *) {
            return withWeight(.bold)
        } else {
            return self
        }
    }
    var semibold: UIFont {
        if #available(iOS 8.2, *) {
            return withWeight(.semibold)
        } else {
            return self
        }
    }
    
    @objc func withWeight(_ weight: UIFont.Weight) -> UIFont {
        var attributes = fontDescriptor.fontAttributes
        var traits = (attributes[.traits] as? [UIFontDescriptor.TraitKey: Any]) ?? [:]
        
        traits[.weight] = weight
        
        attributes[.name] = nil
        attributes[.traits] = traits
        attributes[.family] = familyName
        
        let descriptor = UIFontDescriptor(fontAttributes: attributes)
        
        return UIFont(descriptor: descriptor, size: pointSize)
    }
}
