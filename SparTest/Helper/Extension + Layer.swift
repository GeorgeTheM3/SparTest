//
//  Extension + Layer.swift
//  SparTest
//
//  Created by Георгий Матченко on 13.08.2023.
//

import UIKit

extension CALayer {
    func setShadow() {
        shadowOffset = Constants.shadowOffset
        shadowRadius = Constants.shadowRadius
        shadowOpacity = Constants.shadorOpacity
    }
}
