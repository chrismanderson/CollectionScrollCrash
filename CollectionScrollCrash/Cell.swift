//
//  Cell.swift
//  CollectionScrollCrash
//
//  Created by Chris Anderson on 4/15/19.
//  Copyright © 2019 Polutropos. All rights reserved.
//

import UIKit

class Cell: UICollectionViewCell {
    static let staticCell = Cell()

    lazy var myImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = UIView.ContentMode.scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var bottomStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .fill
        view.spacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.blue.withAlphaComponent(0.3)
        return label
    }()

    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.layer.borderWidth = 1
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .gray
        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$30.00"
        return label
    }()

    lazy var button: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.backgroundColor = .red
        button.layer.cornerRadius = 6.0
        button.setTitle("Button", for: .normal)

        return button
    }()

    lazy var smallButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.backgroundColor = .red
        button.layer.cornerRadius = 6.0
        button.setTitle("+", for: .normal)

        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = UIColor.orange.withAlphaComponent(0.1)

        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
        stackView.addArrangedSubview(bodyLabel)
        stackView.addArrangedSubview(bottomStackView)

        bottomStackView.addArrangedSubview(priceLabel)
        bottomStackView.addArrangedSubview(smallButton)
        bottomStackView.addArrangedSubview(button)

        bottomStackView.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        smallButton.widthAnchor.constraint(equalToConstant: 40.0).isActive = true

        contentView.addSubview(stackView)
        stackView.constrainEdges(to: contentView, padding: 10)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        layoutIfNeeded()
        let layoutAttributes = super.preferredLayoutAttributesFitting(layoutAttributes)
        layoutAttributes.bounds.size = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .defaultLow)
        return layoutAttributes
    }

    func configure(_ item: DemoItem) {
        self.titleLabel.text = item.title
        self.bodyLabel.text = item.body
        self.subtitleLabel.text = item.subtitle
    }

}
