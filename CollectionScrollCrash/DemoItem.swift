//
//  DemoItem.swift
//  CollectionScrollCrash
//
//  Created by Chris Anderson on 4/16/19.
//  Copyright © 2019 Polutropos. All rights reserved.
//

import UIKit

class DemoItem: NSObject {
    class func generate(_ numberOfItems: Int = 32) -> [DemoItem] {
        return (0...numberOfItems).map {
            number in DemoItem(title: "#" + number.description + " " + titles.randomElement()!,
                               subtitle: subtitles.randomElement()!,
                               body: bodies.randomElement()!)
        }
    }

    let title: String
    let subtitle: String
    let body: String
    let uuid: UUID = UUID()

    init(title: String, subtitle: String, body: String) {
        self.title = title
        self.subtitle = subtitle
        self.body = body
    }
}

let titles = [
    "Short",
    "Longer title",
    "Even longer titles",
    "Much longer title getting so much longer",
    "Crazy longer title how can it be so long it's going to wrap so many times."
]

let subtitles = [
    "",
    "Subtitle",
    "A longer subtitle that should really wrap right about now."
]

let bodies = [
    "Short post",
    "Vestibulum elementum rhoncus sapien, at laoreet erat euismod at",
    "Vestibulum elementum rhoncus sapien, at laoreet erat euismod at. Quisque ex erat, vestibulum a turpis a, commodo aliquam eros. Morbi ut venenatis turpis."
]
