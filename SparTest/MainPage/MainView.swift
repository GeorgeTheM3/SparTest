//
//  MainView.swift
//  SparTest
//
//  Created by Георгий Матченко on 11.08.2023.
//
import UIKit
import Combine

class MainView: UIViewController {
    private var viewModel: MainViewModel
    private lazy var dataSource = makeDataSource()
    
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
        view.addSubview(mainScreenCollectionView)
    }
    
    func supplementary(collectionView: UICollectionView, kind: Headers, indexPath: IndexPath) -> UICollectionReusableView? {
        switch kind {
        case .recomend:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: Headers.recomend.rawValue, withReuseIdentifier: Headers.recomend.rawValue, for: indexPath) as? GroupHeader
            let data = self.viewModel.getTitle(for: kind, at: indexPath)
            header?.configureHeader(with: data)
            return header
        case .sweet:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: Headers.sweet.rawValue, withReuseIdentifier: Headers.sweet.rawValue, for: indexPath) as? GroupHeader
            let data = self.viewModel.getTitle(for: kind, at: indexPath)
            header?.configureHeader(with: data)
            return header
        }
    }
    
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
    
    let sectionInsents = NSDirectionalEdgeInsets(top: 10, leading: 13, bottom: 10, trailing: 13)
    
    private func storiesSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/4),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),
                                               heightDimension: .fractionalWidth(0.26))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = sectionInsents
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
        section.contentInsets = sectionInsents
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
        section.contentInsets = sectionInsents
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
        section.contentInsets = sectionInsents
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
        section.contentInsets = sectionInsents
        section.orthogonalScrollingBehavior = .continuous
        
        let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .absolute(30))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerFooterSize,
            elementKind: Headers.sweet.rawValue, alignment: .top)
        
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    private func makeDataSource() -> UICollectionViewDiffableDataSource<SectionType, Int > {
        return UICollectionViewDiffableDataSource(collectionView: mainScreenCollectionView, cellProvider: { collectionView,indexPath,itemIdentifier in
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
                    let data = self.viewModel.getInfo(for: section, at: indexPath)
                    cell.configureCell(with: data)
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
                    let data = self.viewModel.getInfo(for: section, at: indexPath)
                    cell.configureCell(with: data)
                    cell.layer.setShadow()
                    return cell
                }
            case .other:
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SweetCell.reuseId, for: indexPath) as? SweetCell {
                    let data = self.viewModel.getInfo(for: section, at: indexPath)
                    cell.configureCell(with: data)
                    cell.layer.setShadow()
                    return cell
                }
            }
            return UICollectionViewCell()
        })
    }
    
    func updateDataSource(animated: Bool) {
        var snapshot = NSDiffableDataSourceSnapshot<SectionType, Int >()
        snapshot.appendSections(SectionType.allCases)
        
        self.dataSource.supplementaryViewProvider = { [unowned self] collectionView, kind, indexPath in
            return self.supplementary(collectionView: collectionView, kind: Headers(rawValue: kind) ?? .recomend , indexPath: indexPath)
        }
        
        let data = [viewModel.stories, viewModel.sales,viewModel.qrCode, viewModel.categories, viewModel.recomendation, viewModel.other]
        data.forEach({
            snapshotItem(items: $0, section: $0.first?.type ?? .categories )
        })
        
        func snapshotItem(items: [CellConfiguration], section: SectionType) {
            items.forEach { item in
                snapshot.appendItems([item.hashValue], toSection: section)
            }
        }
        
        self.dataSource.apply(snapshot, animatingDifferences: animated)
    }
}

extension MainView {
    private func setupBindings() {
        // берем publishers из vm и производим updateDataSource когда они изменяются
        let publishers = [viewModel.$stories, viewModel.$stories, viewModel.$qrCode, viewModel.$categories, viewModel.$recomendation, viewModel.$other]
        publishers.forEach {
            $0.sink { _ in
                self.updateDataSource(animated: true)
            }
            .store(in: &cancellables)
        }
    }
}
