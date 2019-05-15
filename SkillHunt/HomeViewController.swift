//
//  HomeViewController.swift
//  SkillHunt
//
//  Created by Sai Prasad Ashila on 5/10/19.
//  Copyright © 2019 athywas. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class Skill : UITableViewCell{
    
    @IBOutlet weak var skilledPersonName: UILabel!
    @IBOutlet weak var primarySkillOne: UILabel!
    @IBOutlet weak var displayImageView: UIImageView!
    
    var StudentName : String = ""
    var primarySkill : String = ""
//    var imageUrl = URL(fileURLWithPath: "")
    var imageUrl = ""
    var id = ""
    
}
var db = Firestore.firestore()
var ref : DocumentReference!

    class HomeViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
        
        @IBOutlet weak var name: UILabel!
        
        var nameFromLoginVC : String = ""
        var userList : [Skill] = []
        var toSkillSheetVC : String = ""
        var NametoSkillSheetVC : String = ""
        
        let imageView = UIImageView()
        
        let uid = Auth.auth().currentUser?.uid
        
        let userPhotoURL = Auth.auth().currentUser?.photoURL
        
        
        
        
        @IBOutlet weak var tableView: UITableView!
        
        
        
        override func viewDidLoad() {
            
            super.viewDidLoad()
            getUsers()
            if let userPhotoURL : URL = (Auth.auth().currentUser?.photoURL){
                
            }
//            let userPhotoURL : URL = URL(fileURLWithPath: "https://firebasestorage.googleapis.com/v0/b/skillhunt-bb788.appspot.com/o/Image.png?alt=media&token=30e660ed-1804-42a0-870c-0728d21ac340")
            //print("userphotoURl",userPhotoURL)
            
            name.text = nameFromLoginVC

            
//            tableView.estimatedRowHeight = 50
            tableView.contentInset = UIEdgeInsets(top: 215, left: 0, bottom: 0, right: 0)
            tableView.backgroundColor = UIColor.darkGray
            
            imageView.frame = CGRect(x: 0, y: 150, width: UIScreen.main.bounds.size.width, height: 220)
        

            imageView.sd_setImage(with: userPhotoURL, completed: nil)
//            imageView.sd_setImage(with: "<#T##URL?#>", completed: nil)
//           // imageView.sd_setImage(with: URL(userPhotoURL), placeholderImage: UIImage(named: "ClickHere"))
//            imageView.contentMode = .scaleAspectFill
//            imageView.clipsToBounds = true
            view.addSubview(imageView)
//             Do any additional setup after loading the view.
        }
        
//        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//            imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 300)
//            //imageView.image = UIImage.init(named: "poster")
//            imageView.contentMode = .scaleAspectFill
//            imageView.clipsToBounds = true
//
//            return imageView
//        }
//
//        func scrollViewDidScroll(_ scrollView: UIScrollView) {
//            let y = 300 - (scrollView.contentOffset.y + 300)
//            let height = min(max(y, 60), 300)
//            imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: height)
//        }
//        
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
            
        
    }
        
        func getUsers(){
            
            
            db.collection("Users").getDocuments() { (UserSnapshot, error) in
                if error == nil{
                    var count = 0
                    for user in UserSnapshot!.documents{
                        print("user", user.data())
                        let sk = Skill()
                        
                        self.toSkillSheetVC = user.get("email") as? String ?? ""
                        sk.StudentName = user.get("username") as? String ?? ""
                        sk.primarySkill = user.get("SkillOne") as? String ?? ""
                        sk.imageUrl = user.get("imageUrl") as? String ?? ""
//                        sk.imageUrl = URL(fileURLWithPath: user.get("imageUrl") as? String ?? "" )
                        print("urlretrived is:",sk.imageUrl)
                        //sk.imageUrl.appendPathComponent(user.get("imageUrl")) =
                        print("student name",sk.StudentName)
                        self.userList.append(sk)
                        print("getuserlist",self.userList[count].StudentName)
//                        sk.primarySkill.text = user.get("SkillOne")
                        
                        count += 1
                    }
                    print("userlist count",self.userList.count)
                }
                else{
                    print("encountered error" , error)
                }
                self.tableView.reloadData()
            }
            
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "cell") as? Skill)!
        print("userlist",userList[indexPath.row].StudentName)
        
        
        
        cell.skilledPersonName.text = userList[indexPath.row].StudentName
        cell.primarySkillOne.text = userList[indexPath.row].primarySkill
//        cell.imageView?.sd_setImage(with: userList[indexPath.row].imageUrl , completed: nil)
        cell.displayImageView.image = UIImage(contentsOfFile: userList[indexPath.row].imageUrl)
        //cell.imageView?.image = UIImage(named: "ClickHere")
        print("imageSize",cell.displayImageView.image?.size)
       // tableView.reloadData()
        
//        let userInfo = Auth.auth().currentUser?.providerData[indexPath.row]
//        cell.skilledPersonName?.text = userInfo?.providerID
        // Provider-specific UID
//        cell?.detailTextLabel?.text = userInfo?.uid
        
        return cell
       
    }
        
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            NametoSkillSheetVC = userList[indexPath.row].StudentName
            performSegue(withIdentifier: "goToSkillSheet", sender: self)
            
//            toSkillSheetVC = indexPath.row
            
            
        }
        
                override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                    if let dest = segue.destination as? SignUPVC {
                        dest.dispName = Auth.auth().currentUser?.displayName ?? "set Username"
                    }
                    if let dest = segue.destination as? SkillSheetVC{
                        dest.FromHomeVC = toSkillSheetVC
                        dest.name = NametoSkillSheetVC
                    }

        }
        
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
//
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
