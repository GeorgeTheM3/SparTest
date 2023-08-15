//
//  MainViewModel.swift
//  SparTest
//
//  Created by Георгий Матченко on 11.08.2023.
//

import Foundation
import Combine

final class MainViewModel {
    private let storageService: StorageServiceProtocol
    
    @Published var stories: [CellConfiguration] = []
    @Published var sales: [CellConfiguration] = []
    @Published var qrCode: [CellConfiguration] = []
    @Published var categories: [CellConfiguration] = []
    @Published var recomendation: [CellConfiguration] = []
    @Published var other: [CellConfiguration] = []
    
    init(storageService: StorageServiceProtocol = StorageService()) {
        self.storageService = storageService
        getStartInfo()
    }
    
    private func addNewStories() -> CellConfiguration{
        return CellConfiguration(image: .stories1, type: .stories, title: "Новая история")
    }
 
    func getStartInfo() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            self.stories.append(self.addNewStories())
            self.stories.append(self.addNewStories())
        })
        self.stories = self.storageService.getCellConfiguration(with: .stories)
        self.qrCode = self.storageService.getCellConfiguration(with: .qrCode)
        self.sales = self.storageService.getCellConfiguration(with: .sales)
        self.categories = self.storageService.getCellConfiguration(with: .categories)
        self.recomendation = self.storageService.getCellConfiguration(with: .recomendation)
        self.other = self.storageService.getCellConfiguration(with: .other)
    }
    
    func getInfo(for section: SectionType, at index: IndexPath) -> CellConfiguration {
        switch section {
        case .stories:
            return stories[index.row]
        case .sales:
            return sales[index.row]
        case .qrCode:
            return qrCode[index.row]
        case .categories:
            return categories[index.row]
        case .recomendation:
            return recomendation[index.row]
        case .other:
            return other[index.row]
        }
    }
    
    func getTitle(for header: Headers, at index: IndexPath) -> CellConfiguration {
        switch header {
        case .recomend:
            return recomendation[index.row]
        case .sweet:
            return other[index.row]
        }
    }
}
