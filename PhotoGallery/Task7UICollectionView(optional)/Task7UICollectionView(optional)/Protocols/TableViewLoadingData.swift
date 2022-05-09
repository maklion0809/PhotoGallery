//
//  LoadDataTableView.swift
//  Task7UICollectionView(optional)
//
//  Created by Tymofii (Work) on 24.10.2021.
//

import Foundation

protocol TableViewLoadingData {
    associatedtype T: Hashable
    var getData: [T] { get }
    func append(item: T)
}
