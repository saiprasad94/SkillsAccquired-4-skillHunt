//
//  ViewController.swift
//  SkillHunt
//
//  Created by Sai Prasad Ashila on 5/10/19.
//  Copyright © 2019 athywas. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    
    @IBOutlet weak var actionButton: UIButton!
    
    var action : Bool = true
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func toggleSwitch(_ sender: UISwitch) {
        
       
        if sender.isOn == true {
            actionButton.titleLabel?.text = "Login"
            action = true
        }
        else if sender.isOn == false {
            actionButton.titleLabel?.text = "Signup"
            action = false
        }
        
        
    }
    
    
    
    @IBAction func actionButton(_ sender: Any) {
        if action == true{
            print("in login mode")
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                if error == nil{
                    
                    let user = Auth.auth().currentUser
                    if let user = user {
                        // The user's ID, unique to the Firebase project.
                        // Do NOT use this value to authenticate with your backend server,
                        // if you have one. Use getTokenWithCompletion:completion: instead.
                        let uid = user.uid
                        let email = user.email
                        let photoURL = user.photoURL
                        
                        print("uid,email,photoURL" ,uid,";",email,";",photoURL)
                        // ...
                    }
                    
                    self.performSegue(withIdentifier: "toHomeVC", sender: self)
                    
                }
                else{
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
        else if action == false{
            print("in signup mode")
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!){ (user, error) in
                if error == nil {
                    
                    
                    self.performSegue(withIdentifier: "goToSignUpDetails", sender: self)
                    
                }
                else{
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                   
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                    
                    
                }
        }
        
    }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toHomeVC" {
            let dest = segue.destination as? HomeViewController
            dest?.nameFromLoginVC = emailTextField.text ?? "empty"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        actionButton.titleLabel?.text = "    Login   "
        // Do any additional setup after loading the view.
    }


}

