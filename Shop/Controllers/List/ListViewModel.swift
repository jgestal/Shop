//
//  ListViewModel.swift
//  Shop
//
//  Created by Juan Gestal Romani on 01/06/2019.
//  Copyright © 2019 Juan Gestal Romani. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ListViewModel {
    
    let numberOfProductsInBasket = BehaviorRelay<Int>(value: 0)
    let networkStatus: BehaviorRelay<NetworkTaskStatus> = BehaviorRelay(value: NetworkTaskStatus.completed)

    let bag = DisposeBag()
    
    init() {
        
        Basket.shared.products.asObservable()
            .subscribe(onNext: { [weak self] products in
            self?.numberOfProductsInBasket.accept(products.count)
        }).disposed(by: bag)
     
        Product.products.asObservable().subscribe(onNext: {
            print($0)
        }, onError: {
            print($0)
        }).disposed(by: bag)
        
        loadProductsFromAPI()
    }
    
    func loadProductsFromAPI() {
        networkStatus.accept(.fetching)
        Product.loadProducts { [weak self] result in
            switch result {
            case .success(_):
                self?.networkStatus.accept(.completed)
                break
            case .failure(_):
                 self?.networkStatus.accept(.error)
                 // Try again two seconds latter
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    self?.loadProductsFromAPI()
                }
            }
        }
    }

    func cellTapped(at indexPath: IndexPath) {
        let product = Product.products.value[indexPath.row]
        Basket.shared.add(product)
    }

    func basketButtonTapped() {
        SceneManager.shared.goToBasketLines()
    }
}
