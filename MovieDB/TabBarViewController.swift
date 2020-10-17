//
//  TabBarViewController.swift
//  MovieDB
//
//  Created by Nugi Nuryanto G on 17/10/20.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    private lazy var home: UIViewController = {
        let vc = HomeViewController()
        let image = resizeImage(image: UIImage(imageLiteralResourceName: "homeTMDB"), targetSize: CGSize(width: 30, height: 30))
        let selectedImage = resizeImage(image: UIImage(imageLiteralResourceName: "homeTMDB"), targetSize: CGSize(width: 30, height: 30))
        vc.tabBarItem = UITabBarItem(title: "", image: image, selectedImage: selectedImage)
        return UINavigationController(rootViewController: vc)
    }()
    
    private lazy var recommendation: UIViewController = {
        let vc = RecommendationViewController()
        let image = resizeImage(image: UIImage(imageLiteralResourceName: "popularTMDB"), targetSize: CGSize(width: 30, height: 30))
        let selectedImage = resizeImage(image: UIImage(imageLiteralResourceName: "popularTMDB"), targetSize: CGSize(width: 30, height: 30))
        vc.tabBarItem = UITabBarItem(title: "", image: image, selectedImage: image)
        return UINavigationController(rootViewController: vc)
    }()
    
    private lazy var favorite: UIViewController = {
        let vc = FavoriteViewController()
        let image = resizeImage(image: UIImage(imageLiteralResourceName: "favoriteTMDB"), targetSize: CGSize(width: 30, height: 30))
        let selectedImage = resizeImage(image: UIImage(imageLiteralResourceName: "favoriteTMDB"), targetSize: CGSize(width: 30, height: 30))
        vc.tabBarItem = UITabBarItem(title: "", image: image, selectedImage: image)
        return UINavigationController(rootViewController: vc)
    }()
    
    private lazy var all: UIViewController = {
        let vc = AllViewController()
        let image = resizeImage(image: UIImage(imageLiteralResourceName: "allTMDB"), targetSize: CGSize(width: 30, height: 30))
        let selectedImage = resizeImage(image: UIImage(imageLiteralResourceName: "allTMDB"), targetSize: CGSize(width: 30, height: 30))
        vc.tabBarItem = UITabBarItem(title: "", image: image, selectedImage: image)
        return UINavigationController(rootViewController: vc)
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.tabBar.isOpaque = false
        self.tabBar.isTranslucent = true
        self.tabBar.tintColor = #colorLiteral(red: 0.9844155908, green: 0.8242375851, blue: 0, alpha: 1)
        self.tabBar.barTintColor = UIColor.white
        self.tabBar.unselectedItemTintColor = UIColor.white
        
        tabBar.layer.shadowColor = UIColor.clear.cgColor
        tabBar.layer.shadowOpacity = 0.5
        tabBar.layer.shadowOffset = CGSize.zero
        tabBar.layer.shadowRadius = 5
        self.tabBar.layer.borderColor = UIColor.clear.cgColor
        self.tabBar.layer.borderWidth = 0
        self.tabBar.clipsToBounds = false
        self.tabBar.backgroundColor = UIColor.black
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        
        
        self.viewControllers = [home, recommendation, favorite, all]
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}
