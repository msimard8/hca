//
//  LogoView.swift
//  HCA
//
//  Created by Michael Simard on 8/26/19.
//  Copyright © 2019 Michael Simard. All rights reserved.
//

import UIKit

class LogoView: UIView {

    @IBOutlet weak var binaryLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }

    var view: UIView!

    func xibSetup() {
        view = loadViewFromNib()
        view.frame = bounds
        addSubview(view)
    }

    func loadViewFromNib() -> UIView {

        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "LogoView", bundle: bundle)
        if let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView {
        return view
        }
        return UIView()
    }

    func animate() {
        UIView.animate(withDuration: 4.8, delay: 0, options: [.repeat, .curveLinear], animations: {
            self.binaryLabel.frame = CGRect(x: 0,
                                            y: self.binaryLabel.frame.origin.y,
                                            width: self.binaryLabel.frame.width,
                                            height: self.binaryLabel.frame.height)
        }, completion: nil)
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
