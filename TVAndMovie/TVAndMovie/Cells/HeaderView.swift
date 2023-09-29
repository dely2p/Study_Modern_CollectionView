//
//  HeaderView.swift
//  TVAndMovie
//
//  Created by elly on 2023/09/29.
//

import UIKit

final class HeaderView: UICollectionReusableView {
    static let id = "HeaderView"
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(title: String) {
        self.titleLabel.text = title
    }
}
