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
    var key = ""
    let session = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    var decoder = JSONDecoder()

    internal static var shared: NetworkService = {
        let instance = NetworkService()
        return instance
    }()

    func getRecentQuestions(page:Int = 1, date:Date = Date.init(timeIntervalSinceNow: 0), completion: @escaping((_ questionList: StackOverflowQuestionList) -> Void)){

        dataTask?.cancel()

         if var urlComponents = URLComponents (string: "\(baseURL)/search/advanced") {
            urlComponents.query = "page=\(page)&pagesize=10"
            + "&todate=\(Int(date.timeIntervalSince1970))"
            + "&order=desc&sort=creation"
            + "&accepted=True&answers=2"
            + "&site=stackoverflow"
            + "&filter=!4(Yr(ztczR*6OAdo1"
            + "&key=wV5REhLr1WpnH1aejgbZHw(("

            guard let url = urlComponents.url else {
                return
            }

            dataTask = session.dataTask(with: url) {[weak self] (data, response, error) in
                defer {
                    self?.dataTask = nil
                }

                if let error = error {
                    print ("Error \(error.localizedDescription)")
                }
                else if
                    let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    let questions = try! self?.decoder.decode(StackOverflowQuestionList.self, from: data)
                    completion(questions!)
                    print (questions!.quotaRemaining)

                }
                else {
                    //assume error
                }
            }
            dataTask?.resume()
        }
    }
}
