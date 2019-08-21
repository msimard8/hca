//
//  StackOverflowQuestionList.swift
//  HCA
//
//  Created by Michael Simard on 8/20/19.
//  Copyright © 2019 Michael Simard. All rights reserved.
//

import Foundation

struct StackOverflowQuestionList:Codable {

    var quotaRemaining:Int

    var questions:[StackOverflowQuestion]
    enum CodingKeys: String, CodingKey {
        case questions = "items"
        case quotaRemaining = "quota_remaining"

    }
}
