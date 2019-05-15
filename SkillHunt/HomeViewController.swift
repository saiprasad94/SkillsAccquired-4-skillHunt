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
    var StudentName : String = ""
    var primarySkill : String = ""
    
}

    class HomeViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
        
        @IBOutlet weak var name: UILabel!
        
        var nameFromLoginVC : String = ""
        
        let imageView = UIImageView()
        
        let uid = Auth.auth().currentUser?.uid
        
        let userPhotoURL = Auth.auth().currentUser?.photoURL
        
        
        
        
        @IBOutlet weak var tableView: UITableView!
        
        
        
        override func viewDidLoad() {
            
            super.viewDidLoad()
            let userPhotoURL : URL = (Auth.auth().currentUser?.photoURL)!
            print("userphotoURl",userPhotoURL)
            
            name.text = nameFromLoginVC

            
            tableView.estimatedRowHeight = 50
            tableView.contentInset = UIEdgeInsets(top: 300, left: 0, bottom: 0, right: 0)
            tableView.backgroundColor = UIColor.darkGray
            
            imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 400)
            imageView.sd_setImage(with: userPhotoURL, completed: nil)
           // imageView.sd_setImage(with: URL(userPhotoURL), placeholderImage: UIImage(named: "ClickHere"))
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            view.addSubview(imageView)
//             Do any additional setup after loading the view.
        }
        
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 300)
            imageView.image = UIImage.init(named: "poster")
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            
            return imageView
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let y = 300 - (scrollView.contentOffset.y + 300)
            let height = min(max(y, 60), 400)
            imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: height)
        }
        
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
            
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "cell") as? Skill)!
        cell.skilledPersonName.text = "person1"
        
//        let userInfo = Auth.auth().currentUser?.providerData[indexPath.row]
//        cell.skilledPersonName?.text = userInfo?.providerID
        // Provider-specific UID
//        cell?.detailTextLabel?.text = userInfo?.uid
        
        return cell
       
    }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            
            performSegue(withIdentifier: "goToSkillSheet", sender: self)
            
        }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
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
