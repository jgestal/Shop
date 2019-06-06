//
//  ProductCell.swift
//  Shop
//
//  Created by Juan Gestal Romani on 01/06/2019.
//  Copyright © 2019 Juan Gestal Romani. All rights reserved.
//

import UIKit
import Kingfisher

class ProductCell: UITableViewCell {
    
    var viewModel: ProductCellViewModel? {
        didSet {
            setupUI()
        }
    }
   
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var primaryLabel: UILabel!
    @IBOutlet weak var secondaryLabel: UILabel!
    
    private func setupUI() {
        primaryLabel.text = viewModel?.name
        secondaryLabel.text = viewModel?.price.eur
        icon.kf.setImage(with: URL(string: viewModel?.photo ?? ""))
    }

}
