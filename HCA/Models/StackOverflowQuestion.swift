//
//  StackOverflowQuestion.swift
//  HCA
//
//  Created by Michael Simard on 8/20/19.
//  Copyright © 2019 Michael Simard. All rights reserved.
//

import Foundation

struct StackOverflowQuestionModel:Decodable {
    var acceptedAnswerId:Int?
    var answerCount:Int
    var questionId:Int
    var title:String
    var creationDate:Date
}

