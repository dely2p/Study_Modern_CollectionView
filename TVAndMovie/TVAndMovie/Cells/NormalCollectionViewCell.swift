//
//  NormalCollectionViewCell.swift
//  TVAndMovie
//
//  Created by elly on 2023/09/29.
//

import UIKit
import Kingfisher

class NormalCollectionViewCell: UICollectionViewCell {
    static let id = "NormalCollectionViewCell"
    let image: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 8
        return image
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 2
        return label
    }()
    
    let reviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(image)
        addSubview(titleLabel)
        addSubview(reviewLabel)
        addSubview(descriptionLabel)
        
        image.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(140)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(image.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
        }
        reviewLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
        }
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(reviewLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(title: String, review: String, description: String, imageURL: String) {
        image.kf.setImage(with: URL(string: imageURL))
        titleLabel.text = title
        reviewLabel.text = review
        descriptionLabel.text = description
    }
}


