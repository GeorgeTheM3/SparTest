//
//  StorageServiceProtocol.swift
//  SparTest
//
//  Created by Георгий Матченко on 11.08.2023.
//

import Foundation

protocol StorageServiceProtocol {
    func getCellConfiguration(with sectionType: SectionType) -> [CellConfiguration]
}
