//
//  StoriesCell.swift
//  SparTest
//
//  Created by Георгий Матченко on 11.08.2023.
//

import UIKit

final class StoriesCell: UICollectionViewCell {
    static let reuseId: String = "StoriesCell"
    
    private lazy var storiesImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = contentView.bounds.width * 0.4
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var storiesTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13)
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
        contentView.addSubview(storiesImage)
        contentView.addSubview(storiesTitle)
        
        contentView.subviews.forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
        
        NSLayoutConstraint.activate([
        storiesImage.topAnchor.constraint(equalTo: contentView.topAnchor),
        storiesImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        storiesImage.widthAnchor.constraint(equalToConstant: contentView.bounds.width * 0.8),
        storiesImage.heightAnchor.constraint(equalToConstant: contentView.bounds.width * 0.8),
        
        storiesTitle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        storiesTitle.widthAnchor.constraint(equalTo: contentView.widthAnchor),
        storiesTitle.heightAnchor.constraint(equalToConstant: 40),
        storiesTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
        ])
    }
    
    func configureCell(with: CellConfiguration) {
        storiesImage.image = with.image
        storiesTitle.text = with.title
    }
    
    override func prepareForReuse() {
        storiesImage.image = nil
        storiesTitle.text = ""
    }
    
}
