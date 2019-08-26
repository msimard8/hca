//
//  PlaceHolderDetailViewController.swift
//  HCA
//
//  Created by Michael Simard on 8/22/19.
//  Copyright © 2019 Michael Simard. All rights reserved.
//

import UIKit

class PlaceHolderDetailViewController: UIViewController {

    @IBOutlet weak var logoView: LogoView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        logoView.animate()
    }
}
