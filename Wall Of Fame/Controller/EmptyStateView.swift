//
//  EmptyTableView.swift
//  Wall Of Fame
//
//  Created by Tarek Abdallah on 6/10/19.
//  Copyright © 2019 Tarek. All rights reserved.
//

import Foundation
import UIKit
protocol EmptyStateViewDelegate: class {
    func reloadButtonPressed()
}
class EmptyStateView: UIView {
    @IBOutlet weak var detailsLabel: UILabel!
    weak var delegate: EmptyStateViewDelegate?
    class func instanceFromNib() -> EmptyStateView {
        return UINib(nibName: "EmptyStateView",
                     bundle: .main).instantiate(withOwner: nil, options: nil)[0] as? EmptyStateView ?? EmptyStateView()
    }
    func setup(details: String) {
        detailsLabel.text = details
    }
    @IBAction func didPressReload(_ sender: Any) {
        delegate?.reloadButtonPressed()
    }
}
