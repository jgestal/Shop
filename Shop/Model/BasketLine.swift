//
//  BasketLine.swift
//  Shop
//
//  Created by Juan Gestal Romani on 02/06/2019.
//  Copyright © 2019 Juan Gestal Romani. All rights reserved.
//

import Foundation

struct BasketLine {
    
    let product: Product
    let quantity: Int
    
    var price : Double {
        return product.price * Double(quantity)
    }
   
}

extension BasketLine: CustomStringConvertible {
    var description: String {
        return "\(product.code): \(product.name) \(quantity) x \(product.price) = \(promotionalPrice) (promo: (\(price)€))"
    }
}

extension BasketLine: Hashable {
    static func ==(lhs: BasketLine, rhs: BasketLine) -> Bool {
        return (lhs.product == rhs.product) && (lhs.quantity == rhs.quantity)
    }
}


//TODO: This should be configurable in the server
// and not hardcored in the app

// Other option could be to create a DiscountManager
// or other class that returns a discount for the basket

extension BasketLine {
    
    var discount : Double {
        return price - promotionalPrice
    }
    
    var promotionalPrice : Double {
        var price = self.price
        if product.code == "VOUCHER" {
            price = promotion241Price()
        }
        else if product.code == "TSHIRT" {
            price = promotion3OrMorePrice()
        }
        return price
    }
    
    fileprivate func promotion241Price () -> Double {
        return Double(quantity % 2 + quantity / 2) * product.price
    }
    
    fileprivate func promotion3OrMorePrice () -> Double {
        return (quantity > 2 ? product.price - 1 : product.price) * Double(quantity)
    }
}

extension Array where Element == BasketLine {
    
    var price : Double {
        return self.reduce(0,{ $0 + $1.price })
    }
    
    var promotionalPrice : Double {
        return self.reduce(0, { $0 + $1.promotionalPrice })
    }
    
    var discount: Double {
        return price - promotionalPrice
    }
}
