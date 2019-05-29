//
//  SearchItemsVC.swift
//  ApiTap
//
//  Created by AppZorro on 29/09/17.
//  Copyright © 2017 ApiTap. All rights reserved.
//

import UIKit

class SetSearchItem: NSObject {
    static var serahcItems:String = ""
}

class searchAddCell:UITableViewCell{
    @IBOutlet weak var addScrollView: UIScrollView!
}
class specialCollectionViewCell:UICollectionViewCell{
    
    @IBOutlet weak var specialItemPrice: UILabel!
    @IBOutlet weak var specialItemName: UILabel!
    @IBOutlet weak var specialImageView: UIImageView!
}
class productionAndServiceCollectionViewCell:UICollectionViewCell{
    
    @IBOutlet weak var productitemPrice: UILabel!
    @IBOutlet weak var productitemName: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
}
class searchCell:UITableViewCell{
    
    @IBOutlet var specialCollectionView:UICollectionView!
    @IBOutlet weak var viewAllBtn: UIButton!
    
    @IBOutlet weak var specialLbl: UILabel!
    
   // @IBOutlet weak var specialCollectionView: UICollectionView!
}
class productionAndServiceCell:UITableViewCell{
    
    @IBOutlet weak var viewAllItemBtn: UIButton!
    @IBOutlet weak var productionServiceLbl: UILabel!
    @IBOutlet var productServiceCollectionView:UICollectionView!
    
    @IBOutlet weak var productionAndServiceCollectionView: UICollectionView!
}
class SearchItemsVC: BaseViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var hiddenView: UIView!
    @IBOutlet weak var progressView: UIActivityIndicatorView!
    @IBOutlet weak var pCollectionView: UICollectionView!
    @IBOutlet weak var sCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    var dictparam:[String:AnyObject]=[:]
       var myModel = ModelManager()
    @IBOutlet weak var searchTblView: UITableView!
    @IBOutlet weak var itemsScrollView: UIScrollView!
    var searchItems:[[String:AnyObject]]=[]
    var arrayFinalData:[String]=[]
     var imageUrl:[String]=[]
    var urlImage:String = "http://209.46.35.217:8085/ServerImage/images/"
    var allImage:[UIImage]=[]
    var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    
    @IBOutlet weak var alertView: UIView!
    
    //specialCollection
    var loadSearchCollectionImage:[[String:AnyObject]]=[]
    var offerSearchImage:[String] = []
    var itemNames:[String]=[]
    var itemPriceName:[String]=[]
     var getTotalOfferImage:[String]=[]
    var specialImage:[UIImage]=[]
    var specialDataImage:[Data]=[]
    
    //productionAnd Service
    var productAndServiceArray:[[String:AnyObject]]=[]
    var productAndServiceFinalData:[[String:AnyObject]]=[]
    var productAndServiceFinalmageUrl:[String]=[]
    var productAndServiceItemname:[String]=[]
    var productAndServicePriceName:[String]=[]
    var productAndServiceFinalmage:[String]=[]
    var productAndServiceFinaDatalmage:[Data]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeNavBar()
        self.setBarBtnItems()
        //progressBarDisplayer(msg: "Loading", true)
        progressView.startAnimating()
       // setLoadingScreen()
        hiddenView.isHidden = false
        hiddenView.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
        searchTblView.isUserInteractionEnabled = false
        
        searchTblView.delegate=self
        searchTblView.dataSource=self
        
        
        
        searchTblView.reloadData()
        getScrollViewData()
       // messageFrame.removeFromSuperview()
        
        // Do any additional setup after loading the view.
    }
    private func removeLoadingScreen() {
        
        // Hides and stops the text and the spinner
        spinner.stopAnimating()
        spinner.isHidden = true
        loadingLabel.isHidden = true
        
    }
    var loginUserId:String = ""
    func getScrollViewData(){
         let cell = self.searchTblView.cellForRow(at: IndexPath(row: 0, section: 0)) as! searchAddCell
        if let result = UserDefaults.standard.value(forKey: "loginUserID") as? String{
            loginUserId = result as! String
            print(result)
        }
        dictparam["53"] = loginUserId as AnyObject
        dictparam["114.127"] = SetSearchItem.serahcItems as AnyObject
        myModel.addManager.callMainDict(forHistory: "010400676", userinfo: dictparam, completionResponse: { ( response,  error) in
            
            print(response)
            if let res: [[String : AnyObject]]  = response as? [[String : AnyObject]]{
            self.searchItems = res
            
            for items in self.searchItems{
                if let irImages = items["RESULT"] as? [[String:AnyObject]]{
                    for imageitem2 in irImages{
                        if let irImages2 = imageitem2["IR"] as? [[String:AnyObject]]{
                              for imageitem in irImages2{
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
                         DispatchQueue.global(qos: .userInitiated).async {
                        if let url = NSURL(string: self.imageUrl[i]) {
                            if let data = NSData(contentsOf: url as URL) {
                                let imageView = UIImageView()
                                self.allImage.append(UIImage(data: data as Data)!)
                                // imageView.image = UIImage(data: data as Data)
                                self.frame.origin.x = self.itemsScrollView.frame.size.width * CGFloat(i)
                                self.frame.size = self.itemsScrollView.frame.size
                                let image = UIImageView(frame: self.frame)
                                // let image = UIImageView(frame:frame)
                                image.image = UIImage(data: data as Data)
                                // view.backgroundColor = colors[pageControl.currentPage]
                                 DispatchQueue.main.async(execute: { () -> Void in
                                self.itemsScrollView.addSubview(image)
                                
                                })
                            }
                        }
                    }
                    }
                    self.itemsScrollView.contentSize = CGSize(width: (self.itemsScrollView.frame.size.width * CGFloat(self.imageUrl.count)), height: self.itemsScrollView.frame.size.height)
                    
                   
                    DispatchQueue.main.async {
                        //self.searchTblView.reloadData()
                    }
                    self.pageControl.numberOfPages = self.imageUrl.count
                }
                }
            }
            }
                
            }else{
                self.alertView.isHidden=false
            }
            DispatchQueue.main.async {
                self.getSpecialData()
               // self.searchTblView.reloadData()
            }
           // DispatchQueue.main.async {
            
           // }
        })
    }
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = itemsScrollView.contentOffset.x / itemsScrollView.frame.size.width
        pageControl.currentPage = Int(pageNumber)
        // pageControl.currentPageIndicatorTintColor = dataimage[pageControl.currentPage]
        
    }
    var specialImageUrl:[URL]=[]
    @IBAction func pageChange(_ sender: UIPageControl) {
    }
    func getSpecialData(){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let dateString = dateFormatter.string(from:Date())
        print(dateString)
        
        
        var specialDict:[String:AnyObject]=[:]
        
        specialDict["53"] = loginUserId as AnyObject
        specialDict["114.127"] = SetSearchItem.serahcItems as AnyObject
        specialDict["127.89"] = "2" as AnyObject
       specialDict["121.141"] = dateString as AnyObject
        myModel.addManager.offerSearchImages("010400479", userinfo: specialDict, completionResponse: { ( response,  error) in
            print(response)
            if let res:[[String : AnyObject]] = response as? [[String : AnyObject]]{
            self.loadSearchCollectionImage = res
            for items in self.loadSearchCollectionImage{
                if let irImages = items["RESULT"] as? [[String:AnyObject]]{
                    
                    for imageitem in irImages{
                        
                        if let image = imageitem["PC"] as? [[String:AnyObject]]{
                            for item in image{
                                if let url = item["_121_170"] as? String{
                                    self.offerSearchImage.append(url)
                                }
                                if let itemName = item["_120_83"] as? String{
                                    self.itemNames.append(itemName)
                                }
                                if let itemPriceName = item["_114_98"] as? String{
                                    self.itemPriceName.append(itemPriceName)
                                }
                            }
                            
                        }
                        
                    }
                    
                    
//                    for imageitem in irImages{
//
//                        if let image = imageitem["_121_170"] as? String{
//                            self.offerSearchImage.append(image)
//                        }
//                        if let itemName = imageitem["_120_83"] as? String{
//                            self.itemNames.append(itemName)
//                        }
//                        if let itemPriceName = imageitem["_114_98"] as? String{
//                            self.itemPriceName.append(itemPriceName)
//                        }
//                    }
//                }
                for itemImages in self.offerSearchImage{
                    if let urlStr:String = itemImages as? String{

                        let url =  self.urlImage.appending(urlStr as String)
                        self.getTotalOfferImage.append(url)
                    }

                }
//
//
                for i in 0..<self.getTotalOfferImage.count{
                      DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {

                        if let url = NSURL(string: self.getTotalOfferImage[i]) {
                            self.specialImageUrl.append(url as URL)
                            if let data = NSData(contentsOf: url as URL) {
                                let imageView = UIImageView()
                                self.specialImage.append(UIImage(data: data as Data)!)
                                self.specialDataImage.append(data as Data as Data)

                            }
                    }
                    }
                 }
                
                }
            }
            
            }
            
           // }
            DispatchQueue.main.async {
                self.getProductAndServiceDataInfo()
               // self.searchTblView.reloadData()
            }
        })
    }
    
    var productImageUrl:[URL]=[]
    
    func getProductAndServiceDataInfo(){
        var prodDict:[String:AnyObject]=[:]
        prodDict["53"]=loginUserId as AnyObject
        let now = Date()
        
        let formatter = DateFormatter()
        
        formatter.timeZone = TimeZone.current
        
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateString = formatter.string(from: now)
       // @"yyyy-MM-dd hh:mm:ss"
        prodDict["121.141"]=dateString as AnyObject
        prodDict["114.127"]=SetSearchItem.serahcItems as AnyObject
         prodDict["127.89"]="2" as AnyObject
        myModel.addManager.productAndServiceImages("010400478", userinfo: prodDict, completionResponse: { ( response,  error) in
            print(response)
            if let res: [[String : AnyObject]] = response as? [[String : AnyObject]]{
            self.productAndServiceArray = res
            for items in self.productAndServiceArray{
                if let irImages = items["RESULT"] as? [[String:AnyObject]]{
                    
                    for imageitem in irImages{
                        
                        if let image = imageitem["PC"] as? [[String:AnyObject]]{
                            for item in image{
                                if let url = item["_121_170"] as? String{
                                    self.productAndServiceFinalmageUrl.append(url)
                                }
                                if let itemName = item["_120_83"] as? String{
                                    self.productAndServiceItemname.append(itemName)
                                }
                                if let itemPriceName = item["_114_98"] as? String{
                                    self.productAndServicePriceName.append(itemPriceName)
                                }
                            }
                            
                        }
                        
                    }
                }
            }
                
                for itemImages in self.productAndServiceFinalmageUrl{
                    if let urlStr:String = itemImages as? String{
                        
                        let url =  self.urlImage.appending(urlStr as String)
                        self.productAndServiceFinalmage.append(url)
                    }
                    
                }
                
                for i in 0..<self.productAndServiceFinalmage.count{
                    DispatchQueue.global(qos: .userInitiated).async {
                        if let url = NSURL(string: self.productAndServiceFinalmage[i]) {
                            self.productImageUrl.append(url as URL)
                           
                            
                        }
                    }
                }
                
            }
            
            DispatchQueue.main.async {
                
                self.progressView.stopAnimating()
                self.progressView.isHidden=true
                self.hiddenView.isHidden = true
                
                self.searchTblView.isUserInteractionEnabled = true
                self.searchTblView.reloadData()
            }
            
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        return 15.0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section==0{
            return 270
        }else{
            return 230
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = searchTblView.dequeueReusableCell(withIdentifier: "searchAddCell") as! searchAddCell
            
            
            return cell
        }
        if indexPath.section == 1{
        let cell = searchTblView.dequeueReusableCell(withIdentifier: "searchCell") as! searchCell
        DispatchQueue.main.async {
            cell.specialCollectionView.reloadData()
            }
            return cell
        }
        else{
            let cell = searchTblView.dequeueReusableCell(withIdentifier: "productionAndServiceCell") as! productionAndServiceCell
            DispatchQueue.main.async {
            cell.productionAndServiceCollectionView.reloadData()
            }
            return cell
        }
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
        let x = (searchTblView.frame.width / 2) - (width / 2)
        let y = (searchTblView.frame.height / 2) - (height / 2) - (navigationController?.navigationBar.frame.height)!
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
        
        searchTblView.addSubview(loadingView)
        
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

//}

//extension SearchItemsVC:UICollectionViewDelegate,UICollectionViewDataSource{
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag==501{
            return getTotalOfferImage.count
        }else{
            return productAndServiceFinalmage.count
        }
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
       // let specialCell = searchTblView.cellForRow(at: IndexPath(row: 0, section: 0)) as! searchCell
        // let productionCell = searchTblView.cellForRow(at: IndexPath(row: 0, section: 1)) as! productionAndServiceCell
      //  if collectionView == specialCell.specialCollectionView{
        if collectionView.tag == 501{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "specialCollectionViewCell", for: indexPath) as! specialCollectionViewCell
            cell.layer.borderWidth = 2
            cell.layer.borderColor = UIColor.gray.cgColor
            
            
            for i in 0..<self.getTotalOfferImage.count{
                if specialImageUrl.count>indexPath.row{
                cell.specialImageView.sd_setImage(with: specialImageUrl[indexPath.row])
               // cell.specialItemName.text = self.itemNames[indexPath.row]
                    //let data = dataWithHexString(hex: self.itemNames[indexPath.row]) // <68656c6c 6f2c2077 6f726c64>
                   // let string = String(data: data, encoding: .utf8)
                    cell.specialItemName.text = self.itemNames[indexPath.row]
                cell.specialItemPrice.text = self.itemPriceName[indexPath.row]
                }
            }
            return cell
        }
       if collectionView.tag == 502{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productionAndServiceCollectionViewCell", for: indexPath) as! productionAndServiceCollectionViewCell
         cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.gray.cgColor
        if productImageUrl.count>indexPath.row{
        cell.productImageView.sd_setImage(with: productImageUrl[indexPath.row])
        cell.productitemName.text = self.productAndServiceItemname[indexPath.row]
         cell.productitemPrice.text = self.productAndServicePriceName[indexPath.row]
        }
        

        
            return cell
        }
        return UICollectionViewCell()
    }
}
    
//}
