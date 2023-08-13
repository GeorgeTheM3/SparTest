//
//  Extension + Layer.swift
//  SparTest
//
//  Created by Георгий Матченко on 13.08.2023.
//

import UIKit

extension CALayer {
    func setShadow() {
        shadowOffset = CGSize(width: 0, height: 0)
        shadowRadius = 5
        shadowOpacity = 0.15
    }
}
