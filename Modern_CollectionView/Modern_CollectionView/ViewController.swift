//
//  ViewController.swift
//  Modern_CollectionView
//
//  Created by elly on 2023/09/25.
//

import UIKit

class ViewController: UIViewController {

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: BannerCollectionViewCell.id)
    }
}
