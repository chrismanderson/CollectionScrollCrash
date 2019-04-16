//
//  Font.swift
//  CollectionScrollCrash
//
//  Created by Chris Anderson on 4/16/19.
//  Copyright © 2019 Polutropos. All rights reserved.
//

//
//  UIFont+GKAdditions.swift
//  Galley
//
//  Created by Chris Anderson on 8/25/16.
//  Copyright © 2016 Galley. All rights reserved.
//

import UIKit

struct Font {
    enum Name: String {
        case regular = "Lato-Regular"
        case bold    = "Lato-Bold"
    }

    enum Size: CGFloat {
        case huge = 34
        case title1 = 28
        case extraExtraLarge = 24.0
        case extraLarge = 20.0
        case large = 18.0
        case headline = 17.0
        case regular = 16.0
        case small = 14.0
        case extraSmall = 12.0
        case extraExtraSmall = 10.0
    }

    static func font(_ size: Size = .regular, name: Name = .regular) -> UIFont {
        var font: UIFont

        switch size {
        case .huge:
            return preferredCustomFont(forTextStyle: .largeTitle, name: name)
        case .title1:
            font = preferredCustomFont(forTextStyle: .title1, name: name)
        case .headline:
            font = preferredCustomFont(forTextStyle: .headline, name: name)
        case .extraExtraLarge:
            font = preferredCustomFont(forTextStyle: .title2, name: name)
        case .extraLarge:
            font = preferredCustomFont(forTextStyle: .title3, name: name)
        case .large:
            font = preferredCustomFont(forTextStyle: .headline, name: name)
        case .regular:
            font = preferredCustomFont(forTextStyle: .body, name: name)
        case .small:
            font = preferredCustomFont(forTextStyle: .subheadline, name: name)
        case .extraSmall:
            font = preferredCustomFont(forTextStyle: .caption1, name: name)
        case .extraExtraSmall:
            font = preferredCustomFont(forTextStyle: .caption2, name: name)
        }

        return font
    }

    static func preferredCustomFont(forTextStyle textStyle: UIFont.TextStyle, name: Name = .regular) -> UIFont {
        var systemFontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: textStyle)

        if name == .bold {
            systemFontDescriptor = systemFontDescriptor.withSymbolicTraits(.traitBold)!
        }

        return UIFont(descriptor: systemFontDescriptor, size: 0)
    }
}
