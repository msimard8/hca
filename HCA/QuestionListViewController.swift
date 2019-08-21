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

    override func viewDidLoad() {
        super.viewDidLoad()
        questionsTableView.register(UINib(nibName: "QuestionTableViewCell", bundle: nil), forCellReuseIdentifier: QuestionTableViewCell.identifier)
        questionsTableView.register(UINib(nibName: "QuestionListLoadMoreTableViewCell", bundle: nil), forCellReuseIdentifier: QuestionListLoadMoreTableViewCell.identifier)

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: UIControl.Event.valueChanged)
        self.questionsTableView.refreshControl = refreshControl

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
            self.questions += list.questions
            DispatchQueue.main.async {
                self.questionsTableView.refreshControl?.endRefreshing()
                self.questionsTableView.reloadData()
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

}

extension QuestionListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch questions.count {
        case 0:
            return 0
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
            questionTableViewCell.textLabel?.text = questions[indexPath.row].title
            return questionTableViewCell

        }
    }
}


