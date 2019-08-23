//
//  StackOverflowQuestion.swift
//  HCA
//
//  Created by Michael Simard on 8/20/19.
//  Copyright © 2019 Michael Simard. All rights reserved.
//

import Foundation

struct StackOverflowQuestion: Codable {
    var acceptedAnswerId: Int?
    var answerCount: Int
    var questionId: Int
    var title: String
    var creationDate: Date
    var body: String
    var owner: StackOverflowOwner
    enum CodingKeys: String, CodingKey {
        case acceptedAnswerId = "accepted_answer_id"
        case answerCount = "answer_count"
        case questionId = "question_id"
        case title = "title"
        case creationDate = "creation_date"
        case owner = "owner"
        case body = "body"
    }
}
