//
//  ImageCollectionViewCell.swift
//  Task7UICollectionView
//
//  Created by Tymofii (Work) on 07.10.2021.
//

import UIKit

final class ImageCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Configuration
    
    private enum Configuration {
        static let bottomIndent: CGFloat = 10
        static let trailingIndent: CGFloat = 10
        static let selectedImageSize = CGSize(width: 50, height: 50)
    }
    
    // MARK: - Static variable
    
    static let identifier = "CollectionCell"
        
    // MARK: - UI element
    
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var selectedImage: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = true
        imageView.image = UIImage(systemName: "checkmark.circle")
        return imageView
    }()
    
    // MARK: - Variable
    
    var photo: Photo? {
         didSet {
             photoImageView.image = photo?.image
         }
     }

    
    override var isSelected: Bool {
        didSet {
            photoImageView.layer.opacity = isSelected ? 0.5 : 1
            selectedImage.isHidden = !isSelected
            photoImageView.isHighlighted = !isSelected
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
        contentView.addSubview(selectedImage)
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
        
        selectedImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            selectedImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Configuration.bottomIndent),
            selectedImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Configuration.trailingIndent),
            selectedImage.heightAnchor.constraint(equalToConstant: Configuration.selectedImageSize.height),
            selectedImage.widthAnchor.constraint(equalToConstant: Configuration.selectedImageSize.width)
        ])
    }
}
