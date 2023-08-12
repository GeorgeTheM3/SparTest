//
//  TabBarController.swift
//  SparTest
//
//  Created by Георгий Матченко on 11.08.2023.
//

import UIKit

class TabBarController: UITabBarController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.viewControllers = configureTabBar()
        customizationTabBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureTabBar() -> [UIViewController]{
        var controllers: [UIViewController] = []
        
        let mainController = MainView()
        mainController.view.backgroundColor = .white
        
        let firstController = UINavigationController(rootViewController: mainController)
        firstController.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Helvetica-Bold", size: 20)!]
        firstController.tabBarItem = UITabBarItem(title: "Главная", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        controllers.append(firstController)
        
        let secondController = UINavigationController(rootViewController:  UIViewController())
        secondController.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Helvetica-Bold", size: 20)!]
        secondController.tabBarItem = UITabBarItem(title: "Каталог",  image: UIImage(systemName: "circle"), selectedImage: UIImage(systemName: "circle.fill"))
        controllers.append(secondController)
        
        let thirdController = UINavigationController(rootViewController:  UIViewController())
        thirdController.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Helvetica-Bold", size: 20)!]
        thirdController.tabBarItem = UITabBarItem(title: "Корзина",  image: UIImage(systemName: "circle"), selectedImage: UIImage(systemName: "circle.fill"))
        controllers.append(thirdController)
        
        let fourthController = UINavigationController(rootViewController: UIViewController())
        fourthController.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Helvetica-Bold", size: 20)!]
        let item = UITabBarItem(title: "Профиль",  image: UIImage(systemName: "circle"), selectedImage: UIImage(systemName: "circle.fill"))
        fourthController.tabBarItem = item
        controllers.append(fourthController)
        
        return controllers
    }
    
    private func customizationTabBar() {
        let appearance = UITabBarAppearance()
        appearance.stackedItemPositioning = .centered
        tabBar.standardAppearance = appearance
        tabBar.tintColor = .systemGreen
    }
}

