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
        _ = answerListViewController.view
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        let questionListViewController = QuestionListViewController()
        questionListViewController.delegate = self
        let navigationController = UINavigationController(rootViewController: questionListViewController)
        navigationController.navigationBar.barTintColor = UIColor.Primary.Blue
        answerListNavigationController.navigationBar.barTintColor = UIColor.Primary.Blue

        answerListViewController.navigationItem.rightBarButtonItem = self.displayModeButtonItem
        UIBarButtonItem.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let placeHolderVc = PlaceHolderDetailViewController()
         self.viewControllers = [navigationController, placeHolderVc ]

        self.preferredPrimaryColumnWidthFraction = 0.45
        self.maximumPrimaryColumnWidth = self.view.bounds.size.width/2.0

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
}

extension QuestionSplitViewController: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController,
                             collapseSecondary secondaryViewController: UIViewController,
                             onto primaryViewController: UIViewController) -> Bool {
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
