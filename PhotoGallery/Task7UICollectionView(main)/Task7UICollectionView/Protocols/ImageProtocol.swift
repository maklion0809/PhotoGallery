//
//  ImageProtocol.swift
//  Task7UICollectionView
//
//  Created by Tymofii (Work) on 08.10.2021.
//

import Foundation

protocol ImageViewerDelegate: AnyObject {
    func update(description: String, indexPath: IndexPath)
}
