//
//  PhotoGalleryModelLoadingData.swift
//  Task7UICollectionView
//
//  Created by Tymofii (Work) on 17.10.2021.
//

import Foundation

protocol PhotoGalleryModelLoadingData: TableViewLoadingData {
    func loadDataDescriptionInItem(indexPath: IndexPath, description: String)
    func getNameSection(in section: Int) -> Date
}
