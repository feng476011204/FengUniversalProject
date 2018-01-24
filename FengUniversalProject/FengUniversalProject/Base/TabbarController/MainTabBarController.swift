//
//  MainTabBarController.swift
//  FengUniversalProject
//
//  Created by feng on 2018/1/24.
//  Copyright © 2018年 feng. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    var childVcs: [RootNavigationController]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 初始化tabbar
        setupTabBar()
        // 设置子控制器
        setUpAllChildViewController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupTabBar() {
        setValue(TFTabBar(), forKey: "tabBar")
        tabBar.backgroundColor = UIColor.white
        tabBar.backgroundImage = UIImage()
    }
    func setUpAllChildViewController() {
        
        childVcs = [RootNavigationController]();
        
        let homeVc = TFHomeViewController()
        setupChildViewController(controller: homeVc, title: "首页", imageName: "icon_tabbar_homepage", selectedImageName: "icon_tabbar_homepage_selected")
        self.viewControllers = childVcs
    }
    func setupChildViewController(controller: UIViewController, title: String, imageName: String, selectedImageName: String) {
        controller.title = title
        controller.tabBarItem.image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
        controller.tabBarItem.selectedImage = UIImage(named:selectedImageName)?.withRenderingMode(.alwaysOriginal)
        controller.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.black, NSAttributedStringKey.font : UIFont.systemFont(ofSize: 10)], for: .normal)
        controller.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.black, NSAttributedStringKey.font : UIFont.systemFont(ofSize: 10)], for: .normal)
        let nav = RootNavigationController(rootViewController: controller)
        childVcs?.append(nav)
    }
}
