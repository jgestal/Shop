//
//  UIViewController+Storyboard.swift
//  Shop
//
//  Created by Juan Gestal Romani on 02/06/2019.
//  Copyright © 2019 Juan Gestal Romani. All rights reserved.
//

import UIKit

// Helper extension to load ViewControllers from Storyboards
extension UIViewController {
    static func fromStoryboard() -> UIViewController {
        let className = "\(self)"
        let storyboard = UIStoryboard(name: className, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: className)
    }
}
