//
//  SweetCell.swift
//  SparTest
//
//  Created by Георгий Матченко on 11.08.2023.
//

import UIKit

class SweetCell: UICollectionViewCell {
    static let reuseId: String = "SweetCell"
    
    private lazy var otherImage: UIImageView = {
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
        contentView.addSubview(otherImage)
    }
    
    func configureCell(with: CellConfiguration) {
        otherImage.image = with.image
    }
}
