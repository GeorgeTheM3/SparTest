//
//  SalesCell.swift
//  SparTest
//
//  Created by Георгий Матченко on 11.08.2023.
//

import Foundation

import UIKit

class SalesCell: UICollectionViewCell {
    static let reuseId: String = "SalesCell"
    
    private lazy var salesImage: UIImageView = {
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
        contentView.addSubview(salesImage)
    }
    
    func configureCell(with: CellConfiguration) {
        salesImage.image = with.image
    }
    
    override func prepareForReuse() {
        salesImage.image = nil
    }
}
