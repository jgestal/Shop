//
//  ProductCell.swift
//  Shop
//
//  Created by Juan Gestal Romani on 01/06/2019.
//  Copyright © 2019 Juan Gestal Romani. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    static let identifier = "kProductCell"
    
    func setup(with product: Product) {
    
    }
}
