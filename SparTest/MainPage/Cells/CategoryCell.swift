//
//  CategoryCell.swift
//  SparTest
//
//  Created by Георгий Матченко on 11.08.2023.
//
import UIKit

class CategoryCell: UICollectionViewCell {
    static let reuseId: String = "CategoryCell"
    
    private lazy var categoryImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.frame = self.bounds
        return imageView
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
    }
    
    func configureCell(with: CellConfiguration) {
        categoryImage.image = with.image
    }
    
    override func prepareForReuse() {
        categoryImage.image = nil
    }
}
