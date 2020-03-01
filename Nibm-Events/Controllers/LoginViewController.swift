//
//  LoginViewController.swift
//  Nibm-Events
//
//  Created by Bryan Charles on 2/28/20.
//  Copyright © 2020 Bryan Charles. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var ProfilePhoto: UIImageView!
    
    @IBOutlet weak var EmailAddressTextField: UITextField!
    
    @IBOutlet weak var PasswordTextField: UITextField!
    
    @IBOutlet weak var ErrorLable: UILabel!
    
    
    
    @IBAction func ForgotPasswordButton(_ sender: UIButton) {
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
        // Do any additional setup after loading the view.
    }
    func showError (_ message:String){
        ErrorLable.text = message
        ErrorLable.alpha = 1
        
    }
    
    @IBAction func LoginButton(_ sender: UIButton) {
        
        let email = EmailAddressTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let pass = PasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        Auth.auth().signIn(withEmail: email, password: pass) { (result, error) in
            if error != nil {
                self.ErrorLable.text = error!.localizedDescription
                self.ErrorLable.alpha = 1
            }else{
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Main")
                self.present(vc, animated: true, completion: nil)
            }
        }
        
        }
    
    func validateFields() -> String? {
        if
            EmailAddressTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
                PasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            
            return "Please fill all fields"
        }
        return nil
    }
    
    func setUpElements(){
        ErrorLable.alpha = 0
    }
}
