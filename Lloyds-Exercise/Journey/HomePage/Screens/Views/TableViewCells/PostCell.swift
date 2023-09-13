//
//  PostCell.swift
//
//  Copyright © 2023 Manju Kiran. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet private(set) var titleLabel: UILabel!
    @IBOutlet private(set) var userNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.configureFor(style: .title1)
        userNameLabel.configureFor(style: .subheadline)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        [
            titleLabel,
            userNameLabel
        ].forEach { $0.text = "" }
    }

    func configure(with post: Post, user: User) {
        titleLabel.text = post.title
        userNameLabel.text = user.username
    }

}
