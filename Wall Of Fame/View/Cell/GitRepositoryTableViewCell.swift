//
//  GitRepositoryTableViewCell.swift
//  Wall Of Fame
//
//  Created by Tarek Abdallah on 30/9/19.
//  Copyright © 2019 Tarek. All rights reserved.
//

import UIKit
enum GitRepositoryTableViewCellStrings: String {
    case nibName = "GitRepositoryTableViewCell"
    case cellIdentifier = "gitRepoCell"
}
class GitRepositoryTableViewCell: UITableViewCell {
    @IBOutlet weak var ownerAliasImageView: UIImageView!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var repoDescriptionLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var backgroundCardView: UIView!
    @IBOutlet weak var starsImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundCardView.dropShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setup(repo: GitRepositoryModel) {
        repoNameLabel.text = repo.name
        repoDescriptionLabel.text = repo.description
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: "en_US")
        starsLabel.text = formatter.string(from: NSNumber(value: repo.stars ?? 0))!
        ownerNameLabel.text = repo.owner?.name ?? ""
        starsImageView.tintColor = UIColor(red: 246/255, green: 198/255, blue: 40/255, alpha: 1)
        starsImageView.image = UIImage(named: "star")?.withRenderingMode(.alwaysTemplate)
    }
}
