//
//  AnswerListViewController.swift
//  HCA
//
//  Created by Michael Simard on 8/20/19.
//  Copyright © 2019 Michael Simard. All rights reserved.
//

import UIKit
import WebKit

class AnswerListViewController: UIViewController {
    @IBOutlet weak var answersTableView: UITableView?

    var question: StackOverflowQuestion? {
        didSet {
            DispatchQueue.main.async {

                self.answersTableView?.isHidden = true
                self.answersTableView?.setContentOffset(.zero, animated: false)

                NetworkService.shared.getAnswers(questionId: self.question?.questionId ?? 0) { (answerList) in
                    self.answers = answerList?.answerListWithBestFirst() ?? []
                    DispatchQueue.main.async {
                        self.answersTableView?.reloadData()
                        self.answersTableView?.isHidden = false
                    }
                }
            }
        }
    }
    var answers = [StackOverflowAnswer]()

    override func viewDidLoad() {
        super.viewDidLoad()

        answersTableView?.estimatedRowHeight = 55
        answersTableView?.rowHeight = UITableView.automaticDimension
        answersTableView?.register(UINib(nibName: "AnswerListQuestionTableViewCell", bundle: nil), forCellReuseIdentifier: AnswerListQuestionTableViewCell.identifier)
        answersTableView?.register(UINib(nibName: "AnswerListAnswerTableViewCell", bundle: nil), forCellReuseIdentifier: AnswerListAnswerTableViewCell.identifier)
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Answers"
    }

    private func downloadImage(urlString: String, cell: ImageContainingTableViewCell) {
        NetworkService.shared.getImage(urlString: urlString) { (image, error) in
            DispatchQueue.main.async {
                guard let img = image else {
                    return
                }
                ImageCache.shared.storeImage(key: urlString, image: img)
                if cell.imageURL == urlString {
                if error == nil {
                    cell.setImage(image: image)
                } else {
                    cell.setImage(image: nil)
                }
            }
            }

        }
    }
}

extension AnswerListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.row == 0 {
            guard let answerListQuestionCell = tableView.dequeueReusableCell(withIdentifier: AnswerListQuestionTableViewCell.identifier, for: indexPath) as? AnswerListQuestionTableViewCell else {
                return UITableViewCell()
            }
            answerListQuestionCell.question = question
            return answerListQuestionCell
        } else {
            guard let answerListAnswerCell = tableView.dequeueReusableCell(withIdentifier: AnswerListAnswerTableViewCell.identifier, for: indexPath) as? AnswerListAnswerTableViewCell else {
                return UITableViewCell()
            }
            if answers.count > 0 {
                answerListAnswerCell.answer = answers[indexPath.row - 1]
            }
            return answerListAnswerCell
        }
    }
}

extension AnswerListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let imageContainingCell = cell as? ImageContainingTableViewCell {
            imageContainingCell.setImage(image: nil)
            let imageURL = imageContainingCell.imageURL

            if let cachedImage = ImageCache.shared.retrieveImage(key: imageURL) {
                imageContainingCell.setImage(image: cachedImage)
            } else {
                downloadImage(urlString: imageURL, cell: imageContainingCell)
            }
        }
    }
}
