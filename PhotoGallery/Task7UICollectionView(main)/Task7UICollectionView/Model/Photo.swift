//
//  Photo.swift
//  Task7UICollectionView
//
//  Created by Tymofii (Work) on 07.10.2021.
//

import UIKit

struct Photo {
    let image: UIImage
    let date: Date = Date()
    var description: String? = nil
}

extension Photo {
    static let photoGallery = [
        Photo(image: UIImage(named: "imageOne")!),
        Photo(image: UIImage(named: "imageTwo")!),
        Photo(image: UIImage(named: "imageThree")!),
        Photo(image: UIImage(named: "imageFour")!),
        Photo(image: UIImage(named: "imageFive")!),
        Photo(image: UIImage(named: "imageSix")!),
        Photo(image: UIImage(named: "imageSeven")!)
    ]
}

extension Photo: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(image)
    }
}

