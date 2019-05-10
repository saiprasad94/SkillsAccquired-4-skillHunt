//
//  HomeViewController.swift
//  SkillHunt
//
//  Created by Sai Prasad Ashila on 5/10/19.
//  Copyright © 2019 athywas. All rights reserved.
//

import UIKit

class Skill : UITableViewCell{
    
    @IBOutlet weak var skilledPersonName: UILabel!
    var StudentName : String = ""
    var primarySkill : String = ""
    
}

    class HomeViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "cell") as? Skill)!
        cell.skilledPersonName.text = "person1"
        
        return cell
       
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

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
