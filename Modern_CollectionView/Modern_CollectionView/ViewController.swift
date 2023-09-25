//
//  ViewController.swift
//  Modern_CollectionView
//
//  Created by elly on 2023/09/25.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: BannerCollectionViewCell.id)
        collectionView.setCollectionViewLayout(createLayout(), animated: true)
        setDataSource()
    }
    
    // MARK: - Method for CollectionView Set DataSource & Layout
    
    private func setDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.id, for: indexPath) as? BannerCollectionViewCell else {
                return UICollectionViewCell()
            }
//            cell.config(title: <#T##String#>, imageUrl: <#T##String#>)
            return cell
        })
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        // section index
        return UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            return self?.createBannerSection()
        }
    }
    
    private func createBannerSection() -> NSCollectionLayoutSection {
        // item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
}
