//
//  UIImageExtension.swift
//  Wall Of Fame
//
//  Created by Tarek Abdallah on 30/9/19.
//  Copyright © 2019 Tarek. All rights reserved.
//

import Foundation
import UIKit

private var circular: Bool = false
extension UIImageView {
    @IBInspectable var isCircular: Bool {
        get {
            guard let value = objc_getAssociatedObject(self, &circular) as? Bool else {
                return false
            }
            return value
        }
        set(newValue) {
            objc_setAssociatedObject(self,
                                     &circular,
                                     newValue,
                                     objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            if newValue {
                layer.cornerRadius = frame.width/2
            } else {
                layer.cornerRadius = cornerRadius
            }
        }
    }

    func downloadedFrom(url: URL,
                        tableView: UITableView? = nil,
                        indexPath: IndexPath? = nil,
                        contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        self.image = UIImage(named: "placeholder")
        let imageCache = NSCache<NSString, UIImage>()
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            self.image = cachedImage
        } else {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data, error == nil,
                    let image = UIImage(data: data)
                    else { return }
                DispatchQueue.main.async { () -> Void in
                    imageCache.setObject(image, forKey: url.absoluteString as NSString)
                    if indexPath == nil || tableView == nil {
                        self.image = image
                    } else if tableView!.cellForRow(at: indexPath!) != nil {
                        self.image = image
                    }
                }
                }.resume()
        }
    }

    func downloadedFrom(link: String,
                        tableView: UITableView? = nil,
                        indexPath: IndexPath? = nil,
                        contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, tableView: tableView, indexPath: indexPath, contentMode: mode)
    }
}
