//
//  LoadDataTableViewProtocol.swift
//  Task7UICollectionView
//
//  Created by Tymofii (Work) on 18.10.2021.
//

import Foundation

protocol LoadDataTableViewProtocol {
    associatedtype T: Hashable
    var getData: [Section<T>] { get }
    func LoadDataSection(section: Section<T>)
    func LoadDataItemInSection(at section: Int, item: T)
}
