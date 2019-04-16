//
//  MealHeaderView.swift
//  Galley
//
//  Created by Chris Anderson on 8/24/16.
//  Copyright © 2016 Galley. All rights reserved.
//

import SDWebImage
import UIKit

class ProductHeaderView: UIView {
    /// The meal assigned to this cell
    var product: Product?

    lazy var mealImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = UIView.ContentMode.scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    lazy var titleLabel: Label = {
        let view = Label()
        view.font = Font.font(.extraLarge, name: .bold)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = NSTextAlignment.left
        view.numberOfLines = 0
        return view
    }()

    lazy var subtitleLabel: Label = {
        let view = Label()
        view.font = Font.font(.small)
        view.textColor = UIColor.darkText
        view.textAlignment = NSTextAlignment.left
        return view
    }()

    lazy var priceLabel: Label = {
        let view = Label()
        view.font = Font.font(.extraLarge)
        return view
    }()

    lazy var servingsLabel: Label = {
        let view = Label()
        view.font = Font.font(.small)
        view.lineBreakMode = .byCharWrapping

        return view
    }()

    lazy var dietaryRestrictionsLabel: Label = {
        let view = Label()
        view.font = Font.font(.extraSmall)
        view.textColor = UIColor.brown
        view.textAlignment = NSTextAlignment.left
        return view
    }()

    lazy var button: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.backgroundColor = UIColor.blue
        button.layer.cornerRadius = 6.0
        button.titleLabel?.font = Font.font(.large)
        button.setTitle("add to order", for: .normal)
        button.addTarget(self, action: #selector(didTapAdd), for: UIControl.Event.touchUpInside)

        return button
    }()

    lazy var removeButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.isHidden = true
        button.backgroundColor = UIColor.orange
        button.layer.cornerRadius = 6.0
        button.tintColor = .white
        button.titleLabel?.font = Font.font(.large)
        button.setImage(UIImage(named: "Remove")!.withRenderingMode(.alwaysTemplate), for: .normal)
        button.setImage(UIImage(), for: .selected)
        button.addTarget(self, action: #selector(didTapRemove), for: UIControl.Event.touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    let imageAspectRatio: CGFloat = 4.0 / 3.0
    let padding: CGFloat = 8

    let horizontalPadding: CGFloat = 10

    var initialLoad: Bool = true
    var buttonStack: UIStackView = UIStackView()

    private let rowHeight: CGFloat = 40.0

    convenience init(product: Product) {
        self.init(frame: CGRect.zero)
        self.product = product
        self.configure(product, available: false)
    }

    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = UIColor.white

        let priceStack = UIStackView(elements: [priceLabel, servingsLabel], axis: .vertical, spacing: 4)

        self.buttonStack = UIStackView(elements: [priceStack, removeButton, button], spacing: 4)
        buttonStack.alignment = .center
        buttonStack.distribution = .fill

        let infoStack = UIStackView(elements: [titleLabel, dietaryRestrictionsLabel, subtitleLabel], axis: .vertical, spacing: 4)

        infoStack.distribution = .fill
        let whiteStack = UIStackView(elements: [infoStack, buttonStack], axis: .vertical, spacing: 10)
        whiteStack.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: horizontalPadding, right: horizontalPadding)
        buttonStack.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        whiteStack.isLayoutMarginsRelativeArrangement = true
        buttonStack.isLayoutMarginsRelativeArrangement = true

        let container = UIStackView(elements: [mealImageView, whiteStack], axis: .vertical)
        infoStack.layoutMargins = UIEdgeInsets(top: horizontalPadding, left: horizontalPadding, bottom: horizontalPadding, right: horizontalPadding)
        infoStack.isLayoutMarginsRelativeArrangement = true

        addSubview(container)

        NSLayoutConstraint.activate([
            buttonStack.heightAnchor.constraint(greaterThanOrEqualToConstant: rowHeight),
            priceLabel.leadingAnchor.constraint(equalTo: infoStack.leadingAnchor, constant: 10),
            removeButton.widthAnchor.constraint(equalTo: removeButton.heightAnchor),
            button.widthAnchor.constraint(equalToConstant: 100),
            button.heightAnchor.constraint(equalToConstant: rowHeight),
            removeButton.widthAnchor.constraint(equalToConstant: rowHeight),
            mealImageView.widthAnchor.constraint(equalTo: mealImageView.heightAnchor, multiplier: imageAspectRatio)
            ])

        container.constrainEdges(to: self)

        titleLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .vertical)
        dietaryRestrictionsLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 249), for: .vertical)
        subtitleLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 250), for: .vertical)
    }

    func configure(_ product: Product, available: Bool, mealInCart: Bool = false, condensed: Bool = true) {
        initialLoad = true
        titleLabel.text = product.title
        dietaryRestrictionsLabel.text = product.dietaryRestrictionList
        subtitleLabel.text = condensed ? product.subtitle : product.summary
        subtitleLabel.textAlignment = .left
        priceLabel.text = product.formattedPrice
        configureButton(available, mealInCart: mealInCart)

        if 1 < product.servings {
            servingsLabel.isHidden = false
            servingsLabel.text = "\(product.servings.description) servings"
        } else {
            servingsLabel.isHidden = true
        }

        if product.title == self.product?.title {
            initialLoad = false
        }
        self.product = product

        mealImageView.sd_setImage(with: product.imageUrl) { (image, _, _, _) in
            if image != nil && self.initialLoad {
                self.mealImageView.alpha = 0.0
                UIView.animate(withDuration: 0.15) {
                    self.mealImageView.alpha = 1.0
                }
            }
        }
    }

    func configureButton(_ available: Bool, mealInCart: Bool) {
        var buttonTitle: String

        if available && mealInCart {
            buttonTitle = "Add more"
        } else if available {
            buttonTitle = "Add"
        } else {
            buttonTitle = "None left"
        }

        button.isEnabled = available
        removeButton.isHidden = !mealInCart
        button.setTitle(buttonTitle, for: .normal)
    }

    @objc func didTapAdd() {
    }

    @objc func didTapRemove() {
    }
}
