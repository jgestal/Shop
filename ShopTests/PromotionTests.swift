//
//  PromotionTests.swift
//  ShopTests
//
//  Created by Juan Gestal Romani on 03/06/2019.
//  Copyright © 2019 Juan Gestal Romani. All rights reserved.
//

import XCTest
import RxSwift
@testable import Shop

// Tests for the provided examples
class PromotionTests: XCTestCase {
    
    let voucher = Product(code: "VOUCHER", name: "Cabify Voucher", price: 5)
    let tshirt = Product(code: "TSHIRT", name: "T-Shirt", price: 20)
    let mug = Product(code: "MUG", name: "Coffee Mug", price: 7.5)
    
    var basketLines : [BasketLine] = []
    
    override func setUp() {
        basketLines = [BasketLine]()
    }
    
    //Items: VOUCHER, TSHIRT, MUG
    //Total: 32.50€
    func testPromotion_1Voucher1TShirt1Mug_ExpectedPrice3250() {
        
        basketLines.append(BasketLine(product: voucher, quantity: 1))
        basketLines.append(BasketLine(product: tshirt, quantity: 1))
        basketLines.append(BasketLine(product: mug, quantity: 1))
        
        XCTAssertEqual(basketLines.promotionalPrice, 32.50)

    }
    
    //Items: VOUCHER, TSHIRT, VOUCHER
    //Total: 25.00€
    
    func testPromotion_2Voucher1TShirt_ExpectedPrice2500() {
        
        basketLines.append(BasketLine(product: voucher, quantity: 2))
        basketLines.append(BasketLine(product: tshirt, quantity: 1))
        
        XCTAssertEqual(basketLines.promotionalPrice, 25.00)
    }
    
    //Items: TSHIRT, TSHIRT, TSHIRT, VOUCHER, TSHIRT
    //Total: 81.00€
    
    func testPromotion_3TShirt1Voucher_ExpectedPrice8100() {
        
        basketLines.append(BasketLine(product: tshirt, quantity: 4))
        basketLines.append(BasketLine(product:voucher, quantity: 1))
        
        XCTAssertEqual(basketLines.promotionalPrice, 81.00)
    }
    
    //Items: VOUCHER, TSHIRT, VOUCHER, VOUCHER, MUG, TSHIRT, TSHIRT
    //Total: 74.50€
    
    func testPromotion_3Voucher3TShirt1Mug() {
        
        basketLines.append(BasketLine(product: voucher, quantity: 3))
        basketLines.append(BasketLine(product: tshirt,  quantity: 3))
        basketLines.append(BasketLine(product: mug, quantity: 1))
        
        XCTAssertEqual(basketLines.promotionalPrice, 74.50)
    }
    
}

