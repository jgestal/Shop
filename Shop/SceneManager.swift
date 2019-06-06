//
//  SceneManager.swift
//  Shop
//
//  Created by Juan Gestal Romani on 05/06/2019.
//  Copyright © 2019 Juan Gestal Romani. All rights reserved.
//

import UIKit

// This class should be improved to support all the kind of transactions...

class SceneManager {
    
    static let shared = SceneManager()

    var navigationController : UINavigationController?
    var currentViewController : UIViewController?
    
    func goToProductList() -> UIViewController {
        currentViewController = ListViewController.fromStoryboard() as! ListViewController
        navigationController = UINavigationController.init(rootViewController: currentViewController!)
        return navigationController!
    }
    
    func pop () {
        navigationController?.popViewController(animated: true)
    }
    
    func goToBasketLines() {

        let basketViewController = BasketViewController.fromStoryboard() as! BasketViewController
        currentViewController = basketViewController
        navigationController?.pushViewController(basketViewController, animated: true)
    }
}

