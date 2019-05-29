//
//  RatingReviewVC.swift
//  ApiTap
//
//  Created by AppZorro on 12/09/17.
//  Copyright © 2017 ApiTap. All rights reserved.
//

import UIKit

class showDetailCell:UITableViewCell{
    
}
class ratingReviewCell:UITableViewCell{
    
}

class RatingReviewVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var goBtn: UIButton!

    @IBOutlet weak var ratingTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     // self.view.addSubview(goBtn)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else{
            return 5
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            let cell = ratingTableView.dequeueReusableCell(withIdentifier: "showDetailCell") as! showDetailCell
            
            return cell
        }
        
        if indexPath.section == 1{
            let cell = ratingTableView.dequeueReusableCell(withIdentifier: "ratingReviewCell") as! ratingReviewCell
            
            return cell
        }
        return UITableViewCell()
    }

    @IBAction func goBtnTapped(_ sender: Any) {
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section==0 {
            return 140
        } else {
           return 100
           }
        return 44

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "RatingVC") as! RatingVC
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
