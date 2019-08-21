//
//  StackOverflowQuestion.swift
//  HCA
//
//  Created by Michael Simard on 8/20/19.
//  Copyright © 2019 Michael Simard. All rights reserved.
//

import Foundation

struct StackOverflowQuestionList:Codable {

    var questions:[StackOverflowQuestion]
    
    struct StackOverflowQuestion:Codable {
        var acceptedAnswerId:Int?
        var answerCount:Int
        var questionId:Int
        var title:String
        var creationDate:Date
        enum CodingKeys: String, CodingKey {
            case acceptedAnswerId = "accepted_answer_id"
            case answerCount = "answer_count"
            case questionId = "question_id"
            case title = "title"
            case creationDate = "creation_date"
        }
    }
    enum CodingKeys: String, CodingKey {
        case questions = "items"
    }
}



