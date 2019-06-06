//
//  UITableViewCell+Helper.swift
//  Shop
//
//  Created by Juan Gestal Romani on 02/06/2019.
//  Copyright © 2019 Juan Gestal Romani. All rights reserved.
//

import UIKit

// Helper extension to work with cells
extension UITableViewCell {
    static var identifier : String { return "\(self)" }
    static var nib: UINib { return UINib(nibName: "\(self)", bundle: nil) }
}
