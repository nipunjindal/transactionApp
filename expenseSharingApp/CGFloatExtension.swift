//
//  CGFloatExtension.swift
//  expenseSharingApp
//
//  Created by njindal on 3/10/18.
//  Copyright © 2018 adobe. All rights reserved.
//

import Foundation
import UIKit

extension CGFloat {
    func toString() -> String {
        return String.init(format: "%f", self)
    }
}
