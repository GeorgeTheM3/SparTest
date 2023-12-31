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
            return [CellConfiguration(image: .stories1, type: sectionType, title: "Привилегии Мой спар"),
                    CellConfiguration(image: .stories2, type: sectionType, title: "Мы в соцсетях"),
                    CellConfiguration(image: .stories3, type: sectionType, title: "100 000 бонусов"),
                    CellConfiguration(image: .stories4, type: sectionType, title: "Новинки недели"),
                    CellConfiguration(image: .stories5, type: sectionType, title: "Городецкая роспись"),
                    CellConfiguration(image: .stories6, type: sectionType, title: "Рецепт недели"),]
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
                    CellConfiguration(image: .category5, type: sectionType),]
        case .recomendation:
            return [CellConfiguration(image: .recomend1, type: sectionType, header: "Рекомендуем"),
                    CellConfiguration(image: .recomend2, type: sectionType, header: "Рекомендуем"),
                    CellConfiguration(image: .recomend3, type: sectionType, header: "Рекомендуем"),
                    CellConfiguration(image: .recomend4, type: sectionType, header: "Рекомендуем"),]
        case .other:
            return [CellConfiguration(image: .sweet1, type: sectionType, header: "Сладкое настроение"),
                    CellConfiguration(image: .sweet2, type: sectionType, header: "Сладкое настроение"),
                    CellConfiguration(image: .sweet3, type: sectionType, header: "Сладкое настроение"),
                    CellConfiguration(image: .sweet4, type: sectionType, header: "Сладкое настроение")]
        }
    }
}
