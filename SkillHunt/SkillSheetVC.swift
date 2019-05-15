//
//  SkillSheetVC.swift
//  SkillHunt
//
//  Created by Sai Prasad Ashila on 5/11/19.
//  Copyright © 2019 athywas. All rights reserved.
//

import UIKit

class SkillSet : UITableViewCell{
    
    @IBOutlet weak var SkillLabel: UILabel!
    
    
}

class SkillSheetVC: UIViewController {
    
    let imageView = UIImageView()

    @IBOutlet weak var SkillTableView: UITableView!
    
    override func viewDidLoad() {
        
//        SkillTableView.estimatedRowHeight = 50
//        SkillTableView.contentInset = UIEdgeInsets(top: 300, left: 0, bottom: 0, right: 0)
//        SkillTableView.backgroundColor = UIColor.darkGray
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "Skillcell") as? SkillSet)!
//        cell.SkillLabel.text = "skill1"
        return cell
    }
    
    
    
}
