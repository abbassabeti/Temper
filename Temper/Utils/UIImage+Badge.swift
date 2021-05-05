//
//  UIImage+Badge.swift
//  Temper
//
//  Created by Abbas on 2/13/21.
//

import UIKit

extension UIImage {
    func imageWith(newSize: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: newSize)
        let image = renderer.image { _ in
            self.draw(in: CGRect.init(origin: CGPoint.zero, size: newSize))
        }

        return image.withRenderingMode(self.renderingMode)
    }
    
    func badgeIt() -> UIImage{
        return imageWith(newSize: CGSize(width: 25, height: 25))
    }
    
    func bigBadgeIt() -> UIImage{
        return imageWith(newSize: CGSize(width: 40, height: 40))
    }
    
    func image(alpha: CGFloat) -> UIImage? {
            UIGraphicsBeginImageContextWithOptions(size, false, scale)
            draw(at: .zero, blendMode: .normal, alpha: alpha)
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return newImage
    }
}
