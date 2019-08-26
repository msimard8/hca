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
    var key: String = "REPLACE-THIS-WITH-API-KEY"
    let pageSize = 20

    let session = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    var decoder = JSONDecoder()

    internal static var shared: NetworkService = {
        let instance = NetworkService()
        instance.decoder.dateDecodingStrategy = .secondsSince1970

        return instance
    }()

    private func performDataTask(urlComponents: URLComponents,
                                 completion:  @escaping((_ data: Data?, _ error: Error?) -> Void)) {
        dataTask?.cancel()

        guard let url = urlComponents.url else {
            return
        }

        dataTask = session.dataTask(with: url) {[weak self] (data, response, error) in
            defer {
                self?.dataTask = nil
            }

            if let error = error {
                print ("Error \(error.localizedDescription)")
            } else if
                let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                completion(data, error)
            } else {
                completion(nil, error)
            }
        }
        self.dataTask?.resume()
    }

    func getAnswers (questionId: Int,
                     completion: @escaping((_ answerList: StackOverflowAnswerList?, _ error: Error?) -> Void)) {

        if var urlComponents = URLComponents (string: "\(baseURL)/questions/\(questionId)/answers") {
            urlComponents.query = "order=desc"
                + "&sort=votes"
                + "&site=stackoverflow"
                + "&filter=!)Q2AgQTb-X*Za_BUKPaSUeie"
                + "&key=\(key)"

            performDataTask(urlComponents: urlComponents) { [weak self] (data, error) in
                guard let data = data else {
                    completion(nil, error)
                    return
                }
                if let error = error {
                    completion(nil, error)
                } else {
                    do {
                        let answers = try self?.decoder.decode(StackOverflowAnswerList.self, from: data)
                        completion(answers, nil)
                    } catch let jsonDecodeError {
                        completion(nil, jsonDecodeError)

                    }
                }
            }
        }
    }

    func getRecentQuestions(page: Int = 1,
                            date: Date = Date.init(timeIntervalSinceNow: 0),
                            completion: @escaping((_ questionList: StackOverflowQuestionList?,
                                                  _ error: Error?) -> Void)) {

        if var urlComponents = URLComponents (string: "\(baseURL)/search/advanced") {
            urlComponents.query = "page=\(page)&pagesize=\(pageSize)"
                + "&todate=\(Int(date.timeIntervalSince1970))"
                + "&order=desc&sort=creation"
                + "&accepted=True"
                + "&answers=2"
                + "&site=stackoverflow"
                + "&filter=!.FjtmoGIogKGfL93TUUw1f7UHRoCT"
                + "&key=\(key)"

            performDataTask(urlComponents: urlComponents) {[weak self] (data, error) in
                guard let data = data else {
                    completion(nil, error)
                    return
                }
                if let error = error {
                    completion(nil, error)
                } else {
                    do {
                        let questions = try self?.decoder.decode(StackOverflowQuestionList.self, from: data)
                        completion(questions, nil)
                    } catch let jsonDecodeError {
                        completion(nil, jsonDecodeError)

                    }
                }
            }

        }
    }

    func getImage(urlString: String, completion: @escaping ((_ image: UIImage?, _ error: Error?) -> Void)) {

        guard let imageURL = URL(string: urlString) else {
            completion(nil, NSError.init(domain: "Bad URL", code: 0, userInfo: nil))
            return
        }

        let task = session.dataTask(with: imageURL) { (imageData, _, error) in
            if let dataTaskError = error {
                completion (nil, dataTaskError)
            }
            guard let data = imageData else {
                completion(nil, ImageDownloadError.noData)
                return
            }
            guard let image = UIImage(data: data) else {
                completion(nil, ImageDownloadError.badData)
                return
            }
            completion(image, nil)
        }
        task.resume()
    }
    
    func hasAPIKeyBeenReplaced() -> Bool {
        if key != "REPLACE-THIS-WITH-API-KEY"{
            return true
        }
        else {
            key = ""
            return false
        }
    }
}

enum ImageDownloadError: Error {
    case noData
    case badData
}
