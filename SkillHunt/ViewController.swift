//
//  ViewController.swift
//  SkillHunt
//
//  Created by Sai Prasad Ashila on 5/10/19.
//  Copyright © 2019 athywas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var actionButton: UIButton!
    
    var action : Bool = true
    
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
            performSegue(withIdentifier: "toHomeVC", sender: self)
        }
        else if action == false{
            print("in signup mode")
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        actionButton.titleLabel?.text = "    Login   "
        // Do any additional setup after loading the view.
    }


}

