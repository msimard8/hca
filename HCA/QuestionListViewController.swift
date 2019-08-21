//
//  QuestionListViewController.swift
//  HCA
//
//  Created by Michael Simard on 8/20/19.
//  Copyright © 2019 Michael Simard. All rights reserved.
//

import UIKit

protocol QuestionListViewControllerDelegate: class {
    
}

class QuestionListViewController: UIViewController {

    @IBOutlet weak var questionsTableView: UITableView!
    var questions = [StackOverflowQuestion]()
    var date = Date()
    var pagesLoaded = 0
    var maxQuestionCount = 300 //putting a max so api doesnt get abused

    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionsTableView.register(UINib(nibName: "QuestionTableViewCell", bundle: nil), forCellReuseIdentifier: QuestionTableViewCell.identifier)
        questionsTableView.register(UINib(nibName: "QuestionListLoadMoreTableViewCell", bundle: nil), forCellReuseIdentifier: QuestionListLoadMoreTableViewCell.identifier)
        questionsTableView.estimatedRowHeight = 44
        questionsTableView.rowHeight = UITableView.automaticDimension
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: UIControl.Event.valueChanged)
        self.questionsTableView.refreshControl = refreshControl
        self.title = "Questions"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshData()

    }

    @objc func refreshData(){
        date = Date()
        NetworkService.shared.getRecentQuestions(page:1, date: Date()) { (list) in
            self.pagesLoaded = 1;
            self.questions = list.questions
            DispatchQueue.main.async {
                self.questionsTableView.refreshControl?.endRefreshing()
                self.questionsTableView.reloadData()
            }
        }
    }

    func getQuestionsForNextPage(){
        NetworkService.shared.getRecentQuestions(page:pagesLoaded + 1, date: date) { (list) in
            self.pagesLoaded = self.pagesLoaded + 1;

            DispatchQueue.main.async {

            let previousQuestionCount = self.questions.count
            self.questions += list.questions

            //only reload new questions for smoothness
            var newIndexPaths: [IndexPath] = []
            for idx in previousQuestionCount...previousQuestionCount + list.questions.count-1 {
                newIndexPaths.append(IndexPath(row: idx, section: 0))
            }


            //the load more cell if we are under the max articles
            if self.questions.count < self.maxQuestionCount {
                //only add load more cell if its not there before
                if self.questionsTableView.numberOfRows(inSection: 0) == previousQuestionCount {
                    newIndexPaths.append(IndexPath(row: self.questions.count, section: 0))
                }
            } else if self.questions.count >= self.maxQuestionCount {
                newIndexPaths.removeLast() //no more articles, no need to show the load more cell
            }

                self.questionsTableView.insertRows(at: newIndexPaths, with: .fade)
                self.questionsTableView.refreshControl?.endRefreshing()
            }
        }
    }
    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */

}

extension QuestionListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell as? QuestionListLoadMoreTableViewCell != nil {
            DispatchQueue.main.asyncAfter(deadline: .now() ) {
                self.getQuestionsForNextPage()
            }
        }
        if let questionCell = cell as? QuestionTableViewCell {
         //        questionCell.question = self.questions[indexPath.row]
        }
    }

}

extension QuestionListViewController: UITableViewDataSource {


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch questions.count {
        case 0:
            return 0
        case maxQuestionCount..<Int.max:
            return questions.count
        default:
            return  questions.count + 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == questions.count {
            guard let loadMoreTableViewCell = tableView.dequeueReusableCell(withIdentifier: QuestionListLoadMoreTableViewCell.identifier, for: indexPath) as? QuestionListLoadMoreTableViewCell else{
                return UITableViewCell()
            }
            return loadMoreTableViewCell
        }
        else {
            guard let questionTableViewCell = tableView.dequeueReusableCell(withIdentifier: QuestionTableViewCell.identifier, for: indexPath) as? QuestionTableViewCell else{
                return UITableViewCell()
            }
            questionTableViewCell.question = questions[indexPath.row]
           // questionTableViewCell.layoutIfNeeded()
            return questionTableViewCell

        }
    }
}


