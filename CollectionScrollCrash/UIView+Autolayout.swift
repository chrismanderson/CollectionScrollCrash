//
//  UIView+Autolayout.swift
//  CollectionScrollCrash
//
//  Created by Chris Anderson on 4/15/19.
//  Copyright © 2019 Polutropos. All rights reserved.
//

import UIKit

extension UIView {
    func constrainEdges(to view: UIView, padding: CGFloat = 0, priority: UILayoutPriority = UILayoutPriority(rawValue: 1000)) {
        translatesAutoresizingMaskIntoConstraints = false

        let leading = leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding)
        let trailing = trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        let top = topAnchor.constraint(equalTo: view.topAnchor, constant: padding)
        let bottom = bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding)

        let constraints = [top, leading, trailing, bottom]

        for constraint in constraints {
            constraint.priority = priority
            constraint.isActive = true
        }
    }

    func center(in view: UIView) {
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    var currentLayoutGuide: UILayoutGuide {
        return safeAreaLayoutGuide
    }
}
