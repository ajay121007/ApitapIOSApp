//
//  AddDetailViewController.swift
//  ApiTap
//
//  Created by Ashish on 30/10/17.
//  Copyright © 2017 ApiTap. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class addsCell:UITableViewCell{
    @IBOutlet var addNameLbl:UILabel!
    @IBOutlet var addImageView:UIImageView!
    @IBOutlet weak var playBtn: UIButton!
}

class AddDetailViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    var myModel = ModelManager()
    var headerBtns = [UIButton]()
    
    @IBOutlet weak var addTblView: UITableView!
     //var urlImage:String = "http://209.46.35.217:8085/ServerImage/images/"
    var dictparam:[String:AnyObject]=[:]
    var loginUserId:String = ""
    var addDict:[String:[AnyObject]]=[:]
    var addArr:[[String:AnyObject]]=[]
    var urlImage:String = "http://209.46.35.217:8085/ServerImage/images/"
    var urlVideos:String = "http://209.46.35.217:8085/ServerImage/videos/"
    var categoryData:String = ""
    var categoryDict:[String:[[String:AnyObject]]] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeNavBar()
        self.setbarButtonItems()
        self.navigationController?.navigationBar.isHidden = false
        if let result = UserDefaults.standard.value(forKey: "loginUserID") as? String{
            loginUserId = result as! String
            print(result)
        }
        dictparam["53"] = loginUserId as AnyObject
        myModel.addManager.callMainDict(forHistory: "010200517", userinfo: dictparam, completionResponse: { ( response,  error) in
            print(response)
            if let res:[[String:AnyObject]]=response as? [[String:AnyObject]]{
                for items in res{
                    if let images = items["RESULT"] as? [[String:AnyObject]]{
                        
                        for item in images{
                            if let add = item["_121_170"] as? String{
                                let url =  self.urlImage.appending(add as String)
                                if let url = NSURL(string: url){
                                    self.addDict["addImage"] = [url as AnyObject]
                                }
                            }
                            if let videoStr = item["_121_15"] as? String{
                                if videoStr != ""{
                                 let url =  self.urlVideos.appending(videoStr as String)
                                self.addDict["video"] = [url as AnyObject]
                                }
                            }
                            if let detail = item["_120_157"] as? String{
                                self.addDict["detail"] = [detail as AnyObject]
                            }
                            if let productId = item["_121_18"] as? String{
                                self.addDict["productId"] = [productId as AnyObject]
                            }
                            if let productId = item["_120_45"] as? String{
                                self.categoryData = productId
                            }
                            if let productId = item["_114_70"] as? String{
                                self.addDict["storeName"] = [productId as AnyObject]
                            }
                            if let name = item["_120_83"] as? String{
                                self.addDict["name"] = [name as AnyObject]
                            }
                            
                            if var name = item["_121_77"] as? String{
                                name = self.urlImage.appending(name)
                                
                                self.addDict["storeImage"] =  [name as AnyObject]
                            }
                            if let iR = item["IR"] as? [[String:AnyObject]]{
                                for relatedImages in iR{
                                    
                                    if let allPrice = relatedImages["_114_144"] as? String{
                                        if self.addDict["_114_144"] == nil{
                                            self.addDict["_114_144"] = [allPrice as AnyObject]
                                        }else{
                                            self.addDict["_114_144"]?.append(allPrice as AnyObject)
                                        }
                                    }
                                    if let allPrice = relatedImages["_114_98"] as? String{
                                        if self.addDict["relatedItemPrice"] == nil{
                                            self.addDict["relatedItemPrice"] = [allPrice as AnyObject]
                                        }else{
                                            self.addDict["relatedItemPrice"]?.append(allPrice as AnyObject)
                                        }
                                    }
                                    
                                    
                                    if let allName = relatedImages["_120_83"] as? String{
                                        if self.addDict["relatedItemname"] == nil{
                                        self.addDict["relatedItemname"] = [allName as AnyObject]
                                        }else{
                                           self.addDict["relatedItemname"]?.append(allName as AnyObject)
                                        }
                                    }
                                    
                                    if let allIRImages = relatedImages["_121_170"] as? String{
                                        if self.addDict["relatedImages"] == nil{
                                            let url =  self.urlImage.appending(allIRImages as String)
                                            if let url = NSURL(string: url) {
                                                self.addDict["relatedImages"] = [url as AnyObject]
                                                // self.imageDetailUrl.append(url as URL)
                                                
                                            }
                                        }
                                            
                                        else{
                                            let url =  self.urlImage.appending(allIRImages as String)
                                            if let url = NSURL(string: url) {
                                                self.addDict["relatedImages"]?.append(url as AnyObject)
                                            }
                                        }
                                    }
                                }
                                self.addArr.append(self.addDict as [String : AnyObject])
                                if self.categoryDict.isEmpty{
                                    self.categoryDict[self.categoryData] = [self.addDict as Dictionary<String, AnyObject>]
                                    print(self.categoryDict)
                                }else{
                                    if self.categoryDict.keys.contains(where: { (categoryData) -> Bool in
                                        
                                        self.categoryDict[self.categoryData]?.append(self.addDict as [String : AnyObject])
                                        print(self.categoryDict)
                                        
                                        return true
                                    }){
                                        self.categoryDict[self.categoryData] = [self.addDict as Dictionary<String, AnyObject>]
                                        print(self.categoryDict)
                                    }
                                }
                               
                            }
                            
                        }
                        for i in 0...self.categoryData.count
                        {
                            print(i)
                            let btn = UIButton(frame: CGRect(x: self.view.frame.width-40, y: 5, width: 20, height: 20))
                            btn.setImage(#imageLiteral(resourceName: "arrowup"), for: .normal)
                            btn.tag = i
                            btn.addTarget(self, action: #selector(self.buttonAction(sender:)), for: UIControlEvents.touchUpInside)
                            self.headerBtns.append(btn)
                        }
                        
                    }
                }
            }
            DispatchQueue.main.async {
                self.addTblView.reloadData()
            }
        })
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
      //  let cell = addTblView.dequeueReusableCell(withIdentifier: "addsCell") as! addsCell
        let cell = addTblView.dequeueReusableCell(withIdentifier:  "addsCell", for: indexPath) as! addsCell
       // if addArr.count>indexPath.row{
      noDuplicates(addArr)
        
       // var sets = NSSet(array: addArr)
        let data:[String:[AnyObject]] = addArr[indexPath.row] as! [String : [AnyObject]]
            
        
        
                if let url = data["addImage"] as? [URL]{
                    for element in url{
                        if let url = data["video"] as? [String]{
                            for elements in url{
                                if elements != ""{
                                    cell.playBtn.isHidden=false
                                }else{
                                    cell.playBtn.isHidden=true
                                }
                        }
                        }else{
                            cell.playBtn.isHidden=true
                        }
                        cell.addImageView.sd_setImage(with: element)
//                        cell.addImageView.layer.borderWidth = 1
//                        cell.addImageView.layer.borderColor = UIColor(red: 220/256.0, green: 220/256.0, blue: 220/256.0, alpha: 1.0).cgColor
//                        cell.addImageView.layer.cornerRadius = 3.0
//                        cell.addImageView.clipsToBounds = true
//
//                        cell.addImageView.layer.masksToBounds = false
//                        cell.addImageView.layer.shadowColor = UIColor.lightGray.cgColor
//                        cell.addImageView.layer.shadowOpacity = 0.3
//                        cell.addImageView.layer.shadowOffset = CGSize(width: -1, height: 1)
//                        cell.addImageView.layer.shadowRadius = 1
//
//                        cell.addImageView.layer.shadowPath = UIBezierPath(rect: cell.bounds).cgPath
//                        cell.addImageView.layer.shouldRasterize = true
//                        cell.addImageView.layer.rasterizationScale = 1
                        cell.addImageView.SetCellProparty()
                    }
                
        }
     //   }
                if let name = data["name"] as? [String]{
                    for element in name{
                        cell.addNameLbl.text = self.hexToStr(textValue: element)
                    }
                }
                
           
        return cell
          
     
        
    }
    
    func noDuplicates(_ arrayOfDicts: [[String: AnyObject]]) -> [[String: AnyObject]] {
        var noDuplicates = [[String: AnyObject]]()
         var noDuplicatesArr = [[String: String]]()
        var usedNames:[String] = []
        noDuplicatesArr = noDuplicates as! [[String : String]]
        for dict in noDuplicatesArr {
            if let name = dict["name"], !usedNames.contains(name) {
                noDuplicates.append(dict as [String : AnyObject])
                usedNames.append(name as! String ?? "")
            }
        }
        return noDuplicates
    }
    var didSelectRow: (([String : [AnyObject]]) -> ())?
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
          let  items  = self.addArr[indexPath.row]
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddDetailVC") as! AddDetailVC
       
        vc.addDetail = items as! [String : [AnyObject]]
        didSelectRow?(items as! [String : [AnyObject]])
        self.navigationController?.pushViewController(vc, animated: false)
        
        
        }
            
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   // return self.categoryDict.values.count
        for item in self.categoryDict{
            print(item.value.count)
            if isBool[section]
            {
            if  self.categoryDict.count > section {
                if item.value.count > section  {
                if let valu = item.value[section] as? [String:AnyObject]{
                return valu.values.count
                    }
                }
            }
            }else{
                return 0
            }
            
//            for val in item.value{
//                return val.values.count
//            }
                ///return self.addArr.count
        }
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.categoryDict.count
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        
        let headerView = UIView()
        headerView.frame = CGRect(x: 10, y: 0, width: addTblView.frame.size.width-20, height: 30)
        headerView.backgroundColor = appColor
        
        var lblTitle = UILabel()
        if section == 0
        {
            lblTitle.text = "Ads"
        }
        else if section == 1
        {
            lblTitle.text = "Stores"
        }
        else
        {
            lblTitle.text = "Favourites"
        }
        
        lblTitle.frame = CGRect(x: 5, y: 5, width: addTblView.frame.size.width, height: 20)
        lblTitle.textColor = UIColor.white
        headerView.addSubview(lblTitle)
        

        headerView.addSubview(headerBtns[section])
        return headerView
    }
      var isBool = [true,true]
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    @objc func buttonAction(sender: UIButton!)
    {
        if isBool[sender.tag] == false {
            isBool[sender.tag] = true
            addTblView.reloadData()
            sender.setImage(#imageLiteral(resourceName: "arrowup"), for: .normal)
        } else {
            isBool[sender.tag] = false
            addTblView.reloadData()
            sender.setImage(#imageLiteral(resourceName: "arrowdown"), for: .normal)

        }
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
