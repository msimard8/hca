//
//  StackOverflowAnswer.swift
//  HCA
//
//  Created by Michael Simard on 8/21/19.
//  Copyright © 2019 Michael Simard. All rights reserved.
//

import Foundation

struct StackOverflowAnswer:Codable {
    var score:Int
    var isAccepted:Bool
    var answerId:Int
    var creationDate:Date
    var body:String
    enum CodingKeys: String, CodingKey {
        case body = "body"
        case score = "score"
        case answerId = "answer_id"
        case creationDate = "creation_date"
        case isAccepted = "is_accepted"

    }
}
