//
//  RatingVC.swift
//  ApiTap
//
//  Created by AppZorro on 12/09/17.
//  Copyright © 2017 ApiTap. All rights reserved.
//

import UIKit
class getRatingListCell:UITableViewCell{
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet var star5: UIButton!
    @IBOutlet var star4: UIButton!
    @IBOutlet var star3: UIButton!
    @IBOutlet var star2: UIButton!
    @IBOutlet var star1: UIButton!
    @IBOutlet var nameLblVal: UILabel!
}
class getRatingsCell:UITableViewCell{
    
    @IBOutlet var currentReviewCell: UILabel!
    @IBOutlet var getRatingTblView: UITableView!
    
}
class ratingsCell:UITableViewCell{
    
    @IBOutlet var storeImgView: UIImageView!
    @IBOutlet var storeNameLbl: UILabel!
    @IBOutlet weak var starRatingBtn1: UIButton!
    @IBOutlet weak var starRatingBtn2: UIButton!
    @IBOutlet weak var starRatingBtn3: UIButton!
    @IBOutlet weak var starRatingBtn4: UIButton!
    @IBOutlet weak var starRatingBtn5: UIButton!
}

class reviewCell:UITableViewCell{
    
    
}
class commentCell:UITableViewCell{
    
    
    @IBOutlet var commentTxtView: UITextView!
}
class RatingVC: BaseViewController, UITableViewDataSource, UITableViewDelegate {
var myModel = ModelManager()
    @IBOutlet weak var ratingReviewTableView: UITableView!
    var merchantID:String = ""
    var merchantRating:String = ""
    var storeImgURL:URL!
    var storeNameStr:String = ""
    var ratingStr:String = ""
    var ratingDict:[[String:AnyObject]] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeNavBar()
        self.setbarButtonItems()
       print(merchantID)
        
        getRatingData()
        // Do any additional setup after loading the view.
    }

    @IBAction func backBtnPress(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func getRatingData(){
        dictParam["127.57"] = merchantID as AnyObject
        
        if let result = UserDefaults.standard.value(forKey: "loginUserID") as? String{
            loginUserId = result as! String
            print(result)
        }
        // dictParam["53"] = loginUserId as AnyObject
        
        myModel.addManager.getRatingWithDesc("010100104", userinfo: dictParam, completionResponse: { ( response,  error) in
            
            print(response)
             if let res = response as? [[String : AnyObject]]{
                for item in res{
                    if var ratings = item["RESULT"] as? [[String:AnyObject]]{
                        self.ratingDict = ratings
//                        for rati in ratings{
//                            if let mRating = rati["_121_80"] as? String{
//                            }
//                        }
                    }
                }
            }
            
            self.ratingReviewTableView.reloadData()
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func msgBtnClicked(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SearchMessagesVC") as! SearchMessagesVC
        vc.productId = TestClassStore.storeMerchantId
        vc.messageBool = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView.tag == 101{
            return 1
        }else{
        return 4
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 101{
            return self.ratingDict.count
        }else{
            return 1
        }
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 101{
            let cell = tableView.dequeueReusableCell(withIdentifier: "getRatingListCell", for: indexPath) as! getRatingListCell
            let item = ratingDict[indexPath.row]
            
            
            if let name = item["_120_83"] as? String{
                cell.nameLbl.text = name
            }
            if let name = item["_114_138"] as? String{
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-mm-dd HH:mm:ss"
                
                
                let result = formatter.date(from: name)
                let formatter2 = DateFormatter()
                formatter2.dateFormat = "dd MMM,yyyy"
                let dateStr = formatter2.string(from: result!)
                cell.dateLbl.text = dateStr
                
            
            
            }
            if let name = item["_114_3"] as? String{
                if let name2 = item["_114_5"] as? String{
                cell.nameLblVal.text = name + " " + name2
                }
            }
            if let name = item["_121_80"] as? String{
                if name == "1"{
                     cell.star1.setImage(UIImage(named:"yStar"), for: .normal)
               }
                if name == "2"{
                    cell.star1.setImage(UIImage(named:"yStar"), for: .normal)
                    cell.star2.setImage(UIImage(named:"yStar"), for: .normal)
                }
                if name == "3"{
                    cell.star1.setImage(UIImage(named:"yStar"), for: .normal)
                     cell.star2.setImage(UIImage(named:"yStar"), for: .normal)
                     cell.star3.setImage(UIImage(named:"yStar"), for: .normal)
                }
                if name == "4"{
                    cell.star1.setImage(UIImage(named:"yStar"), for: .normal)
                     cell.star2.setImage(UIImage(named:"yStar"), for: .normal)
                     cell.star3.setImage(UIImage(named:"yStar"), for: .normal)
                     cell.star4.setImage(UIImage(named:"yStar"), for: .normal)
                }
                if name == "5"{
                    cell.star1.setImage(UIImage(named:"yStar"), for: .normal)
                    cell.star2.setImage(UIImage(named:"yStar"), for: .normal)
                    cell.star3.setImage(UIImage(named:"yStar"), for: .normal)
                    cell.star4.setImage(UIImage(named:"yStar"), for: .normal)
                    cell.star5.setImage(UIImage(named:"yStar"), for: .normal)
                }
            }
            return cell
        }else{
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ratingsCell", for: indexPath) as! ratingsCell
            cell.storeImgView.sd_setImage(with: storeImgURL)
            
            cell.storeNameLbl.text = storeNameStr
            if ratingStr == "1"{
                cell.starRatingBtn1.setImage(UIImage(named:"yStar"), for: .normal)
            }
            if ratingStr == "2"{
                cell.starRatingBtn1.setImage(UIImage(named:"yStar"), for: .normal)
                cell.starRatingBtn2.setImage(UIImage(named:"yStar"), for: .normal)
            }
            if ratingStr == "3"{
                cell.starRatingBtn1.setImage(UIImage(named:"yStar"), for: .normal)
                cell.starRatingBtn2.setImage(UIImage(named:"yStar"), for: .normal)
                cell.starRatingBtn3.setImage(UIImage(named:"yStar"), for: .normal)
            }
            if ratingStr == "4"{
                cell.starRatingBtn1.setImage(UIImage(named:"yStar"), for: .normal)
                cell.starRatingBtn2.setImage(UIImage(named:"yStar"), for: .normal)
                cell.starRatingBtn3.setImage(UIImage(named:"yStar"), for: .normal)
                cell.starRatingBtn4.setImage(UIImage(named:"yStar"), for: .normal)
            }
            if ratingStr == "5"{
                cell.starRatingBtn1.setImage(UIImage(named:"yStar"), for: .normal)
                cell.starRatingBtn2.setImage(UIImage(named:"yStar"), for: .normal)
                cell.starRatingBtn3.setImage(UIImage(named:"yStar"), for: .normal)
                cell.starRatingBtn4.setImage(UIImage(named:"yStar"), for: .normal)
                cell.starRatingBtn5.setImage(UIImage(named:"yStar"), for: .normal)
            }
            return cell
        }
        if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "getRatingsCell", for: indexPath) as! getRatingsCell
            if self.ratingDict.count>0{
            cell.currentReviewCell.text = "Current Reviews-" + String(self.ratingDict.count)
            }
            cell.getRatingTblView.reloadData()
            return cell
        }
        if indexPath.section == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath) as! reviewCell
            
            return cell
        }
        if indexPath.section == 3{
            let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as! commentCell
            cell.commentTxtView.layer.borderWidth = 1.0
            cell.commentTxtView.layer.cornerRadius = 5.0
            cell.commentTxtView.layer.borderColor = UIColor.blue.cgColor
            return cell
        }
        }
       return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.tag == 101{
            return 70
        }else{
            if indexPath.section == 0{
                return 80
            }else if indexPath.section == 1{
                return 240
            }else if indexPath.section == 2{
                return 150
            }else {
                return 150
            }
        }
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view:UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.size.width, height: 1))
        view.backgroundColor = .lightGray
        
        return view
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1.0
    }
    
    var dictParam:[String:AnyObject]=[:]
    var rat:[[String:AnyObject]]=[]
    var loginUserId:String = ""
    @IBAction func submitBtnRating(_ sender: Any) {
        
        
        dictParam["127.57"] = merchantID as AnyObject
     
        if let result = UserDefaults.standard.value(forKey: "loginUserID") as? String{
            loginUserId = result as! String
     print(result)
        }
         dictParam["53"] = loginUserId as AnyObject
         dictParam["122.129"] = "2101" as AnyObject
        // dictParam["127.57"] = "0001202A000000000858" as AnyObject
        dictParam["120.83"] = "adjadjjasd" as AnyObject
        dictParam["120.157"] = "sadsad" as AnyObject
   
        
        myModel.addManager.getItemRating("030400103", userinfo: dictParam, completionResponse: { ( response,  error) in
            
            print(response)
            if let res = response as? [[String : AnyObject]]{
            self.rat = res
            for item in self.rat{
                if var ratings = item["RESULT"] as? [[String:AnyObject]]{
                    for rati in ratings{
                        if let mRating = rati["_121_80"] as? String{
                           // self.merchantId = mRating
                        }
                    }
                }
            }
            }
            self.ratingReviewTableView.reloadData()
        })
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
