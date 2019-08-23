//
//  AnswerListAnswerTableViewCell.swift
//  HCA
//
//  Created by Michael Simard on 8/21/19.
//  Copyright © 2019 Michael Simard. All rights reserved.
//

import UIKit

protocol ImageContainingTableViewCell {
    func setImage(image: UIImage?)
    var imageURL: String {get}
}

class AnswerListAnswerTableViewCell: UITableViewCell {

    @IBOutlet weak var answerAttributedLabel: UILabel!
    @IBOutlet weak var cardBackgroundView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var checkmarkImageView: UIImageView!

    var answer: StackOverflowAnswer? {
        didSet {
            let font = UIFont.systemFont(ofSize: 18)
            let attributedString = NSMutableAttributedString.init(html: answer?.body ?? "")
            answerAttributedLabel.numberOfLines = 0
            attributedString?.setFontFace(font: font, color: .black)
            answerAttributedLabel.attributedText = attributedString
            dateLabel.text = Utils.formatDate(date: answer?.creationDate ?? Date())
            scoreLabel.text = "\(answer?.score ?? 0)"
            nameLabel.text = "\(answer?.owner.displayName ?? "anonymous") (\(answer?.owner.reputation ?? 0))"

             if answer?.isAccepted ?? false {
                cardBackgroundView.backgroundColor = UIColor.Secondary.Blue
                checkmarkImageView.isHidden = false

            } else {
                cardBackgroundView.backgroundColor = .white
                checkmarkImageView.isHidden = true
            }
        }
    }
    static let identifier = "AnswerListAnswerTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        checkmarkImageView.image = checkmarkImageView.image?.withRenderingMode(.alwaysTemplate)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension AnswerListAnswerTableViewCell: ImageContainingTableViewCell {
    var imageURL: String {
            return answer?.owner.profileImage ?? ""
    }

    func setImage(image: UIImage?) {
        self.profileImageView.image = image
    }
}
