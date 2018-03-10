//
//  ExpenseHelper.swift
//  expenseSharingApp
//
//  Created by njindal on 3/10/18.
//  Copyright © 2018 adobe. All rights reserved.
//

import UIKit

class ExpenseHelper: NSObject {
    static func isValidExpense(infos: [ParticipantInfo]) -> Bool {
        var share: CGFloat = 0.0
        for info in infos {
            share += info.share
        }
        if share == 100.0 {
            return true
        } else {
            return false
        }
    }
    
    static func addToFKModel(infos: [ParticipantInfo]) {
        var shareTotal: CGFloat = 0.0
        var totalPaid: CGFloat = 0.0
        for info in infos {
            shareTotal += info.share
            totalPaid += info.paid
        }
        
        for info in infos {
            let finalMoney = (totalPaid * info.share / shareTotal) - info.paid 
            
            if let _ = FKTestModel.shared.paidInfo.index(forKey: info.name) {
                let value = FKTestModel.shared.paidInfo[info.name]! + finalMoney
                FKTestModel.shared.paidInfo[info.name] = value
            } else {
                FKTestModel.shared.paidInfo[info.name] = finalMoney
            }
            
        }
    }
}
