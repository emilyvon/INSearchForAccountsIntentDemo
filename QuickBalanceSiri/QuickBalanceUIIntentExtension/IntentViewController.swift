//
//  IntentViewController.swift
//  QuickBalanceUIIntentExtension
//
//  Created by Mengying Feng on 27/10/18.
//  Copyright © 2018 iemrollin. All rights reserved.
//

import IntentsUI

class IntentViewController: UIViewController, INUIHostedViewControlling {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var otherBalanceLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
        
    // MARK: - INUIHostedViewControlling
    func configureView(for parameters: Set<INParameter>, of interaction: INInteraction, interactiveBehavior: INUIInteractiveBehavior, context: INUIHostedViewContext, completion: @escaping (Bool, Set<INParameter>, CGSize) -> Void) {
        
        let intentParameter = parameters.filter { (param) -> Bool in
            return param.parameterClass == INSearchForAccountsIntentResponse.classForCoder()
        }.first
        
        guard let inParameter = intentParameter else {
            completion(false, parameters, CGSize.zero)
            return
        }
    
        let size = displayFor(parameter: inParameter, interaction: interaction)
        completion(true, parameters, size)
        
    }
    
    fileprivate func displayFor(parameter: INParameter, interaction: INInteraction) -> CGSize {
        switch parameter.parameterClass.description() {
        case "INSearchForAccountsIntentResponse":
            
            let responses = interaction.intentResponse as! INSearchForAccountsIntentResponse
            let currentIndex = parameter.index(forSubKeyPath: parameter.parameterKeyPath)
            
            guard let accounts = responses.accounts else {
                return .zero
            }
            
            separatorView.isHidden = currentIndex == accounts.count - 1
            
            let currentAccount = accounts[currentIndex]
            
            if let name = currentAccount.nickname?.spokenPhrase {
                nameLabel.text = "\(name)"
                nameLabel.isHidden = false
            } else {
                nameLabel.isHidden = true
            }
            
            if let balance = currentAccount.balance?.amount?.stringValue {
                balanceLabel.text = "\(balance)"
                balanceLabel.isHidden = false
            } else {
                balanceLabel.isHidden = true
            }
            
            if let otherBalance = currentAccount.secondaryBalance?.amount?.stringValue {
                otherBalanceLabel.text = "$\(otherBalance)"
                otherBalanceLabel.isHidden = false
            } else {
                otherBalanceLabel.isHidden = true
            }
            
            return contentSize

        default:
            break
        }
        
        return CGSize.zero
    }
    
    private var contentSize: CGSize {
        return CGSize(width: self.extensionContext!.hostedViewMinimumAllowedSize.width, height: self.extensionContext!.hostedViewMinimumAllowedSize.height + 60)
    }
    
}
