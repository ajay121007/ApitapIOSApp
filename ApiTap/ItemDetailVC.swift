//
//  ItemDetailVC.swift
//  ApiTap
//
//  Created by Ashish on 16/10/17.
//  Copyright © 2017 ApiTap. All rights reserved.
//

import UIKit
extension Collection where Iterator.Element == [String:AnyObject] {
    func toJSONString(options: JSONSerialization.WritingOptions = .prettyPrinted) -> String {
        if let arr = self as? [[String:AnyObject]],
            let dat = try? JSONSerialization.data(withJSONObject: arr, options: options),
            let str = String(data: dat, encoding: String.Encoding.utf8) {
            return str
        }
        return "[]"
    }
}
class TestClassStore: NSObject {
    
    static var storeAbout:String = ""
    static var storeName: String = ""
    static var storeNameImage: URL! = nil
    //static var storeNameImage: String = ""
    static var storeMerchantId: String = ""
    
}

protocol storeDetails {
    func changeBackgroundColor(_ storeName: String, _ imageUrl : String)
}


class relatedCollectionCell:UICollectionViewCell{
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var relatedImageView: UIImageView!
    @IBOutlet weak var viewOuter: UIView!
    @IBOutlet weak var discountCell: UILabel!
}
class alsoViewCollectionCell:UICollectionViewCell{
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var discountlbl: UILabel!
    @IBOutlet weak var alsoViewitemPriceLbl: UILabel!
    @IBOutlet weak var alsoViewitemNameLbl: UILabel!
    @IBOutlet weak var alsoViewItemsImgView: UIImageView!
}
class alsoViewitemCell:UITableViewCell{
    
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var alsoViewItemLbl: UILabel!
    @IBOutlet weak var alsoViewItemCollectionView: UICollectionView!
}

class relatedItemCell:UITableViewCell{
    @IBOutlet weak var relatedCollectionView: UICollectionView!
    
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var specialItemLbl: UILabel!
    
}
class loadRelatedimageCell:UITableViewCell{
     @IBOutlet weak var loadSelectImageView: UIImageView!
}
class itemDetailCell:UITableViewCell{
    @IBOutlet weak var selectImageView: UIImageView!
    @IBOutlet weak var starBtn1: UIButton!
    
    @IBOutlet var storeNmLbl: UILabel!
    @IBOutlet var storeImgView: UIImageView!
    @IBOutlet var outerView: UIView!
    
    @IBOutlet weak var starBtn5: UIButton!
    @IBOutlet weak var starBtn4: UIButton!
    @IBOutlet weak var starBtn3: UIButton!
    @IBOutlet weak var starBtn2: UIButton!
    @IBOutlet weak var itemPriceLbl: UILabel!
    @IBOutlet weak var storeNameBtn: UIButton!
    @IBOutlet weak var itemNameLbl: UILabel!
    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var selectedImageTableView: UITableView!
    //hArsh
    @IBOutlet var addTocardBtn: UIButton!
    @IBOutlet var moreDetailBtn: UIButton!
    override func awakeFromNib() {
        moreDetailBtn.layer.borderWidth = 1.5
        moreDetailBtn.layer.borderColor =  UIColor(red: 48/255, green: 142/255, blue: 218/255, alpha: 1.0).cgColor //.init(colorLiteralRed: 48, green: 142, blue: 218, alpha: 1).cgColor
        addTocardBtn.layer.cornerRadius = 5
        addTocardBtn.clipsToBounds = true
        moreDetailBtn.layer.cornerRadius = 5
        moreDetailBtn.clipsToBounds = true
        
        
        storeNameBtn.layer.borderWidth = 1.5
        storeNameBtn.layer.borderColor =  UIColor(red: 48/255, green: 142/255, blue: 218/255, alpha: 1.0).cgColor //.init(colorLiteralRed: 48, green: 142, blue: 218, alpha: 1).cgColor
        storeNameBtn.layer.cornerRadius = 5
        storeNameBtn.clipsToBounds = true
        storeNameBtn.layer.cornerRadius = 5
        storeNameBtn.clipsToBounds = true
        
    }
}
class descriptionCells:UITableViewCell{
    
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var descriptionTxt: UITextView!
    @IBOutlet weak var descriptionLbl: UILabel!
}
class ItemDetailVC: BaseViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate, UIPickerViewDataSource,UIPickerViewDelegate,UITextViewDelegate {
    
     @IBOutlet weak var moreDetailsView: MoreDetailsView!
     var delegateStore: storeDetails?
    var selectedRealetedItemFlag:Bool = false
    var itemImagePath:URL!
 var myModel = ModelManager()
    //var shoppingCart = ShoppingCartsVC()
    var baseVC = BaseViewController()
    var specialItmBoolVal:Bool = false
    var specialItemDict:[String:AnyObject]=[:]
    var itemDetailFlag:Bool = false
    var itemDetailScanCode:String = ""
    var getPickervalues:[String:AnyObject]=[:]
    var pickersView = UIPickerView()
 //   let toolBar = UIToolbar()
    let contentsLb = UILabel()
    let removeLbl = UILabel()
    let qualityLbl = UILabel()
    let qualityTextField = UITextField()
    let colorTxField = UITextField()
    @IBOutlet weak var hiddenView: UIView!
    @IBOutlet weak var itemDetailtblview: UITableView!
    var dictparam:[String:AnyObject]=[:]
    var loginUserId:String = ""
    var itemDetailvc:[[String:AnyObject]]=[]
    var selecteditem:Int = 0
    var productId:String = ""
    var productInfo:[String:AnyObject]=[:]
    var itemImage:[String]=[]
    var urlImage:String = "http://209.46.35.217:8085/ServerImage/images/"
    var selectedImageArrl:[String]=[]
    var favString:String = ""
    var favStringArr:[String] = []
    var merchantid:String = ""
    let qtylblText = UILabel()
    var productType:String = ""
    var dataComesSpecialFlag:Bool=false
    var dataComesItemsFlag:Bool = false
    
    var homeItemValue:[String:AnyObject]=[:]
    
    @IBOutlet weak var checkOutView: UIView!
    @IBOutlet weak var progressView: UIActivityIndicatorView!
    var someValue: Int = 1 {
        didSet {
            qtylblText.text = "\(someValue)"
        }
    }
    var descTxt:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        moreDetailsView.doneBtn.addTarget(self, action: #selector(myHideButtonTapped), for: UIControlEvents.touchUpInside)
        moreDetailsView.layer.cornerRadius = 5.0
    moreDetailsView.layer.borderWidth = 2.0
        moreDetailsView.layer.borderColor = UIColor.blue.cgColor
        self.initializeNavBar()
       
        itemDetailtblview.estimatedRowHeight = 44.0
        itemDetailtblview.rowHeight = UITableViewAutomaticDimension
        itemDetailtblview.tableFooterView = UIView()
        
        self.setbarButtonItems()
       // baseVC.setbarButtonItems()
        progressView.startAnimating()
        // setLoadingScreen()
        hiddenView.isHidden = false
        hiddenView.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
        itemDetailtblview.isUserInteractionEnabled = false
        someValue = 0
        itemDetailvc.append(specialItemDict)
        
       
//        pickersView.frame = CGRect(x:0, y:200, width:view.frame.width, height:200)
//        // pickersView = UIPickerView(frame: CGRect(x:0, y:200, width:view.frame.width, height:200))
//        pickersView.backgroundColor = .white
//
//        pickersView.showsSelectionIndicator = true
//        pickersView.delegate = self
//        pickersView.dataSource = self
//
//
//        toolBar.barStyle = UIBarStyle.default
//        toolBar.isTranslucent = true
//        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
//        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: "donePicker")
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: Selector("donePicker"))
        
     //   toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
      //  toolBar.isUserInteractionEnabled = true
        
        countryPickerVal()
        countryPickerVal2()
        
        
        self.getFav()
//        if let strt = productId.characters.count as? Int{
//            if strt == 1{
//                getfav["114.144"] = "0000000000"+productId as AnyObject
//            }else{
//                getfav["114.144"] = "000000000"+productId as AnyObject
//            }
//        }
        
        
        
       
        //getCard
       

        // Do any additional setup after loading the view.
    }
    func myHideButtonTapped(sender:UIButton)
    {
        moreDetailsView.isHidden=true
        //moreDetailsView.view.removeFromSuperview()
    }
    
    @IBAction func backBtnPress(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    let pickerView3 = UIPickerView()
    let pickerView2 = UIPickerView()
    func countryPickerVal2(){
        pickerView3.delegate = self
        
        colorTxField.inputView = pickerView3
        
        let toolBar = UIToolbar(frame: CGRect(x:0, y:self.view.frame.size.height/6, width:self.view.frame.size.width, height:40.0))
        
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        
        toolBar.barStyle = UIBarStyle.blackTranslucent
        
        toolBar.tintColor = UIColor.white
        
        toolBar.backgroundColor = UIColor.black
        
        let defaultButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ItemDetailVC.tappedToolBarBtn))
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(ItemDetailVC.donePressed))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 3, height: self.view.frame.size.height))
        
        label.font = UIFont(name: "Helvetica", size: 12)
        
        label.backgroundColor = UIColor.clear
        
        label.textColor = UIColor.white
        
        label.textAlignment = NSTextAlignment.center
        
        let textBtn = UIBarButtonItem(customView: label)
        
        toolBar.setItems([defaultButton,flexSpace,textBtn,flexSpace,doneButton], animated: true)
        
        colorTxField.inputAccessoryView = toolBar
    }
    func countryPickerVal(){
        pickerView2.delegate = self
        
        qualityTextField.inputView = pickerView2
        
        let toolBar = UIToolbar(frame: CGRect(x:0, y:self.view.frame.size.height/6, width:self.view.frame.size.width, height:40.0))
        
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        
        toolBar.barStyle = UIBarStyle.blackTranslucent
        
        toolBar.tintColor = UIColor.white
        
        toolBar.backgroundColor = UIColor.black
        
        let defaultButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ItemDetailVC.tappedToolBarBtn2))
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(ItemDetailVC.donePressed2))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 3, height: self.view.frame.size.height))
        
        label.font = UIFont(name: "Helvetica", size: 12)
        
        label.backgroundColor = UIColor.clear
        
        label.textColor = UIColor.white
        
        label.textAlignment = NSTextAlignment.center
        
        let textBtn = UIBarButtonItem(customView: label)
        
        toolBar.setItems([defaultButton,flexSpace,textBtn,flexSpace,doneButton], animated: true)
        
        qualityTextField.inputAccessoryView = toolBar
    }
    @objc func donePressed2(sender: UIBarButtonItem) {
        qualityTextField.resignFirstResponder()
    }
    @objc func tappedToolBarBtn2(sender: UIBarButtonItem) {
        qualityTextField.resignFirstResponder()
    }
    @objc func donePressed(sender: UIBarButtonItem) {
        colorTxField.resignFirstResponder()
    }
    @objc func tappedToolBarBtn(sender: UIBarButtonItem) {
        colorTxField.resignFirstResponder()
    }
    
    
    func getFav(){
        if let result = UserDefaults.standard.value(forKey: "loginUserID") as? String{
            loginUserId = result as! String
            print(result)
        }
        
        print(itemDetailvc)
        if selectedRealetedItemFlag == true{
         //   productId = productId
            
        }else{
        if dataComesItemsFlag == true{
            for item in itemDetailvc{
                if let info = item["PC"] as? [[String:AnyObject]]{
                    if let pid  = info[selecteditem]["_114_144"] as? String{
                        productId = pid
                    }
                    
                }
            }
            
        }else{
            
            if dataComesSpecialFlag == true{
                for item in itemDetailvc{
                    if let info = item["PC"] as? [[String:AnyObject]]{
                        if let pid  = info[selecteditem]["_114_144"] as? String{
                            productId = pid
                        }
                        
                    }
                }
            }else{
                
                if specialItmBoolVal == false{
                    if itemDetailFlag == true{
                        productId = itemDetailScanCode
                    }else{
                                            if let pId  = homeItemValue as? [String:AnyObject]{
                                                        productInfo = pId
                                                    }
                        
                            
                                                    // for item in productInfo
                                                    if let produId = productInfo["productId"] as? [String]{
                                                        productId = produId[0]
                                                    }
                                                    if let productTypes = productInfo["_114_112"] as? [String]{
                                                        productType = productTypes[0]
                                                        
                                                    }
                        if let productTypes = productInfo["image"] as? [URL]{
                            itemImagePath = productTypes[0]
                            
                        }
                        
//                        if let pId  = itemDetailvc[selecteditem] as? [String:AnyObject]{
//                            productInfo = pId
//                        }
//                        if let mId = productInfo["_114_179"] as? String{
//                            //merchantid = mId
//                        }
//                        
//                        // for item in productInfo
//                        if let produId = productInfo["productId"] as? String{
//                            productId = produId
//                        }
//                        if let productTypes = productInfo["_114_112"] as? String{
//                            productType = productTypes
//                            
//                        }
                    }
                }else{
                    for item in itemDetailvc{
                        if let info = item["PC"] as? [[String:AnyObject]]{
                            for items in info{
                                print(items["_114_144"])
                                if let itemsId = items["_114_144"] as? String{
                                    productId = itemsId
                                }
                            }
                            
                        }
                    }
                }
            }
            }
        }
        var getfav:[String:AnyObject]=[:]
        getfav["53"] = loginUserId as AnyObject
        getfav["127.10"] = "001" as AnyObject
        getfav["114.112"] =  productType as AnyObject
        myModel.addManager.getFavoriteItem("010400221", userinfo: getfav, completionResponse: { ( response,  error) in
            print(response)
            
            if let res:[[String:AnyObject]]=response as? [[String:AnyObject]]{
                for items in res{
                    if let pId = items["PC"] as? [[String:AnyObject]]{
                        for element in pId{
                            if let productType = element["_114_144"] as? String{
                                self.favStringArr.append(productType)
                                self.favString = productType
                            }
                        }
                        
                      
                    }
                    
                }
            }
            
            self.getCard()
            
        })
    }
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    override func viewDidAppear(_ animated: Bool) {
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }
    override func viewWillAppear(_ animated: Bool) {
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }
    private func shouldAutorotate() -> Bool {
        return true
    }
    private func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    var itemNameStr:String=""
    var storeNameStr:String = ""
    var itemPriceStr:String = ""
    var getItemsPick:[String:AnyObject]=[:]
    var pickerItemArr:[[String:AnyObject]]=[]
     var dict1:[String:AnyObject]=[:]
    func getCard(){
        var optionArr:[[String:AnyObject]]=[]
         var optionArr2:[[String:AnyObject]]=[]
        var mainKey:String = ""
        dictparam["53"] = loginUserId as AnyObject
        if itemDetailFlag == true{
            dictparam["114.144"] = productId as AnyObject
        }else{
            if let strt = productId.characters.count as? Int{
                if strt == 1{
                    dictparam["114.144"] = "0000000000"+productId as AnyObject
                }else if strt == 2{
                    dictparam["114.144"] = "000000000"+productId as AnyObject
                }
                else if strt == 3{
                    dictparam["114.144"] = "00000000"+productId as AnyObject
                }
                else if strt == 4{
                    dictparam["114.144"] = "0000000"+productId as AnyObject
                }else{
                     dictparam["114.144"] = "000000"+productId as AnyObject
                }
            }
        }
       
        var dict2:[String:AnyObject]=[:]
        myModel.addManager.getItemDetails("010100008", userinfo: dictparam, completionResponse: { ( response,  error) in
            print(response)
            if let res:[[String:AnyObject]]=response as? [[String:AnyObject]]{
                for items in res{
                    if let option1 = items["OP"] as? [[String:AnyObject]]{
                        
                        for getItems in option1{
                            if let mainKeys = getItems["_122_134"] as? String{
                                mainKey = mainKeys
                            }
                            if let option1 = getItems["CH"] as? [[String:AnyObject]]{
                                 for getItemsVal in option1{
                                    if let option1Val = getItemsVal["_122_112"] as? String{
                                        if let option2Val = getItemsVal["_127_16"] as? String{
                                            
                                            self.getItemsPick[option1Val] = option2Val as AnyObject
                                        }
                                       
                                    }
                                    self.pickerArrayVal.append(self.getItemsPick)
                                    self.getItemsPick.removeAll()
                                }
                                self.dict1[mainKey] = self.pickerArrayVal as AnyObject
                                self.pickerArrayVal.removeAll()
                            }
                        }
                    }
                    
                    if specialClass.specialFlag == false{
                                        if let itemPrice = items["_122_158"] as? String{
                                            self.itemPriceStr = itemPrice
                                        }
                    }else{
                             if let itemPrice = items["_122_162"] as? String{
                                   self.itemPriceStr = itemPrice
                        }
                    }

                    if let itemName = items["_120_83"] as? String{
                        self.itemNameStr = itemName
                    }
                     if let itemName = items["_121_150"] as? String{
                        
                    }
                    if let itemName = items["_122_131"] as? String{
                        self.moreDetailsView.moreDetailLbl.text = itemName  //done
                    }
                    if let itemName = items["_121_100"] as? String{
                         self.moreDetailsView.textView.text = itemName  //done
                    }
                     if let itemName = items["_114_121"] as? String{
                        if itemName != ""{
                                                         self.moreDetailsView.limitQuantityLbl.text = itemName
                                                    }else{
                                                         self.moreDetailsView.limitQuantityLbl.text = "No Limit"  //done
                                                    }
                    }
                    if let itemName = items["_121_102"] as? String{
                         self.moreDetailsView.posSkuLbl.text = itemName    //done
                    }
                    if let itemName = items["_121_108"] as? String{
                        self.moreDetailsView.barCodeLbl.text = itemName    //done

                        
                    }
                    if let itemName = items["_123_23"] as? String{
                        if itemName == ""{
                            self.moreDetailsView.ageRegister18.isHidden = true
                            self.moreDetailsView.age18Lbl.isHidden = true
                            
                        }else{
                            self.moreDetailsView.ageRegister18.isHidden = false
                            self.moreDetailsView.age18Lbl.isHidden = false
                            self.moreDetailsView.ageRegister18.setImage(UIImage(named:"checkBox"), for: .normal)  //done
                        }
                    }
                    if let itemName = items["_123_22"] as? String{
                        if itemName == ""{
                             self.moreDetailsView.ageRegister21.isHidden = true
                             self.moreDetailsView.age21Lbl.isHidden = true
                           
                        }else{
                            self.moreDetailsView.ageRegister21.isHidden = false
                            self.moreDetailsView.age21Lbl.isHidden = false
                             self.moreDetailsView.ageRegister21.setImage(UIImage(named:"checkBox"), for: .normal)  //done
                        }
                       
                    }
                    if let storeName = items["_121_150"] as? String{
                        self.storeNameStr = storeName
                    }
                    if let merId = items["_53"] as? String{
                        self.merchantid = merId
                    }
                    if let desc = items["_120_157"] as? String{
                        self.descTxt = self.hexToStr(textValue: desc)
                    }
                    if let itesmKeys  = items["IM"] as? [[String:AnyObject]]{
                        for  product in itesmKeys{
                            if let image = product["_47_42"] as? String{
                                self.itemImage.append(image)
                            }
                        }
                    }
                    if let itesmKeys  = items["OP"] as? [[String:AnyObject]]{
                        
                       // dict1.append(itesmKeys[0])
                       // dict2.append(itesmKeys[1])
                       // self.pickerArrayVal.append(itesmKeys[0])
                        // self.pickerArrayVal2.append(itesmKeys[1])
                        for  product in itesmKeys{
                            if let image = product["CH"] as? [[String:AnyObject]]{
                                for itemsElement in image{
                                    print(itemsElement)
                                    
                                    if let numId = itemsElement["_122_112"] as? String{
                                        if let itemData = itemsElement["_127_16"] as? String{
                                          // self.getItemsPick[numId] = itemData as AnyObject
                                           // self.pickerArrayVal.append(self.getItemsPick)
                                            //print(self.pickerArrayVal)
                                            //self.getItemsPick.removeAll()

                                        }

                                    }
                                }
                               // self.itemImage.append(image)
                            }
                        }
                    }
//                   // self.pickerArrayVal.append(dict1[0])
//                    self.pickerArrayVal2.append(dict2[0])
//                    print(self.pickerArrayVal)
//                    print(self.pickerArrayVal2)
//
//                    for items in self.pickerArrayVal{
//                        if let dataEle = items["CH"] as? [[String:AnyObject]]{
//                            for info in dataEle{
//                                if let productId = info["_122_112"] as? String{
//                                     if let productInfo = info["_127_16"] as? String{
//                                        var dict:[String:AnyObject]=[:]
//                                        dict[productId] = productInfo as AnyObject
//
//                                        optionArr.append(dict)
//                                        print(optionArr)
//                                    }
//                                }
//                            }
//                        }
//                    }
                    for images in self.itemImage{
                        let url =  self.urlImage.appending(images as String)
                        self.selectedImageArrl.append(url)
                    }
                    for i in 0..<self.selectedImageArrl.count{
                        if let url = NSURL(string: self.selectedImageArrl[i]) {
                            self.imageDetailUrl.append(url as URL)
                            
                        }
                    }
                   
                }
                
            }else{
               // if let url = NSURL(string: self.itemImagePath) {
                    //self.imageDetailUrl.append(url as URL)
                    
               // }
                
            }
            
            self.getRelatedItem()
             self.itemDetailtblview.reloadData()
        })
    }

    var allPickingData:[String]=[]
    var optionid:String = ""
    var optionIdArr:[String]=[]
      var pickerArrayVal:[[String:AnyObject]]=[]
    var pickerArrayVal2:[[String:AnyObject]]=[]
    var pickerArray:[[String:AnyObject]]=[]
    func getShoppingChoice(){
        var getChoice:[String:AnyObject]=[:]
        //my code
        if itemDetailFlag == true{
            
            
            if let strt = productId.characters.count as? Int{
                if strt == 1{
                    getChoice["114.144"] = "0000000000"+productId as AnyObject
                }else{
                    getChoice["114.144"] = "000000000"+productId as AnyObject
                }
            }
            
            
            //getChoice["114.144"] = productId as AnyObject
        }else{
            if let strt = productId.characters.count as? Int{
                if strt == 1{
                    getChoice["114.144"] = "0000000000"+productId as AnyObject
                }else{
                    getChoice["114.144"] = "000000000"+productId as AnyObject
                }
            }
       // getChoice["114.144"] = "0000000000"+productId as AnyObject
        }
          myModel.addManager.getOptionsByItem("010100012", userinfo: getChoice, completionResponse: { ( response,  error) in
            
            if let res:[[String:AnyObject]]=response as? [[String:AnyObject]]{
                for items in res{
                    if let images = items["RESULT"] as? [[String:AnyObject]]{
                        for collectImages in images{
                            self.pickerArray.append(collectImages)
                            if let img = collectImages["_122_134"] as? String{
                                self.allPickingData.append(img)
                            }else{
                                self.allPickingData.append("Default")
                            }
                            if let optionid = collectImages["_122_111"] as?  String{
                                self.optionid = optionid
                                self.optionIdArr.append(self.optionid)
                            }
                        }
                }
            }
            }
            if self.optionIdArr.count>0{
            for item in self.optionIdArr{
                self.myGroup.enter()
                
                   // self.pickOption1Str = items
               
                    self.getShoppingChoiceSecond(item: item,itemsArr:item)
            }
            }else{
                self.progressView.stopAnimating()
                self.progressView.isHidden=true
                self.hiddenView.isHidden = true
                
                self.itemDetailtblview.isUserInteractionEnabled = true
                self.itemDetailtblview.reloadData()
            }
            self.myGroup.notify(queue: .main) {
                print("Finished all requests.")
            }
        })
    }
    var pickOption1Str:String=""
    var getChiceOption2:[String]=[]
    var optionIdArrDict:[[String:AnyObject]]=[]
    var optionIdDict:[String:[AnyObject]]=[:]
    let myGroup = DispatchGroup()
    
    var optionIdDict2:[String:[AnyObject]]=[:]
    var optionIdDictArr2:[[String:AnyObject]]=[]
    func getShoppingChoiceSecond(item:String,itemsArr:String){
        var getChoice2:[String:AnyObject]=[:]
        
        getChoice2["53"] = loginUserId as AnyObject
        //for item in optionIdArr{
        getChoice2["122.111"] = "000000000"+item as AnyObject
        myModel.addManager.getOptionsByItemId("010100013", userinfo: getChoice2, completionResponse: { ( response,  error) in
            var optionElement:String = ""
            
            if let res:[[String:AnyObject]]=response as? [[String:AnyObject]]{
                for items in res{
                    
                    if var images = items["_122_135"] as? String{
                         if var imagesDetail = items["_122_111"] as? String{
                        if self.optionIdDict[item] != nil{
                            self.optionIdDict[item]?.append(images as AnyObject)
                            
                            
                        }else{
                            self.optionIdDict[item] = [images as AnyObject]
                        }
                            if self.optionIdDict2[item] != nil{
                                self.optionIdDict2[item]?.append(imagesDetail as AnyObject)
                                
                                
                            }else{
                                self.optionIdDict2[item] = [imagesDetail as AnyObject]
                            }
                        }
                        self.getChiceOption2.append(images)
                    }else{
                        self.getChiceOption2.append("Default")
                    }
                    //optionIdDict[item] = images
                }
                self.optionIdDictArr2.append(self.optionIdDict2 as [String : AnyObject])
                self.optionIdArrDict.append(self.optionIdDict as [String : AnyObject])
                print( self.optionIdArrDict)
                self.optionIdDict.removeAll()
                self.optionIdDict2.removeAll()
            }
            
           
            self.myGroup.leave()
            
            DispatchQueue.main.async {
                // self.getBuisnessdetails()
                self.progressView.stopAnimating()
                self.progressView.isHidden=true
                self.hiddenView.isHidden = true
                
                self.itemDetailtblview.isUserInteractionEnabled = true
                self.itemDetailtblview.reloadData()
            }
        })
        self.myGroup.notify(queue: .main) {
            print("Finished all requests.")
        }
       // }
    }
    
    //relatedItems
    var relatedItemsArr:[[String:AnyObject]]=[]
    var relatedImageArr:[String]=[]
    var getRelateImgArr:[String]=[]
    var totalRelateImgArrUrl:[URL]=[]
    var relatedItemName:[String]=[]
    var relatedItemPrice:[String]=[]
    
    var relatedItemArrayDict:[[String:AnyObject]]=[]
     var relatedDict:[String:[AnyObject]]=[:]
    func getRelatedItem(){
       
        var getRelatedItemReq:[String:AnyObject]=[:]
        getRelatedItemReq["53"] = loginUserId as AnyObject
        if dataComesSpecialFlag == true{
             getRelatedItemReq["114.144"] = productId as AnyObject
        }else{
        if itemDetailFlag == true{
            getRelatedItemReq["114.144"] = productId as AnyObject
        }else{
            if let strt = productId.characters.count as? Int{
                if strt == 1{
                    getRelatedItemReq["114.144"] = "0000000000"+productId as AnyObject
                }else{
                    getRelatedItemReq["114.144"] = "000000000"+productId as AnyObject
                }
            }
       // getRelatedItemReq["114.144"] = "0000000000"+productId as AnyObject
        }
        }
        var num:String = ""
        if specialClass.specialFlag == false{
            num = "010100019"
            myModel.addManager.getRelatedItems(num, userinfo: getRelatedItemReq, completionResponse: { ( response,  error) in
                print(response)
                if let res:[[String:AnyObject]]=response as? [[String:AnyObject]]{
                    for items in res{
                        if let productID = items["_114_144"] as? String{
                            if self.relatedDict["productId"] == nil{
                                self.relatedDict["productId"] = [productID  as AnyObject]
                                
                            }else{
                                self.relatedDict["productId"]?.append(productID as AnyObject)
                                
                            }
                        }
                        if let images = items["_121_170"] as? String{
                            let url =  self.urlImage.appending(images as String)
                            if let urls = NSURL(string: url) {
                                if self.relatedDict["image"] == nil{
                                    self.relatedDict["image"] = [urls  as AnyObject]
                                    
                                }else{
                                    self.relatedDict["image"]?.append(urls as AnyObject)
                                    
                                }
                            }
                            self.relatedImageArr.append(images)
                        }
                        
                        if let names = items["_120_83"] as? String{
                            
                            if self.relatedDict["name"] == nil{
                                self.relatedDict["name"] = [names  as AnyObject]
                                
                            }else{
                                self.relatedDict["name"]?.append(names as AnyObject)
                                
                            }
                            self.relatedItemName.append(names)
                        }
                        if let price = items["_114_98"] as? String{
                            if self.relatedDict["price"] == nil{
                                self.relatedDict["price"] = [price  as AnyObject]
                                
                            }else{
                                self.relatedDict["price"]?.append(price as AnyObject)
                                
                            }
                            self.relatedItemPrice.append(price)
                        }
                        if let price = items["_122_158"] as? String{
                            if self.relatedDict["discount"] == nil{
                                self.relatedDict["discount"] = [price  as AnyObject]
                                
                            }else{
                                self.relatedDict["discount"]?.append(price as AnyObject)
                                
                            }
                           // self.relatedItemPrice.append(price)
                        }
                        for images in self.relatedImageArr{
                            let url =  self.urlImage.appending(images as String)
                            self.getRelateImgArr.append(url)
                        }
                        for i in 0..<self.getRelateImgArr.count{
                            if let url = NSURL(string: self.getRelateImgArr[i]) {
                                self.totalRelateImgArrUrl.append(url as URL)
                                
                            }
                        }
                        
                        self.relatedItemArrayDict.append(self.relatedDict as [String : AnyObject])
                        self.relatedDict.removeAll()
                        // self.itemDetailtblview.reloadData()
                    }
                    self.getAlsoViewedItems()
                }
            })
        }else{
            num = "010100488"
        
        
            myModel.addManager.callMainDict(forHistory: num, userinfo: getRelatedItemReq, completionResponse: { ( response,  error) in
            print(response)
            if let res:[[String:AnyObject]]=response as? [[String:AnyObject]]{
                for items in res{
                   
                        if var ratings = items["RESULT"] as? [[String:AnyObject]]{
                            for rati in ratings{
                             if var ratingsIA = rati["IA"] as? [[String:AnyObject]]{
                                print(ratingsIA)
                                
                                for imElements in ratingsIA{
                                    if let names = imElements["_120_83"] as? String{
                                        
                                        if self.relatedDict["name"] == nil{
                                            self.relatedDict["name"] = [names  as AnyObject]
                                            
                                        }else{
                                            self.relatedDict["name"]?.append(names as AnyObject)
                                            
                                        }
                                        self.relatedItemName.append(names)
                                        if let price = imElements["_114_98"] as? String{
                                            if self.relatedDict["price"] == nil{
                                                self.relatedDict["price"] = [price  as AnyObject]
                                                
                                            }else{
                                                self.relatedDict["price"]?.append(price as AnyObject)
                                                
                                            }
                                            self.relatedItemPrice.append(price)
                                        }
                                        if let price = imElements["_122_158"] as? String{
                                            if self.relatedDict["discount"] == nil{
                                                self.relatedDict["discount"] = [price  as AnyObject]
                                                
                                            }else{
                                                self.relatedDict["discount"]?.append(price as AnyObject)
                                                
                                            }
                                            self.relatedItemPrice.append(price)
                                        }
                                        if let productID = imElements["_114_144"] as? String{
                                            if self.relatedDict["productId"] == nil{
                                                self.relatedDict["productId"] = [productID  as AnyObject]
                                                
                                            }else{
                                                self.relatedDict["productId"]?.append(productID as AnyObject)
                                                
                                            }
                                        }
                                    }
                                    if var ratingsIA = imElements["IM"] as? [[String:AnyObject]]{
                                        for images in ratingsIA{
                                            if let names = images["_47_42"] as? String{
                                               
                                                    let url =  self.urlImage.appending(names as String)
                                                    if let urls = NSURL(string: url) {
                                                        if self.relatedDict["image"] == nil{
                                                            self.relatedDict["image"] = [urls  as AnyObject]
                                                            
                                                        }else{
                                                            self.relatedDict["image"]?.append(urls as AnyObject)
                                                            
                                                        }
                                                    }
                                                    self.relatedImageArr.append(names)
                                               
                                            }
                                        }
                                    }
                                                        for images in self.relatedImageArr{
                                                            let url =  self.urlImage.appending(images as String)
                                                            self.getRelateImgArr.append(url)
                                                        }
                                                        for i in 0..<self.getRelateImgArr.count{
                                                            if let url = NSURL(string: self.getRelateImgArr[i]) {
                                                                self.totalRelateImgArrUrl.append(url as URL)
                                    
                                                            }
                                                        }
                                    self.relatedItemArrayDict.append(self.relatedDict as [String : AnyObject])
                                    self.relatedDict.removeAll()
                                }
                            }
                        }
                    }
                    
                    
                    
//                    if let names = items["_120_83"] as? String{
//
//                        if self.relatedDict["name"] == nil{
//                            self.relatedDict["name"] = [names  as AnyObject]
//
//                        }else{
//                            self.relatedDict["name"]?.append(names as AnyObject)
//
//                        }
//                        self.relatedItemName.append(names)
//                    }
//                    if let price = items["_114_98"] as? String{
//                        if self.relatedDict["price"] == nil{
//                            self.relatedDict["price"] = [price  as AnyObject]
//
//                        }else{
//                            self.relatedDict["price"]?.append(price as AnyObject)
//
//                        }
//                        self.relatedItemPrice.append(price)
//                    }


                    
                   // self.relatedItemArrayDict.append(self.relatedDict as [String : AnyObject])
                   // self.relatedDict.removeAll()
                    // self.itemDetailtblview.reloadData()
                }
                self.getAlsoViewedItems()
            }
        })
        }
        
        
    }
   var imageDetailUrl:[URL]=[]
    var alsoViewedImageArr:[String]=[]
    var getAlsoViewedImgArr:[String]=[]
    var totalAlsoViewedImgArrUrl:[URL]=[]
    var alsoViewedItemName:[String]=[]
    var AlsoViewedItemPrice:[String]=[]
    var alsoViewedDict:[String:[AnyObject]]=[:]
    var alsoViewedArrDict:[[String:AnyObject]]=[]
    
    func getAlsoViewedItems(){
        
        var getSpecialItemReq:[String:AnyObject]=[:]
        getSpecialItemReq["53"] = loginUserId as AnyObject
        if dataComesSpecialFlag == true{
            getSpecialItemReq["114.144"] = productId as AnyObject
        }else{
        if itemDetailFlag == true{
            getSpecialItemReq["114.144"] = productId as AnyObject
        }else{
        if let strt = productId.characters.count as? Int{
            if strt == 1{
                getSpecialItemReq["114.144"] = "0000000000"+productId as AnyObject
            }else if strt == 2{
                getSpecialItemReq["114.144"] = "000000000"+productId as AnyObject
            }else{
                getSpecialItemReq["114.144"] = "00000000"+productId as AnyObject
            }
        }
        }
        }
       // getSpecialItemReq["114.144"] = "0000000000"+productId as AnyObject
        
        myModel.addManager.getAlsoViewedItems("010400599", userinfo: getSpecialItemReq, completionResponse: { ( response,  error) in
            print(response)
            
            if let res:[[String:AnyObject]]=response as? [[String:AnyObject]]{
                for items in res{
                    if let productID = items["_114_144"] as? String{
                        if self.alsoViewedDict["productId"] == nil{
                            self.alsoViewedDict["productId"] = [productID  as AnyObject]
                            
                        }else{
                            self.alsoViewedDict["productId"]?.append(productID as AnyObject)
                            
                        }
                    }
                    if let getImg = items["_121_170"] as? String{
                         let url =  self.urlImage.appending(getImg as String)
                        if let urls = NSURL(string: url) {
                        if self.alsoViewedDict["image"] == nil{
                            self.alsoViewedDict["image"] = [urls  as AnyObject]
                            
                        }else{
                            self.alsoViewedDict["image"]?.append(urls as AnyObject)
                            
                        }
                        
                        }
                        
                        self.getAlsoViewedImgArr.append(getImg)
                    }
                    for images in self.getAlsoViewedImgArr{
                        let url =  self.urlImage.appending(images as String)
                        self.alsoViewedImageArr.append(url)
                    }
                    for i in 0..<self.alsoViewedImageArr.count{
                        if let url = NSURL(string: self.alsoViewedImageArr[i]) {
                            self.totalAlsoViewedImgArrUrl.append(url as URL)
                            
                        }
                    }
                    if let getImg = items["_120_83"] as? String{
                        if self.alsoViewedDict["name"] == nil{
                            self.alsoViewedDict["name"] = [getImg  as AnyObject]
                            
                        }else{
                            self.alsoViewedDict["name"]?.append(getImg as AnyObject)
                            
                        }
                        self.alsoViewedItemName.append(getImg)
                    }
                    if let getImg = items["_114_98"] as? String{
                        if self.alsoViewedDict["price"] == nil{
                            self.alsoViewedDict["price"] = [getImg  as AnyObject]
                            
                        }else{
                            self.alsoViewedDict["price"]?.append(getImg as AnyObject)
                            
                        }
                        self.AlsoViewedItemPrice.append(getImg)
                    }
                    if let getImg = items["_122_158"] as? String{
                        if self.alsoViewedDict["discount"] == nil{
                            self.alsoViewedDict["discount"] = [getImg  as AnyObject]
                            
                        }else{
                            self.alsoViewedDict["discount"]?.append(getImg as AnyObject)
                            
                        }
                       // self.AlsoViewedItemPrice.append(getImg)
                    }
                    if let imageArr = items["SP"] as? [[String:AnyObject]]{
                        for imgitem in imageArr{
                            
                        }
                    }
                    self.alsoViewedArrDict.append(self.alsoViewedDict as [String : AnyObject])
                    self.alsoViewedDict.removeAll()
                    self.itemDetailtblview.reloadData()

                }
                
            }
            self.getStoredetails()
            
        })
        
    }
    
    @IBAction func messageIconClicked(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "SearchMessagesVC") as! SearchMessagesVC
        vc.productId = productId
        vc.messageBool = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView.tag == 701{
            return 1
        }else{
            
            return 4
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 701{
            return imageDetailUrl.count
        }
        else{
        
            return 1
        
        }
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 701{
            let cell = tableView.dequeueReusableCell(withIdentifier: "loadRelatedimageCell") as! loadRelatedimageCell
            cell.loadSelectImageView.sd_setImage(with: imageDetailUrl[indexPath.row])
            cell.selectionStyle = .none
            return cell
        }else{
        if indexPath.section == 0{
            let cell = itemDetailtblview.dequeueReusableCell(withIdentifier: "itemDetailCell") as! itemDetailCell
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            cell.selectImageView.isUserInteractionEnabled = true
            cell.selectImageView.addGestureRecognizer(tapGestureRecognizer)
            cell.selectedImageTableView.tag = 701
            cell.outerView.layer.cornerRadius = 3
            cell.outerView.clipsToBounds = true
            cell.storeNmLbl.text = self.storeNameStr
            if storeNameStr != ""{
            cell.storeNmLbl.layer.borderWidth = 1.0
             cell.storeNmLbl.layer.borderColor = UIColor.blue.cgColor
            cell.storeNmLbl.layer.cornerRadius = 5.0
            }
            
            cell.storeNameBtn.layer.borderWidth = 1.0
            cell.storeNameBtn.layer.borderColor = UIColor.blue.cgColor
            cell.storeNameBtn.layer.cornerRadius = 5.0
            
            if let url = NSURL(string: imageUrlStr) {
                let  urlPath = url as URL!
                //TestClassStore.storeNameImage = urlPath
                 cell.storeImgView.sd_setImage(with: urlPath)
                
            }
            if ratingNum == "1"{
               // cell.ratingLbl.text = ratingNum
                cell.starBtn1.setImage(UIImage(named:"yStar"), for: .normal)
                
            }
            if ratingNum == "2"{
                //cell.ratingLbl.text = ratingNum
                cell.starBtn1.setImage(UIImage(named:"yStar"), for: .normal)
                cell.starBtn2.setImage(UIImage(named:"yStar"), for: .normal)
            }
            if ratingNum == "3"{
               // cell.ratingLbl.text = ratingNum
                cell.starBtn1.setImage(UIImage(named:"yStar"), for: .normal)
                cell.starBtn2.setImage(UIImage(named:"yStar"), for: .normal)
                cell.starBtn3.setImage(UIImage(named:"yStar"), for: .normal)
            }
            if ratingNum == "4"{
               // cell.ratingLbl.text = ratingNum
                cell.starBtn1.setImage(UIImage(named:"yStar"), for: .normal)
                cell.starBtn2.setImage(UIImage(named:"yStar"), for: .normal)
                cell.starBtn3.setImage(UIImage(named:"yStar"), for: .normal)
                cell.starBtn4.setImage(UIImage(named:"yStar"), for: .normal)
            }
            if ratingNum == "5"{
              //  cell.ratingLbl.text = ratingNum
                cell.starBtn1.setImage(UIImage(named:"yStar"), for: .normal)
                cell.starBtn2.setImage(UIImage(named:"yStar"), for: .normal)
                cell.starBtn3.setImage(UIImage(named:"yStar"), for: .normal)
                cell.starBtn4.setImage(UIImage(named:"yStar"), for: .normal)
                cell.starBtn5.setImage(UIImage(named:"yStar"), for: .normal)
            }
            cell.selectionStyle = .none
            if itemPriceStr != ""{
                if specialClass.specialFlag == true{
                    cell.itemPriceLbl.text =  itemPriceStr
                }else{
            cell.itemPriceLbl.text = "$" + itemPriceStr
                }
            }
            if storeNameStr != ""{
            //cell.storeNameBtn.setTitle(storeNameStr, for: .normal)
            }
            if itemNameStr != ""{
            cell.itemNameLbl.text = itemNameStr
            }
            if imageDetailUrl.count>indexPath.row{
            cell.selectImageView.sd_setImage(with: imageDetailUrl[0])
            }
            else if self.itemImagePath != nil{
                 cell.selectImageView.sd_setImage(with: self.itemImagePath)
              //  cell.selectImageView.image = UIImage(named: self.itemImagePath)
                
            }
            else{
                cell.selectImageView.image = UIImage(named: "noImage.png")
                
            }
            if favStringArr.contains(productId){
                cell.favBtn.setImage(UIImage(named:"favourite-red"), for: .normal)
            }
            cell.selectedImageTableView.reloadData()
            return cell
        }
        if indexPath.section == 1{
            let cell = itemDetailtblview.dequeueReusableCell(withIdentifier: "descriptionCells") as! descriptionCells
            cell.outerView.layer.cornerRadius = 3
            cell.outerView.clipsToBounds = true
            cell.descriptionTxt.text = self.descTxt
           // cell.descriptionLbl.text = self.descTxt
            TestClassStore.storeAbout = self.descTxt
            cell.selectionStyle = .none
            return cell
        }
        if indexPath.section == 2{
            let cell = itemDetailtblview.dequeueReusableCell(withIdentifier: "relatedItemCell") as! relatedItemCell
            cell.selectionStyle = .none
            cell.outerView.layer.cornerRadius = 3
            cell.outerView.clipsToBounds = true
            if totalRelateImgArrUrl.count>indexPath.row{
                cell.specialItemLbl.isHidden=false
            }else{
                 cell.specialItemLbl.isHidden=true
            }
            cell.relatedCollectionView.reloadData()
            
            return cell
        }
        if indexPath.section == 3{
            let cell = itemDetailtblview.dequeueReusableCell(withIdentifier: "alsoViewitemCell") as! alsoViewitemCell
            cell.selectionStyle = .none
            cell.outerView.layer.cornerRadius = 3
            cell.outerView.clipsToBounds = true
            if totalAlsoViewedImgArrUrl.count>indexPath.row{
                cell.alsoViewItemLbl.isHidden=false
            }else{
                cell.alsoViewItemLbl.isHidden=true
            }
            cell.alsoViewItemCollectionView.reloadData()
            return cell
        }
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       if tableView.tag == 701{
        
        let cell = itemDetailtblview.cellForRow(at: IndexPath(row: 0, section: 0)) as! itemDetailCell
        // let cell = itemDetailtblview.dequeueReusableCell(withIdentifier: "itemDetailCell", forIndexPath: indexPath) as! itemDetailCell
        let image = imageDetailUrl[indexPath.row]
        cell.selectImageView.sd_setImage(with: image)
       
       }else{
       
        }
    }
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ItemGalleryVC") as! ItemGalleryVC
        vc.imageGalleryUrl = imageDetailUrl
        self.navigationController?.pushViewController(vc, animated: true)
       // let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        // Your action
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.tag == 701{
        return 50
        }else{
            if indexPath.section==0{
               return 350
            }
            if indexPath.section==1{
               // if totalAlsoViewedImgArrUrl.count>indexPath.row{
                
                if self.descTxt != ""{
                    var height:CGFloat = self.calculateHeight(inString: self.descTxt)
                    return height + 35

                
                }else{
                    var height:CGFloat = self.calculateHeight(inString: self.descTxt)
                    return 0
                    //return height + 10.0
                    // return 150
                }
            }
            if indexPath.section==2{
                if totalRelateImgArrUrl.count<=0{
                    return 0
                }else{
                     return 210
                }
               
            }
            if indexPath.section==3{
                if totalAlsoViewedImgArrUrl.count<=0{
                    return 0
                }else{
                return 210
                }
            }
        }
        return 44
    }
    let hiddensView = UIView()
    let deviderLineView = UIView()
    let keyContentLabel = UILabel()
    let contentView = UIView()
     
    
    @IBAction func addToCartBtnTapped(_ sender: Any) {
        self.getData()
        addCart()
    }
    let quantityView = UIView()
    
    func addCart(){
        var pickerOptionkeyArr:[String]=[]
        for item in dict1{
            print(item.key)
            pickerOptionkeyArr.append(item.key)
            
            print(item.value)
            print(dict1.keys)
            print(dict1.values)
        }
        hiddenView.isHidden = false
        hiddenView.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
        itemDetailtblview.isUserInteractionEnabled = false
        sleep(0)
        let font = UIFont(name: "HelveticaNeue-Light", size: 13)
        let width = UIScreen.main.bounds.width-40
        hiddensView.frame = CGRect(x:10, y:UIScreen.main.bounds.height/2-(500)/2-25, width:UIScreen.main.bounds.width-20,height: 550)
        hiddensView.backgroundColor = UIColor.clear
        contentView.frame = CGRect(x:20, y:UIScreen.main.bounds.height/2-(500)/2, width:UIScreen.main.bounds.width-40, height:450)
        contentView.backgroundColor = UIColor.yellow
        contentView.layer.cornerRadius = 7
        contentView.layer.borderWidth = 1
        //  contentView.layer.borderColor = UIColor(red: 21.0/255.0, green: 162.0/255.0, blue: 198.0/255.0, alpha: 1.0).cgColor
        deviderLineView.frame = CGRect(x:5, y:35, width:contentView.bounds.width-10,height: 1)
        // deviderLineView.backgroundColor = UIColor(red: 21.0/255.0, green: 162.0/255.0, blue: 198.0/255.0, alpha: 1.0)
        contentView.backgroundColor = UIColor.white
        
        keyContentLabel.frame = CGRect(x:10, y:5,width:contentView.frame.width-20,height: 30)
        keyContentLabel.numberOfLines = 0
        keyContentLabel.text = "Add Items into Cart"
        keyContentLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        keyContentLabel.textAlignment = NSTextAlignment.left
       // keyContentLabel.textColor = UIColor.blue
        keyContentLabel.textColor = UIColor(red: 13.0/255.0, green: 102.0/255.0, blue: 202.0/255.0, alpha: 1.0)
        keyContentLabel.backgroundColor = UIColor.clear
        
        contentsLb.frame = CGRect(x:10, y:55,width:contentView.frame.width-20, height:20)
        contentsLb.numberOfLines = 0
        if allPickingData.count>0{
           if pickerOptionkeyArr.count>0{
        contentsLb.text =  pickerOptionkeyArr[0]
           }else{
             contentsLb.text = "Default"
            }
        }
        
       // contentsLb.text = "Select Type"
        contentsLb.textColor = UIColor(red: 13.0/255.0, green: 102.0/255.0, blue: 202.0/255.0, alpha: 1.0)
        removeLbl.frame = CGRect(x:10, y:124,width:contentView.frame.width-100, height:25)
        removeLbl.numberOfLines = 0
        removeLbl.textAlignment = NSTextAlignment.left
        removeLbl.text = "Choose Option"
        if dict1.count<2{
            removeLbl.isHidden = true
        }else{
            removeLbl.isHidden = false
        }
        if allPickingData.count>0{
          if   pickerOptionkeyArr.count>1 {
                self.removeLbl.text =  pickerOptionkeyArr[1]
            }
        }
        removeLbl.textColor = UIColor(red: 13.0/255.0, green: 102.0/255.0, blue: 202.0/255.0, alpha: 1.0)
        colorTxField.frame = CGRect(x:30, y:179,width:contentView.frame.width-50, height:30)
        
        colorTxField.placeholder = " " + "Color"
        colorTxField.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
        colorTxField.textColor = UIColor.lightGray
        colorTxField.layer.borderWidth = 1
        colorTxField.layer.cornerRadius = 5
        colorTxField.layer.borderColor = UIColor.gray.cgColor
        colorTxField.delegate=self
         colorTxField.backgroundColor = UIColor.white
        if dict1.count<2{
            colorTxField.isHidden = true
        }else{
            colorTxField.isHidden = false
        }
//        if allPickingData.count>0{
//            for itemPicker in pickerOptionValues{
//                for (key,val) in itemPicker{
//                    if  removeLbl.text == key{
//                        var arrayPick:[String]=[]
//                        //   arrayPick.append(val as! String)
//                        if let arrayPicker:[String] = val as? [String]{
//                            colorTxField.text =  arrayPicker[0]
//                        }
//                    }
//                }
//            }
//
//        }
        if dict1.count>0{
             for (key,val) in dict1{
             if  removeLbl.text == key{
                
                if let dictItem = dict1[key] as? [[String:AnyObject]]{
                    for itemPicker in dictItem{
                                for (key,val) in itemPicker{
                                    colorTxField.text = val as! String
                        }
                    }
                }
            }
        }
            for (key,val) in dict1{
                if  contentsLb.text == key{
                    
                    if let dictItem = dict1[key] as? [[String:AnyObject]]{
                        for itemPicker in dictItem{
                            for (key,val) in itemPicker{
                                qualityTextField.text = val as! String
                            }
                        }
                    }
                }
            }
    }
        colorTxField.textAlignment = .center
        
        
        colorTxField.tag = 202
        
        qualityTextField.frame = CGRect(x:30, y:109,width:contentView.frame.width-50, height:30)
         qualityTextField.placeholder = " " + "Size"
        if allPickingData.count>0{
           //qualityTextField.text =  pickersView.selectRow(0, inComponent: 0, animated: false)
        }
        qualityTextField.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
        qualityTextField.textColor = UIColor.lightGray
        qualityTextField.delegate=self
        qualityTextField.layer.borderWidth = 1
        qualityTextField.layer.cornerRadius = 5
        qualityTextField.layer.borderColor = UIColor.gray.cgColor
        //qualityTextField.text = self.allPickingData[0]
        qualityTextField.textAlignment = .center
        qualityTextField.backgroundColor = UIColor.white
        
       // qualityTextField.inputView = pickersView
       // qualityTextField.inputAccessoryView = toolBar
        qualityTextField.tag = 201
        if let qtyA =  getPickervalues["shipping adress"] as? String{
            qualityTextField.text = qtyA
        }

        let dropDown1 = UIButton()
        dropDown1.frame = CGRect(x:qualityTextField.frame.width  ,y:110,width:20, height:25)
        //dropDown1.setTitle("-", for: .normal)
        dropDown1.setImage(UIImage(named:"dropDown"), for: .normal)
        dropDown1.backgroundColor = UIColor.white
        dropDown1.tintColor = UIColor.white
        dropDown1.addTarget(self, action: #selector(ItemDetailVC.quantityDecr), for: UIControlEvents.touchUpInside)
        
        
        
        
        let dropDown2 = UIButton()
        dropDown2.frame = CGRect(x:colorTxField.frame.width  ,y:180,width:20, height:25)
        //dropDown1.setTitle("-", for: .normal)
         if dict1.count<2{
            dropDown2.isHidden = true
         }else{
             dropDown2.setImage(UIImage(named:"dropDown"), for: .normal)
             dropDown2.isHidden = false
        }
        dropDown2.setImage(UIImage(named:"dropDown"), for: .normal)
        dropDown2.backgroundColor = UIColor.white
        dropDown2.tintColor = UIColor.white
        dropDown2.addTarget(self, action: #selector(ItemDetailVC.quantityDecr), for: UIControlEvents.touchUpInside)
        
        
       
       // removeLbl.textColor = UIColor(red: 21.0/255.0, green: 162.0/255.0, blue: 198.0/255.0, alpha: 1.0)
        
        
        
        qualityLbl.frame = CGRect(x:12, y:194,width:contentView.frame.width-100, height:25)
        qualityLbl.numberOfLines = 0
        qualityLbl.textAlignment = NSTextAlignment.left
        qualityLbl.text = "Quantity"
        qualityLbl.font = UIFont(name: "HelveticaNeue-Light", size: 15)
        qualityLbl.textColor = UIColor(red: 13.0/255.0, green: 102.0/255.0, blue: 202.0/255.0, alpha: 1.0)
        
        //qualityLbl.textColor = UIColor(red: 21.0/255.0, green: 162.0/255.0, blue: 198.0/255.0, alpha: 1.0)
        
        
        qtylblText.frame = CGRect(x:180, y:250,width:50, height:30)
        qtylblText.numberOfLines = 0
        qtylblText.textAlignment = NSTextAlignment.center
        qtylblText.text = "QTY 1"
        qtylblText.backgroundColor = UIColor.lightGray
        qtylblText.font = UIFont(name: "HelveticaNeue-Light", size: 14)
        qtylblText.textColor = UIColor.white
//        quantityView.frame = CGRect(x:50, y:230, width:UIScreen.main.bounds.width-40/2, height:50)
//        quantityView.backgroundColor = UIColor.yellow
//        quantityView.layer.cornerRadius = 7
//        quantityView.layer.borderWidth = 1
        
        let quantityIncrement = UIButton()
        quantityIncrement.frame = CGRect(x:150,y:250,width:30, height:30)
        quantityIncrement.setTitle("-", for: .normal)
        quantityIncrement.backgroundColor = UIColor.black
        quantityIncrement.tintColor = UIColor.white
        quantityIncrement.backgroundColor = UIColor.lightGray
        quantityIncrement.addTarget(self, action: #selector(ItemDetailVC.quantityDecr), for: UIControlEvents.touchUpInside)
        
        
        
        
        
        let quantityDecrement = UIButton()
        quantityDecrement.frame = CGRect(x:226,y:250,width:30, height:30)
        quantityDecrement.setTitle("+", for: .normal)
        quantityDecrement.backgroundColor = UIColor.black
        quantityDecrement.tintColor = UIColor.white
        quantityDecrement.backgroundColor = UIColor.lightGray
        quantityDecrement.addTarget(self, action: #selector(ItemDetailVC.quantityIncr), for: UIControlEvents.touchUpInside)
        
        
        
        
        let SpecialInstructionLabl = UILabel()
        
        SpecialInstructionLabl.frame = CGRect(x:30, y:285,width:contentView.frame.width-100, height:25)
        SpecialInstructionLabl.numberOfLines = 0
        SpecialInstructionLabl.textAlignment = NSTextAlignment.left
        SpecialInstructionLabl.text = "Special Instruction"
        SpecialInstructionLabl.textColor = UIColor(red: 13.0/255.0, green: 102.0/255.0, blue: 202.0/255.0, alpha: 1.0)
        
        
        
        let SpecialInstructionTxtView = UITextView()
        
        SpecialInstructionTxtView.frame = CGRect(x:30, y:315,width:contentView.frame.width-30, height:85)
       // SpecialInstructionTxtView.numberOfLines = 0
        SpecialInstructionTxtView.textAlignment = NSTextAlignment.left
        SpecialInstructionTxtView.layer.borderWidth=1
        SpecialInstructionTxtView.delegate = self
       SpecialInstructionTxtView.layer.borderColor = UIColor(red: 13.0/255.0, green: 102.0/255.0, blue: 202.0/255.0, alpha: 1.0).cgColor
        
        SpecialInstructionTxtView.textColor = UIColor(red: 13.0/255.0, green: 102.0/255.0, blue: 202.0/255.0, alpha: 1.0)
        
        
        let submitButton = UIButton()
        submitButton.frame = CGRect(x:contentView.frame.width-90,y:419,width:80, height:35)
        submitButton.setTitle("Submit", for: .normal)
        submitButton.backgroundColor = UIColor(red: 13.0/255.0, green: 102.0/255.0, blue: 202.0/255.0, alpha: 1.0)
        submitButton.tintColor = UIColor.white
        submitButton.addTarget(self, action: #selector(ItemDetailVC.submitBtn), for: UIControlEvents.touchUpInside)
        
        
        
        
        
        let cancelButton = UIButton()
        cancelButton.frame = CGRect(x:contentView.frame.width-180,y:419,width:80, height:35)
         cancelButton.backgroundColor = UIColor(red: 13.0/255.0, green: 102.0/255.0, blue: 202.0/255.0, alpha: 1.0)
        cancelButton.tintColor = UIColor.white
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.addTarget(self, action: #selector(ItemDetailVC.cancel), for: UIControlEvents.touchUpInside)
        
        hiddensView.addSubview(cancelButton)
        hiddensView.addSubview(dropDown1)
        hiddensView.addSubview(dropDown2)
        contentView.addSubview(removeLbl)
        contentView.addSubview(contentsLb)
        contentView.addSubview(keyContentLabel)
        hiddensView.addSubview(qualityTextField)
        hiddensView.addSubview(colorTxField)
        contentView.addSubview(qualityLbl)
        hiddensView.addSubview(SpecialInstructionLabl)
         hiddensView.addSubview(SpecialInstructionTxtView)
        hiddensView.addSubview(quantityIncrement)
        hiddensView.addSubview(quantityDecrement)
       hiddensView.addSubview(qtylblText)
        contentView.addSubview(deviderLineView)
        hiddensView.addSubview(submitButton)
        hiddenView.addSubview(quantityView)
        hiddenView.addSubview(contentView)
        hiddenView.addSubview(hiddensView)
        self.view.bringSubview(toFront: hiddensView)
    }
    var cur = 0;
    var curStr:String = ""
    func quantityDecr(){
        
        
        someValue -= 1
        self.qtylblText.text = "QTY "+String(someValue)
        curStr = self.qtylblText.text!
        
//        if let iCur:Int = qtylblText.text as? Int{
//            cur = iCur
//             self.qtylblText.text = String(cur - 1);
//        }
//     // cur = Int(qtylblText.text!);
      
        
    }
    func quantityIncr(){
        someValue += 1
        self.qtylblText.text = "QTY "+String(someValue)
       curStr = self.qtylblText.text!
        
    }
    func cancel(){
        self.hiddensView.removeFromSuperview()
        self.contentsLb.removeFromSuperview()
        self.contentView.removeFromSuperview()
        self.itemDetailtblview.isUserInteractionEnabled = true
        self.hiddenView.isHidden = true
    }
    func submitBtn(){
        var addCart = [String: AnyObject]()
        addCart["53"] = loginUserId as AnyObject
        if let strt = productId.characters.count as? Int{
            if strt == 1{
                productId = "0000000000"+productId  as! String
            }else if  strt == 2 {
                productId = "000000000"+productId
            }
            else if  strt == 3 {
                productId = "00000000"+productId
            }else{
                productId = "0000000"+productId
            }
        }
        let aString = curStr
        let newString = aString.replacingOccurrences(of: "QTY ", with: "", options: .literal, range: nil)
        
        
        addCart["114.121"] = newString as AnyObject
        
        
        addCart["114.179"] = merchantid as AnyObject
       
        let arrayOfDictionaries: [[String:AnyObject]]  = [["121.104":"00000000074" as AnyObject],["121.104":"00000000078" as AnyObject]]
        
        let item = arrayOfDictionaries.toJSONString()
        
        addCart["CH"] = item as AnyObject
        var dictItem:[String:Any]=[:]
        if productId1 != "" &&   productId2 != ""{
            if let strt = productId1.characters.count as? Int{
                if strt == 1{
                    productId1 = "0000000000"+productId1  as! String
                }else if  strt == 2 {
                    productId1 = "000000000"+productId1
                }
                else if  strt == 3 {
                    productId1 = "00000000"+productId1
                }else{
                    productId1 = "0000000"+productId1
                }
            }
            if let strt = productId2.characters.count as? Int{
                if strt == 1{
                    productId2 = "0000000000"+productId2  as! String
                }else if  strt == 2 {
                    productId2 = "000000000"+productId2
                }
                else if  strt == 3 {
                    productId2 = "00000000"+productId2
                }else{
                    productId2 = "0000000"+productId2
                }
            }
        let dict = ["114.144" : productId,"114.179":merchantid,"53":loginUserId,"114.121":newString,"CH":[["121.104":productId1 as AnyObject],["121.104":productId2 as AnyObject]]] as [String : Any]
            dictItem = dict
        }else if productId1 == ""{
            if let strt = productId2.characters.count as? Int{
                if strt == 1{
                    productId2 = "0000000000"+productId2  as! String
                }else{
                    productId2 = "000000000"+productId2
                }
            }
            
             let dict = ["114.144" : productId,"114.179":merchantid,"53":loginUserId,"114.121":newString,"CH":[["121.104":productId2 as AnyObject]]] as [String : Any]
             dictItem = dict
        }else{
            if let strt = productId1.characters.count as? Int{
                if strt == 1{
                    productId1 = "0000000000"+productId1  as! String
                }else{
                    productId1 = "000000000"+productId1
                }
            }
            
            let dict = ["114.144" : productId,"114.179":merchantid,"53":loginUserId,"114.121":"1","CH":[["121.104":productId1 as AnyObject]]] as [String : Any]
            dictItem = dict
            
        }
        myModel.addManager.addItems(intoCarts: "030400198", userinfo: dictItem, completionResponse: { ( response,  error) in
            print(response)
            if response != nil{
                let alertController = UIAlertController(title: "Success", message: "Add To Cart Sucessfully", preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                    self.openCheckOutView()
                }))
             //   alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }else{
                let alertController = UIAlertController(title: "Ooppss", message: "Add To Cart not  Sucessfully", preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                
               alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
             DispatchQueue.main.async {
                self.hiddensView.removeFromSuperview()
                self.contentsLb.removeFromSuperview()
                self.contentView.removeFromSuperview()
                self.itemDetailtblview.isUserInteractionEnabled = true
                self.hiddenView.isHidden = true
            }
            
        })
     
    }
    func openCheckOutView(){
        hiddenView.isHidden=false
        itemDetailtblview.isUserInteractionEnabled = false
        checkOutView.isHidden=false
    }
    
    @IBAction func continueShoppingCartBtnTapped(_ sender: Any) {
        hiddenView.isHidden=true
        checkOutView.isHidden=true
        itemDetailtblview.isUserInteractionEnabled = true
    }
    
    @IBAction func checkOutBtnTapped(_ sender: Any) {
//        hiddenView.isHidden=true
//         checkOutView.isHidden=true
//        let vc = storyboard?.instantiateViewController(withIdentifier: "CheckOutVC") as! ShoppingCartsVC
//        
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func moreItembtntapp(_ sender: Any) {
        moreDetailsView.isHidden = false
        self.view.addSubview(moreDetailsView)
       // moreDetailsView.view.isHidden = false
       
//         let vc = storyboard?.instantiateViewController(withIdentifier: "ItemRatingVC") as! ItemRatingVC
//        TestClassStore.storeMerchantId = merchantid
//        vc.merchantId = merchantid
//        vc.descText = self.descTxt
//        vc.favArr = favStringArr
//        vc.productid = productId
//        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    var imageUrlStr:String = ""
    func getBuisnessdetails(){
      var  businessDict:[String:AnyObject]=[:]
        businessDict["53"] = merchantid as AnyObject
        var ratingParam:[[String:AnyObject]]=[]
        
        myModel.addManager.getItemRating("010100020", userinfo: businessDict, completionResponse: { ( response,  error) in
            
            print(response)
            if let res = response as? [[String : AnyObject]]{
                ratingParam = res
                for item in ratingParam{
                    if var ratings = item["RESULT"] as? [[String:AnyObject]]{
                        for rati in ratings{
                            if let mRating = rati["_121_80"] as? String{
                                //self.merchantId = mRating
                            }
                            if let storeName = rati["_114_70"] as? String{
                                //self.storeName = storeName
                            }
                            if let ratingNums = rati["_122_19"] as? String{
                               // self.ratingNum = ratingNums
                            }
                            if let mRating = rati["_121_170"] as? String{
                                
                                self.imageUrlStr =  self.urlImage.appending(mRating as String)
                            }
                            if let desc = rati["_121_157"] as? String{
                                
                               // self.descText2 =  desc
                            }
                        }
                    }
                }
            }
            DispatchQueue.main.async {
                
                
               // self.itemRatingTblView.reloadData()
            }
            // self.itemRatingTblView.reloadData()
        })
    }
    @IBAction func moreDetails(_ sender: Any) {
        
        TestClassStore.storeMerchantId = merchantid
        TestClassStore.storeName = storeNameStr
         if let url = NSURL(string: imageUrlStr) {
        let  urlPath = url as URL!
            TestClassStore.storeNameImage = urlPath
       // cell.storeImgView.sd_setImage(with: TestClassStore.storeNameImage)
        
         }
        //TestClassStore.storeNameImage = imageUrlStr
        delegateStore?.changeBackgroundColor(storeNameStr, imageUrlStr) // my code
        self.navigationController?.popViewController(animated: true)  // my code

    }
    
    @IBAction func shareBtnTapped(_ sender: Any) {
    }
    var ratingNum:String = ""
    var pickerOptionValues:[[String:AnyObject]]=[]
    var pickerOptionValuesDict:[String:AnyObject]=[:]
    func getData(){
        for itemChoose in pickerArray{
            if let itemId = itemChoose["_122_111"] as? String{
                if let itemIdName = itemChoose["_122_134"] as? String{
                    print(optionIdDictArr2)
                    for itemIds in optionIdArrDict{
                        for (key,value) in itemIds{
                            if itemId == key{
                                
                                        
                                pickerOptionValuesDict[itemIdName]  = value as AnyObject
                               // pickerOptionValues.append(pickerOptionValuesDict)
                                if pickerOptionValues.contains(where: { $0.keys.contains(itemIdName) }) {
                                    print("it is in there")
                                }else{
                                    self.pickerOptionValues.append(pickerOptionValuesDict)
                                }
//                                if !pickerOptionValues.contains(where: { (pickerOptionValuesDict) -> Bool in
//                                    
//                                    return false
//                                }){
//                                     self.pickerOptionValues.append(pickerOptionValuesDict)
//                                }
                                pickerOptionValuesDict.removeAll()
                                print(pickerOptionValues)
                                
                            }
                        }
                    }
                }
                
            }
        }
    }
    func getStoredetails(){
        
        var ratingParam:[[String:AnyObject]] = []
        var ratingParams:[String:AnyObject]=[:]
        ratingParams["53"] =  merchantid as AnyObject
        myModel.addManager.getItemRating("010100020", userinfo: ratingParams, completionResponse: { ( response,  error) in
            
            print(response)
            if let res = response as? [[String : AnyObject]]{
                ratingParam = res
                for item in ratingParam{
                    if var ratings = item["RESULT"] as? [[String:AnyObject]]{
                        for rati in ratings{
                            if let mRating = rati["_121_80"] as? String{
                               // self.merchantId = mRating
                            }
                            if let storeName = rati["_114_70"] as? String{
                               // self.storeName = storeName
                            }
                            if let ratingNums = rati["_122_19"] as? String{
                                self.ratingNum = ratingNums
                            }
                            if let mRating = rati["_121_170"] as? String{
                                
                                self.imageUrlStr =  self.urlImage.appending(mRating as String)
                            }
                            if let desc = rati["_121_157"] as? String{
                                
                                //self.descText2 =  desc
                            }
                        }
                    }
                }
            }
            DispatchQueue.main.async {
                self.getShoppingChoice()
               // self.getData()
               // self.itemDetailtblview.reloadData()
            }
            // self.itemRatingTblView.reloadData()
        })
    }
    @IBAction func getFavBtnTapped(_ sender: Any) {
        var addfav:[String:AnyObject]=[:]
        addfav["53"] = loginUserId as AnyObject
        if let strt = productId.characters.count as? Int{
            if strt == 1{
                addfav["114.144"] = "0000000000"+productId as AnyObject
            }else{
                addfav["114.144"] = "000000000"+productId as AnyObject
            }
        }
        //addfav["114.144"] = "0000000000"+productId as AnyObject
        if !favStringArr.contains(productId){
            myModel.addManager.addFavoriteItem("030400218", userinfo: addfav, completionResponse: { ( response,  error) in
                print(response)
                
                if let res:[[String:AnyObject]]=response as? [[String:AnyObject]]{
                    for items in res{
                        if let pId = items["_114_144"] as? String{
                            self.favString = pId
                            self.favStringArr.append(pId)
                        }
                    }
                    
                }
                
                DispatchQueue.main.async {
                    self.itemDetailtblview.reloadData()
                }
                
            })
        }
    }
  override  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1001{
            totalRelateImgArrUrl = Array(Set(totalRelateImgArrUrl))
            return relatedItemArrayDict.count
        }
        if collectionView.tag == 1002{
            totalAlsoViewedImgArrUrl = Array(Set(totalAlsoViewedImgArrUrl))
           // return totalAlsoViewedImgArrUrl.count
             return alsoViewedArrDict.count
        }
        return 1
    }
   override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        if collectionView.tag == 1001{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "relatedCollectionCell", for: indexPath) as! relatedCollectionCell
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor.gray.cgColor
            cell.layer.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1).cgColor
            cell.layer.cornerRadius = 5.0
            print(relatedItemArrayDict)
            
            
            cell.viewOuter.layer.borderWidth = 1
            cell.viewOuter.layer.borderColor = UIColor(red: 220/256.0, green: 220/256.0, blue: 220/256.0, alpha: 1.0).cgColor
            cell.viewOuter.layer.cornerRadius = 8.0
            cell.viewOuter.clipsToBounds = true
            
            cell.viewOuter.layer.masksToBounds = false
            cell.viewOuter.layer.shadowColor = UIColor.lightGray.cgColor
            cell.viewOuter.layer.shadowOpacity = 0.3
            cell.viewOuter.layer.shadowOffset = CGSize(width: -1, height: 1)
            cell.viewOuter.layer.shadowRadius = 1
            
            cell.viewOuter.layer.shadowPath = UIBezierPath(rect: cell.bounds).cgPath
            cell.viewOuter.layer.shouldRasterize = true
            cell.viewOuter.layer.rasterizationScale = 1
          let relatedItem =   relatedItemArrayDict[indexPath.row]
            
            if let name = relatedItem["name"] as? [String]{
                
                // if name.count>indexPath.row{
               // let data = dataWithHexString(hex: name[0]) // <68656c6c 6f2c2077 6f726c64>
               // let string = String(data: data, encoding: .utf8)
                cell.nameLbl.text =  name[0]
                // }
                
            }
            if let image = relatedItem["image"] as? [URL]{
                
                //if image.count>indexPath.row{
                cell.relatedImageView.sd_setImage(with: image[0] as URL!)
                // }
                
            }
            if let price = relatedItem["price"] as? [String]{
                
                //  if price.count>indexPath.row{
                if let discountPrice = relatedItem["discount"] as? [String]{
                    var actualPrice =  price[0]
                     let disPrice = discountPrice[0]
                    let actualPriceInt:Double = Double(actualPrice)!
                    
                    let disPriceInt:Double = Double(disPrice)!
                    let HeightArrySumString = String(format: "%.2f", disPriceInt)
                    if disPrice == "0" || disPrice == "0.00" || actualPrice == disPrice{
                        cell.priceLbl.text = "$" + actualPrice
                    }else if actualPriceInt > disPriceInt{
                        actualPrice = "$" + actualPrice
                        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: actualPrice)
                        attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
                        cell.priceLbl.attributedText = attributeString
                        
                        cell.discountCell.text = "$" + HeightArrySumString
                    }
              
                }
                //}
                
            }
            
            
            
//            if totalRelateImgArrUrl.count>indexPath.row{
//                cell.relatedImageView.sd_setImage(with: totalRelateImgArrUrl[indexPath.row])
//                if relatedItemName.count>indexPath.row{
//                    cell.nameLbl.text = relatedItemName[indexPath.row]
//                }
//                if relatedItemPrice.count>indexPath.row{
//                    cell.priceLbl.text = "$" + relatedItemPrice[indexPath.row]
//                }
//            }else{
//                
//            }
            
            return cell
        }else{
           
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "alsoViewCollectionCell", for: indexPath) as! alsoViewCollectionCell
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor.gray.cgColor
            cell.layer.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1).cgColor
            cell.layer.cornerRadius = 5.0
            print(alsoViewedArrDict)
            
            cell.outerView.layer.borderWidth = 1
            cell.outerView.layer.borderColor = UIColor(red: 220/256.0, green: 220/256.0, blue: 220/256.0, alpha: 1.0).cgColor
            cell.outerView.layer.cornerRadius = 8.0
            cell.outerView.clipsToBounds = true
            
            cell.outerView.layer.masksToBounds = false
            cell.outerView.layer.shadowColor = UIColor.lightGray.cgColor
            cell.outerView.layer.shadowOpacity = 0.3
            cell.outerView.layer.shadowOffset = CGSize(width: -1, height: 1)
            cell.outerView.layer.shadowRadius = 1
            
            cell.outerView.layer.shadowPath = UIBezierPath(rect: cell.bounds).cgPath
            cell.outerView.layer.shouldRasterize = true
            cell.outerView.layer.rasterizationScale = 1
            
            let alsoViewDict = alsoViewedArrDict[indexPath.row]
            print(alsoViewDict)
            
            
            if let name = alsoViewDict["name"] as? [String]{
                
               // if name.count>indexPath.row{
                    let data = dataWithHexString(hex: name[0]) // <68656c6c 6f2c2077 6f726c64>
                     let string = String(data: data, encoding: .utf8)
                    cell.alsoViewitemNameLbl.text = string
               // }
                
            }
            if let image = alsoViewDict["image"] as? [URL]{
                
                //if image.count>indexPath.row{
                    cell.alsoViewItemsImgView.sd_setImage(with: image[0] as URL!)
               // }
                
            }
            if let price = alsoViewDict["price"] as? [String]{
                
              //  if price.count>indexPath.row{
                
                
                
                
                if let discountPrice = alsoViewDict["discount"] as? [String]{
                    var actualPrice =  price[0]
                    let disPrice = discountPrice[0]
                    let actualPriceInt:Double = Double(actualPrice)!
                    let disPriceInt:Double = Double(disPrice)!
                    let HeightArrySumString = String(format: "%.2f", disPriceInt)
                    if disPrice == "0" || disPrice == "0.00" || actualPrice == disPrice{
                        cell.alsoViewitemPriceLbl.text = "$" + actualPrice
                    }else if actualPriceInt > disPriceInt{
                        actualPrice = "$" + actualPrice
                        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: actualPrice)
                        attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
                        cell.alsoViewitemPriceLbl.attributedText =  attributeString
                        
                        cell.discountlbl.text = "$" + HeightArrySumString
                    }
                    
                }
                
                
                
               
                
            }
            
//            cell.alsoViewItemsImgView.sd_setImage(with: totalAlsoViewedImgArrUrl[indexPath.row])
//            if alsoViewedItemName.count>indexPath.row{
//                let hexStr = alsoViewedItemName[indexPath.row]
//                let data = dataWithHexString(hex: hexStr) // <68656c6c 6f2c2077 6f726c64>
//                let string = String(data: data, encoding: .utf8)
//                cell.alsoViewitemNameLbl.text = string
//              //  let string = String(data: data, encoding: .utf8)
//                if AlsoViewedItemPrice.count>indexPath.row{
//                cell.alsoViewitemPriceLbl.text = "$" + AlsoViewedItemPrice[indexPath.row]
//                }
//            }
            
            
            return cell
        }
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
    var selectedAlsoViewFlag:Bool=false
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        progressView.startAnimating()
        // setLoadingScreen()
        hiddenView.isHidden = false
        hiddenView.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
        itemDetailtblview.isUserInteractionEnabled = false
        productId = ""
        pickerOptionValues.removeAll()
        allPickingData.removeAll()
        imageDetailUrl.removeAll()
        itemImage.removeAll()
        selectedImageArrl.removeAll()
        relatedItemPrice.removeAll()
        AlsoViewedItemPrice.removeAll()
        let cell = collectionView.cellForItem(at: indexPath)
        if collectionView.tag==1001{
           // relatedItemArrayDict = Array(Set(relatedItemArrayDict))
            let data = relatedItemArrayDict[indexPath.row]
            
            if let pid = data["productId"] as? [String]{
                for item in pid{
                selectedRealetedItemFlag = true
                productId = item
                }
            }
            //let data =
        }else{
            
            let data = alsoViewedArrDict[indexPath.row]
            
            if let pid = data["productId"] as? [String]{
                for item in pid{
                    selectedRealetedItemFlag = true
                  //  selectedAlsoViewFlag = true
                    productId = item
                }
            }
        }
        
        getFav()
    }
    var qualityTxtData:String=""
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if let str = removeLbl.text as? String{
            qualityTxtData = str
        }
        if pickersView.tag == 1002{
            for (key,val) in dict1{
                if  removeLbl.text == key{
                    return val.count
                   
                }
            }

        
        }
        if pickersView.tag == 1001{

            for (key,val) in dict1{
                if  removeLbl.text == key{
                    return val.count
                    
                }
            }
            
        }
        
        return 1
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    var arrayPick:[String]=[]
     var arrayPick2:[String]=[]
    var arrayProductId1:[String]=[]
    var arrayProductId2:[String]=[]
     func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickersView.tag == 1002{
            

            
            for (key,val) in dict1{
                if  removeLbl.text == key{
                    if let dictItem = dict1[key] as? [[String:AnyObject]]{
                        for itemPicker in dictItem{
                            for (key,val) in itemPicker{
                                arrayProductId1.append(key)
                                arrayPick.append(val as! String)
//                                if let arrayPicker:[String] = val as? [String]{
//                                    return arrayPicker[row]
//                                }
                            }
                        }
                    }
                    
                }
            }
            return arrayPick[row]
           // return self.allPickingData[row]
        }
        if pickersView.tag == 1001{
            if dict1.count>0{
            for (key,val) in dict1{
                if  contentsLb.text == key{
                    if let dictItem = dict1[key] as? [[String:AnyObject]]{
                        for itemPicker in dictItem{
                            for (key,val) in itemPicker{
                                arrayProductId2.append(key)
                                arrayPick2.append(val as! String)
//                                if let arrayPicker:[String] = val as? [String]{
//                                    return arrayPicker[row]
//                                }
                            }
                        }
                    }
                    
                }
            }
            }else{
                self.arrayPick2.append("Default")
            }

            
            return arrayPick2[row]
            //return self.getChiceOption2[row]
        }
        
        
        return allPickingData[row]
    }
    
    var productId1:String = ""
     var productId2:String = ""
    
    
     func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickersView.tag == 1002{
            
            colorTxField.text = arrayPick[row]
            productId1 = arrayProductId1[row]

        }
        if pickersView.tag == 1001{
            qualityTextField.text  = arrayPick2[row]
            productId2 = arrayProductId2[row]
//            if dict1.count>0{
//                // if getChiceOption2.count>0{
//                for (key,val) in dict1{
//                    //for (key,val) in itemPicker{
//                    if  contentsLb.text == key{
//                        if let dictItem = dict1[key] as? [[String:AnyObject]]{
//                            for itemPicker in dictItem{
//                                for (key,val) in itemPicker{
//                        var arrayPick:[String]=[]
//                        arrayPick.append(val as! String)
//
//                        if let str = arrayPick[row] as? String{
//                            qualityTextField.text =  str
//                        }
//                        getPickervalues["deleivery method"] = arrayPick[row] as AnyObject
//                                }
//                            }
//                        }
//
//                    }
//                }
//
//            }
            
            
            
//            if getChiceOption2.count>0{
//                for itemPicker in pickerOptionValues{
//                    for (key,val) in itemPicker{
//                        if  contentsLb.text == key{
//                            var arrayPick:[String]=[]
//                           // arrayPick.append(val as! String)
//                            if let arrayPicker:[String] = val as? [String]{
//                                if let str = arrayPicker[row] as? String{
//                                    qualityTextField.text =  str
//                                }
//                                getPickervalues["deleivery method"] = arrayPicker[row] as AnyObject
//                                //return arrayPicker[row]
//                            }
//
//                        }
//                    }
//                }
//
//
//            }
        }
        
        
        itemDetailtblview.reloadData()
    }
    
    func donePicker(){
        self.view.endEditing(true)
    }
    func  textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        //checkOutTableView.setContentOffset(CGPoint(x:0, y:0), animated: true)
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
      //  pickersView.isHidden=false
      //  toolBar.isHidden=false
        if textField.tag == 201{
            
            pickersView.tag = 1001
        }else{
            pickersView.tag = 1002
        }
    }
     func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if collectionView.tag == 1001{
            if  totalRelateImgArrUrl.count<0{
                return CGSize(width:14, height:14)
            }else{
                
                    
                    return CGSize(width: collectionView.frame.size.height-50, height: collectionView.frame.size.height-20)
                    
              
                //return CGSize(width:104, height:104)
            }
        }else{
            if  totalAlsoViewedImgArrUrl.count<0{
                return CGSize(width:14, height:14)
            }else{
                  return CGSize(width: collectionView.frame.size.height-50, height: collectionView.frame.size.height-20)
               // return CGSize(width:104, height:104)
            }
        }
        return CGSize(width:14, height:14)
    }
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//
//        let view:UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.size.width, height: 10))
//        view.backgroundColor = UIColor(red: 220/256.0, green: 220/256.0, blue: 220/256.0, alpha: 1.0)
//
//        return view
//    }
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        if relatedItemArrayDict.count>0 || alsoViewedArrDict.count>0{
//        return 4.0
//        }else{
//            return 0
//        }
//    }
    func calculateHeight(inString:String) -> CGFloat
    {
        let messageString = inString
        let attributes : [String : Any] = [NSFontAttributeName : UIFont.systemFont(ofSize: 15.0)]
        
        let attributedString : NSAttributedString = NSAttributedString(string: messageString, attributes: attributes)
        
        let rect : CGRect = attributedString.boundingRect(with: CGSize(width: 222.0, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)
        
        let requredSize:CGRect = rect
        return requredSize.height
    }
    
    func textViewDidBeginEditing(_ textView: UITextView){
        animateViewMoving(up: true, moveValue: 100)
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.resignFirstResponder()
        animateViewMoving(up: false, moveValue: 100)
        
    }
    
    
    let maxCharacter = 400
    func animateViewMoving (up:Bool, moveValue :CGFloat){
        let movementDuration:TimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        
        UIView.beginAnimations("animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration)
        
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        // textView.resignFirstResponder()
        //  animateViewMoving(up: false, moveValue: 100)
        return textView.text.characters.count + (text.characters.count - range.length) <= maxCharacter
    }
    
    @IBAction func shareBtnClicked(_ sender: UIButton) {
        let textToShare = "Swift is awesome!  Check out this website about it!"
        
        if let myWebsite = NSURL(string: "http://www.codingexplorer.com/") {
            let objectsToShare = [textToShare, myWebsite] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            //New Excluded Activities Code
            activityVC.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList]
            //
            
            activityVC.popoverPresentationController?.sourceView = sender
            self.present(activityVC, animated: true, completion: nil)
        }
    }
    @IBAction func shareButtonClicked(sender: UIButton) {
        
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
//extension ItemDetailVC:UICollectionViewDelegate,UICollectionViewDataSource{
//    
//    
//}
