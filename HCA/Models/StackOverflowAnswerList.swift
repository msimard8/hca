//
//  StackOverflowAnswerList.swift
//  HCA
//
//  Created by Michael Simard on 8/21/19.
//  Copyright © 2019 Michael Simard. All rights reserved.
//

import Foundation

struct StackOverflowAnswerList: Codable {
    var answers: [StackOverflowAnswer]
    enum CodingKeys: String, CodingKey {
        case answers = "items"
    }
    func answerListWithBestFirst() -> [StackOverflowAnswer] {
        return answers.sorted(by: { (answer1, _) -> Bool in
            return answer1.isAccepted
        })
    }
}
