//
//  SearchMessageVC.swift
//  ApiTap
//
//  Created by AppZorro on 14/09/17.
//  Copyright © 2017 ApiTap. All rights reserved.
//

import UIKit

class messageCell:UITableViewCell{
    
}
class searchMessageCell:UITableViewCell{
    
}
class SearchMessageVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var searchMessageTableView: UITableView!
    var myModel = ModelManager()
    
    var dictParam:[String:AnyObject]=[:]
 
    var loginUserId:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        if let result = UserDefaults.standard.value(forKey: "loginUserID") as? String{
            loginUserId = result as! String
            print(result)
        }
        dictParam["53"] = loginUserId as AnyObject
        dictParam["114.9"] = "true" as AnyObject
        dictParam["120.16"] = "96" as AnyObject
        
        myModel.addManager.getItemRating("010100209", userinfo: dictParam, completionResponse: { ( response,  error) in
            
            print(response)
            
            
        })
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }
        if section == 1{
            return 5
        }
        
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            let cell = searchMessageTableView.dequeueReusableCell(withIdentifier: "messageCell") as! messageCell
            
            return cell
        }
        
        if indexPath.section == 1{
            let cell = searchMessageTableView.dequeueReusableCell(withIdentifier: "searchMessageCell") as! searchMessageCell
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section==0 {
            return 140
        } else if indexPath.section==1{
            return 100
        }else{
            return 350
        }
        return 44
        
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
