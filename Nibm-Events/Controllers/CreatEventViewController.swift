//
//  CreatEventViewController.swift
//  Nibm-Events
//
//  Created by Bryan Charles on 2/29/20.
//  Copyright © 2020 Bryan Charles. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import Firebase

class CreatEventViewController: UIViewController {
    
    var image: UIImage? = nil
    
    @IBOutlet weak var UserName: UITextField!
    @IBOutlet weak var EventNameTextField: UITextField!
    
    @IBOutlet weak var DescriptionTextField: UITextField!
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    var PosterImg : UIImagePickerController!
    
    @IBOutlet weak var ErrorLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkLogginStatus()
        setUpElements()
        getEventOwnerName()
        
    }
    
    @IBAction func PosterButton(_ sender: UIButton) {
        
        showChooseSourceTypeAlertController()
        
        PosterImg = UIImagePickerController()
        PosterImg.delegate = self
        PosterImg.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            
            PosterImg.sourceType = .camera
            PosterImg.cameraCaptureMode = .photo
        }else {
            PosterImg.sourceType = .photoLibrary
        }
        
        self.present(PosterImg, animated: true, completion: nil)
    
    }
    @IBAction func PublishEventButton(_ sender: UIButton) {
        
        guard let posterImage = self.image else{
            
            print("profile image nil")
            return
        }
        
        guard let imageData = posterImage.jpegData(compressionQuality: 0.4)else{
            
            return
        }
        
        
        let error = validateFields()
        if error != nil{
            showError(error!)
        }else {
            let eventField = EventNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let description =
            DescriptionTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let metadata = StorageMetadata()
            
            
            let db = Firestore.firestore()
            metadata.contentType = "image/jpg"
             let storageRef = Storage.storage().reference(forURL: "gs://nibm-events-b5f69.appspot.com/")
            
        guard let uid = Auth.auth().currentUser?.uid else{
            return
        }
            
            let storageProfileRef = storageRef.child("Events")
            
            storageProfileRef.putData(imageData, metadata: metadata) { (StorageMetaData, error) in
                
                if error != nil
                {
                    print(error?.localizedDescription)
                    return
                }
                
                storageProfileRef.downloadURL(completion: { (url, error) in
                    
                    if let metaImageUrl = url?.absoluteString{
                        db.collection("NewEvents").document().setData(["Eventname":eventField ,"description": description, "EventImageurl":metaImageUrl]) { (error) in
                            
                            
                            if error != nil {
                                
                                self.showError("Error when creating Event")
                            }else{
                                
                                self.redirectToHomeController()
                            }
                        }
                        print(metaImageUrl)
                    }
                })
            }
    }
}
    func redirectToHomeController(){
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Main")
        self.present(vc, animated: true, completion: nil)
    }
    
    fileprivate func checkLogginStatus(){
        if Auth.auth().currentUser == nil{
            
            DispatchQueue.main.async {
                let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login")
                self.present(viewController, animated: true, completion: nil)
                
                return
            }
        }
        
    }

    func validateFields() -> String? {
        if
            EventNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
                DescriptionTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            
            return "Please fill all fields"
        }
        return nil
    }
    func setUpElements(){
        ErrorLable.alpha = 0
    }
    func showError (_ message:String){
        ErrorLable.text = message
        ErrorLable.alpha = 1
        
    }
    
    func getEventOwnerName(){
        
        guard let uid = Auth.auth().currentUser?.uid else{ return }
        
        let db = Firestore.firestore()
        
        let docRef = db.collection("users").document(uid)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
            
                self.UserName.text = (document.get("firstname") as! String)
                
            } else {
                print("Document does not exist")
            }
        }
        
    }
    

}
extension CreatEventViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
        if let posterImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            
            image = posterImage
            imageView.image = posterImage
        }
        dismiss(animated: true, completion: nil)
    }
}
