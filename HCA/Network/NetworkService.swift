//
//  NetworkService.swift
//  HCA
//
//  Created by Michael Simard on 8/20/19.
//  Copyright © 2019 Michael Simard. All rights reserved.
//

import UIKit

class NetworkService: NSObject {
    let baseURL = "https://api.stackexchange.com/2.2"

    internal static var shared: NetworkService = {
        let instance = NetworkService()
        return instance
    }()

    

}
