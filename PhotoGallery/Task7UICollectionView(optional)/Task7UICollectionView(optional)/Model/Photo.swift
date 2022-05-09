//
//  Photo.swift
//  Task7UICollectionView(optional)
//
//  Created by Tymofii (Work) on 10.10.2021.
//

import Foundation
import UIKit

struct Photo {
    let image: UIImage
}

extension Photo {
    static let photos = [
        Photo(image: UIImage(named: "imageOne")!),
        Photo(image: UIImage(named: "imageTwo")!),
        Photo(image: UIImage(named: "imageThree")!),
        Photo(image: UIImage(named: "imageFour")!),
        Photo(image: UIImage(named: "imageFive")!),
        Photo(image: UIImage(named: "imageSix")!),
        Photo(image: UIImage(named: "imageSeven")!),
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
