//
//  QuestionSplitViewController.swift
//  HCA
//
//  Created by Michael Simard on 8/20/19.
//  Copyright © 2019 Michael Simard. All rights reserved.
//

import UIKit

class QuestionSplitViewController: UISplitViewController {

    let answerListViewController = AnswerListViewController()
    var answerListNavigationController: UINavigationController

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {

        answerListNavigationController = UINavigationController(rootViewController: answerListViewController)
        let _ = answerListViewController.view
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        self.preferredPrimaryColumnWidthFraction = 0.45
        let questionListViewController = QuestionListViewController()
        self.maximumPrimaryColumnWidth = self.view.bounds.size.width/2.0
        questionListViewController.delegate = self 

        let navigationController = UINavigationController(rootViewController: questionListViewController)
        navigationController.navigationBar.barTintColor = UIColor(red: 0, green: 0.4118, blue: 0.8588, alpha: 1.0)
        answerListNavigationController.navigationBar.barTintColor = UIColor(red: 0, green: 0.4118, blue: 0.8588, alpha: 1.0)

        

        UIBarButtonItem.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let placeHolderVc = UIViewController()
        placeHolderVc.view.backgroundColor = .white
        self.viewControllers = [navigationController, placeHolderVc ]

        self.preferredDisplayMode = .allVisible
        delegate = self

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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


extension QuestionSplitViewController: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }

}

extension QuestionSplitViewController: QuestionListViewControllerDelegate {
    func didSelectQuestion(question: StackOverflowQuestion) {
        answerListViewController.question = question
     //   answerListViewController.loadView()
        self.showDetailViewController(answerListNavigationController, sender: self)

    }



}
