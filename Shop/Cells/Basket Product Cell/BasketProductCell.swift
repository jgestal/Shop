//
//  BasketProductCell.swift
//  Shop
//
//  Created by Juan Gestal Romani on 02/06/2019.
//  Copyright © 2019 Juan Gestal Romani. All rights reserved.
//

import UIKit
import Kingfisher

class BasketProductCell: UITableViewCell {
    
    var viewModel: BasketProductCellViewModel? {
        didSet {
            setupUI()
        }
    }
    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var strikedPriceLabel: UILabel!
    
    @IBAction func minusButtonTapped(_ sender: UIButton) {
        viewModel?.del()
    }
    
    @IBAction func plusButtonTapped(_ sender: UIButton) {
        viewModel?.add()
    }
    
    private func setupUI() {
        nameLabel.text = viewModel?.name
        quantityLabel.text = String(viewModel?.quantity ?? 0)
        icon.kf.setImage(with: URL(string: viewModel?.photo ?? ""))

        priceLabel.text = viewModel?.promotionalPrice.eur

        if let discount = viewModel?.discount, discount > 0, let totalPrice = viewModel?.price.eur {
            strikedPriceLabel.attributedText = totalPrice.stroke
            strikedPriceLabel.isHidden = false
            strikedPriceLabel.textColor = Theme.gray
            priceLabel.textColor = Theme.green
        } else {
            strikedPriceLabel.isHidden = true
            priceLabel.textColor = nameLabel.textColor
        }
    }    
}
