//
//  QrCodeCell.swift
//  SparTest
//
//  Created by Георгий Матченко on 11.08.2023.
//

import UIKit

class QrCodeCell: UICollectionViewCell {
    static let reuseId: String = "QrCodeCell"
    
    private lazy var qrCodeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = self.bounds
        imageView.contentMode = .scaleToFill
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
        contentView.addSubview(qrCodeImage)
    }
    
    func configureCell(with: CellConfiguration) {
        qrCodeImage.image = with.image
    }
    
}
