//
//  DefaultTableView.swift
//  Wall Of Fame
//
//  Created by Tarek Abdallah on 4/10/19.
//  Copyright © 2019 Tarek. All rights reserved.
//

import UIKit

class DefaultTableView: UITableView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    private var loadingView: UIView!
    private var indicator: UIActivityIndicatorView!
    @IBInspectable var emptyStateText:String = ""
    var emptyStateDelegate:EmptyStateViewDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func startLoader(){
        self.createLoadingView()
        self.indicator.startAnimating()

    }
    func stopLoader(){
        self.indicator.stopAnimating()
        self.tableFooterView = nil
        if self.numberOfRows(inSection: 0) == 0{
            self.showEmptyState(WithDetails: emptyStateText)
        }
        else{
            self.removeEmptyStateView()
        }
    }
    private func createLoadingView() {
        
        loadingView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        indicator = UIActivityIndicatorView()
        indicator.color = UIColor.lightGray
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.startAnimating()
        loadingView.addSubview(indicator)
        centerIndicator()
        self.tableFooterView = loadingView
    }
    private func centerIndicator() {
        let xCenterConstraint = NSLayoutConstraint(
            item: loadingView!, attribute: .centerX, relatedBy: .equal,
            toItem: indicator, attribute: .centerX, multiplier: 1, constant: 0
        )
        loadingView.addConstraint(xCenterConstraint)
        
        let yCenterConstraint = NSLayoutConstraint(
            item: loadingView!, attribute: .centerY, relatedBy: .equal,
            toItem: indicator, attribute: .centerY, multiplier: 1, constant: 0
        )
        loadingView.addConstraint(yCenterConstraint)
    }
    
    func showEmptyState(WithDetails details:String){
        for view in subviews{
            if view is EmptyStateView{
                return
            }
        }

        let emptyStateView:EmptyStateView = EmptyStateView.instanceFromNib()
        emptyStateView.frame = self.bounds
        emptyStateView.delegate = emptyStateDelegate
        emptyStateView.setup(details: details)
        self.addSubview(emptyStateView)
        self.isScrollEnabled = false
    }
    
    func removeEmptyStateView(){
        for view in subviews{
            if view is EmptyStateView{
                view.removeFromSuperview()
                self.isScrollEnabled = true
                return
            }
        }
    }
    

}
