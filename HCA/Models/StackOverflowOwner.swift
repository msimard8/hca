//
//  StackOverflowOwner.swift
//  HCA
//
//  Created by Michael Simard on 8/22/19.
//  Copyright © 2019 Michael Simard. All rights reserved.
//

import Foundation

struct StackOverflowOwner: Codable {
    var displayName: String
    var profileImage: String
    var reputation: Int?

    enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
        case profileImage = "profile_image"
        case reputation = "reputation"
    }
}
