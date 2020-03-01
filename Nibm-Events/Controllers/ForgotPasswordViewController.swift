//
//  ForgotPasswordViewController.swift
//  Nibm-Events
//
//  Created by Bryan Charles on 3/1/20.
//  Copyright © 2020 Bryan Charles. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var ErrorLabel: UILabel!
    
    @IBOutlet weak var EmailTextField: UITextField!
    
    @IBAction func ResetPassButton(_ sender: UIButton) {
        
        validateFields()
        
        let email = EmailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if error != nil {
               self.ErrorLabel.text = error!.localizedDescription
            }
        }
        
    }
    
    func validateFields() -> String? {
        if
            EmailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill all fields"
        }
        return nil
    }
        func showError (_ message:String){
            ErrorLabel.text = message
            ErrorLabel.alpha = 1
    }
    
    

        override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
  

}
