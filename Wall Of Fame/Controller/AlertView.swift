//
//  AlertView.swift
//  Soffa
//
//  Created by Tarek Abdallah on 14/8/19.
//  Copyright © 2019 Tarek. All rights reserved.
//

import UIKit

class AlertView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var didRetry:(()->Void)!
    @IBOutlet weak var titlelabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var retryButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    class func instanceFromNib() -> AlertView{
        return UINib(nibName: "AlertView", bundle: .main).instantiate(withOwner: nil, options: nil)[0] as! AlertView
    }
    @IBAction func dismissPressed(_ sender: Any) {
        self.dismissPopup()
    }

    @IBAction func retryButtonPressed(_ sender: Any) {
        didRetry()
    }
    
    func dialog(withTitle title:String, andMessage message:String) {
        titlelabel.text = title
        detailsLabel.text = message
    }
}