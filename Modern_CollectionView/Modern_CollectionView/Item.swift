//
//  Item.swift
//  Modern_CollectionView
//
//  Created by elly on 2023/09/25.
//

import Foundation

// MARK: - 섹션과 아이템 정의

struct Section: Hashable {
    let id: String
}

enum Item: Hashable {
    case banner(HomeItem)
    case normalCarousel(HomeItem)
    case listCarousel(HomeItem)
}

struct HomeItem: Hashable {
    let title: String
    let subTitle: String?
    let imageUrl: String
}
