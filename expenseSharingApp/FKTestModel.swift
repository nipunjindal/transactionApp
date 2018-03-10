//
//  FKTestModel.swift
//  expenseSharingApp
//
//  Created by njindal on 3/10/18.
//  Copyright © 2018 adobe. All rights reserved.
//

import UIKit

struct PaidInfo {
    var user:String
    var value: CGFloat
}

class FKTestModel: NSObject {
    public static let shared = FKTestModel()
    
    let userName = "Nipun"
    var paidInfo = [String:CGFloat]()
    
    override init() {
        super.init()
        
        paidInfo[userName] = 0.0
    }    
}
