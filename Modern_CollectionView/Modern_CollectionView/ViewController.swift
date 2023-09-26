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
        setUI()
        
        collectionView.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: BannerCollectionViewCell.id)
        collectionView.register(NormalCaroselCollectionViewCell.self, forCellWithReuseIdentifier: NormalCaroselCollectionViewCell.id)
        collectionView.setCollectionViewLayout(createLayout(), animated: true)
        setDataSource()
        setSnapShot()
    }
    
    // MARK: - Set UI
    
    private func setUI() {
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - Method for CollectionView Set DataSource & Layout
    
    private func setDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            switch itemIdentifier {
                case .banner(let item):
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.id, for: indexPath) as? BannerCollectionViewCell else {
                        return UICollectionViewCell()
                    }
                    cell.config(title: item.title, imageUrl: item.imageUrl)
                    return cell
            case .normalCarousel(let item):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NormalCaroselCollectionViewCell.id, for: indexPath) as? NormalCaroselCollectionViewCell else {
                    return UICollectionViewCell()
                }
                cell.config(imageUrl: item.imageUrl, title: item.title, subTitle: item.subTitle)
                return cell
            default:
                return UICollectionViewCell()
            }
        })
    }
    
    private func setSnapShot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        
        // Banner
        snapshot.appendSections([Section(id: "Banner")])
        let bannerItems = [
            Item.banner(HomeItem(title: "교촌 치킨", imageUrl: "https://www.kyochon.com/uploadFiles/TB_ITEM/%EB%A0%88%ED%97%88(1).png")),
            Item.banner(HomeItem(title: "네네 치킨", imageUrl: "https://nenechicken.com/17_new/images/adm/%EC%B2%AD%EC%96%91%EB%A7%88%EC%9A%94%EC%B9%98%ED%82%A8(4).jpg")),
            Item.banner(HomeItem(title: "굽네 치킨", imageUrl: "https://i.namu.wiki/i/SqEiby1n3a8827cObS11Xp4NJfKuN3SMGKH0YstTvcQltFNzjESwIMBicZbBlVIW5vMZdpHl8ik5imL6GmdNbg.webp"))
        ]
        snapshot.appendItems(bannerItems, toSection: Section(id: "Banner"))
        
        // NormalCarosel
        let normalSection = Section(id: "NormalCarosel")
        snapshot.appendSections([normalSection])
        let normalItems = [
            Item.normalCarousel(HomeItem(title: "교촌 치킨", subTitle: "간장치킨", imageUrl: "https://www.kyochon.com/uploadFiles/TB_ITEM/%EB%A0%88%ED%97%88(1).png")),
            Item.normalCarousel(HomeItem(title: "네네 치킨", subTitle: "후라이드치킨", imageUrl: "https://nenechicken.com/17_new/images/adm/%EC%B2%AD%EC%96%91%EB%A7%88%EC%9A%94%EC%B9%98%ED%82%A8(4).jpg")),
            Item.normalCarousel(HomeItem(title: "굽네 치킨", subTitle: "양념치킨", imageUrl: "https://i.namu.wiki/i/SqEiby1n3a8827cObS11Xp4NJfKuN3SMGKH0YstTvcQltFNzjESwIMBicZbBlVIW5vMZdpHl8ik5imL6GmdNbg.webp"))
        ]
        snapshot.appendItems(normalItems, toSection: normalSection)
        
        dataSource?.apply(snapshot)
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        // section index
        return UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            switch sectionIndex {
                case 0:
                    return self?.createBannerSection()
                case 1:
                    return self?.createNormalCarouselSection()
//                case 2:
//                2번째
                default:
                    return self?.createBannerSection()
            }
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
    
    private func createNormalCarouselSection() -> NSCollectionLayoutSection {
        // item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
}
