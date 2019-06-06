//
//  ShopTests.swift
//  ShopTests
//
//  Created by Juan Gestal Romani on 01/06/2019.
//  Copyright © 2019 Juan Gestal Romani. All rights reserved.
//

import XCTest
import RxSwift
@testable import Shop

class ShopTests: XCTestCase {

    let voucher = Product(code: "VOUCHER", name: "Cabify Voucher", price: 5)
    let tshirt = Product(code: "TSHIRT", name: "T-Shirt", price: 20)
    let mug = Product(code: "MUG", name: "Coffee Mug", price: 7.5)
    
    var bag : DisposeBag!
    
    override func setUp() {
        bag = DisposeBag()
        Basket.shared.clear()
    }
    
    func testBasket_AddOneProduct_ProductIsAdded() {
        
        let expectedBasketLine = BasketLine(product: voucher, quantity: 1)
        Basket.shared.add(voucher)
        
        if let basketLine = Basket.shared.products.value.basketLines.first {
            XCTAssertEqual(basketLine, expectedBasketLine)
            
        } else {
            
            XCTFail()
        }
    }
    
    func testBasket_AddThreeProducts_ProductsAreAdded() {
        
        Basket.shared.add(voucher)
        Basket.shared.add(tshirt)
        Basket.shared.add(mug)
        
        XCTAssertEqual(Basket.shared.products.value.count, 3)
    }
    
    func testBasket_AddOneProductThreeTimes_TheBasketLineQuantityIsThree() {
        
        Basket.shared.add(voucher)
        Basket.shared.add(voucher)
        Basket.shared.add(voucher)
        
        let expectedBasketLine = BasketLine(product: voucher, quantity: 3)
        
        XCTAssertEqual(Basket.shared.products.value.count, 3)
        
        if let basketLine = Basket.shared.products.value.basketLines.first {
            XCTAssertEqual(basketLine, expectedBasketLine)
        } else {
            
             XCTFail()
        }
    }
    
    func testBasket_AddOneProductThenDeleteProduct_BasketIsEmpty() {
        
        Basket.shared.add(voucher)
        Basket.shared.del(voucher)
        
        XCTAssertEqual(Basket.shared.products.value.count,0)
    }
    
    func testBasket_AddTwoUnitsOfTheSameProductAndDeleteOne_BasketHasOneUnitOfThatProduct() {

        Basket.shared.add(voucher)
        Basket.shared.add(voucher)
        Basket.shared.del(voucher)
        
        let product = Basket.shared.products.value.first
        XCTAssertEqual(product,voucher)
    }
    
    func testBasket_AddOneProductThenClearBasket_BasketIsEmpty() {
        
        Basket.shared.add(tshirt)
        Basket.shared.clear()
        
        XCTAssertEqual(Basket.shared.products.value.count, 0)
    }
    
    func testBasket_DeleteProductFromEmptyBasket_BasketIsEmpty() {
        Basket.shared.del(voucher)
        XCTAssertEqual(Basket.shared.products.value.count,0)
    }
    
    func testBasket_BasketWithProductDeleteOtherProduct_BasketStillHasTheProduct() {
        
        let expectedBasketLine = BasketLine(product: voucher, quantity: 1)
        
        Basket.shared.add(voucher)
        Basket.shared.del(tshirt)
        
        XCTAssertEqual(Basket.shared.products.value.count, 1)
        if let basketLine = Basket.shared.products.value.basketLines.first {
            XCTAssertEqual(basketLine, expectedBasketLine)
        } else {
            XCTFail()
        }
    }

    func testBasket_BasketLines_AreOrderAlphabeticallyByProductName() {
        
        Basket.shared.add(voucher)
        Basket.shared.add(tshirt)
        Basket.shared.add(mug)

        let basketLines = Basket.shared.products.value.basketLines
        
        // 1. Cabify Voucher
        XCTAssertEqual(basketLines[0], BasketLine(product: voucher, quantity: 1))
        // 2. Coffee Mug
        XCTAssertEqual(basketLines[1], BasketLine(product: mug, quantity: 1))
        // 3. T-Shirt
        XCTAssertEqual(basketLines[2], BasketLine(product: tshirt, quantity: 1))
    }
    
}
