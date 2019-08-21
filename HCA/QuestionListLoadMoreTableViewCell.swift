//
//  QuestionListLoadMoreTableViewCell.swift
//  HCA
//
//  Created by Michael Simard on 8/20/19.
//  Copyright © 2019 Michael Simard. All rights reserved.
//

import UIKit

class QuestionListLoadMoreTableViewCell: UITableViewCell {

    static let identifier = "QuestionListLoadMoreTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
