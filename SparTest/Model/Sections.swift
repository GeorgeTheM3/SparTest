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
    case recomend
    case sweet
}

struct CellConfiguration: Hashable{
    var identifier: UUID = UUID()
    func hash(into hasher: inout Hasher) {
        return hasher.combine(identifier)
    }
    static func == (lhs: CellConfiguration, rhs: CellConfiguration) -> Bool {
        return lhs.identifier == rhs.identifier
    }

    init(image: UIImage, type: SectionType, title: String = "Title", header: String = "Header") {
        self.image = image
        self.type = type
        self.title = title
        self.header = header
    }
    
    let image: UIImage
    let type: SectionType
    let title: String
    let header: String
}

