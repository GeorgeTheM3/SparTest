//
//  Sections.swift
//  SparTest
//
//  Created by Георгий Матченко on 11.08.2023.
//

import UIKit

enum SectionType: Int, CaseIterable {
    case stories
    case sales
    case qrCode
    case categories
    case recomendation
    case other
}

enum Headers: String {
    case popular
    case shops
}

struct CellConfiguration: Hashable{
    var identifier: UUID = UUID()
    func hash(into hasher: inout Hasher) {
        return hasher.combine(identifier)
    }
    static func == (lhs: CellConfiguration, rhs: CellConfiguration) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    let image: UIImage
    let type: SectionType
}

