//
//  ShopUITests.swift
//  ShopUITests
//
//  Created by Juan Gestal Romani on 01/06/2019.
//  Copyright © 2019 Juan Gestal Romani. All rights reserved.
//

import XCTest

class ShopUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    
    // Sample UI Test that perform a complete journey of placing an order
    func test_CanPlaceOrder() {
        let app = XCUIApplication()
        let cabifyVoucherStaticText = app.tables.staticTexts["Cabify Voucher"]
        cabifyVoucherStaticText.tap()
        app.navigationBars["Products"].buttons["ListViewController_BasketButton"].tap()
        app.buttons["BasketViewController_ProceedButton"].tap()
        
        XCTAssertNotNil(app.alerts["Order completed"])
    }
}
