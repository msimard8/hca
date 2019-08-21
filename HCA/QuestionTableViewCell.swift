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
          //      self.questionTitleLabel.text = "This is a readlly really really reallyreadlly really really reallyreadlly really really reallyreadlly really really reallyreadlly really really reallyreadlly really really reallyreadlly really really really "

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
            cardViewBackground.backgroundColor  = UIColor(red: 0.8784, green: 1, blue: 0.9804, alpha: 1.0)
        }
        else {
            cardViewBackground.backgroundColor = .white

        }
        // Configure the view for the selected state
    }
    
}

extension UIView {

    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }

    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }

    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }

    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }

    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}
