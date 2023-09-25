//
//  BannerCollectionViewCell.swift
//  Modern_CollectionView
//
//  Created by elly on 2023/09/25.
//

import UIKit
import SnapKit

class BannerCollectionViewCell: UICollectionViewCell {
    static let id = "BannerCollectionViewCell"
    let titleLabel = UILabel()
    let backgroundImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.addSubview(titleLabel)
        self.addSubview(backgroundImage)
        
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        backgroundImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    public func config(title: String, imageUrl: String) {
        titleLabel.text = "Title"
//        imageUrl
    }
}
