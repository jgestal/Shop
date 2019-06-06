//
//  Product.swift
//  Shop
//
//  Created by Juan Gestal Romani on 01/06/2019.
//  Copyright © 2019 Juan Gestal Romani. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxAlamofire
import Alamofire

struct ProductList:Decodable {
    let products: [Product]
}


struct Product: Codable {
    
    let code: String
    let name: String
    let price: Double

    // The app without images is a bit boring...
    // So I uploaded some images for products to my server
    func photo() -> String {
        return "https://gestal.es/store/\(code).png"
    }
   
    static let products: BehaviorRelay<[Product]> = BehaviorRelay(value: [])
    
    static func loadProducts(completionHandler: @escaping (Result<Any>) -> Void) {
        
        let stringURL = "https://api.myjson.com/bins/4bwec"
        let manager = Alamofire.SessionManager.default

        _ = manager.rx.request(.get, stringURL)
            .validate(statusCode: 200 ..< 300)
            .validate(contentType: ["application/json"])
            .data()
            .subscribe(onNext:{
                do {
                    let productList = try JSONDecoder().decode(ProductList.self, from: $0)
                    products.accept(productList.products)
                    completionHandler(.success(productList.products))
                }
                catch {
                    products.accept([])
                    completionHandler(.failure(APIError.unexpectedResponse))
                }
            }
            ,onError: { error in
                products.accept([])
                completionHandler(.failure(APIError.unexpectedResponse))
            })
    }
}

extension Product: CustomStringConvertible {
    var description: String {
        return "\(code): \(name) (\(price)€)"
    }
}

extension Product: Hashable {
    static func ==(lhs: Product, rhs: Product) -> Bool {
        return (lhs.code == rhs.code)
    }
}
