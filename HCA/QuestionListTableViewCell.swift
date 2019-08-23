//
//  QuestionListTableViewCell.swift
//  HCA
//
//  Created by Michael Simard on 8/22/19.
//  Copyright © 2019 Michael Simard. All rights reserved.
//

import UIKit

class QuestionListTableViewCell: UITableViewCell {

    @IBOutlet weak var numberOfAnswerLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var cardViewBackground: UIView!
    @IBOutlet weak var patientNameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!

    static let identifier = "QuestionListTableViewCell"
    var question: StackOverflowQuestion? {
        didSet {
            DispatchQueue.main.async {
                self.questionTitleLabel.text = self.question?.title
                self.dateLabel.text = "Asked on: \(Utils.formatDate(date: self.question?.creationDate ?? Date()))"
                self.numberOfAnswerLabel.text = "\(self.question?.answerCount ?? 0)"
                self.profileImageView.image = nil
                self.patientNameLabel.text = self.question?.owner.displayName ?? "anonymous"
                let font = UIFont.systemFont(ofSize: 18, weight: .bold)
                let attributes: [NSAttributedString.Key: Any] = [
                    .foregroundColor: UIColor.black,
                    .font: font
                ]
                let attributedString = NSMutableAttributedString.init(html: self.question?.title ?? "")
                self.questionTitleLabel.numberOfLines = 0
                attributedString?.addAttributes(attributes, range: NSRange(location: 0, length: (attributedString?.length ?? 0)))
                self.questionTitleLabel.attributedText = attributedString
            }
        }
    }

    @IBOutlet weak var questionTitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            cardViewBackground.backgroundColor  =  UIColor(red: 187.0/255.0, green: 224.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        } else {
            cardViewBackground.backgroundColor = .white
        }
        // Configure the view for the selected state
    }
}

extension QuestionListTableViewCell: ImageContainingTableViewCell {
    func setImage(image: UIImage?) {
        DispatchQueue.main.async {
            self.profileImageView.image = image
        }
    }

    var imageURL: String {
        return question?.owner.profileImage ?? ""
    }
}
