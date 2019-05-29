//
//  FavioratesVC.swift
//  ApiTap
//
//  Created by Ashish on 26/10/17.
//  Copyright © 2017 ApiTap. All rights reserved.
//

import UIKit

class faviorateCollecionCell:UICollectionViewCell{
    @IBOutlet weak var favDiscLbl: UILabel!
    @IBOutlet weak var viewOuter: UIView!
    @IBOutlet weak var favItemPrice: UILabel!
    @IBOutlet weak var favItemImageView: UIImageView!
    @IBOutlet weak var favNameLbl: UILabel!
}
class favAddCell:UITableViewCell{
    @IBOutlet weak var addScrollView: UIScrollView!
}
class storeCollecionCell:UICollectionViewCell{
    @IBOutlet weak var storDiscLbl: UILabel!
    @IBOutlet weak var viewOuter: UIView!
    @IBOutlet weak var storItemPrice: UILabel!
    @IBOutlet weak var storItemImageView: UIImageView!
    @IBOutlet weak var storeNameLbl: UILabel!
}
class favItemsCell:UITableViewCell{
    
   
    @IBOutlet weak var favItemNameLbl: UILabel!
    @IBOutlet weak var favCollectionView: UICollectionView!
}
class storeItemsCell:UITableViewCell{
    
    
    @IBOutlet weak var storeLbl: UILabel!
    @IBOutlet weak var storeCollectionView: UICollectionView!
}
class FavioratesVC: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    
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
    @IBOutlet weak var favItemTblView: UITableView!
    var sections = [Section(genre:"ADS",movies:["a","b","c"],expanded:false),
                    Section(genre:"STORES",movies:["a","b","c"],expanded:false),
    Section(genre:"ITEMS",movies:["a","b","c"],expanded:false)]
    
    //*** New Variable ***//
    //HEADER SECTION
    var sectionGet:Int = 0
    var collapseView:Bool=false
    var expandval:Bool = false

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.haderSectionBtn()
        progressView.startAnimating()
        // setLoadingScreen()
        hiddenView.isHidden = false
        hiddenView.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
        favItemTblView.isUserInteractionEnabled = false
        self.initializeNavBar()
        self.setbarButtonItems()
         let timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
        if let result = UserDefaults.standard.value(forKey: "loginUserID") as? String{
            loginUserId = result as! String
            print(result)
        }
        self.favItemTblView.reloadData()
   
        getAdds()
       
        // Do any additional setup after loading the view.
    }
    var offSet: CGFloat = 0
    func autoScroll() {
        if let cell = self.favItemTblView.cellForRow(at: IndexPath(row: 0, section: 0)) as? favAddCell{
            let totalPossibleOffset = CGFloat(imageUrl.count - 1) * self.view.bounds.size.width
            if offSet == totalPossibleOffset {
                offSet = 0 // come back to the first image after the last image
            }
            else {
                offSet += self.view.bounds.size.width
            }
            DispatchQueue.main.async() {
                UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveLinear, animations: {
                    cell.addScrollView.contentOffset.x = CGFloat(self.offSet)
                    let cell = self.favItemTblView.cellForRow(at: IndexPath(row: 0, section: 0)) as! favAddCell
                    let x = cell.addScrollView.contentOffset.x
                    let w = cell.addScrollView.bounds.size.width
                    //cell.pageControl.currentPage = Int(x/w)
                }, completion: nil)
            }
        }
    }
    func getFavItems(){
        dictparam["53"] = loginUserId as AnyObject
        dictparam["127.10"] = "001" as AnyObject
        dictparam["114.112"] = "21" as AnyObject
        myModel.addManager.searchNearby("010400221", userinfo: dictparam, completionResponse: { ( response,  error) in
            
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
                self.progressView.stopAnimating()
                self.progressView.isHidden=true
                self.hiddenView.isHidden = true
                self.favItemTblView.isUserInteractionEnabled = true
                self.favItemTblView.reloadData()
               // self.getStores()
                
            }
            
        })
    }
    var storeItemDictArr:[String:[AnyObject]]=[:]
    var storeItemDictArray:[[String:AnyObject]]=[]
    func getStores(){
        var dict:[String:AnyObject]=[:]
        dict["53"] = loginUserId as AnyObject
        myModel.addManager.searchNearby("010100303", userinfo: dict, completionResponse: { ( response,  error) in
            
            print(response)
            if let favDict:[[String:AnyObject]]=response as? [[String:AnyObject]]{
                for pc in favDict{
                    
                    if let arrNam = pc["RESULT"] as? [[String:AnyObject]]{
                        for val in arrNam{
                            if let arrVal = val["_121_170"] as? String{
                                if self.storeItemDictArr["image"] == nil{
                                    let url =  self.urlImage.appending(arrVal as String)
                                    if let url = NSURL(string: url) {
                                        self.storeItemDictArr["image"] = [url as AnyObject]
                                        // self.imageDetailUrl.append(url as URL)
                                        
                                    }
                                }
                                else{
                                    let url =  self.urlImage.appending(arrVal as String)
                                    if let url = NSURL(string: url) {
                                        self.storeItemDictArr["image"]?.append(url as AnyObject)
                                    }
                                }
                            }
                            if let price = val["_114_70"] as? String{
                                if self.favItemDictArr["storeName"] == nil{
                                    self.storeItemDictArr["storeName"] = [price  as AnyObject]
                                }else{
                                    self.storeItemDictArr["storeName"]?.append(price as AnyObject)
                                    
                                }
                                // }
                                
                            }
//                            if let arrVal = val["CU"] as? [[String:AnyObject]]{
//                                for val in arrVal{
//                                    if let str = arrNam["_121_170"] as? String
//
//                                }
//                            }
                            self.storeItemDictArray.append(self.storeItemDictArr as [String : AnyObject])
                            self.storeItemDictArr.removeAll()
                        }
                    }
                }
            }
            DispatchQueue.main.async {
                self.getFavItems()
                
            }
        })
    }
    
    func getAdds(){
        let cell = self.favItemTblView.cellForRow(at: IndexPath(row: 0, section: 0)) as! favAddCell
        var addArr:[String]=[]
        var imageUrl:[String]=[]
         var allImage:[UIImage]=[]
        var dict:[String:AnyObject]=[:]
        dict["53"] = loginUserId as AnyObject
        myModel.addManager.searchNearby("010100496", userinfo: dict, completionResponse: { ( response,  error) in
            
            print(response)
            if let favDict:[[String:AnyObject]]=response as? [[String:AnyObject]]{
                for pc in favDict{
                    
                    if let arrNam = pc["RESULT"] as? [[String:AnyObject]]{
                        for val in arrNam{
                            if let video = val["_121_15"] as? String{
                                if video == ""{
                                    if let data = val["_121_170"] as? String{
                                        addArr.append(data)
                                    }
                                }else{
                                    addArr.append(video)
                                }
                            }
                            
                        }
                    }
                    for itemImages in addArr{
                        if let urlStr:String = itemImages as? String{
                            
                            let url =  self.urlImage.appending(urlStr as String)
                            imageUrl.append(url)
                        }
                        
                    }
                    for i in 0..<imageUrl.count{
                        DispatchQueue.global(qos: .userInitiated).async {
                            if let url = NSURL(string: imageUrl[i]) {
                                if let data = NSData(contentsOf: url as URL) {
                                    
                                   allImage.append(UIImage(data: data as Data)!)
                                    
                                    
                                    
                                    let xPosition = self.view.frame.width * CGFloat(i)
                                    let image = UIImageView()
                                    image.image = UIImage(data: data as Data)
                                    image.contentMode = .scaleAspectFit
                                    image.frame = CGRect(x: xPosition, y: 0, width: cell.addScrollView.frame.size.width, height: cell.addScrollView.frame.size.height)
                                    
                                    cell.addScrollView.contentSize.width =  self.view.frame.width * CGFloat(i+1)
                                    
                                    DispatchQueue.main.async(execute: { () -> Void in
                                        
                                        cell.addScrollView.addSubview(image)
                                        
                                        
                                    })
                                }
                            }
                        }
                    }
                }
            }
            DispatchQueue.main.async {
                self.getStores()
            }
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.0
    }
    var tagIndex:Int = 0
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == 2{
        let cell = favItemTblView.dequeueReusableCell(withIdentifier: "favItemsCell") as! favItemsCell
        cell.favCollectionView.tag=indexPath.row;
        if favItemArrDict.count>0{
        if let name = favItemArrDict[indexPath.row]["name"] as? [String]{
            if name.count>0{
                cell.favItemNameLbl.text = name[0]
            }
        }
        tagIndex = cell.favCollectionView.tag
        cell.favCollectionView.reloadData()
        }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   
        if section == 0
        {
            if isBool[section]
            {
                return 1
            }
            else
            {
                return 0
            }
        }
        else if section == 1{
            if isBool[section]{
                return 1
            } else {
                return 0
            }
        }
        else
        {
            if isBool[section]{
                return favItemArrDict.count
            } else {
                return 0
            }
        }
        
    }
    var tagIndexPath:Int = 0
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 2{
        let cell = favItemTblView.dequeueReusableCell(withIdentifier: "favItemsCell") as! favItemsCell
            if favItemArrDict.count>0{
        if let name = favItemArrDict[indexPath.row]["name"] as? [String]{
            if name.count>0{
                cell.favItemNameLbl.text = name[0]
            }
        }
        tagIndexPath = indexPath.row
        cell.favCollectionView.tag = indexPath.row
        cell.favCollectionView.reloadData()
            }
        return cell
        }
        if indexPath.section == 1{
            let cell = favItemTblView.dequeueReusableCell(withIdentifier: "storeItemsCell") as! storeItemsCell
            cell.storeCollectionView.tag = 102
            cell.storeCollectionView.delegate = self
            cell.storeCollectionView.reloadData()
            return cell
        }
        if indexPath.section == 0{
            let cell = favItemTblView.dequeueReusableCell(withIdentifier: "favAddCell") as! favAddCell
            
            return cell
            
        }
        return UITableViewCell()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
        
    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 230
       
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    
    var isBool = [true,true,true]
    
    //MARK:- TableView Delegate Methods
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        headerView.frame = CGRect(x: 0, y: 0, width: favItemTblView.frame.size.width, height: 30)
        headerView.backgroundColor = appColor//UIColor(red: 119/256.0, green: 185/256.0, blue: 255/256.0, alpha: 1.0)
        
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
        
        headerView.addSubview(self.headerBtns[section])
        lblTitle.frame = CGRect(x: 5, y: 5, width: 150, height: 20)
        lblTitle.textColor = UIColor.white
        headerView.addSubview(lblTitle)
        return headerView
    }
    
    @objc func buttonAction(sender: UIButton!)
    {
        if isBool[sender.tag] == false {
            sender.setImage(#imageLiteral(resourceName: "arrowup"), for: .normal)
            isBool[sender.tag] = true
            favItemTblView.reloadData()
        } else {
             sender.setImage(#imageLiteral(resourceName: "arrowdown"), for: .normal)
            isBool[sender.tag] = false
            favItemTblView.reloadData()
        }
    }
    
    
    
    
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView.tag == 102{
            return storeItemDictArray.count
        }else{
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
        return 0
    }
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
            return CGSize(width: collectionView.frame.size.height/1.5, height: collectionView.frame.size.height-10)
       
        
        
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        if collectionView.tag == 102{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "storeCollecionCell", for: indexPath) as! storeCollecionCell
//            cell.viewOuter.layer.borderWidth = 1
//            cell.viewOuter.layer.borderColor = UIColor(red: 220/256.0, green: 220/256.0, blue: 220/256.0, alpha: 1.0).cgColor
//            cell.viewOuter.layer.cornerRadius = 8.0
//            cell.viewOuter.clipsToBounds = true
//
//            cell.viewOuter.layer.masksToBounds = false
//            cell.viewOuter.layer.shadowColor = UIColor.lightGray.cgColor
//            cell.viewOuter.layer.shadowOpacity = 0.3
//            cell.viewOuter.layer.shadowOffset = CGSize(width: -1, height: 1)
//            cell.viewOuter.layer.shadowRadius = 1
//
//            cell.viewOuter.layer.shadowPath = UIBezierPath(rect: cell.bounds).cgPath
//            cell.viewOuter.layer.shouldRasterize = true
//            cell.viewOuter.layer.rasterizationScale = 1
            cell.SetCellProparty()
            
            let item = storeItemDictArray[indexPath.row]
            if let image = item["image"] as? [URL]{
                if image.count>0{
                    cell.storItemImageView.sd_setImage(with: image[0])
                }
                
            }
            if let image = item["storeName"] as? [String]{
                if image.count>0{
                    cell.storeNameLbl.text = image[0]
                }
                
            }
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "faviorateCollecionCell", for: indexPath) as! faviorateCollecionCell
//            cell.layer.borderWidth = 1
//            cell.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
//            cell.layer.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1).cgColor
//
//
//            cell.viewOuter.layer.borderWidth = 1
//            cell.viewOuter.layer.borderColor = UIColor(red: 220/256.0, green: 220/256.0, blue: 220/256.0, alpha: 1.0).cgColor
//            cell.viewOuter.layer.cornerRadius = 8.0
//            cell.viewOuter.clipsToBounds = true
//
//            cell.viewOuter.layer.masksToBounds = false
//            cell.viewOuter.layer.shadowColor = UIColor.lightGray.cgColor
//            cell.viewOuter.layer.shadowOpacity = 0.3
//            cell.viewOuter.layer.shadowOffset = CGSize(width: -1, height: 1)
//            cell.viewOuter.layer.shadowRadius = 1
//
//            cell.viewOuter.layer.shadowPath = UIBezierPath(rect: cell.bounds).cgPath
//            cell.viewOuter.layer.shouldRasterize = true
//            cell.viewOuter.layer.rasterizationScale = 1
//             cell.layer.cornerRadius = 5.0
            cell.SetCellProparty()
            if let name = favItemArrDict[tagIndex]["itemName"] as? [String]{
                if name.count>indexPath.row{
                    cell.favNameLbl.text = self.hexToStr(textValue: name[indexPath.row])
                }
            }
            
            if let image = favItemArrDict[tagIndex]["image"] as? [URL]{
                if image.count>indexPath.row{
                    cell.favItemImageView.sd_setImage(with: image[indexPath.row])
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
                                cell.favItemPrice.text = "$" + actualPrice
                                
                            }else if actualPriceInt > disPriceInt{
                                actualPrice = "$" + actualPrice
                                let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: actualPrice)
                                attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
                                cell.favItemPrice.attributedText =  attributeString
                                
                                cell.favDiscLbl.text = "$" + disPrice
                            }
                            
                        }
                    }
                }
                
            }
            
            return cell
        }
        return UICollectionViewCell()
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
    
    //*** Creat hader Btn***//
    var headerBtns = [UIButton]()
    func haderSectionBtn()
    {
        for i in 0...2
        {
            print(i)
            let btn = UIButton(frame: CGRect(x: self.view.frame.width-30, y: 5, width: 20, height: 20))
            btn.setImage(#imageLiteral(resourceName: "arrowup"), for: .normal)
            btn.tag = i
            btn.addTarget(self, action: #selector(self.buttonAction(sender:)), for: UIControlEvents.touchUpInside)
            self.headerBtns.append(btn)
        }
    }
   

}


