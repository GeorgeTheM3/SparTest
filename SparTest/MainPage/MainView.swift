//
//  MainView.swift
//  SparTest
//
//  Created by Георгий Матченко on 11.08.2023.
//
import UIKit
import Combine

final class MainView: UIViewController {
    // MARK: Properties
    private var viewModel: MainViewModel
    private var cancellables = Set<AnyCancellable>()
    
    private var mainScreenCollectionView: UICollectionView!
    
    private lazy var menuButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "line.3.horizontal"), for: .normal)
        button.tintColor = .systemGreen
        return button
    }()
    
    private lazy var myLocationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(" Москва и Московская область", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(systemName: "mappin.and.ellipse"), for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        button.contentHorizontalAlignment = .left
        button.tintColor = .red
        button.layer.borderColor = UIColor.systemGray3.cgColor
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.frame = CGRect(x: 0, y: 0, width: view.frame.width - 70, height: 36)
        button.layer.cornerRadius = button.bounds.height / 2
        return button
    }()
    
    //MARK: Init
    init(viewModel: MainViewModel = MainViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = MainViewModel()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupBindings()
        setupNavigation()
    }
    
    private func setupNavigation() {
        self.navigationItem.rightBarButtonItem = menuButton.toBarButtonItem()
        self.navigationItem.leftBarButtonItem = myLocationButton.toBarButtonItem()
    }
    
    //MARK: Setup collection view
    private func setupCollectionView() {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        mainScreenCollectionView = UICollectionView(frame: frame, collectionViewLayout: setCompositionLayout())
        mainScreenCollectionView.register(SalesCell.self, forCellWithReuseIdentifier: SalesCell.reuseId)
        mainScreenCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseId)
        mainScreenCollectionView.register(RecomendationCell.self, forCellWithReuseIdentifier: RecomendationCell.reuseId)
        mainScreenCollectionView.register(SweetCell.self, forCellWithReuseIdentifier: SweetCell.reuseId)
        mainScreenCollectionView.register(QrCodeCell.self, forCellWithReuseIdentifier: QrCodeCell.reuseId)
        mainScreenCollectionView.register(StoriesCell.self, forCellWithReuseIdentifier: StoriesCell.reuseId)
        
        mainScreenCollectionView.register(GroupHeader.self, forSupplementaryViewOfKind: Headers.recomend.rawValue, withReuseIdentifier: Headers.recomend.rawValue)
        mainScreenCollectionView.register(GroupHeader.self, forSupplementaryViewOfKind: Headers.sweet.rawValue, withReuseIdentifier: Headers.sweet.rawValue)
        
        mainScreenCollectionView.dataSource = self
        mainScreenCollectionView.delegate = self
        view.addSubview(mainScreenCollectionView)
    }
}

//MARK: Bindings
extension MainView {
    private func setupBindings() {
        // берем publishers из vm и производим reloadData() когда они изменяются
        viewModel.$stories
            .receive(on: RunLoop.main)
            .sink(receiveValue: { _ in self.mainScreenCollectionView.reloadData()})
            .store(in: &cancellables)
        
        viewModel.$recomendation
            .receive(on: RunLoop.main)
            .sink(receiveValue: { _ in self.mainScreenCollectionView.reloadData()})
            .store(in: &cancellables)
        
        viewModel.$other
            .receive(on: RunLoop.main)
            .sink(receiveValue: { _ in self.mainScreenCollectionView.reloadData()})
            .store(in: &cancellables)
    }
}

//MARK: UICollectionViewDataSource
extension MainView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        6
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return viewModel.stories.count
        case 1:
            return viewModel.sales.count * 100
        case 2:
            return viewModel.qrCode.count
        case 3:
            return viewModel.categories.count
        case 4:
            return viewModel.recomendation.count * 100
        case 5:
            return viewModel.other.count * 100
        default:
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = SectionType(rawValue: indexPath.section)!
        switch section {
        case .stories:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoriesCell.reuseId, for: indexPath) as? StoriesCell {
                let data = self.viewModel.getInfo(for: section, at: indexPath)
                cell.configureCell(with: data)
                return cell
            }
        case .sales:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SalesCell.reuseId, for: indexPath) as? SalesCell {
                let data = self.viewModel.sales
                let itemToShow = data[indexPath.row % data.count]
                cell.configureCell(with: itemToShow)
                cell.layer.setShadow()
                return cell
            }
        case .qrCode:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QrCodeCell.reuseId, for: indexPath) as? QrCodeCell {
                let data = self.viewModel.getInfo(for: section, at: indexPath)
                cell.configureCell(with: data)
                cell.layer.setShadow()
                return cell
            }
        case .categories:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseId, for: indexPath) as? CategoryCell {
                let data = self.viewModel.getInfo(for: section, at: indexPath)
                cell.configureCell(with: data)
                cell.layer.setShadow()
                return cell
            }
        case .recomendation:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecomendationCell.reuseId, for: indexPath) as?
                RecomendationCell {
                let data = self.viewModel.recomendation
                let itemToShow = data[indexPath.row % data.count]
                cell.configureCell(with: itemToShow)
                cell.layer.setShadow()
                return cell
            }
        case .other:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SweetCell.reuseId, for: indexPath) as? SweetCell {
                let data = self.viewModel.other
                let itemToShow = data[indexPath.row % data.count]
                cell.configureCell(with: itemToShow)
                cell.layer.setShadow()
                return cell
            }
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch indexPath.section {
        case 4:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: Headers.recomend.rawValue, withReuseIdentifier: Headers.recomend.rawValue, for: indexPath) as? GroupHeader else { return UICollectionReusableView()}
            let data = self.viewModel.getTitle(for: .recomend, at: indexPath)
            header.configureHeader(with: data)
            return header
        case 5:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: Headers.sweet.rawValue, withReuseIdentifier: Headers.sweet.rawValue, for: indexPath) as? GroupHeader else { return UICollectionReusableView()}
            let data = self.viewModel.getTitle(for: .sweet, at: indexPath)
            header.configureHeader(with: data)
            return header
        default:
            return UICollectionReusableView()
        }
    }
}

//MARK: UICollectionViewDelegate
extension MainView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard indexPath.row == 1 || indexPath.row == 490 else { return }
        switch indexPath.section {
        case 1:
            collectionView.scrollToItem(at: IndexPath(row: 250, section: 1), at: .centeredHorizontally, animated: false)
        case 4:
            collectionView.scrollToItem(at: IndexPath(row: 250, section: 4), at: .left, animated: false)
        case 5:
            collectionView.scrollToItem(at: IndexPath(row: 250, section: 5), at: .left, animated: false)
        default:
            break
        }
    }
}

//MARK: Setup compositional layout
extension MainView {
    private func setCompositionLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {sectionIndex,enviroment in
            switch sectionIndex {
            case 0:
                return self.storiesSectionLayout()
            case 1:
                return self.salesSectionLayout()
            case 2:
                return self.qrCodeSectionLayout()
            case 3:
                return self.categorySectionLayout()
            case 4:
                return self.recomendSectionLayout()
            default:
                return self.otherSectionLayout()
            }
        }
        return layout
    }
    private func storiesSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/4),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),
                                               heightDimension: .fractionalWidth(0.26))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = Constants.sectionInsents
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    private func salesSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),
                                               heightDimension: .fractionalHeight(0.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = Constants.sectionInsents
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    private func qrCodeSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalWidth(0.3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 18, bottom: 5, trailing: 18)
        section.orthogonalScrollingBehavior = .none
        return section
    }
    
    private func categorySectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.85),
                                               heightDimension: .fractionalWidth(1/3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = Constants.sectionInsents
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    private func recomendSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8),
                                               heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = Constants.sectionInsents
        section.orthogonalScrollingBehavior = .continuous
        
        let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .absolute(30))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerFooterSize,
            elementKind: Headers.recomend.rawValue, alignment: .top)
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    private func otherSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8),
                                               heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = Constants.sectionInsents
        section.orthogonalScrollingBehavior = .continuous
        
        let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .absolute(30))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerFooterSize,
            elementKind: Headers.sweet.rawValue, alignment: .top)
        
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
}
