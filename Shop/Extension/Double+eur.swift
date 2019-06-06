//
//  Double+euro.swift
//  Shop
//
//  Created by Juan Gestal Romani on 05/06/2019.
//  Copyright © 2019 Juan Gestal Romani. All rights reserved.
//

import Foundation

// Formatter for doubles, used to store currency values
extension Double {
    var eur : String {
        return String(format: "%.02f €", self)
    }
}
