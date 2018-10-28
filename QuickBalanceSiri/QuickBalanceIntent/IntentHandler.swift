//
//  IntentHandler.swift
//  QuickBalanceIntent
//
//  Created by Mengying Feng on 27/10/18.
//  Copyright © 2018 iemrollin. All rights reserved.
//

import Intents

// As an example, this class is set up to handle Message intents.
// You will want to replace this or add other intents as appropriate.
// The intents you wish to handle must be declared in the extension's Info.plist.

// You can test your example integration by saying things to Siri like:
// "Send a message using <myApp>"
// "<myApp> John saying hello"
// "Search for messages in <myApp>"

class IntentHandler: INExtension, INSearchForAccountsIntentHandling {
   
    func handle(intent: INSearchForAccountsIntent, completion: @escaping (INSearchForAccountsIntentResponse) -> Void) {
        
        let response = INSearchForAccountsIntentResponse(code: INSearchForAccountsIntentResponseCode.success, userActivity: NSUserActivity(activityType: NSStringFromClass(INSearchForAccountsIntent.self)))
        response.accounts = [
            INPaymentAccount(nickname: INSpeakableString(spokenPhrase: "Transaction Account"), number: nil, accountType: INAccountType.debit, organizationName: intent.organizationName, balance: INBalanceAmount.init(amount: 30.5, currencyCode: "AUD"), secondaryBalance: INBalanceAmount.init(amount: 25.6, currencyCode: "AUD")),
            INPaymentAccount(nickname: INSpeakableString(spokenPhrase: "Saving Account"), number: nil, accountType: INAccountType.saving, organizationName: intent.organizationName, balance: INBalanceAmount.init(amount: 1500.02, currencyCode: "AUD"), secondaryBalance: nil),
            INPaymentAccount(nickname: INSpeakableString(spokenPhrase: "Home loan"), number: nil, accountType: INAccountType.mortgage, organizationName: intent.organizationName, balance: INBalanceAmount.init(amount: 5000, currencyCode: "AUD"), secondaryBalance: INBalanceAmount.init(amount: -450000, currencyCode: "AUD")),
            INPaymentAccount(nickname: INSpeakableString(spokenPhrase: "Stocks"), number: nil, accountType: INAccountType.investment, organizationName: intent.organizationName, balance: INBalanceAmount.init(amount: 2000, currencyCode: "AUD"), secondaryBalance: INBalanceAmount.init(amount: 2000, currencyCode: "AUD"))]
        
        completion(response)
    }
    
    func confirm(intent: INSearchForAccountsIntent, completion: @escaping (INSearchForAccountsIntentResponse) -> Void) {
        completion(
            INSearchForAccountsIntentResponse(
                code: INSearchForAccountsIntentResponseCode.ready,
                userActivity: nil)
        )
    }
    
}
