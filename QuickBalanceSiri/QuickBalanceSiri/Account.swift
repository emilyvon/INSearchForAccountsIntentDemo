//
//  Account.swift
//  QuickBalanceSiri
//
//  Created by Mengying Feng on 27/10/18.
//  Copyright © 2018 iemrollin. All rights reserved.
//

import Foundation
import Intents

public struct Account {
    let nickname: String
    let accountType: Int
    let organizationName: String
    let requestedBalanceType: Int
}

extension Account {
    public var inAccountType: INAccountType {
        return INAccountType(rawValue: accountType) ?? .unknown
    }
    
    public var inBalanceType: INBalanceType {
        return INBalanceType(rawValue: requestedBalanceType) ?? .unknown
    }
}

public let accounts = [
    Account(nickname: "transaction", accountType: 3, organizationName: "Bankmind", requestedBalanceType: 1),
    Account(nickname: "saving", accountType: 7, organizationName: "Bankmind", requestedBalanceType: 1)
]
