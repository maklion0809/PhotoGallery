//
//  PhotoGalleryModel.swift
//  Task7UICollectionView(optional)
//
//  Created by Tymofii (Work) on 24.10.2021.
//

import UIKit

class PhotoGalleryModel: TableViewLoadingData {
    
    typealias T = Photo
    
    // MARK: - Variable
    
    private var photos = [Photo]()

    // MARK: - Loading data
    
    func loadData() {
        self.photos = Photo.photos
    }
    
    var getData: [Photo] {
        return photos
    }
    
    func append(item: Photo) {
        photos.append(item)
    }
}
