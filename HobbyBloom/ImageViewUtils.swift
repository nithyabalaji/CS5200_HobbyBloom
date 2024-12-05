//
//  ImageViewUtils.swift
//  HobbyBloom
//
//  Created by Ashmitha appandaraju on 11/22/24.
//

import Foundation
import UIKit

extension UIImageView {
    
    func loadRemoteImage(from url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
