//
//  Label.swift
//  CollectionScrollCrash
//
//  Created by Chris Anderson on 4/16/19.
//  Copyright © 2019 Polutropos. All rights reserved.
//

import Foundation
import UIKit

@objc(GKLabel) open class Label: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)

        textColor = UIColor.darkText
        font = UIFont.preferredFont(forTextStyle: .body)
        numberOfLines = 0

        adjustsFontForContentSizeCategory = true
    }

    convenience init() {
        self.init(frame: CGRect.zero)
    }

    convenience init(text: String = "", font: UIFont = UIFont.preferredFont(forTextStyle: .body)) {
        self.init(frame: CGRect.zero)

        self.text = text
        self.font = font
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
