//
//  SpecialVC.swift
//  ApiTap
//
//  Created by Ashish on 19/12/17.
//  Copyright © 2017 ApiTap. All rights reserved.
//

import UIKit


class specialCollecionCell:UICollectionViewCell{
    
    @IBOutlet weak var viewOuter: UIView!
    @IBOutlet weak var favItemPrice: UILabel!
    @IBOutlet weak var favItemImageView: UIImageView!
    @IBOutlet weak var favNameLbl: UILabel!
}
class specialItemsCell:UITableViewCell{
    
    @IBOutlet weak var favItemNameLbl: UILabel!
    @IBOutlet weak var specialCollectionView: UICollectionView!
}

class SpecialVC: BaseViewController,UITableViewDelegate,UITableViewDataSource {

    
    @IBOutlet var filterBtnView: UIView!
    @IBOutlet var filterTitleView: UIView!
    @IBOutlet var sortspecialItemView: UIView!
    @IBOutlet weak var progressView: UIActivityIndicatorView!
    @IBOutlet weak var hiddenView: UIView!
    var itemCout = 0;
    var item = 0;
    var count = 0;
    var itemPriceArray:[String]=[]
    var itemNameArray:[String]=[]
    var myModel = ModelManager()
    var dictparam:[String:AnyObject]=[:]
    var loginUserId:String = ""
    var imgArr:[String]=[]
    var urlImage:String = "http://209.46.35.217:8085/ServerImage/images/"
    var imageUrl:[String]=[]
    var favImgUrl:[URL]=[]
    var favItemArrDict:[[String:AnyObject]]=[]
    var favItemDict:[String:AnyObject]=[:]
    var favItemDictArr:[String:[AnyObject]]=[:]
    var ct:Int=0
    var rowsCountDict:[[String:AnyObject]]=[]
    @IBOutlet weak var specialItemTblView: UITableView!
    @IBOutlet weak var categoryNameLbl: UILabel!
    
    @IBOutlet var sortTitletextLbl: UILabel!
    
    
    override func viewDidLoad() {
        filterTitleView.edigeRadius()
        filterBtnView.edigeRadius()
        progressView.startAnimating()
        categoryNameLbl.layer.masksToBounds = true
        categoryNameLbl.layer.cornerRadius = 5
        if let result = UserDefaults.standard.value(forKey: "loginUserID") as? String{
            loginUserId = result as! String
            print(result)
        }
        getProgress()
        // setLoadingScreen()
      
       // self.initializeNavBar()
       // self.setbarButtonItems()oldDb
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let dateString = dateFormatter.string(from:Date())
        print(dateString)
        
        var specialDict:[String:AnyObject]=[:]
        specialDict["53"] = loginUserId as AnyObject
        specialDict["121.141"]=dateString as AnyObject
        specialDict["127.89"]="3" as AnyObject
        getData(dataArray:specialDict)
        
        
        // Do any additional setup after loading the view.
    }
    func getProgress(){
        hiddenView.isHidden = false
        hiddenView.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
        specialItemTblView.isUserInteractionEnabled = false
    }
    func  getData(dataArray:[String:AnyObject]){
    myModel.addManager.getItemsSpecials(byCategoryMobile: "010400479", userinfo: dataArray, completionResponse: { ( response,  error) in
        
        print(response)
        if let favDict:[[String:AnyObject]]=response as? [[String:AnyObject]]{
            self.rowsCountDict = favDict
            for item in favDict{
                // if let result = item["RESULT"] as? [[String:AnyObject]]{
                // for pc in result{
                
                if let arrNam = item["_120_45"] as? String{
                    self.itemNameArray.append(arrNam)
                    if self.favItemDictArr["name"] == nil{
                        self.favItemDictArr["name"] = [arrNam  as AnyObject]
                    }else{
                        self.favItemDictArr["name"]?.append(arrNam as AnyObject)
                    }
                    // self.favItemDict["name"] = arrNam as AnyObject
                }
                
                if let resultPC = item["PC"] as? [[String:AnyObject]]{
                    //self.rowsCountDict.append(resultPC)
                    for pcItem in resultPC{
                        if let resultSP = pcItem["_121_170"] as? String{
                            
                            if self.favItemDictArr["image"] == nil{
                                let url =  self.urlImage.appending(resultSP as String)
                                if let url = NSURL(string: url) {
                                    self.favItemDictArr["image"] = [url as AnyObject]
                                    // self.imageDetailUrl.append(url as URL)
                                    
                                }
                            }
                            else{
                                let url =  self.urlImage.appending(resultSP as String)
                                if let url = NSURL(string: url) {
                                    self.favItemDictArr["image"]?.append(url as AnyObject)
                                }
                            }
                            
                            if let price = pcItem["_120_83"] as? String{
                                if self.favItemDictArr["itemName"] == nil{
                                    self.favItemDictArr["itemName"] = [price  as AnyObject]
                                }else{
                                    self.favItemDictArr["itemName"]?.append(price as AnyObject)
                                    
                                }
                                // }
                                
                            }
                            if let productId = pcItem["_114_144"] as? String{
                                if self.favItemDictArr["productId"] == nil{
                                    self.favItemDictArr["productId"] = [productId  as AnyObject]
                                }else{
                                    self.favItemDictArr["productId"]?.append(productId as AnyObject)
                                    
                                }
                                // }
                                
                            }
                            // if let resultSP = pcItem["SP"] as? [String:AnyObject]{
                            if let price = pcItem["_114_98"] as? String{
                                if self.favItemDictArr["price"] == nil{
                                    self.favItemDictArr["price"] = [price  as AnyObject]
                                }else{
                                    self.favItemDictArr["price"]?.append(price as AnyObject)
                                    
                                }
                                // }
                                
                            }
                            
                        }
                    }
                    
                }
                self.favItemArrDict.append(self.favItemDictArr as [String : AnyObject])
                self.favItemDictArr.removeAll()
                
            }
            
            //  }
            
            //}
        }
        DispatchQueue.main.async {
           // hiddenView.isHidden = true
            self.sortspecialItemView.isHidden = true
            self.progressView.stopAnimating()
            self.progressView.isHidden=true
            self.hiddenView.isHidden = true
            self.specialItemTblView.isUserInteractionEnabled = true
            self.specialItemTblView.reloadData()
        }
        
    })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.0
    }
    var tagIndex:Int = 0
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = specialItemTblView.dequeueReusableCell(withIdentifier: "specialItemsCell") as! specialItemsCell
        cell.specialCollectionView.tag=indexPath.row;
        if let name = favItemArrDict[indexPath.row]["name"] as? [String]{
            if name.count>0{
                cell.favItemNameLbl.text = name[0]
            }
        }
        tagIndex = cell.specialCollectionView.tag
        cell.specialCollectionView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favItemArrDict.count
    }
    var tagIndexPath:Int = 0
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = specialItemTblView.dequeueReusableCell(withIdentifier: "specialItemsCell") as! specialItemsCell
        
        if let name = favItemArrDict[indexPath.row]["name"] as? [String]{
            if name.count>0{
                cell.favItemNameLbl.text = name[0]
            }
        }
        tagIndexPath = indexPath.row
        cell.specialCollectionView.tag = indexPath.row
        cell.specialCollectionView.reloadData()

        
        return cell
    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    @IBAction func sortSpecialItem(_ sender: Any) {
            sortspecialItemView.isHidden = false
            hiddenView.isHidden = false
    }
    
    @IBAction func sortZtoABtnTap(_ sender: UIButton) {
        sortTitletextLbl.text = "Sort Z to A"
        categoryNameLbl.text = "Sort Z to A"
        removeAllData()
        getProgress()
        for view in sortspecialItemView.subviews {
            if view is UIButton && view != sender {
                (view as! UIButton).isSelected = false
            }
        }
        sender.isSelected = true
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let dateString = dateFormatter.string(from:Date())
        print(dateString)
        var specialDict:[String:AnyObject]=[:]
        specialDict["53"] = loginUserId as AnyObject
        specialDict["121.141"]=dateString as AnyObject
        specialDict["127.89"]="3" as AnyObject
        specialDict["127.60"]="120.83-DESC" as AnyObject
        getData(dataArray:specialDict)
    }
    func removeAllData(){
        favItemArrDict.removeAll()
    }
    @IBAction func sortAtoZBtnTap(_ sender: UIButton) {
        sortTitletextLbl.text = "Sort A to Z"
        categoryNameLbl.text = "Sort A to Z"
        removeAllData()
        getProgress()
        for view in sortspecialItemView.subviews {
            if view is UIButton && view != sender {
                (view as! UIButton).isSelected = false
            }
        }
        sender.isSelected = true
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let dateString = dateFormatter.string(from:Date())
        print(dateString)
        var specialDict:[String:AnyObject]=[:]
        specialDict["53"] = loginUserId as AnyObject
        specialDict["121.141"]=dateString as AnyObject
        specialDict["127.89"]="3" as AnyObject
        specialDict["127.60"]="120.83-ASC" as AnyObject
         getData(dataArray:specialDict)
    }
    @IBAction func mostPopularBtnTap(_ sender: UIButton) {
        sortTitletextLbl.text = "Most popular"
        categoryNameLbl.text = "Most popular"
        removeAllData()
        getProgress()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let dateString = dateFormatter.string(from:Date())
        print(dateString)
        for view in sortspecialItemView.subviews {
            if view is UIButton && view != sender {
                (view as! UIButton).isSelected = false
            }
        }
        sender.isSelected = true
        
        var specialDict:[String:AnyObject]=[:]
        specialDict["53"] = loginUserId as AnyObject
        specialDict["121.141"]=dateString as AnyObject
        specialDict["127.89"]="3" as AnyObject
        specialDict["127.60"]="122.19-DESC" as AnyObject
       getData(dataArray: specialDict)
    }
    @IBAction func expirySoonBtnTap(_ sender: UIButton) {
        sortTitletextLbl.text = "Expiring Soon"
        categoryNameLbl.text = "Expiring Soon"
        removeAllData()
        getProgress()
        for view in sortspecialItemView.subviews {
            if view is UIButton && view != sender {
                (view as! UIButton).isSelected = false
            }
        }
        sender.isSelected = true
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let dateString = dateFormatter.string(from:Date())
        print(dateString)
        var specialDict:[String:AnyObject]=[:]
        specialDict["53"] = loginUserId as AnyObject
        specialDict["121.141"]=dateString as AnyObject
        specialDict["127.89"]="3" as AnyObject
        specialDict["127.60"]="114.139-ASC" as AnyObject
        getData(dataArray: specialDict)
    }
    @IBAction func newestArrivalBtnTap(_ sender: UIButton) {
        sortTitletextLbl.text = "Newest Arrival"
        categoryNameLbl.text = "Newest Arrival"
        removeAllData()
        getProgress()
        for view in sortspecialItemView.subviews {
            if view is UIButton && view != sender {
                (view as! UIButton).isSelected = false
            }
        }
        sender.isSelected = true
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let dateString = dateFormatter.string(from:Date())
        print(dateString)
        var specialDict:[String:AnyObject]=[:]
        specialDict["53"] = loginUserId as AnyObject
        specialDict["121.141"]=dateString as AnyObject
        specialDict["127.89"]="3" as AnyObject
        specialDict["127.60"]="114.144-DESC" as AnyObject
        getData(dataArray: specialDict)
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
         if favItemArrDict.count>0{
        itemCout = (favItemArrDict[tagIndex]["image"]?.count)!
        print(itemCout)
        item = collectionView.tag
        print(item)
        return itemCout
         }else{
            return 1
        }
        
        
    }
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.size.height/1.5, height: collectionView.frame.size.height)
        
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "specialCollecionCell", for: indexPath) as! specialCollecionCell
//        cell.layer.borderWidth = 1
//        cell.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
//        cell.layer.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1).cgColor
//
//        cell.viewOuter.layer.borderWidth = 1
//        cell.viewOuter.layer.borderColor = UIColor(red: 220/256.0, green: 220/256.0, blue: 220/256.0, alpha: 1.0).cgColor
//        cell.viewOuter.layer.cornerRadius = 8.0
//        cell.viewOuter.clipsToBounds = true
//
//        cell.viewOuter.layer.masksToBounds = false
//        cell.viewOuter.layer.shadowColor = UIColor.lightGray.cgColor
//        cell.viewOuter.layer.shadowOpacity = 0.3
//        cell.viewOuter.layer.shadowOffset = CGSize(width: -1, height: 1)
//        cell.viewOuter.layer.shadowRadius = 1
//
//        cell.viewOuter.layer.shadowPath = UIBezierPath(rect: cell.bounds).cgPath
//        cell.viewOuter.layer.shouldRasterize = true
//        cell.viewOuter.layer.rasterizationScale = 1
//        cell.layer.cornerRadius = 5.0
        cell.SetCellProparty()
        if let name = favItemArrDict[tagIndex]["itemName"] as? [String]{
            if name.count>indexPath.row{
                cell.favNameLbl.text = name[indexPath.row]
            }
        }
        
        if let image = favItemArrDict[tagIndex]["image"] as? [URL]{
            if image.count>indexPath.row{
                cell.favItemImageView.sd_setImage(with: image[indexPath.row])
            }
            
        }
        if let price = favItemArrDict[tagIndex]["price"] as? [String]{
            if price.count>indexPath.row{
                cell.favItemPrice.text = "$" + price[indexPath.row]
                
            }
            
        }
        
        return cell
    }
    var productIds:String = ""
    var didSelectRow: ((String) -> ())?
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        specialClass.specialFlag = true
        if  let productId = favItemArrDict[collectionView.tag]["productId"]  as? [String]{
            
            if productId.count>indexPath.row{
                productIds = productId[indexPath.row]
            }
            
            
        }
        let vc = storyboard?.instantiateViewController(withIdentifier: "ItemDetailVC") as! ItemDetailVC
        vc.productId = productIds
        didSelectRow?(productIds)
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

