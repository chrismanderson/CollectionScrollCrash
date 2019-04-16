//
//  ViewController.swift
//  CollectionScrollCrash
//
//  Created by Chris Anderson on 4/15/19.
//  Copyright © 2019 Polutropos. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    let numberOfItems: Int = 320

    lazy var collectionView: UICollectionView = {
        return UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    }()

    lazy var flowLayout: UICollectionViewFlowLayout = {
        return FlowLayout()
    }()

    var cellSizeCache: [IndexPath : NSValue] = [:]

    lazy var data: Products = {
        let url = Bundle.main.url(forResource: "products", withExtension: "json")!

        do {
            let jsonData = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            return try decoder.decode(Products.self, from: jsonData)
        } catch {
            print(error)
            return Products(products: [])
        }
    }()


    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(ViewController.refreshView))

        title = "Demo"

        view.addSubview(collectionView)

        collectionView.collectionViewLayout = flowLayout
        collectionView.alwaysBounceVertical = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: "MyCell")
    }

    @objc func refreshView() {
        collectionView.reloadData()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        collectionView.reloadData()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }

    // MARK: UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.products.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! ProductCell
        let object = data.products[indexPath.row]
        cell.configure(object, available: Bool.random())
        return cell
    }

    // MARK: UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width - 40, height: view.bounds.width)
    }

    // MARK: UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = UIViewController()
        controller.view.backgroundColor = .yellow

        self.navigationController?.pushViewController(controller, animated: true)
    }
}

