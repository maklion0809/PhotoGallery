//
//  HeaderView.swift
//  Task7UICollectionView
//
//  Created by Tymofii (Work) on 07.10.2021.
//

import UIKit

final class HeaderView: UICollectionReusableView {
    
    // MARK: - Configuration
    
    private enum Configuration {
        static let fontSize: CGFloat = 20
        static let leftIndent: CGFloat = 10

    }
    
    // MARK: - Static variable
    
    static let identifier = "Header"
    
    private lazy var titleHeaderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: Configuration.fontSize)
        label.textAlignment = .left
        return label
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupSubview()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Setting up the subview
    
    private func setupSubview() {
        addSubview(titleHeaderLabel)
    }
    
    // MARK: - Setting up the constraint
    
    private func setupConstraint() {
        titleHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleHeaderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Configuration.leftIndent),
            titleHeaderLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    // MARK: - Setting up the collectionCell
    
    func setup(_ title: String) {
        titleHeaderLabel.text = title
    }
}
