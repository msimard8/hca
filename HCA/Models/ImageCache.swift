//
//  ImageCache.swift
//  HCA
//
//  Created by Michael Simard on 8/22/19.
//  Copyright © 2019 Michael Simard. All rights reserved.
//

import UIKit

class ImageCache: NSObject {

    private let thumbnailCache = NSCache<NSString, UIImage>()

    internal static var shared: ImageCache = {
        let instance = ImageCache()
        return instance
    }()

    func setImageCap(cap: Int) {
        thumbnailCache.countLimit = cap
    }

    func removeImages() {
        thumbnailCache.removeAllObjects()
    }

    func storeImage(key: String, image: UIImage) {
        thumbnailCache.setObject(image, forKey: key as NSString)
    }

    func retrieveImage(key: String) -> UIImage? {
        return thumbnailCache.object(forKey: key as NSString)
    }
}
