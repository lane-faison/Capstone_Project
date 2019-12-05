//
//  UIImage+Extensions.swift
//  MissionPR
//
//  Created by Lane Faison on 12/4/19.
//  Copyright © 2019 Lane Faison. All rights reserved.
//

import UIKit

extension UIImage {
    
    /// Produces a tinted variant of the receiver
    ///
    /// - Parameter tintColor: The color to tint the image
    /// - Returns: A new image tinted with `tintColor`
    public func tinted(tintColor: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let context = UIGraphicsGetCurrentContext()
        let imageRect = CGRect(origin: CGPoint.zero, size: size)
        context!.translateBy(x: 0, y: size.height)
        context!.scaleBy(x: 1.0, y: -1.0)
        context!.clip(to: imageRect, mask: cgImage!)
        context!.setFillColor(tintColor.cgColor)
        context!.fill(imageRect)
        
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return tintedImage!
    }
}
