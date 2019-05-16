//
//  ProfileViewVC.swift
//  SkillHunt
//
//  Created by Sai Prasad Ashila on 5/15/19.
//  Copyright © 2019 athywas. All rights reserved.
//

import UIKit

class ProfileViewVC: UIViewController {
    
    
    var imageURL : URL!
    
    @IBOutlet weak var imageViewDP: UIImageView!
    @IBOutlet weak var DisplayName: UILabel!
    @IBOutlet weak var SkillOne: UILabel!
    @IBOutlet weak var SkillTwo: UILabel!
    @IBOutlet weak var SkillThree: UILabel!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print("image url in profileVC",imageURL)
        
        if let imgURL : URL = imageURL{
            
            print("imageSize",imgURL)
            imageViewDP.sd_setImage(with: imgURL, completed: nil)
        }

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
