//
//  ProductCellViewModel.swift
//  Shop
//
//  Created by Juan Gestal Romani on 03/06/2019.
//  Copyright © 2019 Juan Gestal Romani. All rights reserved.
//

import Foundation

class ProductCellViewModel {
    
    private let product : Product
    
    init(product: Product) {
        self.product = product
    }
    
    var name : String { return product.name }
    var price : Double { return product.price }
    var photo : String { return product.photo() }
}
