//
//  RepoCollectionCell.swift
//  Assignment
//
//  Created by Jasmeet Singh on 15/07/21.
//

import UIKit
import SDWebImage

class RepoCollectionCell: UICollectionViewCell {

    @IBOutlet weak var repoDescriptionLabel: UILabel!
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var repoImageView: UIImageView!
    
    var repo: Repo? {
        didSet {
            updateContent()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func updateContent() {
        repoNameLabel.text = repo?.name
        repoDescriptionLabel.text = repo?.description
        if let url = URL(string: repo?.owner?.avatarUrl ?? "") {
            repoImageView.sd_setImage(with: url, placeholderImage: nil)
        }
    }
}
