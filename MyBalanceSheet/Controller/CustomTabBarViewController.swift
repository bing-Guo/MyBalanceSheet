//
//  CustomTabBarViewController.swift
//  MyBalanceSheet
//
//  Created by Bing Guo on 2020/3/27.
//  Copyright © 2020 Bing Guo. All rights reserved.
//

import UIKit

class CustomTabBarViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        _ = tabBar.items?.firstIndex(of: item)
    }

    // UITabBarControllerDelegate
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController)!
        switch selectedIndex {
        case 0:
            tabBarController.tabBar.tintColor = ._summary_background
            break
        case 1:
            tabBarController.tabBar.tintColor = ._asset_background
            break
        case 2:
            tabBarController.tabBar.tintColor = ._liability_background
            break
        default:
            break
        }
    }
}
