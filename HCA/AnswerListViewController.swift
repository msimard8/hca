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


    var question : StackOverflowQuestion? {
        didSet {
           // answers.append(StackOverflowAnswer(score: 0, isAccepted: true, answerId: 3, creationDate: Date(), body: "boo"))
            NetworkService.shared.getAnswers(questionId: question?.questionId ?? 0) { (answerList) in
                self.answers = answerList.answers
                DispatchQueue.main.async {
                    self.answersTableView?.reloadData()
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


}

extension AnswerListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            if indexPath.row == 0 {
                guard let answerListQuestionCell = tableView.dequeueReusableCell(withIdentifier: AnswerListQuestionTableViewCell.identifier, for: indexPath) as? AnswerListQuestionTableViewCell else{
                    return UITableViewCell()
                }
                answerListQuestionCell.question = question
                return answerListQuestionCell
            }
            else {
                guard let answerListAnswerCell = tableView.dequeueReusableCell(withIdentifier: AnswerListAnswerTableViewCell.identifier, for: indexPath) as? AnswerListAnswerTableViewCell else{
                    return UITableViewCell()
                }
               answerListAnswerCell.answer = answers[indexPath.row - 1]
                return answerListAnswerCell

            }

    }


}

extension AnswerListViewController : UITableViewDelegate {

}
