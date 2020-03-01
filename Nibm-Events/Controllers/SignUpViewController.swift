//
//  SignUpViewController.swift
//  Nibm-Events
//
//  Created by Bryan Charles on 2/28/20.
//  Copyright © 2020 Bryan Charles. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet weak var ProfilPhoto: UIImageView!
    
    
    var ProfileimagePicker : UIImagePickerController!

    var changeLable:Bool = false
    
    
    @IBAction func AddPhoto(_ sender: UIButton) {
        
        showChooseSourceTypeAlertController()
        
        ProfileimagePicker = UIImagePickerController()
        ProfileimagePicker.delegate = self
        ProfileimagePicker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            
            ProfileimagePicker.sourceType = .camera
            ProfileimagePicker.cameraCaptureMode = .photo
        }else {
            ProfileimagePicker.sourceType = .photoLibrary
        }
        
        self.present(ProfileimagePicker, animated: true, completion: nil)
        
        if changeLable{
            changeLable = false
            sender.setTitle("Add Profile Picture", for: .normal)
        }else {
            changeLable = true
            sender.setTitle("Edit Profile Picture", for: .normal)
        }
        
        
        

    }
    @IBOutlet weak var UserNameTextField: UITextField!
    
    @IBOutlet weak var LastNameTextField: UITextField!
    
    @IBOutlet weak var ContactNumberTextField: UITextField!
    
    @IBOutlet weak var emailAddressTextField: UITextField!
    
    @IBOutlet weak var PasswordTextField: UITextField!
    
    @IBOutlet weak var ErrorLable: UILabel!
    
    @IBAction func SignUpButton(_ sender: UIButton) {
        
        let error = validateFields()
        
        if error != nil {
            
            showError(error!)
        }else {
            let username = UserNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastname = LastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let contactnumber = ContactNumberTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailAddressTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let pass = PasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail: email, password: pass) { (result, err) in
                if  err != nil{
                    self.showError("Error creating user!")
                }else {
                    let db = Firestore.firestore()
                    db.collection("Users").addDocument(data: ["username":username,
                                                              "lastname":lastname,"contactnumber":contactnumber, "pass":pass, "uid":result!.user.uid ]){(error) in
                        if error != nil {
                            self.showError("Error saving user data!")
                        }
                    }
                }
            }
        }
    }
    func showError (_ message:String){
        ErrorLable.text = message
        ErrorLable.alpha = 1
        
    }
    
    func validateFields() -> String? {
        if UserNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            LastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            ContactNumberTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailAddressTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            PasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            
            return "Please fill all fields"
        }
        
        let passclean = PasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Validations.isPasswordValid(passclean) == false {
            return "Password should contain symbols and numbers"
        }
        
        
        return nil
    }
    
    func setUpElements(){
        ErrorLable.alpha = 0
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ProfilPhoto.layer.cornerRadius = 30
        ProfilPhoto.layer.cornerRadius = 5
        ProfilPhoto.layer.cornerRadius = ProfilPhoto.frame.size.width/2
        
        
        
        
        setUpElements()
        // Do any additional setup after loading the view.
    }

}
extension SignUpViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    func showChooseSourceTypeAlertController() {
        let photoLibraryAction = UIAlertAction(title: "Choose a Photo", style: .default) { (action) in
            self.showImagePickerController(sourceType: .photoLibrary)
        }
        let cameraAction = UIAlertAction(title: "Take a New Photo", style: .default) { (action) in
            self.showImagePickerController(sourceType: .camera)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        AlertService.showAlert(style: .actionSheet, title: nil, message: nil, actions: [photoLibraryAction, cameraAction, cancelAction], completion: nil)
    }
    
    
    func showImagePickerController(sourceType: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = sourceType
        present(imagePickerController, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {

          ProfilPhoto.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    
}

