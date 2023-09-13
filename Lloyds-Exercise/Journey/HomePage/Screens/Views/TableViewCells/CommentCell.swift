//
//  CommentCell.swift
//
//  Copyright © 2023 Manju Kiran. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {

    @IBOutlet private var commentBodyLabel: UILabel!
    @IBOutlet private var commenterNameLabel: UILabel!
    @IBOutlet private var commenterEmailLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        commenterNameLabel.configureFor(style: .title1)
        commenterEmailLabel.configureFor(style: .subheadline)
        commentBodyLabel.configureFor(style: .body)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        [
            commenterNameLabel,
            commenterEmailLabel,
            commentBodyLabel
        ].forEach { $0?.text = "" }
    }

    func configure(with comment: Comment) {
        commenterNameLabel.text = comment.name
        commenterEmailLabel.text = comment.email
        commentBodyLabel.text = comment.body
    }
}
