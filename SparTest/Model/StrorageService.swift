//
//  StrorageService.swift
//  SparTest
//
//  Created by Георгий Матченко on 11.08.2023.
//

import UIKit

class StorageService: StorageServiceProtocol {
    func getCellConfiguration(with sectionType: SectionType) -> [CellConfiguration] {
        switch sectionType {
        case .stories:
            return [CellConfiguration(image: .stories1, type: sectionType),
                    CellConfiguration(image: .stories2, type: sectionType),
                    CellConfiguration(image: .stories3, type: sectionType),
                    CellConfiguration(image: .stories4, type: sectionType),
                    CellConfiguration(image: .stories5, type: sectionType)]
        case .sales:
            return [CellConfiguration(image: .sales1, type: sectionType),
                    CellConfiguration(image: .sales2, type: sectionType),
                    CellConfiguration(image: .sales3, type: sectionType)]
        case .qrCode:
            return [CellConfiguration(image: .qrCode, type: sectionType)]
        case .categories:
            return [CellConfiguration(image: .category1, type: sectionType),
                    CellConfiguration(image: .category2, type: sectionType),
                    CellConfiguration(image: .category3, type: sectionType),
                    CellConfiguration(image: .category4, type: sectionType),
                    CellConfiguration(image: .category5, type: sectionType)]
        case .recomendation:
            return [CellConfiguration(image: .recomend1, type: sectionType),
                    CellConfiguration(image: .recomend2, type: sectionType),
                    CellConfiguration(image: .recomend3, type: sectionType),
                    CellConfiguration(image: .recomend4, type: sectionType),]
        case .other:
            return [CellConfiguration(image: .sweet1, type: sectionType),
                    CellConfiguration(image: .sweet2, type: sectionType),
                    CellConfiguration(image: .sweet3, type: sectionType),
                    CellConfiguration(image: .sweet4, type: sectionType)]
        }
    }
}
