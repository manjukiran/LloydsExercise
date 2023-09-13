//
//  PlaceHolderCell.swift
//
//  Copyright © 2023 Manju Kiran. All rights reserved.
//

import UIKit

class PlaceHolderCell: UITableViewCell {
    
    @IBOutlet weak var placeholderImage: UIImageView!
    @IBOutlet weak var placeholderLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.placeholderImage.image = nil
        self.placeholderLabel.text = ""
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        prepareCell()
    }

    private func prepareCell() {
        self.placeholderImage.image = nil
        self.placeholderLabel.text = ""
    }
    
    func configureCell(imageName: String, text: String) {
        self.placeholderImage.image = UIImage(named: imageName)
        self.placeholderLabel.text = text
    }
}
