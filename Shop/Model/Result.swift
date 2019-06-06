//
//  Result.swift
//  Shop
//
//  Created by Juan Gestal Romani on 06/06/2019.
//  Copyright © 2019 Juan Gestal Romani. All rights reserved.
//

import Foundation

// Implementation of the result pattern

enum Result<T> {
    case success(T)
    case failure(Error)
}
