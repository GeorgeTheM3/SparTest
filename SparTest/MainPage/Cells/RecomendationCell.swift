//
//  RecomendationCell.swift
//  SparTest
//
//  Created by Георгий Матченко on 11.08.2023.
//
import UIKit

class RecomendationCell: UICollectionViewCell {
    static let reuseId: String = "RecomendationCell"
    
    private lazy var recomendImage: UIImageView = {
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
        contentView.addSubview(recomendImage)
    }
    
    func configureCell(with: CellConfiguration) {
        recomendImage.image = with.image
    }
}
