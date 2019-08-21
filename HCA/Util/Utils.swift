//
//  Utils.swift
//  HCA
//
//  Created by Michael Simard on 8/21/19.
//  Copyright © 2019 Michael Simard. All rights reserved.
//

import UIKit

class Utils: NSObject {

    static func formatDate(date: Date) -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            print(date.timeIntervalSince1970)
            let displayFormatter = DateFormatter()
            displayFormatter.locale = Locale(identifier: "en_US")
            displayFormatter.dateFormat = "MMM d, YYYY, h:mm a"
            return displayFormatter.string(from: date)
    }


}
