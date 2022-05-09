//
//  CollectionViewCell.swift
//  Task7UICollectionView(optional)
//
//  Created by Tymofii (Work) on 10.10.2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    static let identifier = "Cell"
    
    // MARK: - UI element
    
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // MARK: - Variable
    
    var photo: Photo? {
        didSet {
            photoImageView.image = photo?.image
        }
    }

    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black

        setupSubview()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Setting up the subview
    
    private func setupSubview() {
        contentView.addSubview(photoImageView)
    }
    
    // MARK: - Setting up the constraint
    
    private func setupConstraint() {
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
    }

}
