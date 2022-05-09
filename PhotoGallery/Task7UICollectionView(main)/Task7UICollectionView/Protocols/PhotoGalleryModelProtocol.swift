//
//  PhotoGalleryModelProtocol.swift
//  Task7UICollectionView
//
//  Created by Tymofii (Work) on 17.10.2021.
//

import Foundation

protocol PhotoGalleryModelProtocol: LoadDataTableViewProtocol {
    func loadDataDescriptionInItem(indexPath: IndexPath, description: String)
}
