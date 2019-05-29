//
//  ItemVC.swift
//  ApiTap
//
//  Created by Ashish on 20/12/17.
//  Copyright © 2017 ApiTap. All rights reserved.
//

import UIKit

class itemCollecionCell:UICollectionViewCell{
    
    @IBOutlet weak var discountLbl: UILabel!
    @IBOutlet weak var viewOuter: UIView!
    @IBOutlet weak var itemNamePrice: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemNameLbl: UILabel!
}
class itemDataCell:UITableViewCell{
    
    @IBOutlet weak var itemNameLbl: UILabel!
    @IBOutlet weak var itemCollectionView: UICollectionView!
}

class ItemVC: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var filterlblView: UIView!
    @IBOutlet var filterBtnView: UIView!
    
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet var sortTextLbl: UILabel!
    @IBOutlet var sortItemView: UIView!
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
    @IBOutlet weak var itemTblView: UITableView!
    @IBOutlet var lowToHighBtn: UIButton!
    
    @IBOutlet var sortZtoABtn: UIButton!
    @IBOutlet var sortAtoZBtn: UIButton!
    @IBOutlet var expiringSoonBtn: UIButton!
    @IBOutlet var mostPopularBtn: UIButton!
    @IBOutlet var highToLow: UIButton!
    
    @IBOutlet var newestArrivalBtn: UIButton!
    
    override func viewDidLoad() {
        filterBtnView.edigeRadius()
        filterlblView.edigeRadius()
        progressView.startAnimating()
        categoryLbl.layer.masksToBounds = true
        categoryLbl.layer.cornerRadius = 5
        if let result = UserDefaults.standard.value(forKey: "loginUserID") as? String{
            loginUserId = result as! String
            print(result)
        }
        // setLoadingScreen()
        getProgress()
        // self.initializeNavBar()
        // self.setbarButtonItems()
      
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let dateString = dateFormatter.string(from:Date())
        print(dateString)
        
        var specialDict:[String:AnyObject]=[:]
        specialDict["53"] = loginUserId as AnyObject
        specialDict["121.141"]=dateString as AnyObject
        specialDict["127.89"]="3" as AnyObject
        getDate(date: specialDict)
        
        
        // Do any additional setup after loading the view.
    }
    func getProgress(){
        hiddenView.isHidden = false
        hiddenView.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
        itemTblView.isUserInteractionEnabled = false
    }
    func getDate(date:[String:Any]){
        myModel.addManager.productAndServiceImages("010400478", userinfo: date, completionResponse: { ( response,  error) in
            
            print(response)
            if let favDict:[[String:AnyObject]]=response as? [[String:AnyObject]]{
                self.rowsCountDict = favDict
                for item in favDict{
                    if let result = item["RESULT"] as? [[String:AnyObject]]{
                        for pc in result{
                            
                            if let arrNam = pc["_120_45"] as? String{
                                self.itemNameArray.append(arrNam)
                                if self.favItemDictArr["name"] == nil{
                                    self.favItemDictArr["name"] = [arrNam  as AnyObject]
                                }else{
                                    self.favItemDictArr["name"]?.append(arrNam as AnyObject)
                                }
                                // self.favItemDict["name"] = arrNam as AnyObject
                            }
                            
                            if let resultPC = pc["PC"] as? [[String:AnyObject]]{
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
                                        if let price = pcItem["_122_158"] as? String{
                                            if self.favItemDictArr["discount"] == nil{
                                                self.favItemDictArr["discount"] = [price  as AnyObject]
                                            }else{
                                                self.favItemDictArr["discount"]?.append(price as AnyObject)
                                                
                                            }
                                            // }
                                            
                                        }
                                    }
                                }
                                
                            }
                            self.favItemArrDict.append(self.favItemDictArr as [String : AnyObject])
                            self.favItemDictArr.removeAll()
                            
                        }
                        
                    }
                    
                }
            }
            DispatchQueue.main.async {
                 self.sortItemView.isHidden = true
                self.progressView.stopAnimating()
                self.progressView.isHidden=true
                self.hiddenView.isHidden = true
                self.itemTblView.isUserInteractionEnabled = true
                self.itemTblView.reloadData()
            }
            
        })
    }
    @IBAction func sortItems(_ sender: Any) {
       // if sortItemView.isHidden {
            hiddenView.isHidden = false
            sortItemView.isHidden = false
       // } else {
           // hiddenView.isHidden = true
           // sortItemView.isHidden = true
            // searchActive = false;
       // }
    }
    func getTodayDate(date:String){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let dateString = dateFormatter.string(from:Date())
        print(dateString)
    }
    @IBAction func highToLow(_ sender: UIButton) {
        getProgress()
        self.favItemArrDict.removeAll()
        for view in sortItemView.subviews {
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
        specialDict["127.60"]="114.98-DESC" as AnyObject
        getDate(date: specialDict)
    }
    @IBAction func lowToHighBtnTap(_ sender: UIButton) {
        sortTextLbl.text = "Low to high"
        categoryLbl.text = "Low to high"
        getProgress()
         self.favItemArrDict.removeAll()
        for view in sortItemView.subviews {
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
        specialDict["127.60"]="114.98-ASC" as AnyObject
        getDate(date: specialDict)
        
    }
    
    @IBAction func sortZtoABtnTap(_ sender: UIButton) {
         sortTextLbl.text = "Sort Z to A"
        categoryLbl.text = "Sort Z to A"
        getProgress()
         self.favItemArrDict.removeAll()
        for view in sortItemView.subviews {
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
        getDate(date: specialDict)
    }
    @IBAction func sortAtoZBtnTap(_ sender: UIButton) {
         sortTextLbl.text = "Sort A to Z"
        categoryLbl.text = "Sort A to Z"
        getProgress()
         self.favItemArrDict.removeAll()
        for view in sortItemView.subviews {
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
        getDate(date: specialDict)
    }
    @IBAction func expirySonnBtnTap(_ sender: UIButton) {
         sortTextLbl.text = "Expiry Soon"
         categoryLbl.text = "Expiry Soon"
        getProgress()
         self.favItemArrDict.removeAll()
        for view in sortItemView.subviews {
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
        getDate(date: specialDict)
    }
    @IBAction func mostPopularBtnTap(_ sender: UIButton) {
         sortTextLbl.text = "Most Popular"
         categoryLbl.text = "Most Popular"
        getProgress()
        for view in sortItemView.subviews {
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
        specialDict["127.60"]="122.19-DESC" as AnyObject
        getDate(date: specialDict)
    }
    @IBAction func newestArrivalBtnTap(_ sender: UIButton) {
         sortTextLbl.text = "Newest Arrivals"
        categoryLbl.text = "Newest Arrivals"
        getProgress()
         self.favItemArrDict.removeAll()
        for view in sortItemView.subviews {
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
        getDate(date: specialDict)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.0
    }
    var tagIndex:Int = 0
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = itemTblView.dequeueReusableCell(withIdentifier: "itemDataCell") as! itemDataCell
        cell.itemCollectionView.tag=indexPath.row;
        if let name = favItemArrDict[indexPath.row]["name"] as? [String]{
            if name.count>0{
                cell.itemNameLbl.text = name[0]
            }
        }
        tagIndex = cell.itemCollectionView.tag
        cell.itemCollectionView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favItemArrDict.count
    }
    var tagIndexPath:Int = 0
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = itemTblView.dequeueReusableCell(withIdentifier: "itemDataCell") as! itemDataCell
        
        if let name = favItemArrDict[indexPath.row]["name"] as? [String]{
            if name.count>0{
                cell.itemNameLbl.text = name[0]//self.hexToStr(textValue: name[0])
                //cell.favItemNameLbl.text = name[0]
            }
        }
        tagIndexPath = indexPath.row
        cell.itemCollectionView.tag = indexPath.row
        
        cell.itemCollectionView.reloadData()
        
        return cell
    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.size.height/1.5, height: collectionView.frame.size.height-10)
        
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if favItemArrDict.count>0{
        itemCout = (favItemArrDict[tagIndex]["itemName"]?.count)!
        print(itemCout)
        item = collectionView.tag
        print(item)
        return itemCout
        }else{
            return 1
        }
        
        
    }
  
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCollecionCell", for: indexPath) as! itemCollecionCell
//        cell.layer.borderWidth = 1
//        cell.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
//        cell.layer.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1).cgColor
//
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
                cell.itemNameLbl.text = self.hexToStr(textValue: name[indexPath.row])
            }
        }
        
        if let image = favItemArrDict[tagIndex]["image"] as? [URL]{
            if image.count>indexPath.row{
                cell.itemImageView.sd_setImage(with: image[indexPath.row])
            }
            
        }
        if let price = favItemArrDict[tagIndex]["price"] as? [String]{
            
            if let discountPrice = favItemArrDict[tagIndex]["discount"] as? [String]{
                if price.count>indexPath.row{
                     if discountPrice.count>indexPath.row{
                var actualPrice =  price[indexPath.row]
                let disPrice = discountPrice[indexPath.row]
                let actualPriceInt:Double = Double(actualPrice)!
                let disPriceInt:Double = Double(disPrice)!
                if disPrice == "0" || disPrice == "0.00" || actualPrice == disPrice{
                    cell.itemNamePrice.text = "$" + actualPrice
                   // cell.itemNamePrice.frame =   CGRect(x: 0, y: 0, width: cell.contentView.frame.size.width, height: 15 )
                    // cell.productionPriceLbl.frame.size.width = cell.contentView.frame.size.width
                }else if actualPriceInt > disPriceInt{
                    actualPrice = "$" + actualPrice
                    let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: actualPrice)
                    attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
                    cell.itemNamePrice.attributedText =  attributeString
                    
                    cell.discountLbl.text = "$" + disPrice
                }
                
            }
            }
            }
//            if price.count>indexPath.row{
//                cell.itemNamePrice.text = "$" + price[indexPath.row]
//
//            }
            
        }
        
        return cell
    }
    var productIds:String = ""
    var didSelectRow: ((String) -> ())?
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        specialClass.specialFlag = false
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
