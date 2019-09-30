//
//  UIViewExtension.swift
//  Wall Of Fame
//
//  Created by Tarek Abdallah on 30/9/19.
//  Copyright © 2019 Tarek. All rights reserved.
//

import Foundation
import UIKit
extension UIView{
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

}
