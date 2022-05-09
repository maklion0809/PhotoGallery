//
//  PhotoGalleryViewController.swift
//  Task7UICollectionView
//
//  Created by Tymofii (Work) on 07.10.2021.
//

import UIKit

final class PhotoGalleryViewController: UIViewController, UINavigationControllerDelegate {
    
    // MARK: - Configuration
    
    private enum Configuration {
        static let numberOfCellsPerRow: CGFloat = 3
        static let minimumLineSpacing: CGFloat = 4
        static let minimumInteritemSpacing: CGFloat = 4
        static let sectionInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        static let headerHeight: CGFloat = 40
        static let dateFormat = "MMM dd"
    }
    
    // MARK: - mode Enum
    
    private enum Mode {
        case view
        case select
    }
    
    // MARK: - UI element
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = Configuration.minimumLineSpacing
        layout.minimumInteritemSpacing = Configuration.minimumInteritemSpacing
        layout.sectionInset = Configuration.sectionInset
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    private lazy var selectBarButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Select", style: .plain, target: self, action: #selector(didSelectButtonClicked(_:)))
        return barButtonItem
    }()
    
    private lazy var addBarButton: UIBarButtonItem = {
        let addButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didAddButtonClicked(_:)))
        return addButtonItem
    }()
    
    // MARK: - Variable
    
    private var photoGalleryModel = PhotoGalleryModel()
            
    private var mode: Mode = .view {
        didSet {
            switch mode {
            case .view:
                selectBarButton.title = "Select"
                collectionView.allowsMultipleSelection = false
                collectionView.reloadData()
            case .select:
                selectBarButton.title = "Cancel"
                collectionView.allowsMultipleSelection = true
            }
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Gallery"
        
        view.addSubview(collectionView)
        setupConstraint()
        setupBarButtonItem()
        setupCollection()
        loadPhotos()
    }
    
    // MARK: - Setting up the constraint
    
    private func setupConstraint() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
    
    // MARK: - Setting up the collectionView
    
    private func setupCollection() {
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    // MARK: - Setting up the barButtonItem
    
    private func setupBarButtonItem() {
        navigationItem.rightBarButtonItem = selectBarButton
        navigationItem.leftBarButtonItem = addBarButton
    }
    
    // MARK: - Loading data
    
    private func loadPhotos() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            let sectionOne = Section<Photo>(date: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date(), objects: Photo.photoGallery)
            self.photoGalleryModel.loadDataSection(section: sectionOne)
            let sectionTwo = Section<Photo>(date: Calendar.current.date(byAdding: .day, value: -2, to: Date()) ?? Date(), objects: Photo.photoGallery)
            self.photoGalleryModel.loadDataSection(section: sectionTwo)
            self.collectionView.reloadData()
        }
    }
    
    // MARK: - UIAction
    
    @objc private func didSelectButtonClicked(_ sender: UITabBarItem) {
        mode = (mode == .view ? .select : .view)
    }
    
    @objc private func didAddButtonClicked(_ sender: UITabBarItem) {
        let alert = UIAlertController(title: "Add Image", message: "Select source", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Photo library", style: .default, handler: { [weak self] action in
            self?.chooseImagePicker(source: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { [weak self] action in
            self?.chooseImagePicker(source: .camera)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDelegate

extension PhotoGalleryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)  {
        switch mode {
        case .view:
            collectionView.deselectItem(at: indexPath, animated: true)
            let imageViewer = ImageViewerViewController()
            imageViewer.indexPath = indexPath
            imageViewer.photo =  photoGalleryModel.getObject(for: indexPath)
            imageViewer.delegate = self
            navigationController?.pushViewController(imageViewer, animated: true)
        case .select:
            print("")
        }
    }
}

// MARK: - UICollectionViewDataSource

extension PhotoGalleryViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        photoGalleryModel.sectionCount
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photoGalleryModel.getDataCount(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as? ImageCollectionViewCell else { return ImageCollectionViewCell() }
        
        cell.photo = photoGalleryModel.getObject(for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.identifier, for: indexPath) as? HeaderView else { return HeaderView() }
        
        let titleHeader = photoGalleryModel.getNameSection(in: indexPath.section).getFormattedDate(format: Configuration.dateFormat)
        header.setup(titleHeader)
        
        return header
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PhotoGalleryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize(width: 1, height: 1) }
        
        let offset = flowLayout.sectionInset.right + flowLayout.sectionInset.left + (flowLayout.minimumInteritemSpacing * (Configuration.numberOfCellsPerRow + 1))
        
        let width = (collectionView.bounds.width - offset) / Configuration.numberOfCellsPerRow
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: Configuration.headerHeight)
    }
}

// MARK: - ImageViewerDelegate

extension PhotoGalleryViewController: ImageViewerDelegate {
    func update(description: String, indexPath: IndexPath) {
        photoGalleryModel.loadDataDescriptionInItem(indexPath: indexPath, description: description)
    }
}

// MARK: - UIImagePickerControllerDelegate

extension PhotoGalleryViewController: UIImagePickerControllerDelegate {
    private func chooseImagePicker(source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            imagePicker.delegate = self
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let choseImage = info[.editedImage] as? UIImage else { return }
        let photo = Photo(image: choseImage)
        var isExist = false
        for index in 0..<photoGalleryModel.sectionCount {
            if photoGalleryModel.getNameSection(in: index).getFormattedDate(format: Configuration.dateFormat) == Date().getFormattedDate(format: Configuration.dateFormat) {
                photoGalleryModel.loadDataItemInSection(at: index, item: photo)
                collectionView.reloadItems(at: [IndexPath(item: photoGalleryModel.getDataCount(in: index) - 1, section: index)])
                isExist = true
                break
            }
        }
        if !isExist {
            photoGalleryModel.loadDataSection(section: Section(date: Date(), objects: [photo]))
            collectionView.reloadData()
        }
        dismiss(animated: true, completion: nil)
    }
}
