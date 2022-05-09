//
//  TableViewLoadingData.swift
//  Task7UICollectionView
//
//  Created by Tymofii (Work) on 18.10.2021.
//

import Foundation

protocol TableViewLoadingData {
    associatedtype T: Hashable
    var sectionCount: Int { get }
    func getObject(for indexPath: IndexPath) -> T
    func getDataCount(in section: Int) -> Int
    func loadDataSection(section: Section<T>)
    func loadDataItemInSection(at section: Int, item: T)
}
