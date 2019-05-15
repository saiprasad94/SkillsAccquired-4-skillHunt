//
//  SignUPVC.swift
//  SkillHunt
//
//  Created by Sai Prasad Ashila on 5/13/19.
//  Copyright © 2019 athywas. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage


class SignUPVC: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet var TextFields: [UITextField]!
    
    @IBOutlet weak var editImageView: UIImageView!
    
    var dispName : String = ""
    var db = Firestore.firestore()
    var ref : DocumentReference!
    var useremail : String = ""
    
    
    
    @IBAction func update(_ sender: UIButton) {
        print(" update clicked")
        db.collection("Users").document(useremail).setData([
            "username": editDisplayName.text!,
            "SkillOne": editSkillOne.text!,
            "SkillTwo": editSkillTwo.text!,
            "SkillThree": editSkillThree.text!
            ])
        
        let storageRef = Storage.storage().reference().child("Image.png")
        let imgData = editImageView.image?.pngData()
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        storageRef.putData(imgData!, metadata: metaData) { (metaData, error) in
            if error == nil{
                print("upload sucessfull")
                storageRef.downloadURL(completion: { (url, error) in
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.photoURL = url
                    let  unwrappedURLvar = url?.absoluteString
                    
                    let warppedString = unwrappedURLvar
                    var URLvar = ""
                    if let unvindURLvar = warppedString {
                        URLvar = unvindURLvar
                        print(URLvar)
                    }
                        print("url is: ",URLvar)
                    self.db.collection("Users").document(self.useremail).setData(["imageUrl":URLvar ], merge: true)
                    changeRequest?.displayName = self.editDisplayName.text
                    changeRequest?.commitChanges(completion: { (error) in
                        if error == nil{
                            print("updATE SUCESSFUL")
                        }
                        else{
                            print("update unsuccessfull")
                        }
                    })
                })
            }else{
                print("error in ", error)
            }
        }
        
    }
    
    
    @IBOutlet weak var editDisplayName: UITextField!
    @IBOutlet weak var editSkillOne: UITextField!
    @IBOutlet weak var editSkillTwo: UITextField!
    @IBOutlet weak var editSkillThree: UITextField!
    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.editDisplayName.delegate = self
        self.editSkillOne.delegate = self
        self.editSkillTwo.delegate = self
        self.editSkillThree.delegate = self
        
        self.editDisplayName.text = dispName
        
        if let userem = Auth.auth().currentUser?.email{
            useremail = userem
        }
        
//        editImageView.image =  UIImage(named: "ClickHere")
        
        //        let img = editImageView.image = UIImage(contentsOfFile: "ClcikHere")
                if let img = Auth.auth().currentUser?.photoURL {
                    editImageView.sd_setImage(with: img, completed: nil)
                }else{
                    editImageView.image = UIImage(named: "ClickHere")
                }
        editImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageClicked)))
        editImageView.isUserInteractionEnabled = true
        
        // Do any additional setup after loading the view.
    }

}

extension SignUPVC : UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @objc func imageClicked(){
        print("imageClicked")
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
         present(picker, animated: true, completion: nil)
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("info",info)
        
        //let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        // changeRequest?.photoURL = info[UIImagePickerController.InfoKey.imageURL] as? URL
        if info[UIImagePickerController.InfoKey.originalImage] != nil {
            editImageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            
        }
//        changeRequest?.commitChanges { (error) in
//            print("encountered error: ",  error ?? "")
//        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("cacneled")
        dismiss(animated: true, completion: nil)
    }
}
