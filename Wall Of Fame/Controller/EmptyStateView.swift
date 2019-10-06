//
//  EmptyTableView.swift
//  Wall Of Fame
//
//  Created by Tarek Abdallah on 6/10/19.
//  Copyright © 2019 Tarek. All rights reserved.
//

import Foundation
import UIKit
protocol EmptyStateViewDelegate{
    func reloadButtonPressed()
}
class EmptyStateView:UIView{
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    @IBOutlet weak var detailsLabel: UILabel!
    var delegate:EmptyStateViewDelegate?
    class func instanceFromNib() -> EmptyStateView{
        return UINib(nibName: "EmptyStateView", bundle: .main).instantiate(withOwner: nil, options: nil)[0] as! EmptyStateView
    }
    
    func setup(details:String){
        detailsLabel.text = details
    }

    
    @IBAction func didPressReload(_ sender: Any){
        delegate?.reloadButtonPressed()
    }    
}
