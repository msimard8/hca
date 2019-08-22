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

    var question:StackOverflowQuestion? {
        didSet {

            let font = UIFont.systemFont(ofSize: 30)

            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.white,
                .font: font
            ]


            let attributedString = NSMutableAttributedString.init(html: question?.title ?? "")

            questionAttributedLabel.numberOfLines = 0
            attributedString?.addAttributes(attributes, range: NSRange(location: 0, length: (attributedString?.length ?? 0)))
            questionAttributedLabel.attributedText = attributedString
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
