//
//  QuestionTableViewCell.swift
//  HCA
//
//  Created by Michael Simard on 8/20/19.
//  Copyright © 2019 Michael Simard. All rights reserved.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {

    @IBOutlet weak var numberOfAnswerLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var cardViewBackground: UIView!


    static let identifier = "ArticleListTableViewCell"
    var question:StackOverflowQuestion? {
        didSet{
            DispatchQueue.main.async {
                self.questionTitleLabel.text = self.question?.title
                self.dateLabel.text = "Asked On:  \(Utils.formatDate(date: self.question?.creationDate ?? Date()))"
                self.numberOfAnswerLabel.text = "No. of Answers: \(self.question?.answerCount ?? 0)"

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
        }
        else {
            cardViewBackground.backgroundColor = .white

        }
        // Configure the view for the selected state
    }
    
}

