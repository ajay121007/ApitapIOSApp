//
//  StoreVC.swift
//  ApiTap
//
//  Created by Ashish on 01/11/17.
//  Copyright © 2017 ApiTap. All rights reserved.
//

import UIKit

class storeCollectionViewCell:UICollectionViewCell{
     @IBOutlet var storeImageView:UIImageView!
    @IBOutlet var storeNameLbl:UILabel!
    
    @IBOutlet var viewOuter: UIView!
    
}

class storesCell:UITableViewCell{
     @IBOutlet var storeFullNameLbl:UILabel!
    @IBOutlet var storeCollectionView:UICollectionView!
}

class StoreVC: BaseViewController,UITableViewDelegate,UITableViewDataSource{
    @IBOutlet weak var progressView: UIActivityIndicatorView!
var myModel = ModelManager()
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    var itemCout = 0;
    var item = 0;
    var count = 0;
    @IBOutlet weak var hiddenView: UIView!
    var loginUserId:String = ""
    var dictParam:[String:AnyObject] = [:]
    var storeItemDictArr:[String:[AnyObject]]=[:]
     var urlImage:String = "http://209.46.35.217:8085/ServerImage/images/"
    var storefavItemArrDict:[[String:AnyObject]]=[]
    
    @IBOutlet var filterBtnView: UIView!
    @IBOutlet var filterTitleView: UIView!
    @IBOutlet weak var filterNameLbl: UILabel!
    @IBOutlet var filterTextLbl: UILabel!
    @IBOutlet var filterView: UIView!
    @IBOutlet weak var storeTblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterTitleView.edigeRadius()
        filterTitleView.borderColor(color: UIColor.white, boderWidth: 1.0)
        filterBtnView.edigeRadius()
        filterBtnView.borderColor(color: UIColor.white, boderWidth: 1.0)
        
        progressView.startAnimating()
        filterNameLbl.layer.masksToBounds = true
        filterNameLbl.layer.cornerRadius = 5
        // setLoadingScreen()
        hiddenView.isHidden = false
        hiddenView.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
        storeTblView.isUserInteractionEnabled = false
        self.initializeNavBar()
        self.setbarButtonItems()
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        if let result = UserDefaults.standard.value(forKey: "loginUserID") as? String{
            loginUserId = result as! String
            print(result)
        }
        getStoreData()
        // Do any additional setup after loading the view.
    }

    func getStoreData(){
        dictParam["53"]=loginUserId as AnyObject
        //dictParam["114.27"]="" as AnyObject
        myModel.addManager.getStoreDetail("010400645", userinfo: dictParam, completionResponse: { ( response,  error) in
            
            print(response)
            if let favDict:[[String:AnyObject]]=response as? [[String:AnyObject]]{
                for item in favDict{
                    if let result = item["RESULT"] as? [[String:AnyObject]]{
                        for pc in result{
                            if let storeName = pc["_120_45"] as? String{
                                if self.storeItemDictArr["store"] == nil{
                                    self.storeItemDictArr["name"] = [storeName  as AnyObject]
                                }else{
                                    self.storeItemDictArr["name"]?.append(storeName as AnyObject)
                                }
                            }
                            if let storeName = pc["_120_83"] as? String{
                                if self.storeItemDictArr["filterName"] == nil{
                                    self.storeItemDictArr["filterName"] = [storeName  as AnyObject]
                                }else{
                                    self.storeItemDictArr["filterName"]?.append(storeName as AnyObject)
                                }
                            }
                            if let me = pc["ME"] as? [[String:AnyObject]]{
                                for ME in me{
                                    if let resultSP = ME["_121_170"] as? String{
                                        
                                        if self.storeItemDictArr["image"] == nil{
                                            let url =  self.urlImage.appending(resultSP as String)
                                            if let url = NSURL(string: url) {
                                                self.storeItemDictArr["image"] = [url as AnyObject]
                                                
                                            }
                                        }
                                        else{
                                            let url =  self.urlImage.appending(resultSP as String)
                                            if let url = NSURL(string: url) {
                                                self.storeItemDictArr["image"]?.append(url as AnyObject)
                                            }
                                        }
                                    }
                                    
                                    
                                    if let imageStoreName = ME["_114_70"] as? String{
                                        if self.storeItemDictArr["imageStoreName"] == nil{
                                            self.storeItemDictArr["imageStoreName"] = [imageStoreName  as AnyObject]
                                        }else{
                                            self.storeItemDictArr["imageStoreName"]?.append(imageStoreName as AnyObject)
                                            
                                        }
                                    }
                                    if let productId = ME["_53"] as? String{
                                        if self.storeItemDictArr["productId"] == nil{
                                            self.storeItemDictArr["productId"] = [productId  as AnyObject]
                                        }else{
                                            self.storeItemDictArr["productId"]?.append(productId as AnyObject)
                                            
                                        }
                                    }
                                }
                            }
                            self.storefavItemArrDict.append(self.storeItemDictArr as [String : AnyObject])
                            self.storeItemDictArr.removeAll()
                        }
                    }
                }
            }
            
            
            DispatchQueue.main.async {
                self.progressView.stopAnimating()
                self.progressView.isHidden=true
                self.hiddenView.isHidden = true
                self.storeTblView.isUserInteractionEnabled = true
                self.storeTblView.reloadData()
            }
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    var tagIndex:Int = 0
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = storeTblView.dequeueReusableCell(withIdentifier: "storesCell") as! storesCell
        cell.storeCollectionView.tag=indexPath.row;
        tagIndex = cell.storeCollectionView.tag
        cell.storeCollectionView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         if(searchActive){
            return filData.count
         }else{
        return storefavItemArrDict.count
        }
    }
    var didSelectIndex:Int = 0
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = storeTblView.dequeueReusableCell(withIdentifier: "storesCell") as! storesCell
         if(searchActive){
            didSelectIndex = indexPath.row
            
            let nameItem = filData[indexPath.row]
            if let name = nameItem["name"] as? [String]{
                if name.count>0{
                    cell.storeFullNameLbl.text = name[0]
                }
            }
            
            
            
            cell.storeCollectionView.tag = indexPath.row
            cell.storeCollectionView.reloadData()
         }else{
        didSelectIndex = indexPath.row
                
        let nameItem = storefavItemArrDict[indexPath.row]
        if let name = nameItem["name"] as? [String]{
            if name.count>0{
        cell.storeFullNameLbl.text = name[0]
            }
        }
    
    
       
        cell.storeCollectionView.tag = indexPath.row
        cell.storeCollectionView.reloadData()
        }
         return cell
        
    }
    var storeMerchantId:String = ""
    var didSelectRow: ((String,Int,Bool) -> ())?
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if searchActive{
            if  let nameItem = filData[collectionView.tag]["productId"] as? [String]{
                
                if nameItem.count>indexPath.row{
                    storeMerchantId = nameItem[indexPath.row]
                    TestClassStore.storeMerchantId = nameItem[indexPath.row]
                }
                
                
            }
            if  let nameItem = filData[collectionView.tag]["imageStoreName"] as? [String]{
                
                if nameItem.count>0{
                    TestClassStore.storeName = nameItem[0]
                }
                
                
            }
            if  let nameItem = filData[collectionView.tag]["name"] as? [String]{
                
                if nameItem.count>0{
                 
                }
                
                
            }
            if  let nameItem = filData[collectionView.tag]["image"] as? [URL]{
                
                if nameItem.count>0{
                    print(indexPath.row)
                    TestClassStore.storeNameImage = nameItem[indexPath.row]
                }
                
                
            }
        }else{
            
      if  let nameItem = storefavItemArrDict[collectionView.tag]["productId"] as? [String]{
       
        if nameItem.count>indexPath.row{
            storeMerchantId = nameItem[indexPath.row]
            TestClassStore.storeMerchantId = nameItem[indexPath.row]
        }
        
        
        }
            if  let nameItem = storefavItemArrDict[collectionView.tag]["imageStoreName"] as? [String]{
                
                if nameItem.count>0{
                    TestClassStore.storeName = nameItem[indexPath.row]
                }
                
                
            }
        if  let nameItem = storefavItemArrDict[collectionView.tag]["name"] as? [String]{
            
            if nameItem.count>0{
              
            }
            
            
        }
        if  let nameItem = storefavItemArrDict[collectionView.tag]["image"] as? [URL]{
            
            if nameItem.count>0{
                print(indexPath.row)
                //storeMerchantId = nameItem[0]
                TestClassStore.storeNameImage = nameItem[indexPath.row]
            }
            
            
        }
        }
        let vc = storyboard?.instantiateViewController(withIdentifier: "PagerVC") as! PagerVC
        TestClass.doubleVar = 0;
        TestClass2.doubleVarBool = true;
        didSelectRow!(storeMerchantId,0,true)
        
        self.navigationController?.pushViewController(vc, animated: true)

        }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
     var searchActive : Bool = false
    var filData:[[String:AnyObject]] = []
    @IBAction func filterBtnTap(_ sender: Any) {

        if filterView.isHidden {
            hiddenView.isHidden = false
            filterView.isHidden = false
        } else {
           filterView.isHidden = true
            hiddenView.isHidden = true
        }
     
    }
    
    func filterData(title:String){
        var arrayval:[[String:AnyObject]] = []
        for item in storefavItemArrDict{
            if let name = item["filterName"] as? [String]{
                if name.count>0{
                    for itemName in name{
                    if itemName.contains(title){
                        arrayval.append(item)
                        filData.append(item)
                    }
                    }
                }
            }
        }
        if(arrayval.count == 0){
             searchActive = false;
        }else{
             searchActive = true;
        }
        
        

        filterView.isHidden = true
        hiddenView.isHidden = true
        storeTblView.reloadData()
    }
    @IBAction func allSearchBtnTap(_ sender: UIButton) {
          filterTextLbl.text = sender.currentTitle
        filterNameLbl.text = sender.currentTitle
        searchActive = false;
        getStoreData()
    
      
    }
    
    @IBAction func retailBtnTap(_ sender: UIButton) {
          filterTextLbl.text = sender.currentTitle
         filterNameLbl.text = sender.currentTitle
        searchActive = true;
        filterData(title: sender.currentTitle!)
    }
    
    @IBAction func restaurantBtnTap(_ sender: UIButton) {
        filterTextLbl.text = sender.currentTitle
         filterNameLbl.text = sender.currentTitle
        searchActive = true;
       filterData(title: sender.currentTitle!)
    }
    
    @IBAction func hospitalityBtnTap(_ sender: UIButton) {
          filterTextLbl.text = sender.currentTitle
         filterNameLbl.text = sender.currentTitle
        searchActive = true;
        filterData(title: sender.currentTitle!)
    }
    
    @IBAction func servicesBtnTap(_ sender: UIButton) {
        filterTextLbl.text = sender.currentTitle
        filterNameLbl.text = sender.currentTitle
        searchActive = true;
        filterData(title: sender.currentTitle!)
        
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if storefavItemArrDict.count>0{
        itemCout = (storefavItemArrDict[tagIndex]["image"]?.count)!
                print(itemCout)
                item = collectionView.tag
                print(item)
                return itemCout
        }else{
            return 1
        }
    }

    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
//        return CGSize(width: collectionView.frame.size.width/3.5, height: collectionView.frame.size.height)
        return CGSize(width: collectionView.frame.size.height/1.5, height: collectionView.frame.size.height-10)
    }
    
     override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "storeCollectionViewCell", for: indexPath) as! storeCollectionViewCell
//        cell.viewOuter.layer.borderWidth = 1
//        cell.viewOuter.layer.borderColor = UIColor(red: 220/256.0, green: 220/256.0, blue: 220/256.0, alpha: 1.0).cgColor
//        cell.viewOuter.layer.cornerRadius = 3.0
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
        cell.SetCellProparty()
        
        if(searchActive){
            if let name = filData[tagIndex]["imageStoreName"] as? [String]{
                
                if name.count>indexPath.row{
                    cell.storeNameLbl.text = name[indexPath.row]
                }
                
            }
            if let image = filData[tagIndex]["image"] as? [URL]{
                
                if image.count>indexPath.row{
                    cell.storeImageView.sd_setImage(with: image[indexPath.row] as URL!)
                }
                
            }
            
            
        }else{
        if let name = storefavItemArrDict[tagIndex]["imageStoreName"] as? [String]{
            
            if name.count>indexPath.row{
                cell.storeNameLbl.text = name[indexPath.row]
            }
            
        }
        if let image = storefavItemArrDict[tagIndex]["image"] as? [URL]{
            
            if image.count>indexPath.row{
                cell.storeImageView.sd_setImage(with: image[indexPath.row] as URL!)
            }
            
        }
        }
        
        
        return cell
    }
    
}

//extension StoreVC:UICollectionViewDelegate,UICollectionViewDataSource{
//    
//}
