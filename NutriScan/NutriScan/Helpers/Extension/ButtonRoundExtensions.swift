//
//  ButtonRoundExtensions.swift
//  NutriScan
//
//  Created by Elena Diniz on 10/16/25.
//

import UIKit

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius

        self.layer.maskedCorners = corners.toCACornerMask()
    }
}

extension UIRectCorner {
    func toCACornerMask() -> CACornerMask {
        var mask: CACornerMask = []
        if self.contains(.topLeft) {
            mask.insert(.layerMinXMinYCorner)
        }
        if self.contains(.topRight) {
            mask.insert(.layerMaxXMinYCorner)
        }
        if self.contains(.bottomLeft) {
            mask.insert(.layerMinXMaxYCorner)
        }
        if self.contains(.bottomRight) {
            mask.insert(.layerMaxXMaxYCorner)
        }
        return mask
    }
}
