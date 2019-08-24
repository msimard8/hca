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

    var question: StackOverflowQuestion? {
        didSet {
            dateLabel.text = Utils.formatDate(date: question?.creationDate ?? Date())
            nameLabel.text = question?.owner.displayName ?? "anonymous"
            questionAttributedLabel.numberOfLines = 0
            bodyAttributedLabel.numberOfLines = 0

            questionAttributedLabel.attributedText = Utils.makeAttributedString(html: question?.title ?? "",
                                                                          font: UIFont.boldSystemFont(ofSize: 24),
                                                                          color: .white)

            bodyAttributedLabel.attributedText =  Utils.makeAttributedString(html: question?.body ?? "",
                                                                        font: UIFont.systemFont(ofSize: 18),
                                                                        color: .white)
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

extension AnswerListQuestionTableViewCell: ImageContainingTableViewCell {
    func setImage(image: UIImage?) {
        self.profileImageView.image = image
    }

    var imageURL: String {
            return question?.owner.profileImage ?? ""
    }
}
