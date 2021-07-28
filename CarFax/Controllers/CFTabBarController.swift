//
//  CFTabBarController.swift
//  CarFax
//
//  Created by Alex Paul on 7/21/21.
//

import UIKit

class CFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBarControllers()
    }
    
    func configureTabBarControllers(){
        UITabBar.appearance().barTintColor = .systemBlue
        UITabBar.appearance().selectedImageTintColor = .white
        UITabBar.appearance().unselectedItemTintColor = .lightText
        viewControllers = [createCarController(), createSavedController()]
    }
    
    func createCarController() -> UINavigationController {
        let carsViewController = CarsViewController()
        carsViewController.title = "Cars"
        carsViewController.tabBarItem = UITabBarItem.init(title: "Cars", image:UIImage(named: "cars"), tag: 0)
        carsViewController.tabBarItem.badgeColor = .white
        return UINavigationController(rootViewController: carsViewController)
    }
    
    func createSavedController() -> UINavigationController {
        let savedcarsController = SavedCarsViewController()
        savedcarsController.title = "Saved Cars"
        savedcarsController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        savedcarsController.tabBarItem.badgeColor = .white
        return UINavigationController(rootViewController: savedcarsController)
    }
    


    
}
