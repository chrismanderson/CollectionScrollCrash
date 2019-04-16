//
//  Product.swift
//  CollectionScrollCrash
//
//  Created by Chris Anderson on 4/16/19.
//  Copyright © 2019 Polutropos. All rights reserved.
//

import UIKit

struct Products: Codable {
    let products: [Product]
}

struct Product: Codable {
    let id: Int
    let title: String
    let subtitle: String
    let summary: String
    let formattedPrice: String
    let dietaryRestrictionList: String

    let servings: Int

    let imageUrl: URL
}
