//
//  ListCollectionViewCell.swift
//  TVAndMovie
//
//  Created by elly on 2023/09/29.
//

import UIKit
import Kingfisher

final class ListCollectionViewCell: UICollectionViewCell {
    static let id = "ListCollectionViewCell"
    private let image = UIImageView()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(image)
        addSubview(titleLabel)
        addSubview(releaseDateLabel)
        
        image.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.3)
        }
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(image.snp.trailing).offset(8)
            $0.top.equalToSuperview()
        }
        releaseDateLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(title: String, releaseDate: String, url: String) {
        titleLabel.text = title
        releaseDateLabel.text = releaseDate
        image.kf.setImage(with: URL(string: url))
    }
}
