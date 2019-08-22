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
    let key:String = "wV5REhLr1WpnH1aejgbZHw(("
    let pageSize = 20
    let session = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    var decoder = JSONDecoder()

    internal static var shared: NetworkService = {
        let instance = NetworkService()
        return instance
    }()


    func getAnswers (questionId:Int, completion: @escaping((_ questionList: StackOverflowAnswerList) -> Void)){

        decoder.dateDecodingStrategy = .secondsSince1970

        dataTask?.cancel()

        if var urlComponents = URLComponents (string: "\(baseURL)/questions/\(questionId)/answers") {
            urlComponents.query = "order=desc"
            + "&sort=votes"
            + "&site=stackoverflow"
            + "&filter=!)Q2AgQTb-X*Za_BUKPaSUeie"
            + "&key=\(key)"

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
                    let answers = try! self?.decoder.decode(StackOverflowAnswerList.self, from: data)
                    completion(answers!)

                }
                else {
                    //assume error
                }
            }
            dataTask?.resume()
        }


    }

    func getRecentQuestions(page:Int = 1, date:Date = Date.init(timeIntervalSinceNow: 0), completion: @escaping((_ questionList: StackOverflowQuestionList) -> Void)){

        decoder.dateDecodingStrategy = .secondsSince1970

        dataTask?.cancel()

         if var urlComponents = URLComponents (string: "\(baseURL)/search/advanced") {
            urlComponents.query = "page=\(page)&pagesize=\(pageSize)"
            + "&todate=\(Int(date.timeIntervalSince1970))"
            + "&order=desc&sort=creation"
            + "&accepted=True&answers=2"
            + "&site=stackoverflow"
            + "&filter=!Fcb8-IEX7ThAPGnNQjZJpIpIOD"
            + "&key=\(key)"

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

    func getImage(urlString: String, completion: @escaping ((_ image: UIImage?, _ error: Error?) -> Void)) {

        guard let imageURL = URL(string: urlString) else {
            completion(nil, NSError.init(domain: "Bad URL", code: 0, userInfo: nil))
            return
        }

        let t = session.dataTask(with: imageURL) { (imageData, response, error) in
            guard let data = imageData else {
                completion(nil, error)
                return
            }
            guard let image = UIImage(data: data) else {
                completion(nil, error)
                return
            }
            completion(image, nil)
        }
        t.resume()
    }


}
