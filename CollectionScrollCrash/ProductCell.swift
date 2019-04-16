//
//  ProductCell.swift
//  CollectionScrollCrash
//
//  Created by Chris Anderson on 4/16/19.
//  Copyright © 2019 Polutropos. All rights reserved.
//

//
//  MealCollectionViewCell.swift
//  Galley
//
//  Created by Chris Anderson on 5/21/18.
//  Copyright © 2018 Galley. All rights reserved.
//

import UIKit

public enum MealCartStatus {
    case empty, added, noneLeft, soldOut, unknown
}

class ProductCell: UICollectionViewCell {
    static var sizingCell = ProductCell()

    lazy var mealView: ProductHeaderView = {
        let view = ProductHeaderView(frame: CGRect.zero)
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = UIColor.clear

        contentView.addSubview(mealView)
        contentView.translatesAutoresizingMaskIntoConstraints = false

        mealView.translatesAutoresizingMaskIntoConstraints = false
        mealView.constrainEdges(to: contentView)
        contentView.widthAnchor.constraint(equalToConstant: bounds.width).isActive = true

        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

        mealView.layer.cornerRadius = 10
        mealView.layer.masksToBounds = true

        contentView.layer.cornerRadius = 20
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.borderWidth = 0.0
        contentView.backgroundColor = .white

        self.layer.shadowRadius = 10
        self.layer.shadowOpacity = 0.1
        self.layer.shadowColor = UIColor.gray.cgColor
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(_ product: Product, available: Bool, mealInCart: Bool = false) {
        mealView.configure(product, available: available, mealInCart: mealInCart)
    }

    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()

        let size = contentView.systemLayoutSizeFitting(CGSize(width: layoutAttributes.frame.width,
                                                              height: CGFloat.greatestFiniteMagnitude),
                                                       withHorizontalFittingPriority: UILayoutPriority.required, verticalFittingPriority: UILayoutPriority.fittingSizeLevel)
        layoutAttributes.frame.size = size
        return layoutAttributes
    }
}
