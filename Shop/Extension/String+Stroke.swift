//
//  String+StrokeTexxt.swift
//  Shop
//
//  Created by Juan Gestal Romani on 06/06/2019.
//  Copyright © 2019 Juan Gestal Romani. All rights reserved.
//

import UIKit

extension String {
    
    var stroke : NSAttributedString {
    
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        return attributeString
        
    }
}
