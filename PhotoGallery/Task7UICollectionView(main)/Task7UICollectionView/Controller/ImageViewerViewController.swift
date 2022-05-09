//
//  ImageViewerViewController.swift
//  Task7UICollectionView
//
//  Created by Tymofii (Work) on 08.10.2021.
//

import UIKit

final class ImageViewerViewController: UIViewController {
    
    // MARK: - Configuration
    
    private enum Configuration {
        static let textFieldFont: CGFloat = 30
        static let itemHorizontalSpace: CGFloat = 30
        static let itemBottonSpace: CGFloat = 30
        static let textLength = 10
    }
    
    // MARK: - UI element
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .white
        return imageView
    }()
    
    private lazy var descriptionTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.placeholder = "Write a description"
        textField.textColor = .black
        textField.textAlignment = .center
        textField.font = .systemFont(ofSize: Configuration.textFieldFont)
        return textField
    }()
    
    private lazy var saveBarButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveChange))
        return barButtonItem
    }()
    
    private lazy var textFieldBottonConstraint = NSLayoutConstraint()
    
    // MARK: Delegate
    
    weak var delegate: ImageViewerDelegate?
    
    // MARK: Variable
    
    var photo: Photo?
    var indexPath: IndexPath?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNotificationCenter()
        setupSubview()
        setupConstraint()
        setupContent()
        setupNotificationCenter()
    }
    
    // MARK: - Setting up the subview
    
    private func setupSubview() {
        view.addSubview(imageView)
        view.addSubview(descriptionTextField)
        descriptionTextField.addTarget(self, action: #selector(editingChanged(sender:)), for: .editingChanged)
        descriptionTextField.delegate = self
        navigationItem.rightBarButtonItem = saveBarButton
    }
    
    // MARK: - Setting up the constraint
    
    private func setupConstraint() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
        
        descriptionTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Configuration.itemHorizontalSpace),
            descriptionTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Configuration.itemHorizontalSpace)
        ])
        textFieldBottonConstraint =             descriptionTextField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Configuration.itemBottonSpace)
        textFieldBottonConstraint.isActive = true
    }
    
    // MARK: - Setting up the content
    
    private func setupContent() {
        guard let photo = photo else { return }
        imageView.image = photo.image
        guard let description = photo.description else { return }
        descriptionTextField.text = description
    }
    
    // MARK: - Setting up the NotificationCenter
    
    private func setupNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil);
    }
    
    // MARK: - UIAction
    
    @objc private func editingChanged(sender: UITextField) {
        guard let text = sender.text, text.count >= Configuration.textLength else { return }
        sender.text = String(text.dropLast(text.count - Configuration.textLength))
    }
    
    @objc private func saveChange() {
        guard let text = descriptionTextField.text, let indexPath = indexPath else { return }
        delegate?.update(description: text, indexPath: indexPath)
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo, let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {return}
        textFieldBottonConstraint.constant = -keyboardSize.height
        UIView.animate(
            withDuration: 1,
            delay: 0,
            options: .curveEaseIn,
            animations: { self.view.layoutIfNeeded() },
            completion: nil)
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        textFieldBottonConstraint.constant = -Configuration.itemBottonSpace
        UIView.animate(
            withDuration: 1,
            delay: 0,
            options: .curveEaseIn,
            animations: { self.view.layoutIfNeeded() },
            completion: nil)
    }
}

// MARK: - UITextFieldDelegate

extension ImageViewerViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
