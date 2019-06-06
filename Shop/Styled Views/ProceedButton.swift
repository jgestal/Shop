//
//  ProceedButton.swift
//  Shop
//
//  Created by Juan Gestal Romani on 05/06/2019.
//  Copyright © 2019 Juan Gestal Romani. All rights reserved.
//

import UIKit

// It is better to create styled views that you can reuse in the app
class ProceedButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = Theme.red
        setTitleColor(Theme.proceedButton_textColor_stateNormal, for: .normal)
    }
}
