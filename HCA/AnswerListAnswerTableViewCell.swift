//
//  AnswerListAnswerTableViewCell.swift
//  HCA
//
//  Created by Michael Simard on 8/21/19.
//  Copyright © 2019 Michael Simard. All rights reserved.
//

import UIKit

class AnswerListAnswerTableViewCell: UITableViewCell {

    @IBOutlet weak var answerAttributedLabel: UILabel!
    
    var answer:StackOverflowAnswer? {
        didSet {
            let font = UIFont.systemFont(ofSize: 18)
            let attributedString = NSMutableAttributedString.init(html: answer?.body ?? "")
            answerAttributedLabel.numberOfLines = 0
            attributedString?.setFontFace(font: font, color: .black)
            answerAttributedLabel.attributedText = attributedString
        }
    }
    static let identifier = "AnswerListAnswerTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
