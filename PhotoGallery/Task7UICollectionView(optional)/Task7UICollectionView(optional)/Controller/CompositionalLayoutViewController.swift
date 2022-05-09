//
//  CompositionalLayoutViewController.swift
//  Task7UICollectionView(optional)
//
//  Created by Tymofii (Work) on 10.10.2021.
//

import UIKit

class CompositionalLayoutViewController: UIViewController {
    
    // MARK: - Configuration
    
    private enum Configuration {
        static let contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
    }
    
    // MARK: - UI element
    
    private lazy var compositionalLayoutCollectionView = UICollectionView()
    
    // MARK: - Variable
    
    private var photoGalleryModel = PhotoGalleryModel()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollection()
        setupSubview()
        setupConstraint()
        loadPhotos()
    }
    
    // MARK: - Setting up the subview
    
    private func setupSubview() {
        view.addSubview(compositionalLayoutCollectionView)
    }
    
    // MARK: - Setting up the constraint
    
    private func setupConstraint() {
        compositionalLayoutCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            compositionalLayoutCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            compositionalLayoutCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            compositionalLayoutCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            compositionalLayoutCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
    
    // MARK: - Setting up the collectionView
    
    private func setupCollection() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: generateLayout())
        collectionView.backgroundColor = .white
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collectionView.dataSource = self
        compositionalLayoutCollectionView = collectionView
    }
    
    // MARK: - Compositional Layout
    
    private func generateLayout() -> UICollectionViewLayout {
      let fullPhotoItem = NSCollectionLayoutItem(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1.0),
          heightDimension: .fractionalWidth(2/3)))
        fullPhotoItem.contentInsets = Configuration.contentInsets

      let mainItem = NSCollectionLayoutItem(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(2/3),
          heightDimension: .fractionalHeight(1.0)))
      mainItem.contentInsets = Configuration.contentInsets

      let pairItem = NSCollectionLayoutItem(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1.0),
          heightDimension: .fractionalHeight(0.5)))
      pairItem.contentInsets = Configuration.contentInsets
      let trailingGroup = NSCollectionLayoutGroup.vertical(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1/3),
          heightDimension: .fractionalHeight(1.0)),
        subitem: pairItem,
        count: 2)

      let mainWithPairGroup = NSCollectionLayoutGroup.horizontal(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1.0),
          heightDimension: .fractionalWidth(4/9)),
        subitems: [mainItem, trailingGroup])

      let tripletItem = NSCollectionLayoutItem(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1/3),
          heightDimension: .fractionalHeight(1.0)))
      tripletItem.contentInsets = Configuration.contentInsets

      let tripletGroup = NSCollectionLayoutGroup.horizontal(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1.0),
          heightDimension: .fractionalWidth(2/9)),
        subitems: [tripletItem, tripletItem, tripletItem])

      let mainWithPairReversedGroup = NSCollectionLayoutGroup.horizontal(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1.0),
          heightDimension: .fractionalWidth(4/9)),
        subitems: [trailingGroup, mainItem])

      let nestedGroup = NSCollectionLayoutGroup.vertical(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1.0),
          heightDimension: .fractionalWidth(16/9)),
        subitems: [fullPhotoItem, mainWithPairGroup, tripletGroup, mainWithPairReversedGroup])

      let section = NSCollectionLayoutSection(group: nestedGroup)
      let layout = UICollectionViewCompositionalLayout(section: section)
        
      return layout
    }
    
    // MARK: - Loading data
    
    private func loadPhotos() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.photoGalleryModel.loadData()
            self.compositionalLayoutCollectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDataSource

extension CompositionalLayoutViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photoGalleryModel.getData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell else { return CollectionViewCell() }
        cell.photo = photoGalleryModel.getData[indexPath.item]
        return cell
    }
}
