//
//  GitRepositoryTableViewCell.swift
//  Wall Of Fame
//
//  Created by Tarek Abdallah on 30/9/19.
//  Copyright © 2019 Tarek. All rights reserved.
//

import UIKit

class GitRepositoryTableViewCell: UITableViewCell {

    @IBOutlet weak var ownerAliasImageView: UIImageView!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var repoDescriptionLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setup(repo:GitRepositoryModel){
        ownerAliasImageView.downloadedFrom(link: repo.owner.avatar)
        repoNameLabel.text = repo.name
        repoDescriptionLabel.text = repo.description
        starsLabel.text = "\(repo.stars ?? 0)"
        ownerNameLabel.text = repo.owner.name
    }
    
}
