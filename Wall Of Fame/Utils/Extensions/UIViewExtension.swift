//
//  UIViewExtension.swift
//  Wall Of Fame
//
//  Created by Tarek Abdallah on 30/9/19.
//  Copyright © 2019 Tarek. All rights reserved.
//

import Foundation
import UIKit
extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    func dropShadow(scale: Bool = true, opacity: Float = 0.7, cornerRadius: Int = 10) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    func  presentPopup(view: UIView, duration: Double = 0.3) {
        view.transform = CGAffineTransform(scaleX: 0, y: 0)
        let backgroundView = UIView(frame: UIScreen.main.bounds)
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        backgroundView.viewWithTag(100)
        let tapGesture = UITapGestureRecognizer(target: backgroundView,
                                                                       action: #selector(backgroundView.dismissPopup(sender:duration:)))
        backgroundView.addGestureRecognizer(tapGesture)
        backgroundView.addSubview(view)
        self.addSubview(backgroundView)
        UIView.animate(withDuration: duration, animations: {
            view.transform = CGAffineTransform(scaleX: 1, y: 1)
        }) { finished in
        }
    }
    func dismissPopup() {
        var popupView: UIView!
        for view in subviews {
            if view.subviews.first?.tag == 1 {
                popupView = view.subviews.first!
            }
        }
        UIView.animate(withDuration: 0.3, animations: {
            popupView?.transform = CGAffineTransform(scaleX: 0, y: 0)
        }) { finished in
            popupView?.transform = CGAffineTransform.identity
            self.superview?.removeFromSuperview()
            self.removeFromSuperview()
        }
    }
    func pressInView(sender: UITapGestureRecognizer) -> Bool {
        if sender.state == UIGestureRecognizer.State.ended {
            let location: CGPoint = sender.location(in: self)
            if !self.point(inside: location, with: nil) {
                return false
            } else {
                return true
            }
        }
        return true
    }
    @objc func dismissPopup(sender: UITapGestureRecognizer, duration: Double = 0.3) {
        var popupView: UIView!
        for view in subviews {
            if view.subviews.first?.tag == 1 {
                popupView = view.subviews.first!
            }
        }
        if popupView?.pressInView(sender: sender) ?? false {
            return
        }
        self.removeGestureRecognizer(sender)
        UIView.animate(withDuration: duration, animations: {
            popupView?.transform = CGAffineTransform(scaleX: 0, y: 0)
        }) { finished in
            popupView?.transform = CGAffineTransform.identity
            self.removeFromSuperview()
        }
    }
    static func showErrorDialog(title: String, details: String, retry: @escaping () -> Void) {
        if let displayView = UIApplication.shared.keyWindow?.rootViewController?.view {
            for view in displayView.subviews {
                if view is AlertView {
                    return
                }
            }
            let alert = AlertView.instanceFromNib()
            alert.frame = UIScreen.main.bounds
            alert.titlelabel.text = title
            alert.detailsLabel.text = details
            alert.didRetry = retry
            displayView.presentPopup(view: alert)
        }
    }
}
