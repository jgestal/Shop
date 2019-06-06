//
//  Basket.swift
//  Shop
//
//  Created by Juan Gestal Romani on 01/06/2019.
//  Copyright © 2019 Juan Gestal Romani. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import AudioToolbox


class Basket {
    
    // Singleton Pattern
    static let shared = Basket()
    
    private let bag = DisposeBag()
    
    let products: BehaviorRelay<[Product]> = BehaviorRelay(value: [])
    
    func clear() {
        Basket.shared.products.accept([])
    }
    
    func add(_ product: Product) {
        Basket.shared.products.accept(Basket.shared.products.value + [product])
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
    
    func del(_ product: Product) {

        var filtered = false

        Basket.shared.products.accept(Basket.shared.products.value.filter {
            if $0 == product && !filtered {
                filtered = true
                return false
            }
            return true
        })
    }
}

extension Array where Element == Product {
    var basketLines : [BasketLine] {
        let productSet = Set<Product>(self)
        return productSet.map { product in
            let quantity = self.reduce(0, { product == $1 ? $0 + 1 : $0 })
            return BasketLine(product: product, quantity: quantity)
        }.sorted { $0.product.name < $1.product.name }
    }
}


