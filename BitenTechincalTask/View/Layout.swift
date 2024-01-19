//
//  Layout.swift
//  BitenTechincalTask
//
//  Created by Александр Кузьминов on 13.01.24.
//

import Foundation
import UIKit

class HomeLayout {
    func natureLayout() -> UICollectionViewCompositionalLayout {
        let size = NSCollectionLayoutSize(
            widthDimension: .absolute(174),
            heightDimension: .absolute(280)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: size)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, repeatingSubitem: item, count: 2)
        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = .init(
            top: 32,
            leading: 16,
            bottom: 0,
            trailing: 16
        )
        return UICollectionViewCompositionalLayout(section: section)
    }
}

