//
//  PaddingLabel.swift
//  HobbyBloom
//
//  Created by Ashmitha appandaraju on 11/21/24.
//

import Foundation
import UIKit
class PaddingLabel: UILabel {
    var padding = UIEdgeInsets.zero

    override func drawText(in rect: CGRect) {
        let insetRect = rect.inset(by: padding)
        super.drawText(in: insetRect)
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + padding.left + padding.right,
                      height: size.height + padding.top + padding.bottom)
    }
}
