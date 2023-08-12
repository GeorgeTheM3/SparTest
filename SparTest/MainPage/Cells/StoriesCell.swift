//
//  StoriesCell.swift
//  SparTest
//
//  Created by Георгий Матченко on 11.08.2023.
//

import UIKit

class StoriesCell: UICollectionViewCell {
    static let reuseId: String = "StoriesCell"
    
    private lazy var categoryImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray5
        return imageView
    }()
    
    private lazy var categoryTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        contentView.addSubview(categoryImage)
        contentView.addSubview(categoryTitle)
        
        contentView.subviews.forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
        
        NSLayoutConstraint.activate([
        categoryImage.topAnchor.constraint(equalTo: contentView.topAnchor),
        categoryImage.widthAnchor.constraint(equalTo: contentView.heightAnchor, constant: -10),
        categoryImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        categoryImage.bottomAnchor.constraint(equalTo: categoryTitle.topAnchor, constant: 0),
        
        categoryTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
        categoryTitle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
    }
    
    func configureCell(with: CellConfiguration) {
        categoryImage.image = with.image
        categoryTitle.text = "text"
    }
    
}
