//
//  PhotoGalleryModel.swift
//  Task7UICollectionView
//
//  Created by Tymofii (Work) on 15.10.2021.
//

import UIKit

final class PhotoGalleryModel: PhotoGalleryModelLoadingData {
    
    typealias T = Photo
    
    // MARK: - Variable
    
    private var sections = [Section<Photo>]()
    
    // MARK: - Loading data
    
    func loadData() {
        self.sections = [
            Section<Photo>(date: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date(), objects: Photo.photoGallery),
            Section<Photo>(date: Calendar.current.date(byAdding: .day, value: -2, to: Date()) ?? Date(), objects: Photo.photoGallery)
        ]
    }
    
    // MARK: - Getting data
    

    
    var sectionCount: Int {
        sections.count
    }
    
    func getDataCount(in section: Int) -> Int {
        sections[section].objects.count
    }
    
    func getObject(for indexPath: IndexPath) -> Photo {
        sections[indexPath.section].objects[indexPath.item]
    }
    
    func getNameSection(in section: Int) -> Date {
        sections[section].date
    }
    
    // MARK: - Loading data
    
    func loadDataSection(section: Section<Photo>) {
        sections.append(section)
    }
    
    func loadDataItemInSection(at section: Int, item: Photo) {
        sections[section].objects.append(item)
    }
    
    func loadDataDescriptionInItem(indexPath: IndexPath, description: String) {
        sections[indexPath.section].objects[indexPath.item].description = description
    }
}
