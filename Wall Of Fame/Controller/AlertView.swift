//
//  AlertView.swift
//  Soffa
//
//  Created by Tarek Abdallah on 14/8/19.
//  Copyright © 2019 Tarek. All rights reserved.
//

import UIKit
enum AlertViewStrings: String {
    case nibName = "AlertView"
}
class AlertView: UIView {
    var didRetry:(() -> Void)!
    @IBOutlet weak var titlelabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var retryButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    class func instanceFromNib() -> AlertView {
        return UINib(nibName: AlertViewStrings.nibName.rawValue, bundle: .main)
            .instantiate(withOwner: nil, options: nil)[0] as? AlertView ?? AlertView()
    }
    @IBAction func dismissPressed(_ sender: Any) {
        self.dismissPopup()
    }
    @IBAction func retryButtonPressed(_ sender: Any) {
        didRetry()
    }
    func dialog(withTitle title: String, andMessage message: String) {
        titlelabel.text = title
        detailsLabel.text = message
    }
}
