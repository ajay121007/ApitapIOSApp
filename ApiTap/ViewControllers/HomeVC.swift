//
//  HomeVC.swift
//  ApiTap
//
//  Created by Ashish on 14/12/17.
//  Copyright © 2017 ApiTap. All rights reserved.
//

import UIKit
var appColor = UIColor(red: 48/256.0, green: 142/256.0, blue: 218/256.0, alpha: 1.0)
struct specialClass{
    static var specialFlag:Bool = false
}
class addsItemsCell:UITableViewCell{
    @IBOutlet weak var storeImgView: UIImageView!
    @IBOutlet var viewAllAdsBtn: UIButton!
    @IBOutlet weak var noAdsImgView: UIImageView!
    
    @IBOutlet weak var storeViewheight: NSLayoutConstraint!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var storeDetailLbl: UIButton!
    @IBOutlet weak var storeDetailsLbl: UILabel!
    @IBOutlet weak var storeNmeLbl: UILabel!
    @IBOutlet weak var storeView: UIView!
    @IBOutlet weak var addsScrollView: UIScrollView!
    override func awakeFromNib() {
        storeDetailLbl.layer.cornerRadius = 5
        storeDetailLbl.clipsToBounds = true
        storeNmeLbl.layer.cornerRadius = 5
        storeNmeLbl.clipsToBounds = true
        pageControl.isHidden = true
    }
}
class homeSpecialDataCell:UICollectionViewCell{
    @IBOutlet var titleLbl:UILabel!
    @IBOutlet var specialImageView:UIImageView!
    @IBOutlet weak var discountLbl: UILabel!
    @IBOutlet var priceLbl:UILabel!
    @IBOutlet var viewOuter: UIView!
}
class homeProductionServiceDataCell:UICollectionViewCell{
    @IBOutlet var productionServiceTitleLbl:UILabel!
    @IBOutlet weak var productionPriceLbl: UILabel!
    @IBOutlet var productServiceImageView:UIImageView!
    @IBOutlet var viewOuter: UIView!
    @IBOutlet weak var productionDisPriceLbl: UILabel!
}
class specialCell:UITableViewCell{
    @IBOutlet var specialCollectionView:UICollectionView!
    @IBOutlet weak var viewAllBtn: UIButton!
    
    @IBOutlet weak var specialLbl: UILabel!
}
class faviorateItemCell:UITableViewCell{
    
    @IBOutlet weak var favItemCollectionView: UICollectionView!
    @IBOutlet weak var viewAllfavItem: UIButton!
    @IBOutlet weak var favLbl: UILabel!
}
class homeFaviourateItemCell:UICollectionViewCell{
    @IBOutlet weak var favItemTitleLbl: UILabel!
   @IBOutlet var viewOuter: UIView!
    @IBOutlet weak var favItemPriceLbl: UILabel!
    @IBOutlet weak var favItemImageView: UIImageView!
}
class productAndServiceCell:UITableViewCell{
    @IBOutlet weak var viewAllItemBtn: UIButton!
    @IBOutlet weak var productionServiceLbl: UILabel!
    @IBOutlet var productServiceCollectionView:UICollectionView!
}
class HomeVC: BaseViewController,UITableViewDataSource,UITableViewDelegate,storeDetails,storeDetailsInfo{
    @IBOutlet weak var storeView: UIView!
    var myModel = ModelManager()
    @IBOutlet weak var progressView: UIActivityIndicatorView!
    @IBOutlet weak var hiddenView: UIView!
    @IBOutlet weak var itemsTblView: UITableView!
    @IBOutlet weak var addScrollView: UIScrollView!
    @IBOutlet weak var containerView: UIView!
    var dictparam:[String:AnyObject]=[:]
    var productAndServiceArray:[[String:AnyObject]]=[]
    var productAndServiceFinalData:[[String:AnyObject]]=[]
    var productAndServiceFinalmageUrl:[String]=[]
    var productAndServiceItemname:[String]=[]
    var productAndServicePriceName:[String]=[]
    var productAndServiceFinalmage:[String]=[]
    var productAndServiceFinaDatalmage:[Data]=[]
    var urlImage:String = "http://209.46.35.217:8085/ServerImage/images/"
    var searchItems:[[String:AnyObject]]=[]
    var getTotalOfferImage:[String]=[]
    var loadSearchCollectionImage:[[String:AnyObject]]=[]
    var imageUrl:[String]=[]
    var arrayFinalData:[String]=[]
    var allImage:[UIImage]=[]
     var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    var offerSearchImage:[String] = []
    var itemNames:[String]=[]
    var itemPriceName:[String]=[]
    var specialImage:[UIImage]=[]
    var specialDataImage:[Data]=[]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor.green
       self.initializeNavBar()
       // self.setbarButtonItems()
        self.setBarBtnItems()
        let arr = [1,2,3,4]
        let second = [[1,2,3,4],[5,6,7]]
 
        let newArrUsingMap = arr.map { $0 * 10 }
        
        print(newArrUsingMap)
        let new = arr.filter { (x) -> Bool in
            if x%2 == 0{
                print(x)
            }
            return true
        }
        
        let reducedNumberSum = arr.reduce(0,*)
        print(reducedNumberSum)
        for (firstIndex, firstElement) in arr.enumerated() {
            for (secondIndex, secondElement) in arr.enumerated() {
                if firstIndex != secondIndex && firstElement + secondElement == 5 {
                    print(firstIndex)
                    print(secondIndex)
                   // return true
                }
            }
        }
        progressView.startAnimating()
       
        hiddenView.isHidden = false
        hiddenView.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
        itemsTblView.isUserInteractionEnabled = false
        
        itemsTblView.delegate=self
        itemsTblView.dataSource=self
        
         let timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
        
        itemsTblView.reloadData()
         getScrollViewData()
       
        // Do any additional setup after loading the view.
    }
    var loginUserId:String = ""
    
    func getScrollViewData(){
        let cell = self.itemsTblView.cellForRow(at: IndexPath(row: 0, section: 0)) as! addsItemsCell
       // 010400478
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let dateString = dateFormatter.string(from:Date())
        print(dateString)
        
        
        if let result = UserDefaults.standard.value(forKey: "loginUserID") as? String{
            loginUserId = result as! String
            print(result)
        }
        dictparam["53"] = loginUserId as AnyObject
   
        if storeMerchantClass.storeMerchantIdBool == true{
           
            var dict2:NSMutableArray = []
            dict2 = [["114.179": storeMerchantClass.storeMerchantId as AnyObject,"operator":"eq" as AnyObject]]
            myModel.addManager.getMsgReply("010200517", userinfo: dictparam,userinfo2: dict2, completionResponse: { ( response,  error) in
                
                print(response)
                if let res: [[String : AnyObject]]  = response as? [[String : AnyObject]]{
                    
                    self.searchItems = res
                    for items in self.searchItems{
                        if let irImages = items["RESULT"] as? [[String:AnyObject]]{
                            if irImages.count <= 0{
                                cell.noAdsImgView.isHidden = false
                                cell.addsScrollView.isHidden = true
                                cell.noAdsImgView.image = UIImage(named:"noads")
                            }else{
                                cell.noAdsImgView.isHidden = true
                                cell.addsScrollView.isHidden = false
                                self.searchItems = res
                            }
                            for imageitem in irImages{
                             
                                if let image:String = imageitem["_121_170"] as? String{
                                    
                                    print(image)
                                    self.arrayFinalData.append(image)

                                }
                            }
                            for itemImages in self.arrayFinalData{
                                if let urlStr:String = itemImages as? String{
                                    
                                    let url =  self.urlImage.appending(urlStr as String)
                                    self.imageUrl.append(url)
                                }
                                
                            }
                            for i in 0..<self.imageUrl.count{
                                DispatchQueue.global(qos: .background).async {
                                    if let url = NSURL(string: self.imageUrl[i]) {
                                        if let data = NSData(contentsOf: url as URL) {
                                           
                                            self.allImage.append(UIImage(data: data as Data)!)
                                            
                                            let xPosition = self.view.frame.width * CGFloat(i)
                                            let image = UIImageView()
                                            
                                            image.contentMode = .scaleAspectFit
                                            image.image = UIImage(data: data as Data)
                                            image.frame = CGRect(x: xPosition, y: 0, width: cell.addsScrollView.frame.size.width, height: cell.addsScrollView.frame.size.height)
                                            
                                            cell.addsScrollView.contentSize.width =  self.view.frame.width * CGFloat(i+1)
                                            
                                            
                                            DispatchQueue.main.async(execute: { () -> Void in
                                              
                                                cell.addsScrollView.addSubview(image)
                                                
                                            })
                                        }
                                    }
                                }
                            }
    
                            
                            DispatchQueue.main.async {
                            }
                        }else{
                            cell.noAdsImgView.isHidden = false
                            cell.addsScrollView.isHidden = true
                            cell.noAdsImgView.image = UIImage(named:"noads")
                        }
                    }
                    
                }else{
                    cell.noAdsImgView.isHidden = false
                    cell.addsScrollView.isHidden = true
                    cell.noAdsImgView.image = UIImage(named:"noads")
                 
                }
                DispatchQueue.main.async {
                    self.getSpecialData()
                }
        
            })
        }else{
            
        myModel.addManager.showAdds("010200517", userinfo: dictparam, completionResponse: { ( response,  error) in
            
            print(response)
            if let res: [[String : AnyObject]]  = response as? [[String : AnyObject]]{
                self.searchItems = res

                for items in self.searchItems{
                    if let irImages = items["RESULT"] as? [[String:AnyObject]]{
                        if irImages.count <= 0{
                            cell.noAdsImgView.isHidden = false
                            cell.addsScrollView.isHidden = true
                            cell.noAdsImgView.image = UIImage(named:"noads")
                        }else{
                            cell.noAdsImgView.isHidden = true
                            cell.addsScrollView.isHidden = false
                            self.searchItems = res
                        }
                        for imageitem in irImages{

                            if let image:String = imageitem["_121_170"] as? String{
                                
                                print(image)
                                self.arrayFinalData.append(image)
                                
//                            }
//                        }
                        }
                        }
                        for itemImages in self.arrayFinalData{
                            if let urlStr:String = itemImages as? String{
                                
                                let url =  self.urlImage.appending(urlStr as String)
                                self.imageUrl.append(url)
                            }
                            
                        }
                        for i in 0..<self.imageUrl.count{
                            DispatchQueue.global(qos: .userInitiated).async {
                                if let url = NSURL(string: self.imageUrl[i]) {
                                    if let data = NSData(contentsOf: url as URL) {
                                  
                                        self.allImage.append(UIImage(data: data as Data)!)
                                        
  
                                        
                                        let xPosition = self.view.frame.width * CGFloat(i)
                                        let image = UIImageView()
                                        image.image = UIImage(data: data as Data)
                                         image.contentMode = .scaleAspectFit
                                        image.frame = CGRect(x: xPosition, y: 0, width: cell.addsScrollView.frame.size.width, height: cell.addsScrollView.frame.size.height)
                                        
                                        cell.addsScrollView.contentSize.width =  self.view.frame.width * CGFloat(i+1)
                                       
                                        DispatchQueue.main.async(execute: { () -> Void in
                                            
                                            cell.addsScrollView.addSubview(image)
                                            
                                            
                                        })
                                    }
                                }
                            }
                        }
                       // cell.addsScrollView.contentSize = CGSize(width: (cell.addsScrollView.frame.size.width * CGFloat(self.imageUrl.count)), height: cell.addsScrollView.frame.size.height)
                        
                        
                        DispatchQueue.main.async {
                        }
                    }
                }
                
            }else{
                cell.noAdsImgView.isHidden = false
                cell.addsScrollView.isHidden = true
                cell.noAdsImgView.image = UIImage(named:"noads")

            }
            DispatchQueue.main.async {
                self.getSpecialData()
            }

        })
        }
    }
    var offSet: CGFloat = 0
    func autoScroll() {
        if let cell = self.itemsTblView.cellForRow(at: IndexPath(row: 0, section: 0)) as? addsItemsCell{
        let totalPossibleOffset = CGFloat(imageUrl.count - 1) * self.view.bounds.size.width
        if offSet == totalPossibleOffset {
            offSet = 0 // come back to the first image after the last image
        }
        else {
            offSet += self.view.bounds.size.width
        }
        DispatchQueue.main.async() {
            UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveLinear, animations: {
                 cell.addsScrollView.contentOffset.x = CGFloat(self.offSet)
                let cell = self.itemsTblView.cellForRow(at: IndexPath(row: 0, section: 0)) as! addsItemsCell
                let x = cell.addsScrollView.contentOffset.x
                let w = cell.addsScrollView.bounds.size.width
                cell.pageControl.currentPage = Int(x/w)
            }, completion: nil)
        }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let cell = self.itemsTblView.cellForRow(at: IndexPath(row: 0, section: 0)) as? addsItemsCell {
        let x = cell.addsScrollView.contentOffset.x
        let w = cell.addsScrollView.bounds.size.width
        cell.pageControl.currentPage = Int(x/w)
        }
     
    }
    var specialImageUrl:[URL]=[]
    @IBAction func pageChange(_ sender: UIPageControl) {
    }
    
    
    
    var specialItemArrayDict:[[String:AnyObject]]=[]
    var specialDict:[String:[AnyObject]]=[:]
    func getSpecialData(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let dateString = dateFormatter.string(from:Date())
        print(dateString)
        
        var specialDict:[String:AnyObject]=[:]
        specialDict["53"] = loginUserId as AnyObject
        specialDict["121.141"]=dateString as AnyObject
        specialDict["127.89"]="3" as AnyObject
        if storeMerchantClass.storeMerchantIdBool == true{
            specialDict["114.179"] = storeMerchantClass.storeMerchantId as AnyObject
            myModel.addManager.getStoreSpecialsDetails("010400479", userinfo: specialDict, completionResponse: { ( response,  error) in
                print(response)
                if let res:[[String : AnyObject]] = response as? [[String : AnyObject]]{
                    self.loadSearchCollectionImage = res
                    for items in self.loadSearchCollectionImage{
                        if let irImages = items["PC"] as? [[String:AnyObject]]{
                            
                            for imageitem in irImages{
                                
                                if let productID = imageitem["_114_112"] as? String{
                                    
                                    if self.specialDict["_114_112"] == nil{
                                        self.specialDict["_114_112"] = [productID  as AnyObject]
                                        
                                    }else{
                                        self.specialDict["_114_112"]?.append(productID as AnyObject)
                                        
                                    }
                                }
                                 if let productID = imageitem["_120_157"] as? String{
                                    let str = self.hexToStr(textValue: productID)
                                    TestClassStore.storeAbout = str
                                }
                                if let productID = imageitem["_114_144"] as? String{
                                    
                                    if self.specialDict["productId"] == nil{
                                        self.specialDict["productId"] = [productID  as AnyObject]
                                        
                                    }else{
                                        self.specialDict["productId"]?.append(productID as AnyObject)
                                        
                                    }
                                }
                                if let image = imageitem["_121_170"] as? String{
                                    
                                    
                                    let url =  self.urlImage.appending(image as String)
                                    if let urls = NSURL(string: url) {
                                        if self.specialDict["image"] == nil{
                                            self.specialDict["image"] = [urls  as AnyObject]
                                            
                                        }else{
                                            self.specialDict["image"]?.append(urls as AnyObject)
                                            
                                        }
                                    }
                                    // self.offerSearchImage.append(image)
                                }
                                if let itemName = imageitem["_120_83"] as? String{
                                    
                                    if self.specialDict["name"] == nil{
                                        self.specialDict["name"] = [itemName  as AnyObject]
                                        
                                    }else{
                                        self.specialDict["name"]?.append(itemName as AnyObject)
                                        
                                    }
                                }
                                if let itemPriceName = imageitem["_122_162"] as? String{
                                    
                                    if self.specialDict["price"] == nil{
                                        self.specialDict["price"] = [itemPriceName  as AnyObject]
                                        
                                    }else{
                                        self.specialDict["price"]?.append(itemPriceName as AnyObject)
                                        
                                    }
                                    
                                }
                                self.specialItemArrayDict.append(self.specialDict as [String : AnyObject])
                                self.specialDict.removeAll()
                            }
                        }
                        
                        
                    }
                }
                
                
                DispatchQueue.main.async {
                    self.getProductAndServiceDataInfo()
                    
                }
            })
        }else{
        myModel.addManager.getItemsSpecials(byCategoryMobile: "010400479", userinfo: specialDict, completionResponse: { ( response,  error) in
            print(response)
            if let res:[[String : AnyObject]] = response as? [[String : AnyObject]]{
                self.loadSearchCollectionImage = res
                for items in self.loadSearchCollectionImage{
                    if let irImages = items["PC"] as? [[String:AnyObject]]{
                        
                        for imageitem in irImages{
                            
                            if let productID = imageitem["_114_112"] as? String{
                                
                                if self.specialDict["_114_112"] == nil{
                                    self.specialDict["_114_112"] = [productID  as AnyObject]
                                    
                                }else{
                                    self.specialDict["_114_112"]?.append(productID as AnyObject)
                                    
                                }
                            }
                            if let productID = imageitem["_120_157"] as? String{
                                let str = self.hexToStr(textValue: productID)
                                TestClassStore.storeAbout = str
                            }
                            if let productID = imageitem["_114_144"] as? String{
                                
                                if self.specialDict["productId"] == nil{
                                    self.specialDict["productId"] = [productID  as AnyObject]
                                    
                                }else{
                                    self.specialDict["productId"]?.append(productID as AnyObject)
                                    
                                }
                            }
                            if let image = imageitem["_121_170"] as? String{
                                
                                
                                let url =  self.urlImage.appending(image as String)
                                if let urls = NSURL(string: url) {
                                    if self.specialDict["image"] == nil{
                                        self.specialDict["image"] = [urls  as AnyObject]
                                        
                                    }else{
                                        self.specialDict["image"]?.append(urls as AnyObject)
                                        
                                    }
                                }
                            }
                            if let itemName = imageitem["_120_83"] as? String{
                                
                                if self.specialDict["name"] == nil{
                                    self.specialDict["name"] = [itemName  as AnyObject]
                                    
                                }else{
                                    self.specialDict["name"]?.append(itemName as AnyObject)
                                    
                                }
                            }
                            if let itemPriceName = imageitem["_122_162"] as? String{
                                
                                if self.specialDict["price"] == nil{
                                    self.specialDict["price"] = [itemPriceName  as AnyObject]
                                    
                                }else{
                                    self.specialDict["price"]?.append(itemPriceName as AnyObject)
                                    
                                }
                                
                            }
                            self.specialItemArrayDict.append(self.specialDict as [String : AnyObject])
                            self.specialDict.removeAll()
                        }
                    }

                    
                }
            }
            
           
            DispatchQueue.main.async {
                self.getProductAndServiceDataInfo()
               
            }
        })
        }
    }
    
    var productImageUrl:[URL]=[]
    var productServiceItemArrayDict:[[String:AnyObject]]=[]
    var productServiceDict:[String:[AnyObject]]=[:]
    func getProductAndServiceDataInfo(){
        var prodDict:[String:AnyObject]=[:]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let dateString = dateFormatter.string(from:Date())
        print(dateString)
        // @"yyyy-MM-dd hh:mm:ss"
        prodDict["53"]=loginUserId as AnyObject
        prodDict["121.141"]=dateString as AnyObject
        prodDict["127.89"]="2" as AnyObject
        if storeMerchantClass.storeMerchantIdBool == true{
            prodDict["114.179"] = storeMerchantClass.storeMerchantId as AnyObject
            myModel.addManager.getStoreSpecialsDetails("010400478", userinfo: prodDict, completionResponse: { ( response,  error) in
                print(response)
                if let res: [[String : AnyObject]] = response as? [[String : AnyObject]]{
                    self.productAndServiceArray = res
                    for items in self.productAndServiceArray{
                        if let irImages = items["RESULT"] as? [[String:AnyObject]]{
                            
                            for imageitem in irImages{
                                if let pc = imageitem["PC"] as? [[String:AnyObject]]{
                                    for pcitem in pc{
                                        if let productID = pcitem["_114_112"] as? String{
                                            if self.productServiceDict["_114_112"] == nil{
                                                self.productServiceDict["_114_112"] = [productID  as AnyObject]
                                                
                                            }else{
                                                self.productServiceDict["_114_112"]?.append(productID as AnyObject)
                                                
                                            }
                                        }
                                        if let productID = imageitem["_120_157"] as? String{
                                            let str = self.hexToStr(textValue: productID)
                                            TestClassStore.storeAbout = str
                                        }
                                        if let productID = pcitem["_114_144"] as? String{
                                            if self.productServiceDict["productId"] == nil{
                                                self.productServiceDict["productId"] = [productID  as AnyObject]
                                                
                                            }else{
                                                self.productServiceDict["productId"]?.append(productID as AnyObject)
                                                
                                            }
                                        }
                                        if let image = pcitem["_121_170"] as? String{
                                            
                                            
                                            let url =  self.urlImage.appending(image as String)
                                            if let urls = NSURL(string: url) {
                                                if self.productServiceDict["image"] == nil{
                                                    self.productServiceDict["image"] = [urls  as AnyObject]
                                                    
                                                }else{
                                                    self.productServiceDict["image"]?.append(urls as AnyObject)
                                                    
                                                }
                                            }
                                        }
                                        if let itemName = pcitem["_120_83"] as? String{
                                            
                                            if self.productServiceDict["name"] == nil{
                                                self.productServiceDict["name"] = [itemName  as AnyObject]
                                                
                                            }else{
                                                self.productServiceDict["name"]?.append(itemName as AnyObject)
                                                
                                            }
                                        }
                                        if let itemPriceName = pcitem["_114_98"] as? String{
                                            
                                            if self.productServiceDict["price"] == nil{
                                                self.productServiceDict["price"] = [itemPriceName  as AnyObject]
                                                
                                            }else{
                                                self.productServiceDict["price"]?.append(itemPriceName as AnyObject)
                                                
                                            }
                                            
                                        }
                                    }
                                }
                                self.productServiceItemArrayDict.append(self.productServiceDict as [String : AnyObject])
                                self.productServiceDict.removeAll()
                            }
                        }
                    }
                    
                    //                    }
                    //                }
                    
                }
                
                DispatchQueue.main.async {
                    self.getFavioratesItem()

                }
                
            })
        }else{
        
        myModel.addManager.productAndServiceImages("010400478", userinfo: prodDict, completionResponse: { ( response,  error) in
            print(response)
            if let res: [[String : AnyObject]] = response as? [[String : AnyObject]]{
                self.productAndServiceArray = res
                for items in self.productAndServiceArray{
                    if let irImages = items["RESULT"] as? [[String:AnyObject]]{
                        
                        for imageitem in irImages{
                             if let pc = imageitem["PC"] as? [[String:AnyObject]]{
                                 for pcitem in pc{
                                    if let productID = pcitem["_114_112"] as? String{
                                        if self.productServiceDict["_114_112"] == nil{
                                            self.productServiceDict["_114_112"] = [productID  as AnyObject]
                                            
                                        }else{
                                            self.productServiceDict["_114_112"]?.append(productID as AnyObject)
                                            
                                        }
                                    }
                                    
                                    
                                    
                                    
                            if let productID = pcitem["_114_144"] as? String{
                                if self.productServiceDict["productId"] == nil{
                                    self.productServiceDict["productId"] = [productID  as AnyObject]
                                    
                                }else{
                                    self.productServiceDict["productId"]?.append(productID as AnyObject)
                                    
                                }
                            }
                            if let image = pcitem["_121_170"] as? String{
                                
                                
                                let url =  self.urlImage.appending(image as String)
                                if let urls = NSURL(string: url) {
                                    if self.productServiceDict["image"] == nil{
                                        self.productServiceDict["image"] = [urls  as AnyObject]
                                        
                                    }else{
                                        self.productServiceDict["image"]?.append(urls as AnyObject)
                                        
                                    }
                                }
                            }
                            if let itemName = pcitem["_120_83"] as? String{
                                
                                if self.productServiceDict["name"] == nil{
                                    self.productServiceDict["name"] = [itemName  as AnyObject]
                                    
                                }else{
                                    self.productServiceDict["name"]?.append(itemName as AnyObject)
                                    
                                }
                            }
                            if let itemPriceName = pcitem["_114_98"] as? String{
                                
                                if self.productServiceDict["price"] == nil{
                                    self.productServiceDict["price"] = [itemPriceName  as AnyObject]
                                    
                                }else{
                                    self.productServiceDict["price"]?.append(itemPriceName as AnyObject)
                                    
                                }
                                
                            }
                                    
                                    if let itemPriceName = pcitem["_122_158"] as? String{
                                        
                                        if self.productServiceDict["discount"] == nil{
                                            self.productServiceDict["discount"] = [itemPriceName  as AnyObject]
                                            
                                        }else{
                                            self.productServiceDict["discount"]?.append(itemPriceName as AnyObject)
                                            
                                        }
                                        
                                    }
                                    
                                }
                            }
                            self.productServiceItemArrayDict.append(self.productServiceDict as [String : AnyObject])
                            self.productServiceDict.removeAll()
                        }
                    }
                }
                
//                    }
//                }
                
            }
            
            DispatchQueue.main.async {
                self.getFavioratesItem()

            }
            
        })
        }
    }
    
    var favioratesArray:[[String:AnyObject]]=[]
    var favioratesItemsDict:[String:[AnyObject]]=[:]
    var favioratesItemArrayDict:[[String:AnyObject]]=[]
    func getFavioratesItem(){
        var favDict:[String:AnyObject]=[:]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let dateString = dateFormatter.string(from:Date())
        print(dateString)
        // @"yyyy-MM-dd hh:mm:ss"
        favDict["53"]=loginUserId as AnyObject
        favDict["127.10"]="001"  as AnyObject
        favDict["114.112"]="21" as AnyObject
        if storeMerchantClass.storeMerchantIdBool == true{
            favDict["114.179"] = storeMerchantClass.storeMerchantId as AnyObject
            myModel.addManager.getStoreSpecialsDetails("010400221", userinfo: favDict, completionResponse: { ( response,  error) in
                print(response)
                if let res: [[String : AnyObject]] = response as? [[String : AnyObject]]{
                    self.favioratesArray = res
                    for items in self.favioratesArray{
                        if let irImages = items["RESULT"] as? [[String:AnyObject]]{
                            
                            for imageitem in irImages{
                                if let pc = imageitem["PC"] as? [[String:AnyObject]]{
                                    for pcitem in pc{
                                        
                                        
                                        if let productID = pcitem["_114_112"] as? String{
                                            if self.productServiceDict["_114_112"] == nil{
                                                self.productServiceDict["_114_112"] = [productID  as AnyObject]
                                                
                                            }else{
                                                self.productServiceDict["_114_112"]?.append(productID as AnyObject)
                                                
                                            }
                                        }

                                        if let productID = pcitem["_114_144"] as? String{
                                            if self.favioratesItemsDict["productId"] == nil{
                                                self.favioratesItemsDict["productId"] = [productID  as AnyObject]
                                                
                                            }else{
                                                self.favioratesItemsDict["productId"]?.append(productID as AnyObject)
                                                
                                            }
                                        }
                                        if let image = pcitem["_121_170"] as? String{
                                            
                                            
                                            let url =  self.urlImage.appending(image as String)
                                            if let urls = NSURL(string: url) {
                                                if self.favioratesItemsDict["image"] == nil{
                                                    self.favioratesItemsDict["image"] = [urls  as AnyObject]
                                                    
                                                }else{
                                                    self.favioratesItemsDict["image"]?.append(urls as AnyObject)
                                                    
                                                }
                                            }
                                            // self.offerSearchImage.append(image)
                                        }
                                        if let itemName = pcitem["_120_83"] as? String{
                                            
                                            if self.favioratesItemsDict["name"] == nil{
                                                self.favioratesItemsDict["name"] = [itemName  as AnyObject]
                                                
                                            }else{
                                                self.favioratesItemsDict["name"]?.append(itemName as AnyObject)
                                                
                                            }
                                            //  self.itemNames.append(itemName)
                                        }
                                        if let itemPriceName = pcitem["_114_98"] as? String{
                                            
                                            if self.favioratesItemsDict["price"] == nil{
                                                self.favioratesItemsDict["price"] = [itemPriceName  as AnyObject]
                                                
                                            }else{
                                                self.favioratesItemsDict["price"]?.append(itemPriceName as AnyObject)
                                                
                                            }
                                            
                                            // self.itemPriceName.append(itemPriceName)
                                        }
                                    }
                                }
                                self.favioratesItemArrayDict.append(self.favioratesItemsDict as [String : AnyObject])
                                self.favioratesItemsDict.removeAll()
                            }
                        }
                    }
                    
                    //                    }
                    //                }
                    
                }
                
                DispatchQueue.main.async {
                    
                    self.progressView.stopAnimating()
                    self.progressView.isHidden=true
                    self.hiddenView.isHidden = true
                    
                    self.itemsTblView.isUserInteractionEnabled = true
                    self.itemsTblView.reloadData()
                }
                
            })
        }else{
            
            myModel.addManager.productAndServiceImages("010400221", userinfo: favDict, completionResponse: { ( response,  error) in
                print(response)
                if let res: [[String : AnyObject]] = response as? [[String : AnyObject]]{
                    self.favioratesArray = res
                    for items in self.favioratesArray{
                        if let irImages = items["RESULT"] as? [[String:AnyObject]]{
                            
                            for imageitem in irImages{
                                if let pc = imageitem["PC"] as? [[String:AnyObject]]{
                                    for pcitem in pc{
                                        if let productID = pcitem["_114_112"] as? String{
                                            if self.productServiceDict["_114_112"] == nil{
                                                self.productServiceDict["_114_112"] = [productID  as AnyObject]
                                                
                                            }else{
                                                self.productServiceDict["_114_112"]?.append(productID as AnyObject)
                                                
                                            }
                                        }
                                        if let productID = pcitem["_114_144"] as? String{
                                            if self.favioratesItemsDict["productId"] == nil{
                                                self.favioratesItemsDict["productId"] = [productID  as AnyObject]
                                                
                                            }else{
                                                self.favioratesItemsDict["productId"]?.append(productID as AnyObject)
                                                
                                            }
                                        }
                                        if let image = pcitem["_121_170"] as? String{
                                            
                                            
                                            let url =  self.urlImage.appending(image as String)
                                            if let urls = NSURL(string: url) {
                                                if self.favioratesItemsDict["image"] == nil{
                                                    self.favioratesItemsDict["image"] = [urls  as AnyObject]
                                                    
                                                }else{
                                                    self.favioratesItemsDict["image"]?.append(urls as AnyObject)
                                                    
                                                }
                                            }
                                            // self.offerSearchImage.append(image)
                                        }
                                        if let itemName = pcitem["_120_83"] as? String{
                                            
                                            if self.favioratesItemsDict["name"] == nil{
                                                self.favioratesItemsDict["name"] = [itemName  as AnyObject]
                                                
                                            }else{
                                                self.favioratesItemsDict["name"]?.append(itemName as AnyObject)
                                                
                                            }
                                            //  self.itemNames.append(itemName)
                                        }
                                        if let itemPriceName = pcitem["_114_98"] as? String{
                                            
                                            if self.favioratesItemsDict["price"] == nil{
                                                self.favioratesItemsDict["price"] = [itemPriceName  as AnyObject]
                                                
                                            }else{
                                                self.favioratesItemsDict["price"]?.append(itemPriceName as AnyObject)
                                                
                                            }
                                            
                                            // self.itemPriceName.append(itemPriceName)
                                        }
                                    }
                                }
                                self.favioratesItemArrayDict.append(self.favioratesItemsDict as [String : AnyObject])
                                self.favioratesItemsDict.removeAll()
                            }
                        }
                    }
                    
                    //                    }
                    //                }
                    
                }
                
                DispatchQueue.main.async {
                    
                    self.progressView.stopAnimating()
                    self.progressView.isHidden=true
                    self.hiddenView.isHidden = true
                    
                    self.itemsTblView.isUserInteractionEnabled = true
                    self.itemsTblView.reloadData()
                }
                
            })
        }
    }
    @IBAction func viewAllAdsBtntapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddDetailViewController") as! AddDetailViewController
        TestClass.doubleVar = 2;
        TestClass2.doubleVarBool = true;
        didSelectSpecial!(2,true)
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    var storeProductId:String = ""
     var didSelectSpecial: ((Int,Bool) -> ())?
    var didSelectfav: ((Int,Bool) -> ())?
    @IBAction func viewAllSpecialBtntapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PagerVC") as! PagerVC
        TestClass.doubleVar = 3;
        TestClass2.doubleVarBool = true;
        didSelectSpecial!(3,true)
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    var didSelectProductService: ((Int,Bool) -> ())?
    @IBAction func viewAllProductAndServiceBtntapp(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PagerVC") as! PagerVC
        TestClass.doubleVar = 4;
        TestClass2.doubleVarBool = true;
        didSelectProductService!(4,true)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    @IBAction func viewAllfavItems(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PagerVC") as! PagerVC
        TestClass.doubleVar = 5;
        TestClass2.doubleVarBool = true;
        didSelectfav!(5,true)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    var storeNameStr:String = ""
    var imageStr:String = ""
    var imageUrls:URL? = nil
    var changeData: ((String,String) -> ())?
    var didSelectStoreRow: ((String,[String]) -> ())?
    @IBAction func storeDetailInfo(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ItemRatingVC") as!  ItemRatingVC
        vc.merchantId = TestClassStore.storeMerchantId
        vc.imageGetUrl = imageUrl
        didSelectStoreRow!(TestClassStore.storeMerchantId,imageUrl)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func viewDidAppear(_ animated: Bool) {
       
        if TestClassStore.storeName != ""{
           // storeView.isHidden=false
      storeNameStr =   TestClassStore.storeName
        //imageStr =   TestClassStore.storeNameImage
            imageUrls = TestClassStore.storeNameImage
            itemsTblView.reloadData()
            
        }
        
    }
    
    func getStoreDetails(_ storeName: String, _ imageUrl: String) {
        storeNameStr = storeName
        
        imageStr = imageUrl
    }
    func changeBackgroundColor(_ storeName: String, _ imageUrl: String) {
        changeData!(storeName,imageUrl)
        storeView.isHidden=false
        storeNameStr = storeName
        
        imageStr = imageUrl
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }
        if section == 1{
            return 1
        }
        if section == 2{
            return 1
        }
//        if section == 3{
//            return 1
//        }
        return 1
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if specialItemArrayDict.count>0{
        return 10.0
        }else{
            return 0
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.tag == 701{
            return 44
        }else{
            if indexPath.section==0{
                return 270
            }
        if indexPath.section==1{
            if specialItemArrayDict.count <= 0{
                return 0
            }else{
                return 230
            }
        }
            if indexPath.section==2{
            if productServiceItemArrayDict.count <= 0{
                return 0
            }else{
                return 230
            }
        }
            if indexPath.section==3{
                if productServiceItemArrayDict.count <= 0{
                    return 0
                }else{
                    return 230
                }
            }
        }
        return 80
    }
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      
        
        if collectionView.tag == 501 || collectionView.tag == 502 || collectionView.tag == 503
        {
            return CGSize(width: collectionView.frame.size.height/1.5, height: collectionView.frame.size.height-10)
        }
        else
        {
        
        let cellsAcross: CGFloat = 3
        let spaceBetweenCells: CGFloat = 1
        let dim = (collectionView.bounds.width - (cellsAcross - 1) * spaceBetweenCells) / cellsAcross
        return CGSize(width: collectionView.frame.size.height/1.5, height: collectionView.frame.size.height-10)

        }
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view:UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.size.width, height: 10))
        view.backgroundColor = UIColor.groupTableViewBackground
        
        return view
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            let cell = itemsTblView.dequeueReusableCell(withIdentifier: "addsItemsCell") as! addsItemsCell
            cell.addsScrollView.delegate=self
            if imageUrl.count>indexPath.row{
                 cell.addBtn.isHidden = false
                cell.viewAllAdsBtn.isHidden = false
                cell.pageControl.isHidden=true
            }else{
                cell.addBtn.isHidden = true
               
                cell.storeView.isHidden=true
                cell.viewAllAdsBtn.isHidden = true
                cell.pageControl.isHidden=true
            }
            if cell.storeView.isHidden == true
            {
                cell.storeViewheight.constant = 0
            }
            else
            {
                cell.storeViewheight.constant = 35
            }
            if TestClassStore.storeName  != ""{
                cell.storeView.isHidden = false
              
                cell.storeNmeLbl.text = TestClassStore.storeName  // mycode
                cell.storeDetailLbl.setTitle("Store Details", for: .normal) // mycode
                cell.storeImgView.sd_setImage(with: TestClassStore.storeNameImage) //my code
                }else{
                    cell.storeView.isHidden=true
                    cell.storeNmeLbl.text = TestClassStore.storeName
                    cell.storeDetailLbl.setTitle("Store Details", for: .normal)
                    cell.storeImgView.sd_setImage(with: TestClassStore.storeNameImage)
                    

            }
            
            return cell
        }
        if indexPath.section == 1{
            let cell = itemsTblView.dequeueReusableCell(withIdentifier: "specialCell") as! specialCell
            if specialItemArrayDict.count>indexPath.row{
            cell.specialLbl.text = "Special"
            cell.viewAllBtn.setTitle("Show All", for: .normal)
            }
            
            DispatchQueue.main.async {
                cell.specialCollectionView.reloadData()
            }
            return cell
        }
        if indexPath.section == 2{
            let cell = itemsTblView.dequeueReusableCell(withIdentifier: "productAndServiceCell") as! productAndServiceCell
             if productAndServiceArray.count>indexPath.row{
            cell.productionServiceLbl.text = "Items"
            cell.viewAllItemBtn.setTitle("Show All", for: .normal)
            }
            DispatchQueue.main.async {
                cell.productServiceCollectionView.reloadData()
            }
            return cell
        }

        return UITableViewCell()
    }
    var messageFrame = UIView()
    var strLabel = UILabel()
    let loadingView = UIView()
    
    /// Spinner shown during load the TableView
    let spinner = UIActivityIndicatorView()
    
    /// Text shown during load the TableView
    let loadingLabel = UILabel()
    var activityIndicator = UIActivityIndicatorView()
    private func setLoadingScreen() {
        
        // Sets the view which contains the loading text and the spinner
        let width: CGFloat = 120
        let height: CGFloat = 30
        let x = (itemsTblView.frame.width / 2) - (width / 2)
        let y = (itemsTblView.frame.height / 2) - (height / 2) - (navigationController?.navigationBar.frame.height)!
        loadingView.frame = CGRect(x: x, y: y, width: width, height: height)
        
        // Sets loading text
        loadingLabel.textColor = .gray
        loadingLabel.textAlignment = .center
        loadingLabel.text = "Loading..."
        loadingLabel.frame = CGRect(x: 0, y: 0, width: 140, height: 30)
        
        // Sets spinner
        spinner.activityIndicatorViewStyle = .gray
        spinner.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        spinner.startAnimating()
        
        // Adds text and spinner to the view
        loadingView.addSubview(spinner)
        loadingView.addSubview(loadingLabel)
        
        itemsTblView.addSubview(loadingView)
        
    }
    func dataWithHexString(hex: String) -> Data {
        var hex = hex
        var data = Data()
        while(hex.characters.count > 0) {
            let c: String = hex.substring(to: hex.index(hex.startIndex, offsetBy: 2))
            hex = hex.substring(from: hex.index(hex.startIndex, offsetBy: 2))
            var ch: UInt32 = 0
            Scanner(string: c).scanHexInt32(&ch)
            var char = UInt8(ch)
            data.append(&char, count: 1)
        }
        return data
    }

    
    //extension SearchItemsVC:UICollectionViewDelegate,UICollectionViewDataSource{
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag==501{
            return specialItemArrayDict.count
        }
        if collectionView.tag==502{
            return productServiceItemArrayDict.count
        }
        if collectionView.tag==503{
            return productServiceItemArrayDict.count
        }
        return 1
    }
    var didSelectRow: (([String:AnyObject],Int) -> ())?
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         if collectionView.tag == 501{//soecial collaction
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ItemDetailVC") as! ItemDetailVC
             let vc2 = PagerController()
           specialClass.specialFlag = true
            let specialItem =   specialItemArrayDict[indexPath.row]
            vc.delegateStore = self

            didSelectRow!(specialItem,indexPath.row)
             vc2.delegateStore = self
            self.navigationController?.pushViewController(vc, animated: true)
         }
        if collectionView.tag == 502{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ItemDetailVC") as! ItemDetailVC
            let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "PagerVC") as! PagerVC
             let specialItem2 =   productServiceItemArrayDict[indexPath.row]
            vc.delegateStore = self
            specialClass.specialFlag = false
            vc.selecteditem = indexPath.row
            vc.itemDetailvc = productServiceItemArrayDict
            didSelectRow!(specialItem2,indexPath.row)
             vc2.delegateStore = self
        }
        if collectionView.tag == 503{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ItemDetailVC") as! ItemDetailVC
            let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "PagerVC") as! PagerVC
            let specialItem3 =   favioratesItemArrayDict[indexPath.row]
            vc.delegateStore = self
            specialClass.specialFlag = false
            vc.selecteditem = indexPath.row
            vc.itemDetailvc = productServiceItemArrayDict
            didSelectRow!(specialItem3,indexPath.row)
            vc2.delegateStore = self
        }
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
   
        if collectionView.tag == 501{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeSpecialDataCell", for: indexPath) as! homeSpecialDataCell
//            cell.viewOuter.layer.borderWidth = 1
//            cell.viewOuter.layer.borderColor = UIColor(red: 220/256.0, green: 220/256.0, blue: 220/256.0, alpha: 1.0).cgColor
//            cell.viewOuter.layer.cornerRadius = 3.0
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
            
            let specialItem =   specialItemArrayDict[indexPath.row]
            
            if let name = specialItem["name"] as? [String]{
                cell.titleLbl.text =  name[0]
                
                
                
            }

            if let image = specialItem["image"] as? [URL]{
                
                cell.specialImageView.sd_setImage(with: image[0] as URL!)
                
                
            }
            if let price = specialItem["price"] as? [String]{
                
                cell.priceLbl.text = "$" + price[0]
                
                
            }
            
            

            return cell
        }
        if collectionView.tag == 502{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeProductionServiceDataCell", for: indexPath) as! homeProductionServiceDataCell
            cell.viewOuter.layer.borderWidth = 1
            cell.viewOuter.layer.borderColor = UIColor(red: 220/256.0, green: 220/256.0, blue: 220/256.0, alpha: 1.0).cgColor
            cell.viewOuter.layer.cornerRadius = 3.0
            cell.viewOuter.clipsToBounds = true
            
            cell.viewOuter.layer.masksToBounds = false
            cell.viewOuter.layer.shadowColor = UIColor.lightGray.cgColor
            cell.viewOuter.layer.shadowOpacity = 0.3
            cell.viewOuter.layer.shadowOffset = CGSize(width: -1, height: 1)
            cell.viewOuter.layer.shadowRadius = 1
            
            cell.viewOuter.layer.shadowPath = UIBezierPath(rect: cell.bounds).cgPath
            cell.viewOuter.layer.shouldRasterize = true
            cell.viewOuter.layer.rasterizationScale = 1
            
            let specialItem =   productServiceItemArrayDict[indexPath.row]
            if productServiceItemArrayDict.count>indexPath.row{
            if let name = specialItem["name"] as? [String]{
                cell.productionServiceTitleLbl.text =  self.hexToStr(textValue: name[0])
                
                
                
            }
            if let image = specialItem["image"] as? [URL]{
                
                cell.productServiceImageView.sd_setImage(with: image[0] as URL!)
                
                
            }
            if let price = specialItem["price"] as? [String]{
                
                if let discountPrice = specialItem["discount"] as? [String]{
                    var actualPrice =  price[0]
                    let disPrice = discountPrice[0]
                    let actualPriceInt:Double = Double(actualPrice)!
                    let disPriceInt:Double = Double(disPrice)!
                    if disPrice == "0" || disPrice == "0.00" || actualPrice == disPrice{
                        cell.productionPriceLbl.text = "$" + actualPrice

                    }else if actualPriceInt > disPriceInt{
                        actualPrice = "$" + actualPrice
                        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: actualPrice)
                        attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
                        cell.productionPriceLbl.attributedText =  attributeString
                        
                        cell.productionDisPriceLbl.text = "$" + disPrice
                    }
                    
                }
                
            }
            
            return cell
            }
        }

        return UICollectionViewCell()
    }
    @IBAction func storeDetailBtnTap(_ sender: Any) {
        
    }

  
 
}
