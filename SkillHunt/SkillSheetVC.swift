//
//  SkillSheetVC.swift
//  SkillHunt
//
//  Created by Sai Prasad Ashila on 5/11/19.
//  Copyright © 2019 athywas. All rights reserved.
//

import UIKit
import Firebase

public class SkillSet : UITableViewCell{
    
    @IBOutlet weak var SkillLabel: UILabel!
    
    
    var skillOne : String = ""
    var skillTwo : String = ""
    var skillThree : String = ""
    
    
}

class SkillSheetVC: UIViewController {
    
    var imagurlfromHomeVC : URL!
//    var skillList : [SkillSet] = []
    var skillList : [String] = []
    
    @IBOutlet weak var Name: UILabel!
    var name : String = ""
    var FromHomeVC :String = ""
    let imageView = UIImageView()
    var db = Firestore.firestore()
    
    

    @IBOutlet weak var SkillTableView: UITableView!
    
    override func viewDidLoad() {
        
            self.Name.text = name
        
//        SkillTableView.estimatedRowHeight = 50
//        SkillTableView.contentInset = UIEdgeInsets(top: 300, left: 0, bottom: 0, right: 0)
//        SkillTableView.backgroundColor = UIColor.darkGray
        
        super.viewDidLoad()
        getSkills()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func OnClickViewProfile(_ sender: UIButton) {
        
        performSegue(withIdentifier: "goToProfileVC", sender: self)
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 300)
//        imageView.image = UIImage.init(named: "poster")
//        imageView.contentMode = .scaleAspectFill
//        imageView.clipsToBounds = true
//
//        return imageView
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SkillSheetVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return skillList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "Skillcell") as? SkillSet)!
       cell.SkillLabel.text = skillList[indexPath.row]
        return cell
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? ProfileViewVC{
            dest.imageURL = imagurlfromHomeVC
        }
    }
    
    func getSkills(){
        
        db.collection("Users").document(FromHomeVC).getDocument { (SkillSnapShot, error) in
            if error == nil{
                print("SkillSnapShot",SkillSnapShot?.data())
//                let Sk = SkillSet()
                let skone = SkillSnapShot?.get("SkillOne") as? String ?? ""
                self.skillList.append(skone)
                let sktwo = SkillSnapShot?.get("SkillTwo") as? String ?? ""
                self.skillList.append(sktwo)
                let skthree = SkillSnapShot?.get("SkillThree") as? String ?? ""
                self.skillList.append(skthree)
//                Sk.skillOne = SkillSnapShot?.get("SkillOne") as? String ?? ""
//                Sk.skillTwo =  SkillSnapShot?.get("SkillTwo") as? String ?? ""
//                Sk.skillThree =  SkillSnapShot?.get("SkillThree") as? String ?? ""
                
//                print("SkillSet",Sk.skillOne)
                
                
                self.SkillTableView.reloadData()
                
            }else{
                print("error retr",error)
            }
            
            
            
        }
        
    }
    
}
