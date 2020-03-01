//
//  UserProfileViewController.swift
//  Nibm-Events
//
//  Created by Bryan Charles on 3/1/20.
//  Copyright © 2020 Bryan Charles. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import Firebase
import LocalAuthentication


class UserProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var Profilephoto: UIImageView!
    
    
    @IBAction func EditPicButton(_ sender: UIButton) {
    }
    
    @IBOutlet weak var FirstnameTxt: UILabel!
    
    @IBOutlet weak var LastnameTxt: UILabel!
    
    @IBOutlet weak var ContactNumberTxt: UILabel!
    
    @IBOutlet weak var EmailTxt: UILabel!
    
    @IBOutlet weak var PassTxt: UILabel!
    
    @IBAction func LogoutButton(_ sender: UIButton) {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Main")
        self.present(vc, animated: true, completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Profilephoto.layer.cornerRadius = 30
        Profilephoto.layer.cornerRadius = 5
        Profilephoto.layer.cornerRadius = Profilephoto.frame.size.width/2
        
        
        
        view.backgroundColor = UIColor.white
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign out", style: .done, target: self, action: #selector(handleSignOutButtonTapped))
        
        checkLoggedInUserStatus()
        
    }
    @objc fileprivate func handleFaceIdTouchId(){
        
        let context = LAContext()
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil){
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "To have an access to NIBM Events we need to check your faceId/TouchID") { (wasSuccessful, error) in
                if wasSuccessful{
                    
                    self.dismiss(animated: true, completion:nil)
                    
                    
                }else{
                    Alert.showBasics(title: "Incorrect credentials", msg: "Please try again", vc: self)
                }
            }
            
        }else{
            Alert.showBasics(title: "FaceID/TouchID is not configured", msg: "Please go to settings", vc: self)
        }
        
    }
    
    
    @objc func handleSignOutButtonTapped(){
        
        UserDefaults.standard.removeObject(forKey: "userLogIn")
        UserDefaults.standard.removeObject(forKey: "userId")
        UserDefaults.standard.removeObject(forKey: "userLogged")
        UserDefaults.standard.synchronize()
        
        do{
            try Auth.auth().signOut()
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Main")
            self.present(vc, animated: true, completion: nil)
            
        }catch let err{
            
            print("Failed to sign out with error",err)
            
            
        }
        
    }
    
    fileprivate func checkLoggedInUserStatus(){
        if Auth.auth().currentUser == nil{
            
            DispatchQueue.main.async {
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login")
                self.present(vc, animated: true, completion: nil)
                
                return
            }
        }else{
            
            
            handleFaceIdTouchId()
            retriveUserData()
        }
        
    }
    func retriveUserData(){
        
        guard let uid = Auth.auth().currentUser?.uid else{ return }
        
        print(uid)
        
        let db = Firestore.firestore()
        
        let docRef = db.collection("Users").document(uid)
        
        print(docRef)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
                
                
                
                self.FirstnameTxt.text = (document.get("username") as! String)
                self.LastnameTxt.text = (document.get("lastname") as! String)
                self.ContactNumberTxt.text = (document.get("contactnumber" ) as! String)
//                self.EmailTxt.text = (document.get("email") as! String)
//                let profile = (document.get("profileimageurl") as! String)
//                self.Profilephoto.setImage(with: URL(string: profile), placeholder: nil, options: [.transition(.fade(0.7))], progressBlock: nil)
                
            } else {
                print("Document does not exist")
            }
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
