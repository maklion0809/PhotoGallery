//
//  Section.swift
//  Task7UICollectionView
//
//  Created by Tymofii (Work) on 07.10.2021.
//

import UIKit

struct Section<T: Hashable> {
    let date: Date
    var objects: [T]
}

extension Section: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(date)
        hasher.combine(objects)
    }
}
