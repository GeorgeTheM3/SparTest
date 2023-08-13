//
//  Extension + UIButton.swift
//  SparTest
//
//  Created by Георгий Матченко on 13.08.2023.
//

import UIKit

extension UIButton {
    func toBarButtonItem() -> UIBarButtonItem? {
        return UIBarButtonItem(customView: self)
    }
}
