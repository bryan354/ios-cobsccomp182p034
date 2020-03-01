//
//  Alert.swift
//  Nibm-Events
//
//  Created by Bryan Charles on 3/1/20.
//  Copyright © 2020 Bryan Charles. All rights reserved.
//

import Foundation
import UIKit

class Alert{
    
    class func showBasics(title: String, msg: String , vc: UIViewController){
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        vc.present(alert ,animated: true)
    }
}
