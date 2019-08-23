//
//  AnswerListQuestionTableViewCell.swift
//  HCA
//
//  Created by Michael Simard on 8/21/19.
//  Copyright © 2019 Michael Simard. All rights reserved.
//

import UIKit

class AnswerListQuestionTableViewCell: UITableViewCell {
    static let identifier = "AnswerListQuestionTableViewCell"

    @IBOutlet weak var questionAttributedLabel: UILabel!

    @IBOutlet weak var bodyAttributedLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!

    var question:StackOverflowQuestion? {
        didSet {


            dateLabel.text = Utils.formatDate(date: question?.creationDate ?? Date())
            nameLabel.text = question?.owner.displayName ?? "anonymous"


            let font = UIFont.boldSystemFont(ofSize: 24)

            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.white,
                .font: font
            ]
            let attributedString = NSMutableAttributedString.init(html: question?.title ?? "")
            questionAttributedLabel.numberOfLines = 0
            attributedString?.addAttributes(attributes, range: NSRange(location: 0, length: (attributedString?.length ?? 0)))
            questionAttributedLabel.attributedText = attributedString


            let bodyFont = UIFont.systemFont(ofSize: 18)

            let bodyAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.white,
                .font: bodyFont
            ]

            let bodyAttributedString = NSMutableAttributedString.init(html: question?.body ?? "")
            bodyAttributedLabel.numberOfLines = 0
            bodyAttributedString?.addAttributes(bodyAttributes, range: NSRange(location: 0, length: (bodyAttributedString?.length ?? 0)))
            bodyAttributedLabel.attributedText = bodyAttributedString
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension AnswerListQuestionTableViewCell : ImageContainingTableViewCell {
    func setImage(image: UIImage?) {
        self.profileImageView.image = image
    }

    var imageURL: String {
        get {
            return question?.owner.profileImage ?? ""
        }
    }
}
