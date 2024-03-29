//
//  Utils.swift
//  HCA
//
//  Created by Michael Simard on 8/21/19.
//  Copyright © 2019 Michael Simard. All rights reserved.
//

import UIKit

class Utils: NSObject {
    static func formatDate(date: Date) -> String {
            let displayFormatter = DateFormatter()
            displayFormatter.locale = Locale(identifier: "en_US")
            displayFormatter.dateFormat = "MMM d, YYYY, h:mm a"
            return displayFormatter.string(from: date)
    }

    static func makeAttributedString(html: String, font: UIFont, color: UIColor) -> NSMutableAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color
        ]
        let attributedString = NSMutableAttributedString.init(html: html)
        attributedString?.addAttributes(attributes,
                                        range: NSRange(location: 0, length: (attributedString?.length ?? 0)))
        attributedString?.setFontFace(font: font, color: color)
        return attributedString ?? NSMutableAttributedString()
    }

    static func showErrorMessage(controller: UIViewController, message: String, seconds: Double) {

        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.black
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15

        controller.present(alert, animated: true)

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
}
