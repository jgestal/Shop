//
//  BasketProductCellViewModel.swift
//  Shop
//
//  Created by Juan Gestal Romani on 02/06/2019.
//  Copyright © 2019 Juan Gestal Romani. All rights reserved.
//

import UIKit

class BasketProductCellViewModel {
    
    private let basketLine : BasketLine

    var name : String { return basketLine.product.name }
    var price : Double { return basketLine.price }
    var discount: Double { return basketLine.discount }
    var promotionalPrice : Double { return basketLine.promotionalPrice }
    var quantity: Int { return basketLine.quantity }
    var photo : String { return basketLine.product.photo() }

    init(basketLine: BasketLine) {
        self.basketLine = basketLine
    }
    
    func del() {
        Basket.shared.del(basketLine.product)
    }
    
    func add() {
        Basket.shared.add(basketLine.product)
    }
}
