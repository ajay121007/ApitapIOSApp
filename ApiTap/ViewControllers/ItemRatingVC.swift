//
//  ItemRatingVC.swift
//  ApiTap
//
//  Created by AppZorro on 25/09/17.
//  Copyright © 2017 ApiTap. All rights reserved.
//

import UIKit
import CoreLocation

class getLocationCell:UITableViewCell{
    @IBOutlet weak var locationCollectionView: UICollectionView!
      @IBOutlet weak var noLocationFoundView: UIView!
}
class addCell:UITableViewCell{
     @IBOutlet var addImageView:UIImageView!
    @IBOutlet var addScrollView:UIScrollView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
class showAllLocationCell:UICollectionViewCell{
    
    @IBOutlet var numLbl: UILabel!
    @IBOutlet var streetLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var cityNamelabl: UILabel!
    @IBOutlet var milesLbl: UILabel!
    
}

class ratingCell:UITableViewCell{
    @IBOutlet var selectImage:UIImageView!
    @IBOutlet var storeDetalsBtm: UIButton!
    
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var storeNameLbl: UILabel!
    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var starBtn1: UIButton!
    @IBOutlet weak var ratingView: UIView!
    
    @IBOutlet weak var starBtn5: UIButton!
    @IBOutlet weak var starBtn4: UIButton!
    @IBOutlet weak var starBtn3: UIButton!
    @IBOutlet weak var starBtn2: UIButton!
    override func awakeFromNib() {
        storeDetalsBtm.layer.cornerRadius = 5
        storeDetalsBtm.clipsToBounds = true
    }
}
class aboutCell:UITableViewCell{
    
    @IBOutlet var aboutSelectImage: UIImageView!
    @IBOutlet weak var aboutTxtView: UITextView!
    @IBOutlet weak var aboutLbl: UILabel!
}
class descriptionCell:UITableViewCell{
    
}
class ItemRatingVC: BaseViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate{
    
    var locationManager:CLLocationManager!
    var urlImage:String = "http://209.46.35.217:8085/ServerImage/images/"
    var merchantrating:String = ""
    var merchantId:String = ""
    var dictParam:[String:AnyObject] = [:]
    var ratingParam:[[String:AnyObject]] = []
    var locationDict:[String:AnyObject]=[:]
    var getLocation:[[String:AnyObject]]=[]
    var dictparam:[String:AnyObject]=[:]
    var loginUserId:String = ""
    var arrayFinalData:[String]=[]
    var imageGetUrl:[String]=[]
    var storeName:String = ""
    var ratingNum:String = ""
    
    @IBOutlet weak var activityIndicater: UIActivityIndicatorView!
    @IBOutlet weak var hiddenBlureView: UIView!
    @IBOutlet weak var blureView: UIView!
    @IBOutlet weak var contentLabel: UILabel!
    let contentsLb = UILabel()
    var descText:String = ""
    var descText2:String = ""
    @IBOutlet weak var itemRatingTblView: UITableView!
    var myModel = ModelManager()
    var favArr:[String]=[]
    var productid:String = ""
    var storeFlag:Bool = false
    
    var loading_1: UIImage!
    var loading_2: UIImage!
    var loading_3: UIImage!
    
    var images: [UIImage]!
    
    var animatedImage: UIImage!
    var mrId:String = ""
    var text: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        determineMyCurrentLocation()
        self.initializeNavBar()
        self.setbarButtonItems()
        print(imageGetUrl)
        loading_1 = UIImage(named: "Grey_Square")
        loading_2 = UIImage(named: "whiteLoader")
        loading_3 = UIImage(named: "skyBlue")
        images = [loading_1, loading_2, loading_3]
        animatedImage = UIImage.animatedImage(with: images, duration: 1.0)
        let timer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
      
        activityIndicater.startAnimating()
        
        itemRatingTblView.estimatedRowHeight = 68.0
        itemRatingTblView.rowHeight = UITableViewAutomaticDimension
        hiddenBlureView.isHidden = false
        hiddenBlureView.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
       // itemRatingTblView.isUserInteractionEnabled = false
        
        
        
       dictParam["53"] =  merchantId as AnyObject
        
        
        print(merchantId)
        mrId = merchantId
        itemRatingTblView.delegate=self
        itemRatingTblView.dataSource=self
        itemRatingTblView.reloadData()
        //getCard
       //  getAdd()
        
        
     
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            //locationManager.startUpdatingHeading()
        }
    }
    var latitude:Double = 0.0
    var longitude:Double = 0.0
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        // Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.
        
        // manager.stopUpdatingLocation()
        latitude = userLocation.coordinate.latitude
            longitude = userLocation.coordinate.longitude
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
        showAdd()
        self.getLocations()
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
    var didSelectSpecial: ((Int,Bool) -> ())?
    @IBAction func showAllAdsBtnClick(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddDetailViewController") as! AddDetailViewController
         //didSelectSpecial!(2,true)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func showAdd(){
        let cell = self.itemRatingTblView.cellForRow(at: IndexPath(row: 0, section: 2)) as! addCell
        for i in 0..<self.imageGetUrl.count{
            DispatchQueue.global(qos: .background).async {
                if let url = NSURL(string: self.imageGetUrl[i]) {
                    if let data = NSData(contentsOf: url as URL) {
                        
                        self.allImage.append(UIImage(data: data as Data)!)
                        
                        let xPosition = self.view.frame.width * CGFloat(i)
                        let image = UIImageView()
                         DispatchQueue.main.async(execute: { () -> Void in
                        image.image = UIImage(data: data as Data)
                         })
                        image.frame = CGRect(x: xPosition, y: 0, width: cell.addScrollView.frame.size.width, height: cell.addScrollView.frame.size.height)
                        image.contentMode = .scaleAspectFit
                        cell.addScrollView.contentSize.width =  self.view.frame.width * CGFloat(i+1)
                        
                       
                            
                            cell.addScrollView.addSubview(image)
                        self.activityIndicater.stopAnimating()
                        self.activityIndicater.isHidden=true
                        self.hiddenBlureView.isHidden = true
                        //})
                    }
                }
            }
        }
        
    }
    
   
    func getBuisnessdetails(){
        myModel.addManager.getItemRating("010100020", userinfo: dictParam, completionResponse: { ( response,  error) in
            
            print(response)
            if let res = response as? [[String : AnyObject]]{
                self.ratingParam = res
                for item in self.ratingParam{
                    if var ratings = item["RESULT"] as? [[String:AnyObject]]{
                        for rati in ratings{
                            if let mRating = rati["_121_80"] as? String{
                                self.merchantId = mRating
                            }
                            if let storeName = rati["_114_70"] as? String{
                                self.storeName = storeName
                            }
                            if let ratingNums = rati["_122_19"] as? String{
                                self.ratingNum = ratingNums
                            }
                            if let mRating = rati["_121_170"] as? String{
                                
                                self.imageUrlStr =  self.urlImage.appending(mRating as String)
                            }
                            if let desc = rati["_121_157"] as? String{
                                
                                self.descText2 =  desc
                            }
                        }
                    }
                }
            }
            DispatchQueue.main.async {
                
                self.itemRatingTblView.reloadData()
            }
            //
        })
    }
    func getLocations(){
        var dParam:[String:AnyObject]=[:]
        dParam["53"] = merchantId as AnyObject
         dParam["120.38"] = String(self.latitude) as AnyObject
        dParam["120.39"] = String(self.longitude) as AnyObject
        myModel.addManager.getMap("010400516", userinfo: dParam, completionResponse: { ( response,  error) in
            print(response)
            
            if let res = response as? [[String:AnyObject]]{
                for item in res{
                    if let result = item["RESULT"] as? [[String:AnyObject]]{
                        for invoiceItem in result{
                            if let getLoc = invoiceItem["_47_8"] as? String{
                                self.locationDict["location"] = getLoc as AnyObject
                            }
                            if let ad = invoiceItem["AD"] as? [String:AnyObject]{
                                print(ad)
                                if let locations = ad["ZP"] as? [String:AnyObject]{
                                    //for getLoc in locations{
                                    if let lat = locations["_120_38"] as? String{
                                        self.locationDict["lat"] = lat as AnyObject
                                    }
                                    if let long = locations["_120_39"] as? String{
                                        self.locationDict["long"] = long as AnyObject
                                    }
                                    
                                    //}
                                }
                                if let country = ad["CO"] as? [String:AnyObject]{
                                    if let contr = country["_47_18"] as? String{
                                        self.locationDict["country"] = contr as AnyObject
                                    }
                                }
                                if let subAdd1 = ad["_114_12"] as? String{
                                    self.locationDict["subAdd1"] = subAdd1 as AnyObject
                                }
                                if let subAdd2 = ad["_114_13"] as? String{
                                    self.locationDict["subAdd2"] = subAdd2 as AnyObject
                                }
                                self.getLocation.append(self.locationDict)
                            }
                            
                        }
                    }
                }
            }
            
            self.activityIndicater.stopAnimating()
            self.activityIndicater.isHidden=true
            self.hiddenBlureView.isHidden = true
            self.itemRatingTblView.reloadData()
           
           self.getBuisnessdetails()
          
            
        })
    }
    func getAdd(){
        
        if let result = UserDefaults.standard.value(forKey: "loginUserID") as? String{
            loginUserId = result as! String
            print(result)
        }
      //  let cell = mapTblView.cellForRow(at: IndexPath(row: 0, section: 1)) as! mapCell
        dictparam["53"] = loginUserId as AnyObject
        myModel.addManager.addSearchImages("010200517", userinfo: dictparam, completionResponse: { ( response,  error) in
            
            print(response)
            if let res: [[String : AnyObject]]  = response as? [[String : AnyObject]]{
                //self.searchItems = res
                
                for items in res{
                    if let irImages = items["RESULT"] as? [[String:AnyObject]]{
                        for imageitem in irImages{
                            if let image:String = imageitem["_121_170"] as? String{
                                
                                print(image)
                                self.arrayFinalData.append(image)
                                
                            }
                        }
                        for itemImages in self.arrayFinalData{
                            if let urlStr:String = itemImages as? String{
                                
                                let url =  self.urlImage.appending(urlStr as String)
                              //  self.imageUrl.append(url)
                            }
                            
                        }

                        
                    }
                }
                
            }else{
                
            }
            
            DispatchQueue.main.async {
                
                
                self.itemRatingTblView.isUserInteractionEnabled = true
                
                self.itemRatingTblView.reloadData()
            }
        })
    }
    var offSet: CGFloat = 0
    func autoScroll() {
        if let cell = self.itemRatingTblView.cellForRow(at: IndexPath(row: 0, section: 2)) as? addCell{
            let totalPossibleOffset = CGFloat(imageGetUrl.count - 1) * self.view.bounds.size.width
            if offSet == totalPossibleOffset {
                offSet = 0 // come back to the first image after the last image
            }
            else {
                offSet += self.view.bounds.size.width
            }
            DispatchQueue.main.async() {
                UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveLinear, animations: {
                    cell.addScrollView.contentOffset.x = CGFloat(self.offSet)
                    let cell = self.itemRatingTblView.cellForRow(at: IndexPath(row: 0, section: 2)) as! addCell
                    let x = cell.addScrollView.contentOffset.x
                    let w = cell.addScrollView.bounds.size.width
                    //cell.pageControl.currentPage = Int(x/w)
                }, completion: nil)
            }
        }
    }
    var imageUrlStr:String = ""
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        return 1
        
    }
     func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
     return 1.0
    } 
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view:UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.size.width, height: 1))
        view.backgroundColor = .lightGray
        
        return view
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    var urlPath:URL!
    var allImage:[UIImage]=[]
    var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    
    @IBAction func backBtnPress(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        itemRatingTblView.separatorStyle = .none
        
        if indexPath.section == 0{
        let cell = itemRatingTblView.dequeueReusableCell(withIdentifier: "ratingCell", for: indexPath) as! ratingCell
            cell.selectionStyle = .none
            if storeName != ""{
           cell.storeNameLbl.text = storeName
            }
            if favArr.contains(productid){
                cell.favBtn.setImage(UIImage(named:"favourite-red.png"), for: .normal)
            }
            if let url = NSURL(string: imageUrlStr) {
                urlPath = url as URL!
                cell.selectImage.sd_setImage(with: urlPath as URL!)
            }
            if ratingNum == "0"{
                cell.ratingLbl.text = "No Ratings"
            }
            if let dotRange = ratingNum.range(of: ".") {
                ratingNum.removeSubrange(dotRange.lowerBound..<ratingNum.endIndex)
            }
        if ratingNum == "1"{
            cell.ratingLbl.text = ratingNum
            cell.starBtn1.setImage(UIImage(named:"yStar"), for: .normal)
           
            }
            if ratingNum == "2"{
                 cell.ratingLbl.text = ratingNum
                cell.starBtn1.setImage(UIImage(named:"yStar"), for: .normal)
                cell.starBtn2.setImage(UIImage(named:"yStar"), for: .normal)
            }
            if ratingNum == "3"{
                 cell.ratingLbl.text = ratingNum
                cell.starBtn1.setImage(UIImage(named:"yStar"), for: .normal)
                cell.starBtn2.setImage(UIImage(named:"yStar"), for: .normal)
                 cell.starBtn3.setImage(UIImage(named:"yStar"), for: .normal)
            }
            if ratingNum == "4"{
                 cell.ratingLbl.text = ratingNum
                cell.starBtn1.setImage(UIImage(named:"yStar"), for: .normal)
                cell.starBtn2.setImage(UIImage(named:"yStar"), for: .normal)
                 cell.starBtn3.setImage(UIImage(named:"yStar"), for: .normal)
                 cell.starBtn4.setImage(UIImage(named:"yStar"), for: .normal)
            }
            if ratingNum == "5"{
                 cell.ratingLbl.text = ratingNum
                cell.starBtn1.setImage(UIImage(named:"yStar"), for: .normal)
                cell.starBtn2.setImage(UIImage(named:"yStar"), for: .normal)
                 cell.starBtn3.setImage(UIImage(named:"yStar"), for: .normal)
                cell.starBtn4.setImage(UIImage(named:"yStar"), for: .normal)
                 cell.starBtn5.setImage(UIImage(named:"yStar"), for: .normal)
            }
        return cell
        }
        if indexPath.section == 1{
            let cell = itemRatingTblView.dequeueReusableCell(withIdentifier: "aboutCell", for: indexPath) as! aboutCell
            if descText2 != ""{
                // cell.aboutTxtView.text = descText2
               // cell.aboutTxtView.text = descText2 // temp
            }else{
           // cell.aboutTxtView.text = TestClassStore.storeAbout  // temp
               // cell.aboutLbl.text = descText
            }
            cell.aboutSelectImage.sd_setImage(with: urlPath as URL!)
            return cell
        }
        if indexPath.section == 2{
            let cell = itemRatingTblView.dequeueReusableCell(withIdentifier: "addCell", for: indexPath) as! addCell
//            if imageUrl.count>indexPath.row{
//
//            DispatchQueue.global(qos: .userInitiated).async {
//                for i in 0..<self.imageUrl.count{
//                    if let url = NSURL(string: self.imageUrl[i]) {
//                        if let data = NSData(contentsOf: url as URL) {
//                            // let imageView = UIImageView()
//                         //   self.allImage.append(UIImage(data: data as Data)!)
//                            // imageView.image = UIImage(data: data as Data)
//                            let xPosition = self.view.frame.width * CGFloat(i)
//                            let image = UIImageView()
//                            image.image = UIImage(data: data as Data)
//                            image.frame = CGRect(x: xPosition, y: 0, width: cell.addScrollView.frame.size.width, height: cell.addScrollView.frame.size.height)
//
//                            cell.addScrollView.contentSize.width =  self.view.frame.width * CGFloat(i+1)
////                            self.frame.origin.x = cell.addScrollView.frame.size.width * CGFloat(i)
////                            self.frame.size = cell.addScrollView.frame.size
////                            let image = UIImageView(frame: self.frame)
////                            // let image = UIImageView(frame:frame)
////
////                            image.image = UIImage(data: data as Data)
//                            // view.backgroundColor = colors[pageControl.currentPage]
//                            DispatchQueue.main.async(execute: { () -> Void in
//                            cell.addScrollView.addSubview(image)
//                            })
//
//
//                        }
//                    }
//                }
//               }
//               // cell.addScrollView.contentSize = CGSize(width: (cell.addScrollView.frame.size.width * CGFloat(self.imageUrl.count)), height: cell.addScrollView.frame.size.height)
//            }else{
//               // cell.addImageView.contentMode = .scaleAspectFit
//                 let images = UIImage.gifImageWithName("2")
//                let imageView = UIImageView(image: images)
//                imageView.frame = CGRect(x: 20.0, y: 50.0, width: self.view.frame.size.width - 40, height: 150.0)
//               cell.addScrollView.addSubview(imageView)
//              //  cell.addImageView.image = images
//            }
            //cell.aboutTxtView.text = descText
            
            return cell
        }
        if indexPath.section == 3{
            let cell = itemRatingTblView.dequeueReusableCell(withIdentifier: "getLocationCell", for: indexPath) as! getLocationCell
            if self.getLocation.count>0{
                cell.locationCollectionView.isHidden=false
            }else{
                cell.locationCollectionView.isHidden=true
                cell.noLocationFoundView.isHidden=false
                cell.noLocationFoundView.layer.borderWidth=1
                cell.noLocationFoundView.layer.cornerRadius = 5
                cell.noLocationFoundView.layer.borderColor = UIColor(red: 13/256.0, green:  102/256.0, blue:  202/256.0, alpha: 1.0).cgColor
            }
            cell.locationCollectionView.reloadData()
            return cell
        }
//        if indexPath.section == 2{
//            let cell = itemRatingTblView.dequeueReusableCell(withIdentifier: "descriptionCell", for: indexPath) as! descriptionCell
//            
//            return cell
//        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 90
        }
        if indexPath.section == 1{
            if descText != ""{
            var height:CGFloat = self.calculateHeight(inString:descText)
            return height + 20.0
            }else{
                var height:CGFloat = self.calculateHeight(inString:TestClassStore.storeAbout)
                return 130
              // return height + 30.0
            }
            
            
        }
        if indexPath.section == 2{
           
            return 200
        }
        if indexPath.section == 3{
            
            return 170
        }
//        if indexPath.section == 2{
//            return 90
//        }
        return 44
    }
    let hiddenView = UIView()
    let contentView = UIView()
    let messageFrame = UIView()
    let deviderLineView = UIView()
    let keyContentLabel = UILabel()
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        blureView.isHidden = false
        blureView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
      //  tableView.isUserInteractionEnabled = false
        sleep(0)
        let font = UIFont(name: "HelveticaNeue-Light", size: 15)
        let width = UIScreen.main.bounds.width-40
        //let height = self.calculateHeightForString(content!, font: font!, width:width)
        hiddenView.frame = CGRect(x:10, y:UIScreen.main.bounds.height/2-(200)/2-25, width:UIScreen.main.bounds.width-20,height: 300)
        hiddenView.backgroundColor = UIColor.clear
        contentView.frame = CGRect(x:20, y:UIScreen.main.bounds.height/2-(200)/2, width:UIScreen.main.bounds.width-40, height:150)
        contentView.backgroundColor = UIColor.yellow
        contentView.layer.cornerRadius = 7
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor(red: 21.0/255.0, green: 162.0/255.0, blue: 198.0/255.0, alpha: 1.0).cgColor
        deviderLineView.frame = CGRect(x:5, y:35, width:contentView.bounds.width-10,height: 1)
        deviderLineView.backgroundColor = UIColor(red: 21.0/255.0, green: 162.0/255.0, blue: 198.0/255.0, alpha: 1.0)
        contentView.backgroundColor = UIColor.white
        
        keyContentLabel.frame = CGRect(x:10, y:5,width:contentView.frame.width-20,height: 25)
        keyContentLabel.numberOfLines = 0
        //keyContentLabel.text = key
        keyContentLabel.textAlignment = NSTextAlignment.center
        keyContentLabel.textColor = UIColor(red: 21.0/255.0, green: 162.0/255.0, blue: 198.0/255.0, alpha: 1.0)
        keyContentLabel.backgroundColor = UIColor.clear
        contentsLb.frame = CGRect(x:10, y:23,width:contentView.frame.width-20, height:130)
        contentsLb.numberOfLines = 0
        contentsLb.text = ""
        
        
        let cancelButton = UIButton()
        cancelButton.frame = CGRect(x:0,y:15,width:25, height:25)
        cancelButton.setImage(UIImage(named: "close"), for: UIControlState.normal)
        cancelButton.addTarget(self, action: #selector(ItemRatingVC.cancel), for: UIControlEvents.touchUpInside)
        
        //contentLabel.text = content
        contentsLb.font = UIFont(name: "HelveticaNeue-Light", size: 15)
        keyContentLabel.font = UIFont(name: "Bold", size: 15)
        
        hiddenView.addSubview(cancelButton)
        contentView.addSubview(contentsLb)
        contentView.addSubview(keyContentLabel)
        contentView.addSubview(deviderLineView)
        
        blureView.addSubview(contentView)
        blureView.addSubview(hiddenView)
        
        self.messageFrame.removeFromSuperview()
        self.view.bringSubview(toFront: hiddenView)
       
    }
 
    func cancel(){
        self.hiddenView.removeFromSuperview()
        self.contentsLb.removeFromSuperview()
        self.contentView.removeFromSuperview()
        itemRatingTblView.isUserInteractionEnabled = true
        blureView.isHidden = true
        
    }
    func checkRemoveBtn(){
        
    }
    
    @IBAction func ratingBtnTouch(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "RatingVC") as! RatingVC
        vc.merchantID = mrId
        vc.merchantRating = merchantrating
        vc.storeImgURL =  urlPath
        vc.storeNameStr =    storeName
        vc.ratingStr = ratingNum
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func storeDetails(_ sender: Any) {
        
//        let vc = storyboard?.instantiateViewController(withIdentifier: "RatingVC") as! RatingVC
//        vc.merchantID = mrId
//        vc.merchantRating = merchantrating
//        vc.storeImgURL =  urlPath
//     vc.storeNameStr =    storeName
//        vc.ratingStr = ratingNum
//        self.navigationController?.pushViewController(vc, animated: true)
    }

    var addFav:[String:AnyObject]=[:]
    @IBAction func getFaviorateBtnClicked(_ sender: Any) {
        addFav["53"] = "00011010000000000254" as AnyObject
        addFav["127.56"] = merchantId as AnyObject
       
        myModel.addManager.removeFavoriteItemMobile("040400219", userinfo: addFav, completionResponse: { ( response,  error) in
            
            print(response)
            if let res = response as? [[String : AnyObject]]{
            self.ratingParam = res
            for item in self.ratingParam{
                if var ratings = item["RESULT"] as? [[String:AnyObject]]{
                    for rati in ratings{
                        if let mRating = rati["_121_80"] as? String{
                            self.merchantId = mRating
                        }
                    }
                }
            }
            }
            self.itemRatingTblView.reloadData()
        })
        
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getLocation.count
        
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "showAllLocationCell", for: indexPath) as! showAllLocationCell
        //hArsh
        
        cell.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        cell.addressLbl.preferredMaxLayoutWidth = cell.frame.size.width - 10
        cell.cityNamelabl.preferredMaxLayoutWidth = cell.frame.size.width - 10
        cell.layer.borderWidth = 3
        cell.layer.borderColor = UIColor(red: 220/256.0, green: 220/256.0, blue: 220/256.0, alpha: 1.0).cgColor
        cell.layer.backgroundColor = UIColor.white.cgColor
        //cell.layer.cornerRadius = 5.0
        collectionView.layer.borderWidth=3
        // collectionView.layer.cornerRadius = 5
        collectionView.layer.borderColor = UIColor(red: 220/256.0, green:  220/256.0, blue:  220/256.0, alpha: 1.0).cgColor
        if getLocation.count > indexPath.row{
            let loaction = getLocation[indexPath.row]
            
            //    cell.specialImageView.image = UIImage(data: specialDataImage[indexPath.row])
            if let cun = loaction["country"] as? String{
                    cell.cityNamelabl.text = cun
            }
            if var cite = loaction["subAdd1"] as? String{
                  cell.addressLbl.text = cite
            }
                   // cite = cite + " "
                if let subAdd2 = loaction["subAdd2"] as? String{
                   // cite += subAdd2!
                cell.streetLbl.text = subAdd2
                }
             if let lat = loaction["lat"] as? String{
                if let long = loaction["long"] as? String{
              let dis =       distance(lat1: latitude, lon1: longitude, lat2: Double(lat)!, lon2: Double(long)!, unit: "M")
//            let coordinate₀ = CLLocation(latitude: latitude, longitude: longitude)
//                    let coordinate₁ = CLLocation(latitude: Double(lat)!, longitude: Double(long)!)
//
//            let distanceInMeters = coordinate₀.distance(from: coordinate₁)
//                 var   distanceInMiles = distanceInMeters/1609.344
//                    print(distanceInMiles)
                 
                    if let location = loaction["location"] as? String{
                        let doubleStr = Double(location)
                        let miles =  String(format: "%.2f", doubleStr!)
                    cell.milesLbl.text = "Distance: " + miles
                    }
                  // cell.milesLbl.text = String(miles) + " miles"
                    cell.numLbl.text = "123456789"
                }
            }
        }
        return cell
    }
    func deg2rad(deg:Double) -> Double {
        return deg * M_PI / 180
    }
    
   
    func rad2deg(rad:Double) -> Double {
        return rad * 180.0 / M_PI
    }
    func distance(lat1:Double, lon1:Double, lat2:Double, lon2:Double, unit:String) -> Double {
        let theta = lon1 - lon2
        var dist = sin(deg2rad(deg: lat1)) * sin(deg2rad(deg:lat2)) + cos(deg2rad(deg:lat1)) * cos(deg2rad(deg:lat2)) * cos(deg2rad(deg:theta))
        dist = acos(dist)
        dist = rad2deg(rad: dist)
        dist = dist * 60 * 1.1515
        if (unit == "K") {
            dist = dist * 1.609344
        }
        else if (unit == "N") {
            dist = dist * 0.8684
        }
        return dist
    }
    @IBAction func showAllBtnTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        vc.merchantId = merchantId
        vc.locArray = getLocation
        vc.urlStr = imageUrlStr
        vc.urlS = urlPath
        vc.detailTxt = descText
        vc.storeNameTxt = storeName
        vc.ratingNum = ratingNum
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func calculateHeight(inString:String) -> CGFloat
    {
        let messageString = inString
        let attributes : [String : Any] = [NSFontAttributeName : UIFont.systemFont(ofSize: 15.0)]
        
        let attributedString : NSAttributedString = NSAttributedString(string: messageString, attributes: attributes)
        
        let rect : CGRect = attributedString.boundingRect(with: CGSize(width: 222.0, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)
        
        let requredSize:CGRect = rect
        return requredSize.height
    }
    
//    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        // Compute the dimension of a cell for an NxN layout with space S between
//        // cells.  Take the collection view's width, subtract (N-1)*S points for
//        // the spaces between the cells, and then divide by N to find the final
//        // dimension for the cell's width and height.
//
//        let cellsAcross: CGFloat = 3
//        let spaceBetweenCells: CGFloat = 1
//        let dim = (collectionView.bounds.width - (cellsAcross - 1) * spaceBetweenCells) / cellsAcross
//        return CGSize(width: dim, height: 70)
//    }
    
    @IBAction func msgBtnClicked(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SearchMessagesVC") as! SearchMessagesVC
        vc.productId = TestClassStore.storeMerchantId
        vc.messageBool = true
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("index harsh >\(indexPath.item))")
        let loaction = getLocation[indexPath.row]
        
        print(loaction)
        let long = String(describing: loaction["long"]!)
        let lat = String(describing: loaction["lat"]!)
        let latitude = (lat as NSString).doubleValue
        let longitude = (long as NSString).doubleValue
        //let lat = Double(lat)
       // let lon = Double(long)
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        vc.merchantId = merchantId
        vc.locArray = getLocation
        vc.urlStr = imageUrlStr
        vc.urlS = urlPath
        vc.detailTxt = descText
        vc.storeNameTxt = storeName
        vc.ratingNum = ratingNum
        vc.conditionChakflow = true
        vc.longvale = longitude
        vc.latVale = latitude
        self.navigationController?.pushViewController(vc, animated: true)
//      let vc = storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
//        vc.merchantId = merchantId
//        vc.locArray = getLocation
//        vc.urlStr = imageUrlStr
//        vc.urlS = urlPath
//        vc.detailTxt = descText
//        vc.conditionChakflow = true
//        vc.longvale = longitude
//        vc.latVale = latitude
//         vc.storeNameTxt = storeName
//        self.navigationController?.pushViewController(vc, animated: true)
    }
}
