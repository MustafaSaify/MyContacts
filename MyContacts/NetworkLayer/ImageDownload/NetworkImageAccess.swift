//
//  NetworkImageAccess.swift
//  MyContacts
//
//  Created by Mustafa Saify on 12/1/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation
import UIKit

private let MB = 1024 * 1024
private let oneHour: TimeInterval = 60 * 60

class NetworkImageAccess {
    
    fileprivate let synchronizer: Synchronizer
    
    init(cacheTime: TimeInterval = oneHour) {
        self.synchronizer = Synchronizer(
            cacheTime: cacheTime,
            URLCache: URLCache(memoryCapacity: 100 * MB, diskCapacity: 100 * MB, diskPath: "images")
        )
    }
}

extension NetworkImageAccess: ImageAccess {
    
    func imageWithURL(_ URL: Foundation.URL, completion: @escaping (UIImage?) -> Void) -> CancelImageLoading {
        return synchronizer.loadResource(ImageResource(URL: URL)) { (object) in
            switch object {
            case .error: completion(nil)
            case .noData: completion(nil)
            case .success(let image): completion(image)
            }
        }
    }
}
