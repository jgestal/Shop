//
//  BasketViewModel.swift
//  Shop
//
//  Created by Juan Gestal Romani on 02/06/2019.
//  Copyright © 2019 Juan Gestal Romani. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class BasketViewModel {
    
    let bag = DisposeBag()
    let basketLines: BehaviorRelay<[BasketLine]> = BehaviorRelay(value: [])

    init() {
        Basket.shared.products.asObservable()
            .subscribe(onNext: { [weak self] products in
            self?.basketLines.accept(products.basketLines)
        }).disposed(by: bag)
    }
    
    func confirmAndPay() {
        Basket.shared.clear()
        SceneManager.shared.pop()
    }
}
