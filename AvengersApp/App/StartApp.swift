//
//  StartApp.swift
//  AvengersApp
//
//  Created by Eva Gonzalez Ferreira on 25/04/2020.
//  Copyright © 2020 Eva Gonzalez Ferreira. All rights reserved.
//

import UIKit

class StartApp: UIViewController {
    
    lazy var dataProvider: DataProvider = {
        let dataProvider = DataProvider()
        return dataProvider
    }()

    var window: UIWindow?

    convenience init(window: UIWindow?) {
        self.init()
        self.window = window
    }
    
    func start() {
        self.dataProvider.initSuperheroData()
        self.dataProvider.initVillainData()

        let tabBarController = UITabBarController()

        let superherosVM = SuperheroesViewModel(superHeroesDataManager: self.dataProvider,
                                                superheroDetailDataManager: self.dataProvider)
        let superherosVC = SuperherosViewController(viewModel: superherosVM)
        superherosVM.viewDelegate = superherosVC
        let superherosNavigationController = UINavigationController(rootViewController: superherosVC)
        
        let villainsVM = VillainsViewModel(villainsDataManager: self.dataProvider,
                                           villainDetailDataManager: self.dataProvider)
        let villainsVC = VillainsViewController(viewModel: villainsVM)
        villainsVM.viewDelegate = villainsVC
        let villainsNavigationController = UINavigationController(rootViewController: villainsVC)
        
        let battlesVM = BattlesViewModel(battlesDataManager: self.dataProvider,
                                         superherosDataManager: self.dataProvider,
                                         villainsDataManager: self.dataProvider)
        let battlesVC = BattlesViewController(viewModel: battlesVM)
        battlesVM.viewDelegate = battlesVC
        let battlesNavigationController = UINavigationController(rootViewController: battlesVC)

        tabBarController.tabBar.tintColor = UIColor.init(named: Colors.Primary.rawValue)
        tabBarController.tabBar.barTintColor = UIColor.init(named: Colors.DarkGray.rawValue)
        tabBarController.viewControllers = [superherosNavigationController, battlesNavigationController, villainsNavigationController]
        let imageSize = CGSize(width: 30, height: 30)
        tabBarController.tabBar.items?.first?.image = resizeImage(image: UIImage(named: "ic_tab_heroes")!, targetSize: imageSize)
        tabBarController.tabBar.items?[1].image = resizeImage(image: UIImage(named: "ic_tab_battles")!, targetSize: imageSize)
        tabBarController.tabBar.items?[2].image = resizeImage(image: UIImage(named: "ic_tab_villain")!, targetSize: imageSize)
        
        let appearance = tabBarController.tabBar.standardAppearance
        appearance.shadowImage = nil
        appearance.shadowColor = nil
        tabBarController.tabBar.standardAppearance = appearance;
        
        tabBarController.tabBar.shadowImage = UIImage()
        tabBarController.tabBar.backgroundImage = UIImage()
        
        tabBarController.tabBar.layer.shadowColor = UIColor.init(named: Colors.Primary.rawValue)?.cgColor
        tabBarController.tabBar.layer.shadowOffset = CGSize(width: -20, height: 20)
        tabBarController.tabBar.layer.shadowOpacity = 0.7
        tabBarController.tabBar.layer.shadowRadius = 26
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size

        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }

        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }

}
