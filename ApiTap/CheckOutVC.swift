//
//  CheckOutVC.swift
//  ApiTap
//
//  Created by AppZorro on 14/09/17.
//  Copyright © 2017 ApiTap. All rights reserved.
//

import UIKit
import Foundation
//import MFSideMenu

class itemTblViewCell:UITableViewCell{
    @IBOutlet weak var selBtnImg: UIButton!
    
    @IBOutlet var option2PriceLbl: UILabel!
    @IBOutlet var optionPriceLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var qtyLbl: UILabel!
    @IBOutlet weak var option2Lbl: UILabel!
    @IBOutlet weak var opton1Lbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var ietmShoppingImage: UIImageView!
}
class itemReturnCell:UITableViewCell{
    @IBOutlet weak var itemRequestLbl: UILabel!
    
    @IBOutlet weak var returnImage: UIImageView!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var itemReturnLbl: UILabel!
    @IBOutlet weak var itemReturnView: UIView!
    @IBOutlet weak var transactionLbl: UILabel!
}
class itemCells:UITableViewCell{
    
    @IBOutlet weak var returnImages: UIImageView!
}
class itemreturnInfoCell:UITableViewCell{
    
    @IBOutlet weak var commentsTxtField: UITextField!
    @IBOutlet weak var returnItemreasonTxtField: UITextField!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var closeBtn: UIButton!
    
    
}
class checkOutCell:UITableViewCell{
    
    @IBOutlet var approvedLbl: UILabel!
    
    @IBOutlet var shoppingCartLbl: UILabel!
    
    @IBOutlet var authLbl: UILabel!
    @IBOutlet var statusLbl: UILabel!
    @IBOutlet weak var checkOutImage: UIImageView!
    @IBOutlet weak var invoiceValLbl: UILabel!
    @IBOutlet weak var dateValLbl: UILabel!
    @IBOutlet weak var approvalValLbl: UILabel!
    @IBOutlet weak var timeHoursLbl: UILabel!
    @IBOutlet weak var transactionValLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var transactionLbl: UILabel!
    @IBOutlet weak var approvalLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var invoiceLbl: UILabel!
}
class itemCell:UITableViewCell{
    @IBOutlet weak var quanityLbl: UILabel!
    
    @IBOutlet weak var option2Lbl: UILabel!
    @IBOutlet weak var option1Lbl: UILabel!
    @IBOutlet weak var itemTblview: UITableView!
    @IBOutlet weak var selectBtn: UIButton!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var titleLbel: UILabel!
    @IBOutlet weak var shoppingImageView: UIImageView!
}
class  orderCell:UITableViewCell{
    @IBOutlet var shippingaddressTxtField: UITextField!
    
    @IBOutlet var getPriceLbl: UILabel!
    @IBOutlet weak var totlPriceLbl: UILabel!
    @IBOutlet weak var addTaxLbl: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var instructiontxtField: UITextField!
    @IBOutlet weak var paymntTxtField: UITextField!
    @IBOutlet weak var deleiveryTxtField: UITextField!
    @IBOutlet weak var instructionLbl: UILabel!
    @IBOutlet weak var paymntLbl: UILabel!
    @IBOutlet weak var deleiveryLbl: UILabel!
    @IBOutlet weak var shippingAddresLbl: UILabel!
    @IBOutlet weak var addRatingBtn: UIButton!
    @IBOutlet weak var reorderBtn: UIButton!
    @IBOutlet weak var returnBtn: UIButton!
}
class CheckOutVC: BaseViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate, YPSignatureDelegate ,UITextViewDelegate{
    @IBOutlet var returntxtField: IQDropDownTextField!
    var didSelectCheckOut: ((Int,Bool) -> ())?
    @IBOutlet weak var tipFieldView: UIView!
    @IBOutlet var addTipView: UIView!
    @IBOutlet var returnreasonTxtField: IQDropDownTextField!
    @IBOutlet weak var returnReasonTxtField: UITextField!
    @IBOutlet var returnView: UIView!
    let qualityTextField = UITextField()
    var checkOutArrDict:[[String:AnyObject]]=[]
    var checkOutDict:[String:[AnyObject]]=[:]
    var invoiceDict:[String:AnyObject]=[:]
    var pickersView = UIPickerView()
    @IBOutlet weak var hiddenView: UIView!
    var urlImage:String = "http://209.46.35.217:8085/ServerImage/images/"
    @IBOutlet var signaturesView: UIView!
    @IBOutlet var shoppingCartView: UIView!
    @IBOutlet weak var returnTableview: UITableView!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @IBOutlet weak var signatureView: UIView!
    @IBOutlet weak var checkOutTableView: UITableView!
    var shoppingAddressId:[String:AnyObject]=[:]
    var checkOutFlag:Bool = false
    var dictparam:[String:AnyObject]=[:]
    var shoppingCartDictparam:[String:AnyObject]=[:]
    var myModel = ModelManager()
    let hiddensView = UIView()
    let hiddensSignatureView = UIView()
    let contentView = UIView()
    let messageFrame = UIView()
    let deviderLineView = UIView()
    let keyContentLabel = UILabel()
    let contentsLb = UILabel()
    let removeLbl = UILabel()
    let saveLbl = UILabel()
    var shoppingImageArr:[String] = ["bag","girlsshot"]
    let removeCompletChckBtn = UIButton()
    let saveLblBtn = UIButton()
    var loginUserId:String = ""
    var getShoppingCart:[[String:AnyObject]]=[]
    var shoppingCart:[[String:AnyObject]] = []
    var getPickervalue:[String:AnyObject]=[:]
    var getItemInvoiceDict:[[String:AnyObject]]=[]
    var invoiceImageArrUrl:[String]=[]
    var invoiceImageArrl:[String]=[]
    var invoiceNameArray:[String]=[]
    var invoicePricearr:[String]=[]
    var invoiceQtyArra:[String]=[]
    var imgUrl:String = ""
    var option1Arr:[String]=[]
    var option2Arr:[String]=[]
    //var paymentJson:[[String:AnyObject]]=[]
    @IBOutlet weak var progressView: UIActivityIndicatorView!
    var selectedIndex = -1
    var fillArray:Bool=false
    var toolBar = UIToolbar()
    var chckImgUrl:URL!
    var returnReasonArr:[String]=["Bought by mistake","Better Price Avaialable","Product  damaged,but shipping box OK","Items arrive too late","Missing Parts or accessories","Product and shipping box both damaged","Wrong item was Sent","Items Defective or doesn't work","Receive extra item i didn't buy (no refund needed)","no longer needed","Didn't approve purchase","inaccurate website description"]
    
    @IBOutlet var storeDetailBtn: UIButton!
    @IBOutlet var storeNameLbl: UILabel!
    @IBOutlet var storeImgView: UIImageView!
    @IBOutlet var submitBtnOutlet: UIButton!
     let pickerView3 = UIPickerView()
    @IBOutlet var sentMsgBtn: UIButton!
    var storeName:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        
        self.initializeNavBar()
         self.setbarButtonItems()
        storeNameLbl.layer.cornerRadius = 5.0
        
        storeNameLbl.layer.borderWidth = 1.0
        storeNameLbl.layer.borderColor = UIColor.blue.cgColor
        
        storeDetailBtn.layer.cornerRadius = 5.0
        
        storeDetailBtn.layer.borderWidth = 1.0
        storeDetailBtn.layer.borderColor = UIColor.blue.cgColor
        
        submitBtnOutlet.layer.borderColor = UIColor.blue.cgColor
        submitBtnOutlet.layer.borderWidth = 1.0
        submitBtnOutlet.layer.cornerRadius = 5.0
        
        sentMsgBtn.layer.borderColor = UIColor.blue.cgColor
        sentMsgBtn.layer.borderWidth = 1.0
        sentMsgBtn.layer.cornerRadius = 5.0
        tipFieldView.layer.borderWidth=1
        addTipView.layer.borderColor = UIColor.lightGray.cgColor
        tipFieldView.layer.borderColor = UIColor.lightGray.cgColor
    //   returnView.isHidden=true
        print(shoppingAddressId)
          if let storeNam = shoppingAddressId["_114_70"] as? String {
            storeName = storeNam
            storeNameLbl.text = storeName
        }
        if let img = shoppingAddressId["_121_170"] as? String {
         let url =  self.urlImage.appending(img)
        if let url = NSURL(string: url) {
            self.chckImgUrl = url as URL!
            }
            
        }
        countryPickerVal()
        countryPickerVal2()
//        pickersView.frame = CGRect(x:0, y:200, width:view.frame.width, height:200)
//       // pickersView = UIPickerView(frame: CGRect(x:0, y:200, width:view.frame.width, height:200))
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
        
//        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: "donePicker")
//        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
//        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: Selector("donePicker"))
//
//        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
//        toolBar.isUserInteractionEnabled = true
        
//        pickersView.delegate=self
        progressView.isHidden=false
        progressView.startAnimating()
        // setLoadingScreen()
        hiddenView.isHidden = false
        hiddenView.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
        checkOutTableView.isUserInteractionEnabled = false
        
        returnTableview.isHidden = true
        signatureView.isHidden=true
        effect = visualEffectView.effect
        visualEffectView.effect = nil
        shoppingCartView.isHidden = true
        signatureView.layer.cornerRadius =  5
       
        
        // Add yellowView to self's main view
     //   getData()
        
       // getPaymentJsonArray()
        let btnCancel = UIButton(frame: CGRect(x:returnTableview.frame.size.width-20, y:5,width: 22.0,height: 22.0))
        //btnCancel.backgroundColor = UIColor.red
        btnCancel.setImage(UIImage(named:"cancel"), for: .normal)
        // btnCancel.layer.mask = returnTableview.layer  // Set btnCancel.layer.mask to yellowView.layer
        self.returnTableview.addSubview(btnCancel)
        
        // Do any additional setup after loading the view.
    }
    let pickerView2 = UIPickerView()
    override func viewDidAppear(_ animated: Bool) {
        self.getData()
    }
    func countryPickerVal(){
        pickerView2.delegate = self
        
        qualityTextField.inputView = pickerView2
        
        let toolBar = UIToolbar(frame: CGRect(x:0, y:self.view.frame.size.height/6, width:self.view.frame.size.width, height:40.0))
        
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        
        toolBar.barStyle = UIBarStyle.blackTranslucent
        
        toolBar.tintColor = UIColor.white
        
        toolBar.backgroundColor = UIColor.black
        
        let defaultButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(CheckOutVC.tappedToolBarBtn3))
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(CheckOutVC.donePressed3))
        
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
    func countryPickerVal2(){
        pickerView3.delegate = self
        
        colorTxField.inputView = pickerView3
        
        let toolBar = UIToolbar(frame: CGRect(x:0, y:self.view.frame.size.height/6, width:self.view.frame.size.width, height:40.0))
        
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        
        toolBar.barStyle = UIBarStyle.blackTranslucent
        
        toolBar.tintColor = UIColor.white
        
        toolBar.backgroundColor = UIColor.black
        
        let defaultButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ItemDetailVC.tappedToolBarBtn))
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(CheckOutVC.donePressed))
        
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
    @objc func donePressed3(sender: UIBarButtonItem) {
        qualityTextField.resignFirstResponder()
    }
    @objc func tappedToolBarBtn3(sender: UIBarButtonItem) {
        qualityTextField.resignFirstResponder()
    }
    @objc func donePressed(sender: UIBarButtonItem) {
        colorTxField.resignFirstResponder()
    }
    @objc func tappedToolBarBtn(sender: UIBarButtonItem) {
        colorTxField.resignFirstResponder()
    }
    @objc func donePressed2(sender: UIBarButtonItem) {
        pickersView.isHidden=true
        pickerView2.isHidden = true
        toolBar.isHidden = true
        checkOutTableView.reloadData()
        qualityTextField.resignFirstResponder()
    }
    @objc func tappedToolBarBtn2(sender: UIBarButtonItem) {
         pickersView.isHidden=true
        pickerView2.isHidden = true
        toolBar.isHidden = true
        qualityTextField.resignFirstResponder()
    }
    @IBAction func addTipBtnClicked(_ sender: Any) {
        hiddenView.isHidden = true
        addTipView.isHidden=true
    }
    
    @IBAction func canceTipBtnClikced(_ sender: Any) {
        hiddenView.isHidden = true
        addTipView.isHidden=true
    }
    var invoiceItemDict:[String:[AnyObject]]=[:]
    var invoiceItemArrDict:[[String:AnyObject]]=[]
    func getData(){
        
        if checkOutFlag == false{
            //            hiddenView.isHidden = false
            //            hiddenView.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
            //            checkOutTableView.isUserInteractionEnabled = false
            if let  invoiceId = invoiceDict["invoiceId"] as? String{
                
                        if let strt = invoiceId.characters.count as? Int{
                            if strt == 1{
                                dictparam["121.75"] = "0000000000"+invoiceId as AnyObject
                            }else if strt == 2{
                                dictparam["121.75"] = "000000000"+invoiceId as AnyObject
                            }else{
                                dictparam["121.75"] = "00000000"+invoiceId as AnyObject
                            }
                        }
                
                
                
                
            }
               // dictparam["121.75"] = "000000000" + invoiceId as AnyObject
                myModel.addManager.getItemInvoiceDict("010100114", userinfo: dictparam, completionResponse: { ( response,  error) in
                    print(response)
                    if let res   = response as? [[String : AnyObject]]{
                        self.getItemInvoiceDict = res
                        for res in self.getItemInvoiceDict{
                            if let result = res["RESULT"] as? [[String:AnyObject]]{
                                for id in result{
                                    
                                     if let res = id["CH"] as? [[String:AnyObject]]{
                                        for item in res{
                                             if let name  = item["_122_135"] as? String{
                                                 self.option1Arr.append(name)
                                            }
                                            if let name  = item["_120_84"] as? String{
                                                self.option2Arr.append(name)
                                            }
                                        }
                                    }
                                    if let res = id["IM"] as? [[String:AnyObject]]{
                                        if let name  = id["_120_83"] as? String{
                                            if self.invoiceItemDict["name"] == nil{
                                                self.invoiceItemDict["name"] = [name as AnyObject]
                                            }else{
                                                self.invoiceItemDict["name"]?.append(name as AnyObject)
                                            }
                                            //self.invoiceNameArray.append(name)
                                        }
                                        if let quantity  = id["_122_148"] as? String{
                                            if self.invoiceItemDict["qty"] == nil{
                                                self.invoiceItemDict["qty"] = [quantity as AnyObject]
                                            }else{
                                                self.invoiceItemDict["qty"]?.append(quantity as AnyObject)
                                            }
                                           // self.invoiceQtyArra.append(quantity)
                                        }
                                        if let price  = id["_114_98"] as? String{
                                            if self.invoiceItemDict["price"] == nil{
                                                self.invoiceItemDict["price"] = [price as AnyObject]
                                            }else{
                                                self.invoiceItemDict["price"]?.append(price as AnyObject)
                                            }
                                           // self.invoicePricearr.append(price)
                                        }
                                        for resItem in res{
                                            if let image  = resItem["_47_42"] as? String{
                                                let url =  self.urlImage.appending(image as String)
                                                if let urls = NSURL(string: url) {
                                                if self.invoiceItemDict["url"] == nil{
                                                    self.invoiceItemDict["url"] = [urls as AnyObject]
                                                }else{
                                                    self.invoiceItemDict["url"]?.append(urls as AnyObject)
                                                }
                                                }
                                                //self.invoiceImageArrUrl.append(image)
                                            }
                                            
                                        }
                                    }
                                    self.invoiceItemArrDict.append(self.invoiceItemDict as [String : AnyObject])
                                    self.invoiceItemDict.removeAll()
                                }
                                
                            }
                        }
                        
                    }
                    
//                    for itemImages in self.invoiceImageArrUrl{
//                        if let urlStr:String = itemImages as? String{
//                            
//                            let url =  self.urlImage.appending(urlStr as String)
//                            self.invoiceImageArrl.append(url)
//                        }
//                        
//                    }
//                    for i in 0..<self.invoiceImageArrl.count{
//                        if let url = NSURL(string: self.invoiceImageArrl[i]) {
//                            self.imageInvoiceUrl.append(url as URL)
//                            
//                            
//                        }
//                    }
                    DispatchQueue.main.async {
                       
                        self.progressView.stopAnimating()
                       // self.progressView.isHidden=true
                        // setLoadingScreen()
                        self.hiddenView.isHidden = true
                        // self.hiddenView.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
                        self.checkOutTableView.isUserInteractionEnabled = true
                        self.checkOutTableView.reloadData()
                    }
                    
                    
                })
            
        }
        else{
            self.getShoppingCartItem()
            
            
        }
    }
    
    var getAddressArray:[[String:AnyObject]]=[]
       var addressId:String = ""
    var houseno:String = ""
    var sector:String=""
    var cityName:String=""
    var houseNum:[String]=[]
    var sectorId:[String]=[]
    var cityNames:[String]=[]
    var paymentString:String=""
    var paymentArray:[String]=[]
    
    var getPaymentJson:[String:AnyObject]=[:]
    
    
    func getPayementmethod(){
        if let result = UserDefaults.standard.value(forKey: "loginUserID") as? String{
            loginUserId = result as! String
            print(result)
        }
        dictparam["53"] = loginUserId as AnyObject
        //getCard
        myModel.addManager.getPayment("010100017", userinfo: dictparam, completionResponse: { ( response,  error) in
            
            print(response)
            if let res =  response as? [[String : AnyObject]]{
            self.getAddressArray = res
            for item in self.getAddressArray{
                if let add = item["RESULT"] as? [[String:AnyObject]]{
                    for itemAddress in add{
                        if let addressId = itemAddress["_120_7"] as? String{
                            self.paymentString = addressId
                            if self.paymentString == "61"{
                                self.paymentString = "VISA"
                            }
                            self.paymentArray.append(self.paymentString)
                        }
                        if let KT = itemAddress["_48_15"] as? String{
                            self.getPaymentJson["48.15"] = KT as AnyObject
                            
                        }
                    }
                }
                
            }
            }
            DispatchQueue.main.async {
               // self.getItemDetailData()

                self.fillArray = true
                
                self.progressView.isHidden=true
                self.progressView.stopAnimating()
                // setLoadingScreen()
                self.hiddenView.isHidden = true
                // self.hiddenView.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
                self.checkOutTableView.isUserInteractionEnabled = true
                self.checkOutTableView.reloadData()
            }
           
        })
    }
    var getItemsPick:[String:AnyObject]=[:]
    var pickerItemArr:[[String:AnyObject]]=[]
    var dict1:[String:AnyObject]=[:]
     var pickerArrayVal:[[String:AnyObject]]=[]
    func getPickerData(){
        var dict:[String:AnyObject]=[:]
        if let result = UserDefaults.standard.value(forKey: "loginUserID") as? String{
            loginUserId = result as! String
            print(result)
        }
        dict["53"] = loginUserId as AnyObject
        
        let id = self.productIdArray[selectedIndex]

        if let strt = id.characters.count as? Int{
            if strt == 1{
                dict["114.144"] = "0000000000" + id as AnyObject
            }else if strt == 2{
                dict["114.144"] = "000000000" + id as AnyObject
            }else{
                dict["114.144"] = "00000000" + id as AnyObject
            }

        }
        var mainKey:String = ""
        myModel.addManager.getItemDetails("010100008", userinfo:  dict, completionResponse: { ( response,  error) in
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
                   
                    
                
                
            }
            }
            self.addCart()
            //self.getRelatedItem()
            //self.itemDetailtblview.reloadData()
        })
    }
    func getShippingAddress(){
        if let result = UserDefaults.standard.value(forKey: "loginUserID") as? String{
            loginUserId = result as! String
            print(result)
        }
        dictparam["53"] = loginUserId as AnyObject
        //getCard
        myModel.addManager.getShipping("010100055", userinfo: dictparam, completionResponse: { ( response,  error) in
                           print(response)
            if let res =  response as? [[String : AnyObject]]{
                self.getAddressArray = res
                for item in self.getAddressArray{
                    if let add = item["RESULT"] as? [[String:AnyObject]]{
                        for itemAddress in add{
                            if let addressId = itemAddress["AD"] as? [[String:AnyObject]]{
                                for id in addressId{
                                    if let houseno = id["_114_53"] as? String{
                                        
                                        self.houseno = houseno
                                        if let sector = id["_114_12"] as? String{
                                            self.sector =  sector
                                            
                                            //self.sectorId.append(self.sector)
                                        }
                                        if let cityName = id["_114_13"] as? String{
                                            self.cityName = self.houseno + self.sector + cityName
                                            self.cityNames.append(self.cityName)
                                            self.fillArray = true
                                        }
                                       
                                    }
                                    
                                    

                                    
                                }
                            }
                        }
                    }
                    
                }
            }else{
                self.cityNames.append("No City Found")
            }
            DispatchQueue.main.async {
                self.getDeleivery()
            }
            
            })
        
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    var totalShopping:[[String:AnyObject]]=[]
     var addShoppingCart:[[String:AnyObject]]=[]
    var logoImageArray:[String]=[]
    var titleArray:[String]=[]
    var quantityArray:[String]=[]
    var priceArray:[String]=[]
    var imageUrl:[String]=[]
    
    var deleiveryArr:[String]=[]
    func getDeleivery(){
        
        if let id = shoppingAddressId["_114_179"] as? String{
            shoppingCartDictparam["53"] = id as AnyObject
        }
        //getCard
        myModel.addManager.getDeleiveryMethod("010100015", userinfo: shoppingCartDictparam, completionResponse: { ( response,  error) in
            print(response)
            if let res =  response as? [[String : AnyObject]]{
                self.getAddressArray = res
                for item in self.getAddressArray{
                    if let add = item["RESULT"] as? [[String:AnyObject]]{
                        for itemAddress in add{
                            if var delivery = itemAddress["_122_133"] as? String{
                                if var deliveryAdd = itemAddress["_122_39"] as? String{
                                    delivery = delivery + deliveryAdd
                                self.deleiveryArr.append(delivery)
                                }
                            }
                           
                            
                                    
                            
                        }
                    }
                    
                }
            }
            self.getPayementmethod()
            DispatchQueue.main.async {
                //self.getShippingAddress()
                
                
                self.checkOutTableView.reloadData()
            }
        })
    }
    var checkOutUrl:[URL]=[]
    var productIdArr:[String]=[]
     var productIdArray:[String]=[]
    var shoppingDict:[String:[AnyObject]]=[:]
    var shoppingArrayDict:[[String:AnyObject]]=[]
   func  getShoppingCartItem(){
    
   shoppingDict.removeAll()
    shoppingArrayDict.removeAll()
    var dict2:[String:AnyObject]=[:]
                if let id = shoppingAddressId["_122_31"] as? String{
                    shoppingCartDictparam["122.31"] = id as AnyObject
                    dict2["122.31"] = id as AnyObject
                }
    var dict:[String:AnyObject]=[:]
    dict["114.143"] = shoppingAddressId["_114_143"] as! String as AnyObject
    dict["operator"] = "eq" as AnyObject
           
            myModel.addManager.getShoppingCartsItem("010100201", userinfo: dict2, userinfo2: dict, completionResponse: { ( response,  error) in
                print(response)
                if let res = response as? [[String : AnyObject]]{
                self.addShoppingCart = res
                for item in self.addShoppingCart{
                    if let result = item["RESULT"] as? [[String:AnyObject]]{
                        
                        for reslutItem in result{
                            if let array  = reslutItem["_121_30"] as? String{
                                self.productIdArr.append(array)
                            }
                            if let array  = reslutItem["CH"] as? [[String:AnyObject]]{
                                print(array)
                                for item in array{
                                    if let idItem = item["_127_16"] as? String{
                                        self.option1Arr.append(idItem)
//                                        if self.shoppingDict["_127_16"] == nil{
//                                            self.shoppingDict["_127_16"] = [idItem  as AnyObject]
//
//                                        }else{
//                                            self.shoppingDict["_127_16"]?.append(idItem as AnyObject)
//
//                                        }
                                    }
                                    if let idItem = item["_120_84"] as? String{
                                         self.option2Arr.append(idItem)
                                    }
                                    
                                }
                            }
                            if let logoImage = reslutItem["_121_170"] as? String{
                                let url =  self.urlImage.appending(logoImage as String)
                                if let urls = NSURL(string: url) {
                                if self.shoppingDict["image"] == nil{
                                    self.shoppingDict["image"] = [urls  as AnyObject]
                                    
                                }else{
                                    self.shoppingDict["image"]?.append(urls as AnyObject)
                                    
                                }
                                }
                               // self.logoImageArray.append(logoImage)
                            }
                           // if let productId = reslutItem["_121_30"] as? String{
                                if let productId = reslutItem["_114_144"] as? String{
                                self.productIdArray.append(productId)
                                if self.shoppingDict["productid"] == nil{
                                    self.shoppingDict["productid"] = [productId  as AnyObject]
                                    
                                }else{
                                    self.shoppingDict["productid"]?.append(productId as AnyObject)
                                    
                                }
                                //self.productIdArr.append(productId)
                            }
                            if let name = reslutItem["_123_41"] as? String{
                                if self.shoppingDict["title"] == nil{
                                    self.shoppingDict["title"] = [name  as AnyObject]
                                    
                                }else{
                                    self.shoppingDict["title"]?.append(name as AnyObject)
                                    
                                }
                              //  self.titleArray.append(name)
                            }
                            if let price = reslutItem["_114_112"] as? String{
                                if self.shoppingDict["price"] == nil{
                                    self.shoppingDict["price"] = [price  as AnyObject]
                                    
                                }else{
                                    self.shoppingDict["price"]?.append(price as AnyObject)
                                    
                                }
                                self.priceArray.append(price)
                            }
                            if let quantity = reslutItem["_114_132"] as? String{
                                if self.shoppingDict["qty"] == nil{
                                    self.shoppingDict["qty"] = [quantity  as AnyObject]
                                    
                                }else{
                                    self.shoppingDict["qty"]?.append(quantity as AnyObject)
                                    
                                }
                               
                            }
                            self.shoppingArrayDict.append(self.shoppingDict as [String : AnyObject])
                            self.shoppingDict.removeAll()
                            print(self.shoppingArrayDict)
                        }

                }
                    }
            }
                
                DispatchQueue.main.async {
                    self.getShippingAddress()
                    
                   // self.getPayementmethod()
                    self.checkOutTableView.reloadData()
                }
                
            })
        
    
    }
    var imageInvoiceUrl:[URL]=[]
    
    
    @IBAction func selectEditBtnItem(_ sender: UIButton) {
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 2001{
            if checkOutFlag == false{
            if imageInvoiceUrl.count>0{
                invoiceImageArrl = Array(Set(invoiceImageArrl))
               return invoiceItemArrDict.count
               // return 1
            }

            }else{
                
                return shoppingArrayDict.count
            }
        }
        
        if tableView == checkOutTableView{
            if checkOutFlag == false{
                if section == 0{
                    return 1
                }
                if section == 1{
                   return 1
                }
                if section == 2{
                    return 1
                }
            }else{
            if section == 0{
                return 1
            }
            if section == 1{
                return 1
            }
            if section == 2{
                return 1
            }
            }
        }
    else{
            if section == 0{
                return 1
            }
            if section == 1{
                if shoppingImageArr.count>0{
                   // return 1
                 return shoppingImageArr.count
                }else{
                    return 1
                }
            }
            if section == 2{
                return 1
            }
    
        
    }
        return 1
    }
    var isSelect:Bool = false
    var allPrice:Int = 0
    var price:Int = 10
    var count:Int = 0
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView.tag == 2001{
            //allPrice = 0
            let cell = tableView.dequeueReusableCell(withIdentifier: "itemTblViewCell") as! itemTblViewCell
            cell.selBtnImg.tag = indexPath.row+101
             if option1Arr.count>0{
                cell.optionPriceLbl.text =  "$" + option2Arr[0]
            cell.opton1Lbl.text = option1Arr[0]
            }
            if option2Arr.count>1{
                cell.option2PriceLbl.text = "$" + option2Arr[1]
            cell.option2Lbl.text = option1Arr[1]
            }
            //cell.priceLbl.text = option2Arr[0]
            if checkOutFlag == false{
                
                
                if invoiceItemArrDict.count>indexPath.row{
                    let item = invoiceItemArrDict[indexPath.row]
                    if let itemTile = item["qty"] as? [String]{
                        
                        cell.qtyLbl.text = itemTile[0]
                    }else{
                        if let itemTile = item["qty"] as? String{
                            cell.qtyLbl.text = itemTile
                        }
                    }
                    if let itemTile = item["url"] as? [URL]{
                        
                        cell.ietmShoppingImage.sd_setImage(with:itemTile[0] )
                    }
                    
                    if let itemTile = item["price"] as? [String]{
                        if itemTile.count>0{
                        cell.priceLbl.text = "$" + itemTile[0] + ".00"
                            if let str = itemTile[0] as? String{
                            
                                allPrice =  allPrice+Int(str)!
                            }
                        }
                    }
                    if let itemTile = item["name"] as? [String]{
                        
                        cell.titleLbl.text = itemTile[0]
                    }
                    
                }
//                imageInvoiceUrl = Array(Set(imageInvoiceUrl))
//               // cell.selBtnImg.addTarget(self, action: Selector("data:"), for: .touchUpInside)
//                invoiceItemDict
//                if imageInvoiceUrl.count>indexPath.row{
//                    cell.ietmShoppingImage.sd_setImage(with: imageInvoiceUrl[indexPath.row])
//                }else{
//                    cell.titleLbl.text = "No data found"
//                }
//                
//                if invoiceNameArray.count>indexPath.row{
//                    cell.titleLbl.text = invoiceNameArray[indexPath.row]
//                    cell.qtyLbl.text = invoiceQtyArra[indexPath.row]
//                    cell.priceLbl.text = invoicePricearr[indexPath.row]
//                }else{
//                    cell.titleLbl.text = "N/D"
//                    cell.qtyLbl.text = "N/D"
//                    cell.priceLbl.text = "N/D"
//                }
                
            }else{
                if shoppingArrayDict.count>indexPath.row{
            let item = shoppingArrayDict[indexPath.row]
                    if let itemTile = item["qty"] as? [String]{
                      
                        cell.qtyLbl.text = itemTile[0]
                    }else{
                        if let itemTile = item["qty"] as? String{
                             cell.qtyLbl.text = itemTile
                    }
                    }
                    if let itemTile = item["image"] as? [URL]{
                        
                        cell.ietmShoppingImage.sd_setImage(with:itemTile[0] )
                    }
                    
                    if let itemTile = item["price"] as? [String]{
                        
                       cell.priceLbl.text = "$" + itemTile[0] + ".00"
                        if count <= shoppingArrayDict.count-1{
                        allPrice =  allPrice+Int(itemTile[0])!
                        count += 1
                        }
                          //allPrice =  allPrice+Int(itemTile[0])!
                    }
                    if let itemTile = item["title"] as? [String]{
                        
                         cell.titleLbl.text = itemTile[0]
                    }
                  
                }
                
                
            }
            if (selectedIndex == indexPath.row) {
                
                cell.selBtnImg.isSelected = true
                //cell.violenceBtnSelect.setImage(UIImage(named: "radio-selected"),for:UIControlState.normal)
            } else {
                cell.selBtnImg.isSelected = false
                //cell.violenceBtnSelect.setImage(UIImage(named: "radio-unselected"),for:UIControlState.normal)
            }
            
            if(cell.selBtnImg.isSelected){
                cell.selBtnImg.setImage(UIImage(named: "radio-selected"),for:UIControlState.normal)
                isSelect=true
            }
            else{
                cell.selBtnImg.setImage(UIImage(named: "unselected"),for:UIControlState.normal)
            }
            
            return cell

        }
        if tableView == checkOutTableView{
            if indexPath.section == 0{
                let cell = checkOutTableView.dequeueReusableCell(withIdentifier: "checkOutCell") as! checkOutCell
                
                cell.selectionStyle = .none
                cell.checkOutImage.sd_setImage(with: self.chckImgUrl)
                storeImgView.sd_setImage(with: self.chckImgUrl)
                  if let storeNam = shoppingAddressId["_122_31"] as? String {
                    cell.shoppingCartLbl.text = "Shopping Cart No.: " + storeNam
                    cell.authLbl.text = "Auth: Approved"
                    cell.approvedLbl.text = "Approval No.:N/A"
                }
                 if let storeNam = shoppingAddressId["_114_138"] as? String {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-mm-dd HH:mm:ss"
                    
                    
                    
//                     let dateFormatterPrint = DateFormatter()
//                     dateFormatterPrint.dateFormat = "MMM dd,yyyy"
                                                let result = formatter.date(from: storeNam)
                                                let formatter2 = DateFormatter()
                                                formatter2.dateFormat = "MMM dd,yyyy"
                                                let dateStr = formatter2.string(from: result!)
                    cell.dateLbl.text = dateStr
                }
                if let storeNam = shoppingAddressId["_114_138"] as? String {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-mm-dd HH:mm:ss"
                    
                    
                    
                    //                     let dateFormatterPrint = DateFormatter()
                    //                     dateFormatterPrint.dateFormat = "MMM dd,yyyy"
                    let result = formatter.date(from: storeNam)
                    let formatter2 = DateFormatter()
                    formatter2.dateFormat = "hh:mm"
                    let dateStr = formatter2.string(from: result!)
                    cell.timeLbl.text = dateStr
                    cell.statusLbl.text = "Status:Checkout"
                }
                if checkOutFlag == true{
                   // cell.approvalLbl.isHidden=true
                   // cell.dateLbl.isHidden = true
                   // cell.invoiceLbl.text="Checkout"
                   // cell.invoiceLbl.isHidden = true
                 //   cell.timeHoursLbl.isHidden = true
                   // cell.timeLbl.isHidden = true
                   // cell.transactionLbl.isHidden = true
                   // cell.transactionValLbl.isHidden = true
                  //  cell.invoiceValLbl.isHidden = true
                   // cell.dateValLbl.isHidden = true
                    //cell.approvalValLbl.isHidden = true
                    
                }else{
                    
//                    cell.approvalLbl.isHidden=false
//                    cell.dateLbl.isHidden = false
//                    cell.invoiceLbl.isHidden = false
//                    cell.timeHoursLbl.isHidden = false
//                    cell.timeLbl.isHidden = false
//                    cell.transactionLbl.isHidden = false
//                    cell.transactionValLbl.isHidden = false
//                    cell.invoiceValLbl.isHidden = false
//                    cell.dateValLbl.isHidden = false
//                    cell.approvalValLbl.isHidden = false
                    if    let date = invoiceDict["store_name"] as? String{
                        storeNameLbl.text = date
                    }
                     if let date = invoiceDict["invoice_num"] as? String{
                        cell.shoppingCartLbl.text = "Invoice no: " + date
                        cell.authLbl.text = "Auth: Approved"
                        cell.approvedLbl.text = "Approval No.:"
                    }
                    if let date = invoiceDict["date"] as? String{
                    var myStringArr = date.components(separatedBy: " ")
                        let formatter = DateFormatter()
                        formatter.dateFormat = "yyyy-mm-dd HH:mm:ss"
                        
                        
                        
                        //                     let dateFormatterPrint = DateFormatter()
                        //                     dateFormatterPrint.dateFormat = "MMM dd,yyyy"
                        let result = formatter.date(from: date)
                        let formatter2 = DateFormatter()
                        formatter2.dateFormat = "MMM dd,yyyy"
                        let dateStr = formatter2.string(from: result!)
                        cell.dateLbl.text = dateStr
                    }
                    if let date = invoiceDict["date"] as? String{
                        var myStringArr = date.components(separatedBy: " ")
                        let formatter = DateFormatter()
                        formatter.dateFormat = "yyyy-mm-dd HH:mm:ss"
                        
                        
                        
                        //                     let dateFormatterPrint = DateFormatter()
                        //                     dateFormatterPrint.dateFormat = "MMM dd,yyyy"
                        let result = formatter.date(from: date)
                        let formatter2 = DateFormatter()
                        formatter2.dateFormat = "hh:mm"
                        let dateStr = formatter2.string(from: result!)
                        cell.timeLbl.text = dateStr
                    }
                    if let invocie = invoiceDict["invoiceNum"] as? String{
                        //cell.invoiceValLbl.text = invocie
                    }
                }
                
                
                return cell
            }
            
            if indexPath.section == 1{
                let cell = checkOutTableView.dequeueReusableCell(withIdentifier: "itemCell") as! itemCell
               // cell.selectBtn.addTarget(self, action: Selector("data:"), for: .touchUpInside)
                
                
                cell.itemTblview.tag = 2001
                
                
                cell.itemTblview.reloadData()
                
            return cell
            }
            if indexPath.section == 2{
                let cell = checkOutTableView.dequeueReusableCell(withIdentifier: "orderCell") as! orderCell
                cell.selectionStyle = .none
                cell.returnBtn.layer.borderColor = UIColor.blue.cgColor
                cell.returnBtn.layer.borderWidth = 1.0
                cell.returnBtn.layer.cornerRadius = 5.0
                
                cell.reorderBtn.layer.borderColor = UIColor.blue.cgColor
                cell.reorderBtn.layer.borderWidth = 1.0
                cell.reorderBtn.layer.cornerRadius = 5.0
                
                cell.addRatingBtn.layer.borderColor = UIColor.blue.cgColor
                cell.addRatingBtn.layer.borderWidth = 1.0
                cell.addRatingBtn.layer.cornerRadius = 5.0
                
                cell.shippingaddressTxtField.layer.borderColor = UIColor.blue.cgColor
                cell.shippingaddressTxtField.layer.borderWidth = 1.0
                cell.shippingaddressTxtField.layer.cornerRadius = 5.0
                
                cell.deleiveryTxtField.layer.borderColor = UIColor.blue.cgColor
                cell.deleiveryTxtField.layer.borderWidth = 1.0
                cell.deleiveryTxtField.layer.cornerRadius = 5.0
                
                cell.paymntTxtField.layer.borderColor = UIColor.blue.cgColor
                cell.paymntTxtField.layer.borderWidth = 1.0
                cell.paymntTxtField.layer.cornerRadius = 5.0
                
                cell.shippingaddressTxtField.delegate = self
                cell.deleiveryTxtField.delegate=self
                cell.paymntTxtField.delegate=self
                
                cell.instructiontxtField.delegate=self
                cell.shippingaddressTxtField.layer.borderWidth=1
                cell.shippingaddressTxtField.layer.borderColor = UIColor(red: 13.0/255.0, green: 102.0/255.0, blue: 202.0/255.0, alpha: 1.0).cgColor
                cell.deleiveryTxtField.layer.borderWidth=1
                cell.deleiveryTxtField.layer.borderColor = UIColor(red: 13.0/255.0, green: 102.0/255.0, blue: 202.0/255.0, alpha: 1.0).cgColor
                cell.paymntTxtField.layer.borderWidth=1
                cell.paymntTxtField.layer.borderColor = UIColor(red: 13.0/255.0, green: 102.0/255.0, blue: 202.0/255.0, alpha: 1.0).cgColor
               // allPrice = allPrice/2
                cell.getPriceLbl.text = "$" + String(allPrice) + ".00"
                
               cell.instructiontxtField.placeholder = "Enter Any Special instructions for your order"
                if checkOutFlag == true{
                    cell.totalPrice.text = "Delivery Cost: " + String(allPrice)
                    cell.totlPriceLbl.text = "Total:" + String(allPrice + 10)
                    
                    cell.shippingaddressTxtField.inputView = pickerView2
                    cell.deleiveryTxtField.inputView = pickerView2
                    cell.paymntTxtField.inputView = pickerView2
                    cell.shippingaddressTxtField.inputAccessoryView = toolBar
                    cell.deleiveryTxtField.inputAccessoryView = toolBar
                    cell.paymntTxtField.inputAccessoryView = toolBar
                    cell.paymntTxtField.text = self.paymentString
                    
                if  self.fillArray == true{
                     cell.shippingaddressTxtField.text = cityNames.first
                    cell.deleiveryTxtField.text = deleiveryArr.first
                    cell.paymntTxtField.text = paymentArray.first
                }
                if getPickervalue.count>indexPath.row{
                if let shipping = getPickervalue["shipping adress"] as? String
                {
                    cell.shippingaddressTxtField.text = shipping
                }
                if let deleivery = getPickervalue["deleivery method"] as? String
                {
                cell.deleiveryTxtField.text =  deleivery
                }
                if let payment = getPickervalue["payment method"] as? String
                {
                cell.paymntTxtField.text =  payment
                }

                }else{
                    
                    cell.shippingaddressTxtField.placeholder = "Select Shipping Address"
                    
                     cell.deleiveryTxtField.placeholder = "Select Deleivery Method"
                    
                    cell.paymntTxtField.placeholder =  "Select payment Method"
                    
                }
                    for item in shoppingArrayDict{
                        if let prices  = item["price"] as? [String]{
                             if var totalPrice:Int = Int(prices[0]) as? Int{
                           // allPrice = allPrice + totalPrice
                               // cell.totalPrice.text = "Delivery Cost: " + String(allPrice)
                           // price = price +  allPrice/shoppingArrayDict.count
                               // cell.totlPriceLbl.text = "Total:" + String(allPrice/shoppingArrayDict.count + 10);
                               // totalPrice = 0
                            }
                        }
                    }

                }else{
                    cell.totalPrice.text = "Shipping:$0.00"
                    if let did = invoiceDict["did"] as? String{
                        cell.shippingaddressTxtField.text = did
                    }
                    if let pick = invoiceDict["pick"] as? String{
                        cell.deleiveryTxtField.text = pick
                    }
                    if let name = invoiceDict["name"] as? String{
                        cell.paymntTxtField.text = name
                    }
                    for item in invoicePricearr{
                        let myInt = (item as NSString).integerValue
                        //if let totalPrice:Int = Int(item) as? Int{
                            
                            allPrice = allPrice + myInt
                            cell.totalPrice.text = "Sub Total: " + String(allPrice)
                            price = price + myInt
                            cell.totlPriceLbl.text = "Total:" + String(price)
                      
                    }
                }
                
                
                if checkOutFlag == true{
                   // cell.addRatingBtn.isHidden  = true
                    cell.reorderBtn.setTitle("Edit", for: .normal)
                    
                    cell.returnBtn.setTitle("Remove", for: .normal)
                    cell.shippingAddresLbl.text = "Please choose a shipping address"
                    cell.deleiveryLbl.text = "Please choose a delivery method"
                    cell.paymntLbl.text = "Please choose a payment method"
                    cell.instructionLbl.text = "Order Special Instructions"
                }else{
                    cell.addRatingBtn.isHidden  = false
                    
                  cell.shippingAddresLbl.text = "Shipping address"
                    cell.deleiveryLbl.text = "Delivery method"
                    
                    cell.paymntLbl.text = "Payment method"
                    cell.instructionLbl.text = "Order Special Instructions"
                }
                return cell
            }
        }
        if tableView == returnTableview{
            if indexPath.section == 0{
                let cell = returnTableview.dequeueReusableCell(withIdentifier: "itemReturnCell") as! itemReturnCell
                cell.returnImage.image = UIImage(named: "")
                cell.selectionStyle = .none
                return cell
            }
            if indexPath.section == 1{
                let cell = returnTableview.dequeueReusableCell(withIdentifier: "itemCells") as! itemCells
                cell.returnImages.image = UIImage(named: shoppingImageArr[indexPath.row])
                
                cell.selectionStyle = .none
                return cell
            }
            if indexPath.section == 2{
                let cell = returnTableview.dequeueReusableCell(withIdentifier: "itemreturnInfoCell") as! itemreturnInfoCell
                cell.selectionStyle = .none
                cell.returnItemreasonTxtField.layer.borderWidth = 1
                cell.returnItemreasonTxtField.layer.borderColor = UIColor.black.cgColor
                cell.commentsTxtField.layer.borderWidth = 1
                cell.commentsTxtField.layer.borderColor = UIColor.black.cgColor
                return cell
            }
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 15.0
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView.tag == 2001{
           // checkOutUrl = Array(Set(checkOutUrl))
            if checkOutFlag == true{
                return 1
           // return checkOutUrl.count
            }else{
                return 1
               // invoiceImageArrl = Array(Set(invoiceImageArrl))
               // return invoiceImageArrl.count
            }
        }
        if tableView == checkOutTableView{
            return 3
        }
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == checkOutTableView{
            if indexPath.section==0 {
                return 140
            } else if indexPath.section==1{
                return 130
            }else{
                return 350
            }
        }else{
            if indexPath.section==0 {
                return 180
            } else if indexPath.section==1{
                return 130
            }else{
                return 150
            }
            
        }
        return 44
        
    }
    var selectedIndexitem:Int = 0
    var selectBtnTag:Int = 0
    @IBAction func setBtnImgTapped(_ sender: UIButton) {
        let i =  Int(sender.tag)
        selectBtnTag = sender.tag
        selectedIndex = i - 101
        self.getShoppingChoice()
        //self.editItems()
        checkOutTableView.reloadData()
    }
    
    func editItems(){
        var editItemsDict:[String:[AnyObject]]=[:]
        var editItemsArrDict:[[String:AnyObject]]=[]
      let stripped = String(curStr.characters.dropFirst(4))
        shoppingArrayDict[selectedIndex].updateValue(stripped as AnyObject, forKey: "qty")
        
        
        print(shoppingArrayDict)
        print(selectBtnTag)
        print(checkOutArrDict.count)
        print(curStr)
        checkOutTableView.reloadData()
       
        
    }
    
    @IBAction func sentMsgBtnTap(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SearchMessagesVC") as! SearchMessagesVC
        
        self.navigationController?.pushViewController(vc, animated: false)
    }
    func data(_ sender: UIButton){
        let i =  Int(sender.tag)
        selectedIndexitem = i
        selectedIndex = i - 101
        
        checkOutTableView.reloadData()
    }
    var effect:UIVisualEffect!
    //var blur:UIBlurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
    @IBAction func submitBtnTapped(_ sender: Any) {
        signaturesView.isHidden=false
        //  signatureView.isHidden=false
        if (!UIAccessibilityIsReduceTransparencyEnabled()) {
            checkOutTableView.backgroundColor = UIColor.clear
            let blurEffect = UIBlurEffect(style: .light)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            checkOutTableView.backgroundView = blurEffectView
            
            //if inside a popover
            if let popover = navigationController?.popoverPresentationController {
                popover.backgroundColor = UIColor.clear
            }
            
            //if you want translucent vibrant table view separator lines
            checkOutTableView.separatorEffect = UIVibrancyEffect(blurEffect: blurEffect)
        }
        
    }
    var removeEdit:Bool = false
    func removeItems(){
    
        
        var productId:String = ""
        var removeProductDict:[String:AnyObject]=[:]
        
        let id = productIdArr[selectedIndex]
        
        if let strt = id.characters.count as? Int{
            if strt == 1{
                removeProductDict["121.30"] = "0000000000" + id as AnyObject
            }else if strt == 2{
                removeProductDict["121.30"] = "000000000" + id as AnyObject
            }else{
                removeProductDict["121.30"] = "00000000" + id as AnyObject
            }
            
        }
        
        myModel.addManager.removeProduct("020400203", userinfo: removeProductDict, completionResponse: { ( response,  error) in
            print(response)
            
            DispatchQueue.main.async {
                self.imageUrl.removeAll()
                self.checkOutUrl.removeAll()
                self.quantityArray.removeAll()
                self.priceArray.removeAll()
                self.titleArray.removeAll()
                self.logoImageArray.removeAll()
                self.checkOutArrDict.removeAll()
                //self.checkOutDict.removeAll()
                self.shoppingArrayDict.removeAll()
                self.getPickerData()
               // self.checkOutTableView.reloadData()
                
                self.dismiss(animated: true, completion: nil)
            }
        })
        
        
        }
    
    @IBAction func editBtnClicked(_ sender: Any) {
        removeEdit = true
        if selectedIndex == -1{
            let alert = UIAlertController(title: "Alert", message: "Please select any item", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
            removeItems()
            
             //self.pickerData()
        
            
        }
    }
    @IBAction func cancelBtnTapped(_ sender: Any) {
        signaturesView.isHidden=true
        //  signatureView.isHidden=true
        
    }
    func donePicker(){
        self.view.endEditing(true)
        pickersView.resignFirstResponder()
        toolBar.resignFirstResponder()
      //  pickersView.isHidden=true
       // toolBar.isHidden=true
    }
    func createShoppingCartView(){
    //  didSelectSpecials!(0,true)
        editView.isHidden=true
        hiddenView.isHidden = false
        hiddenView.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
        checkOutTableView.isUserInteractionEnabled = false
        sleep(0)
        let font = UIFont(name: "HelveticaNeue-Light", size: 13)
        let width = UIScreen.main.bounds.width-40
        hiddensView.frame = CGRect(x:10, y:UIScreen.main.bounds.height/2-(350)/2-25, width:UIScreen.main.bounds.width-20,height: 500)
        hiddensView.backgroundColor = UIColor.clear
        contentView.frame = CGRect(x:20, y:UIScreen.main.bounds.height/2-(350)/2, width:UIScreen.main.bounds.width-40, height:200)
        contentView.backgroundColor = UIColor.yellow
        contentView.layer.cornerRadius = 7
        contentView.layer.borderWidth = 1
        //  contentView.layer.borderColor = UIColor(red: 21.0/255.0, green: 162.0/255.0, blue: 198.0/255.0, alpha: 1.0).cgColor
        deviderLineView.frame = CGRect(x:5, y:35, width:contentView.bounds.width-10,height: 1)
        // deviderLineView.backgroundColor = UIColor(red: 21.0/255.0, green: 162.0/255.0, blue: 198.0/255.0, alpha: 1.0)
        contentView.backgroundColor = UIColor.white
        
        keyContentLabel.frame = CGRect(x:10, y:5,width:contentView.frame.width-20,height: 25)
        keyContentLabel.numberOfLines = 0
        keyContentLabel.text = "Remove an item from a shopping chart"
        keyContentLabel.textAlignment = NSTextAlignment.left
        keyContentLabel.textColor = UIColor(red: 21.0/255.0, green: 162.0/255.0, blue: 198.0/255.0, alpha: 1.0)
        keyContentLabel.backgroundColor = UIColor.clear
        
        contentsLb.frame = CGRect(x:10, y:41,width:contentView.frame.width-20, height:20)
        contentsLb.numberOfLines = 0
        contentsLb.text = "Would you like to..."
        contentsLb.textColor = UIColor.black
        
        removeLbl.frame = CGRect(x:10, y:70,width:contentView.frame.width-100, height:25)
        removeLbl.numberOfLines = 0
        removeLbl.textAlignment = NSTextAlignment.right
        removeLbl.text = "Remove completely"
        removeLbl.textColor = UIColor(red: 21.0/255.0, green: 162.0/255.0, blue: 198.0/255.0, alpha: 1.0)
        
        saveLbl.frame = CGRect(x:10, y:100,width:contentView.frame.width-100, height:25)
        saveLbl.numberOfLines = 0
        saveLbl.textAlignment = NSTextAlignment.right
        saveLbl.text = "Save for Later"
        saveLbl.textColor = UIColor(red: 21.0/255.0, green: 162.0/255.0, blue: 198.0/255.0, alpha: 1.0)
        
        
        let submitButton = UIButton()
        submitButton.frame = CGRect(x:contentView.frame.width-100,y:160,width:80, height:25)
        submitButton.setTitle("Submit", for: .normal)
        submitButton.backgroundColor = UIColor(red: 21.0/255.0, green: 162.0/255.0, blue: 198.0/255.0, alpha: 1.0)
        submitButton.tintColor = UIColor.white
        submitButton.addTarget(self, action: #selector(CheckOutVC.submitBtn), for: UIControlEvents.touchUpInside)
        
        
        let cancelButton = UIButton()
        cancelButton.frame = CGRect(x:10,y:15,width:15, height:15)
        
        cancelButton.addTarget(self, action: #selector(CheckOutVC.cancel), for: UIControlEvents.touchUpInside)
        
       
        removeCompletChckBtn.frame = CGRect(x:removeLbl.frame.width+30,y:100,width:20, height:20)
        removeCompletChckBtn.layer.borderColor = UIColor(red: 21.0/255.0, green: 162.0/255.0, blue: 198.0/255.0, alpha: 1.0).cgColor
        removeCompletChckBtn.layer.borderWidth = 1
        //removeCompletChckBtn.addTarget(self, action: #selector(CheckOutVC.checkRemoveBtn(_:)), for: UIControlEvents.touchUpInside)
       removeCompletChckBtn.addTarget(self, action: #selector(CheckOutVC.checkRemoveBtn(sender:) ), for: .touchUpInside)
        // removeCompletChckBtn.addTarget(self, action: "checkRemoveBtn:", for: .touchUpInside)
        
        
        saveLbl.isHidden=false
        removeLbl.isHidden=false
        saveLblBtn.isHidden=false
        removeCompletChckBtn.isHidden=false
        
        saveLblBtn.frame = CGRect(x:saveLbl.frame.width+30,y:130,width:20, height:20)
        saveLblBtn.layer.borderColor = UIColor(red: 21.0/255.0, green: 162.0/255.0, blue: 198.0/255.0, alpha: 1.0).cgColor
        saveLblBtn.layer.borderWidth = 1
        saveLblBtn.addTarget(self, action: #selector(CheckOutVC.checkSavebtn(sender:)), for: UIControlEvents.touchUpInside)
        
        
        //contentLabel.text = content
        contentsLb.font = UIFont(name: "HelveticaNeue-Light", size: 15)
        keyContentLabel.font = UIFont(name: "Bold", size: 15)
        
        hiddensView.addSubview(cancelButton)
        contentView.addSubview(contentsLb)
        contentView.addSubview(keyContentLabel)
        contentView.addSubview(removeLbl)
        contentView.addSubview(saveLbl)
        contentView.addSubview(deviderLineView)
        hiddensView.addSubview(submitButton)
        hiddensView.addSubview(removeCompletChckBtn)
        hiddensView.addSubview(saveLblBtn)
        hiddenView.addSubview(contentView)
        hiddenView.addSubview(hiddensView)
        
        self.messageFrame.removeFromSuperview()
        self.view.bringSubview(toFront: hiddensView)
    }
    func itemReturn(){
        hiddenView.isHidden = false
        hiddenView.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
        returnTableview.isHidden=false
        let cell = returnTableview.cellForRow(at: IndexPath(row: 0, section: 0)) as! itemReturnCell
        let cell2 = returnTableview.cellForRow(at: IndexPath(row: 0, section: 2)) as! itemreturnInfoCell
        if cell2.closeBtn.currentTitle == "Close"{
            cell2.closeBtn.isHidden=false
        cell.dateLbl.isHidden = true
        cell.timeLbl.isHidden  = true
            cell.returnImage.isHidden = true
        cell.itemRequestLbl.text = "You have choosen to return the following item(s)"
            
        }else{
           cell.returnImage.isHidden = false
            cell.dateLbl.isHidden = false
            cell.timeLbl.isHidden  = false
        }
        
         checkOutTableView.isUserInteractionEnabled = false
        hiddenView.addSubview(returnTableview)
        
        self.view.bringSubview(toFront: returnTableview)
        
    }
    func  textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        checkOutTableView.setContentOffset(CGPoint(x:0, y:0), animated: true)
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        pickerView2.isHidden = false
        toolBar.isHidden = false
      //  pickersView.isHidden=false
        toolBar.isHidden=false
        if textField.tag == 101{
            self.fillArray = false
            
            pickerView2.tag = 501
            checkOutTableView.setContentOffset(CGPoint(x:0, y:20), animated: true)
        }
        if textField.tag == 102{
            self.fillArray = false
            pickerView2.tag = 502
            checkOutTableView.setContentOffset(CGPoint(x:0, y:20), animated: true)
        }
        if textField.tag == 103{
            self.fillArray = false
            pickerView2.tag = 503
            checkOutTableView.setContentOffset(CGPoint(x:0, y:80), animated: true)
        }
        if textField.tag == 104{
            self.fillArray = false
             checkOutTableView.setContentOffset(CGPoint(x:0, y:300), animated: true)
        }
        if textField.tag == 5001{
            self.fillArray = false
            checkOutTableView.setContentOffset(CGPoint(x:0, y:250), animated: true)
        }
       // pickersView.isHidden=false
       // toolBar.isHidden=false
        if textField.tag == 201{
            
            pickerView2.tag = 1001
        }
        if textField.tag == 202{
            
            pickerView2.tag = 1002
        }
    }
    @IBAction func submitReasonBtnClicked(_ sender: Any) {
        hiddenView.isHidden = true
        returnView.isHidden=true
    }
    let qualityLbl = UILabel()
 //  let qualityTextField = UITextField()
    let colorTxField = UITextField()
    let qtylblText = UILabel()
    var getPickervalues:[String:AnyObject]=[:]
    var cartContentView = UIView()
    func addCart(){
       // getPickerData()
        var pickerOptionkeyArr:[String]=[]
        for item in dict1{
            print(item.key)
            pickerOptionkeyArr.append(item.key)
            
            print(item.value)
            print(dict1.keys)
            print(dict1.values)
        }
        cartContentView.isHidden=false
        saveLbl.isHidden=true
        //removeLbl.isHidden=true
        saveLblBtn.isHidden=true
        hiddenView.isHidden = false
        removeCompletChckBtn.isHidden=true
        hiddenView.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
        checkOutTableView.isUserInteractionEnabled = false
        sleep(0)
        let font = UIFont(name: "HelveticaNeue-Light", size: 13)
        let width = UIScreen.main.bounds.width-40
        hiddenReviewView.frame = CGRect(x:10, y:UIScreen.main.bounds.height/2-(500)/2-25, width:UIScreen.main.bounds.width-20,height: 550)
        hiddenReviewView.backgroundColor = UIColor.clear
        cartContentView.frame = CGRect(x:20, y:UIScreen.main.bounds.height/2-(500)/2, width:UIScreen.main.bounds.width-40, height:450)
        cartContentView.backgroundColor = UIColor.yellow
        cartContentView.layer.cornerRadius = 7
        cartContentView.layer.borderWidth = 1
        
        deviderLineView.frame = CGRect(x:5, y:35, width:cartContentView.bounds.width-10,height: 1)
        // deviderLineView.backgroundColor = UIColor(red: 21.0/255.0, green: 162.0/255.0, blue: 198.0/255.0, alpha: 1.0)
        cartContentView.backgroundColor = UIColor.white
        
        keyContentLabel.frame = CGRect(x:10, y:5,width:cartContentView.frame.width-20,height: 30)
        keyContentLabel.numberOfLines = 0
        keyContentLabel.text = "Add Items into Cart"
        keyContentLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        keyContentLabel.textAlignment = NSTextAlignment.left
        // keyContentLabel.textColor = UIColor.blue
        keyContentLabel.textColor = UIColor(red: 13.0/255.0, green: 102.0/255.0, blue: 202.0/255.0, alpha: 1.0)
        keyContentLabel.backgroundColor = UIColor.clear
        
        contentsLb.frame = CGRect(x:10, y:55,width:cartContentView.frame.width-20, height:20)
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
        
        
        removeLbl.frame = CGRect(x:10, y:135,width:cartContentView.frame.width-100, height:25)
        removeLbl.numberOfLines = 0
        removeLbl.textAlignment = NSTextAlignment.left
       // removeLbl.text = "Choose Option"
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
        
        colorTxField.frame = CGRect(x:30, y:169,width:cartContentView.frame.width-50, height:30)
        // colorTxField.inputView = pickersView
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
        
        
        
        qualityTextField.frame = CGRect(x:30, y:90,width:cartContentView.frame.width-50, height:30)
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
       //  qualityTextField.inputView = p
        //qualityTextField.text = self.allPickingData[0]
        qualityTextField.textAlignment = .center
        qualityTextField.backgroundColor = UIColor.white
        
        // qualityTextField.inputView = pickersView
        // qualityTextField.inputAccessoryView = toolBar
        qualityTextField.tag = 201
        if let qtyA =  getPickervalues["shipping adress"] as? String{
            qualityTextField.text = qtyA
        }
        
        
        dropDown1.frame = CGRect(x:qualityTextField.frame.width  ,y:95,width:20, height:25)
        //dropDown1.setTitle("-", for: .normal)
        dropDown1.setImage(UIImage(named:"dropDown"), for: .normal)
        dropDown1.backgroundColor = UIColor.white
        dropDown1.tintColor = UIColor.white
        dropDown1.addTarget(self, action: #selector(CheckOutVC.quantityDecr), for: UIControlEvents.touchUpInside)
        
        
        dropDown2.frame = CGRect(x:colorTxField.frame.width  ,y:170,width:20, height:25)
        if dict1.count<2{
            dropDown2.isHidden = true
        }else{
            dropDown2.setImage(UIImage(named:"dropDown"), for: .normal)
            dropDown2.isHidden = false
        }
        dropDown2.setImage(UIImage(named:"dropDown"), for: .normal)
        dropDown2.backgroundColor = UIColor.white
        dropDown2.tintColor = UIColor.white
        dropDown2.addTarget(self, action: #selector(CheckOutVC.quantityDecr), for: UIControlEvents.touchUpInside)
        
        
        
        qualityLbl.frame = CGRect(x:12, y:204,width:cartContentView.frame.width-100, height:25)
        qualityLbl.numberOfLines = 0
        qualityLbl.textAlignment = NSTextAlignment.left
        qualityLbl.text = "Quantity"
        qualityLbl.font = UIFont(name: "HelveticaNeue-Light", size: 15)
        qualityLbl.textColor = UIColor(red: 13.0/255.0, green: 102.0/255.0, blue: 202.0/255.0, alpha: 1.0)
        
        //qualityLbl.textColor = UIColor(red: 21.0/255.0, green: 162.0/255.0, blue: 198.0/255.0, alpha: 1.0)
        
        
        qtylblText.frame = CGRect(x:180, y:240,width:50, height:30)
        qtylblText.numberOfLines = 0
        qtylblText.textAlignment = NSTextAlignment.center
        qtylblText.text = "QTY"
        qtylblText.backgroundColor = UIColor.lightGray
        qtylblText.font = UIFont(name: "HelveticaNeue-Light", size: 14)
        qtylblText.textColor = UIColor.white
        
        
        quantityIncrement.frame = CGRect(x:150,y:240,width:30, height:30)
        quantityIncrement.setTitle("-", for: .normal)
        quantityIncrement.backgroundColor = UIColor.black
        quantityIncrement.tintColor = UIColor.white
        quantityIncrement.backgroundColor = UIColor.lightGray
        quantityIncrement.addTarget(self, action: #selector(ItemDetailVC.quantityDecr), for: UIControlEvents.touchUpInside)
        
        
        
        
        
        
        quantityDecrement.frame = CGRect(x:226,y:240,width:30, height:30)
        quantityDecrement.setTitle("+", for: .normal)
        quantityDecrement.backgroundColor = UIColor.black
        quantityDecrement.tintColor = UIColor.white
        quantityDecrement.backgroundColor = UIColor.lightGray
        quantityDecrement.addTarget(self, action: #selector(ItemDetailVC.quantityIncr), for: UIControlEvents.touchUpInside)
        
        SpecialInstructionLabl.frame = CGRect(x:30, y:285,width:cartContentView.frame.width-100, height:25)
        SpecialInstructionLabl.numberOfLines = 0
        SpecialInstructionLabl.textAlignment = NSTextAlignment.left
        SpecialInstructionLabl.text = "Special Instruction"
        SpecialInstructionLabl.textColor = UIColor(red: 13.0/255.0, green: 102.0/255.0, blue: 202.0/255.0, alpha: 1.0)
        
        
        SpecialInstructionTxtView.frame = CGRect(x:30, y:315,width:cartContentView.frame.width-50, height:85)
        // SpecialInstructionTxtView.numberOfLines = 0
        SpecialInstructionTxtView.textAlignment = NSTextAlignment.left
        SpecialInstructionTxtView.layer.borderWidth=1
        SpecialInstructionTxtView.delegate = self
        SpecialInstructionTxtView.layer.borderColor = UIColor(red: 13.0/255.0, green: 102.0/255.0, blue: 202.0/255.0, alpha: 1.0).cgColor
        
        SpecialInstructionTxtView.textColor = UIColor(red: 13.0/255.0, green: 102.0/255.0, blue: 202.0/255.0, alpha: 1.0)
        
        
        let submitButton = UIButton()
        submitButton.frame = CGRect(x:cartContentView.frame.width-90,y:412,width:80, height:35)
        submitButton.setTitle("Submit", for: .normal)
        submitButton.backgroundColor = UIColor(red: 13.0/255.0, green: 102.0/255.0, blue: 202.0/255.0, alpha: 1.0)
        submitButton.tintColor = UIColor.white
        submitButton.addTarget(self, action: #selector(CheckOutVC.submitRemoveItem), for: UIControlEvents.touchUpInside)
        
        cancelButton.frame = CGRect(x:cartContentView.frame.width-180,y:412,width:80, height:35)
        cancelButton.backgroundColor = UIColor(red: 13.0/255.0, green: 102.0/255.0, blue: 202.0/255.0, alpha: 1.0)
        cancelButton.tintColor = UIColor.white
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.addTarget(self, action: #selector(ItemDetailVC.cancel), for: UIControlEvents.touchUpInside)
       
        
        hiddenView.addSubview(hiddenReviewView)
        hiddenView.addSubview(cartContentView)
        cartContentView.addSubview(cancelButton)
        cartContentView.addSubview(dropDown1)
        cartContentView.addSubview(dropDown2)
        cartContentView.addSubview(removeLbl)
        cartContentView.addSubview(contentsLb)
        cartContentView.addSubview(keyContentLabel)
        cartContentView.addSubview(qualityTextField)
        cartContentView.addSubview(colorTxField)
        cartContentView.addSubview(qualityLbl)
        cartContentView.addSubview(SpecialInstructionLabl)
        cartContentView.addSubview(SpecialInstructionTxtView)
        cartContentView.addSubview(quantityIncrement)
        cartContentView.addSubview(quantityDecrement)
        cartContentView.addSubview(qtylblText)
        cartContentView.addSubview(deviderLineView)
        cartContentView.addSubview(submitButton)
        hiddenView.addSubview(quantityView)
        
        
       // hiddenView.addSubview(hiddensView)
        self.view.bringSubview(toFront: hiddenReviewView)
    }
    let SpecialInstructionTxtView = UITextView()
    let quantityView = UIView()
    let cancelButton = UIButton()
    let submitButton = UIButton()
    let SpecialInstructionLabl = UILabel()
    let quantityIncrement = UIButton()
    let quantityDecrement = UIButton()
     let dropDown2 = UIButton()
     let dropDown1 = UIButton()
    
    func quantityDecr(){
        
        
        someValue -= 1
        self.qtylblText.text = "QTY "+String(someValue)
        curStr = self.qtylblText.text!
       
        
        
    }
     var curStr:String = ""
    func quantityIncr(){
        someValue += 1
        self.qtylblText.text = "QTY "+String(someValue)
        curStr = self.qtylblText.text!
        
    }
    var someValue: Int = 0 {
        didSet {
            qtylblText.text = "\(someValue)"
        }
    }
    
    @IBOutlet weak var addtipTextField: UITextField!
    @IBAction func addTipBtnClick(_ sender: Any) {
        addtipTextField.delegate=self
        addtipTextField.tag = 5001
        tipFieldView.layer.borderWidth=1
        addTipView.layer.borderColor = UIColor.lightGray.cgColor
        tipFieldView.layer.borderColor = UIColor.lightGray.cgColor
        hiddenView.isHidden=false
        addTipView.isHidden=false
        hiddenView.addSubview(addTipView)
        returnreasonTxtField.showDismissToolbar=true
        returnreasonTxtField.isOptionalDropDown=false
        returnreasonTxtField.itemList = returnReasonArr
        
        addTipView.center = self.view.center
        self.view.bringSubview(toFront: addTipView)
    }
    
    @IBOutlet weak var returnItemTitle: UILabel!
    
    @IBOutlet weak var returnItemQty: UILabel!
    
    @IBOutlet weak var returnItemPrice: UILabel!
    
    
    @IBAction func returnBtnTapped(_ sender: Any) {
        
        if let buttonTitle = (sender as AnyObject).title(for: .normal) {
            if buttonTitle == "Return"{
              // self.addCart()
                
                
                if selectedIndex == -1{
                    let alert = UIAlertController(title: "Alert", message: "Please select any item", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }else{
                if let id = invoiceItemArrDict[selectedIndex]["name"] as? [String]{
                    if let dataId = id[0] as? String{
                        returnItemTitle.text = dataId
                    }
                }
                if let id = invoiceItemArrDict[selectedIndex]["price"] as? [String]{
                    if let dataId = id[0] as? String{
                        returnItemPrice.text = dataId
                    }
                }
                if let id = invoiceItemArrDict[selectedIndex]["qty"] as? [String]{
                    if let dataId = id[0] as? String{
                        returnItemQty.text = dataId
                        
                    }
                }
                
                
                returnView.isHidden=false
                hiddenView.isHidden=false
                hiddenView.addSubview(returnView)
                returnreasonTxtField.showDismissToolbar=true
                returnreasonTxtField.isOptionalDropDown=false
                returnreasonTxtField.itemList = returnReasonArr
                
                returnView.center = self.view.center
                self.view.bringSubview(toFront: returnView)
                }
            }
            if buttonTitle == "Remove"{
                //itemReturn()
                if selectedIndex == -1{
                    let alert = UIAlertController(title: "Alert", message: "Please select any item", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }else{
                    removeEdit = false
                createShoppingCartView()
                }
                
            }
            
        }
    }
   
    let digitalSignatureView = YPDrawSignatureView()
     let editView = UIView()
    
    func editAddItems(){
        var mercahntId:String = ""
        var productIds:String = ""
     if let id = shoppingAddressId["_114_179"] as? String{
        mercahntId = id
        }
        
        let id = productIdArray[selectedIndex]
        
        if let strt = id.characters.count as? Int{
            if strt == 1{
                productIds = "0000000000" + id
            }else if strt == 2{
                productIds = "000000000" + id
            }else{
                productIds = "00000000" + id
            }
            
        }
        
        
//        if let id = shoppingArrayDict[selectedIndex]["productid"] as? [String]{
//            if let dataId = id[0] as? String{
//                if let strt = dataId.characters.count as? Int{
//                    if strt == 1{
//                        productIds = "0000000000" + dataId
//                    }else if strt == 2{
//                        productIds = "000000000" + dataId
//                    }else{
//                       productIds = "00000000" + dataId
//                    }
//                }
//            }
//        }
    var addCart = [String: AnyObject]()
    addCart["53"] = loginUserId as AnyObject

    let aString = curStr
    let newString = aString.replacingOccurrences(of: "QTY ", with: "", options: .literal, range: nil)


    addCart["114.121"] = newString as AnyObject


    addCart["114.179"] = mercahntId as AnyObject

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
    let dict = ["114.144" : productIds,"114.179":mercahntId,"53":loginUserId,"114.121":newString,"CH":[["121.104":"00000000074" as AnyObject],["121.104":"00000000078" as AnyObject]]] as [String : Any]
    dictItem = dict
    }else if productId1 == ""{
    if let strt = productId1.characters.count as? Int{
    if strt == 1{
    productId1 = "0000000000"+productId1  as! String
    }else{
    productId1 = "000000000"+productId1
    }
    }

        let dict = ["114.144" : productIds,"114.179":mercahntId,"53":loginUserId,"114.121":newString,"CH":[["121.104":productId2 as AnyObject]]] as [String : Any]
    dictItem = dict
    }
    myModel.addManager.addItems(intoCarts: "030400198", userinfo: dictItem, completionResponse: { ( response,  error) in
    print(response)
       // DispatchQueue.main.async {
        //self.getShoppingCartItem()
             //self.getData()
        //}
       
    if response != nil{
    let alertController = UIAlertController(title: "Success", message: "Edit Item Sucessfully", preferredStyle: .alert)

    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PagerVC") as! PagerVC
        TestClass.doubleVar = 0;
        TestClass2.doubleVarBool = true;
        // didSelectSpecialsIten!(0,true)
        
        self.navigationController?.pushViewController(vc, animated: true)
       // self.navigationController?.popViewController(animated: true)
       
//self.getData()
   // self.openCheckOutView()
    }))
    // alertController.addAction(defaultAction)
   self.present(alertController, animated: true, completion: nil)
    }else{
    let alertController = UIAlertController(title: "Ooppss", message: "Item not Edit not  Sucessfully", preferredStyle: .alert)

    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)

    alertController.addAction(defaultAction)
    self.present(alertController, animated: true, completion: nil)
    }
    

    })

    }
    
    func submitRemoveItem(){
        editAddItems()
       // self.pickerData()
        print(selectBtnTag)
      //self.editItems()
       
    self.hiddenReviewView.removeFromSuperview()
    self.contentsLb.removeFromSuperview()
    self.cartContentView.removeFromSuperview()
    self.checkOutTableView.isUserInteractionEnabled = true
        self.checkOutTableView.reloadData()
    self.hiddenView.isHidden = true
    }
    var hiddenReviewView = UIView()
    func pickerData(){
        for itemChoose in pickerArray{
            if let itemId = itemChoose["_122_111"] as? String{
                if let itemIdName = itemChoose["_122_134"] as? String{
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
                                
                                pickerOptionValuesDict.removeAll()
                                print(pickerOptionValues)
                                
                            }
                        }
                    }
                }
                
            }
        }
    }
    func createSignatureView(){
        cartContentView.isHidden=true
        hiddenReviewView.isHidden=true
       // contentView.isHidden=true
        hiddenView.isHidden = false
        editView.isHidden=false
        hiddenView.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
        saveLbl.isHidden=true
        removeLbl.isHidden=true
        saveLblBtn.isHidden=true
        removeCompletChckBtn.isHidden=true
       // checkOutTableView.isUserInteractionEnabled = false
        sleep(0)
        let font = UIFont(name: "HelveticaNeue-Light", size: 13)
        let width = UIScreen.main.bounds.width-40
        hiddensSignatureView.frame = CGRect(x:10, y:UIScreen.main.bounds.height/2-(450)/2-25, width:UIScreen.main.bounds.width-10,height: 260)
        hiddensSignatureView.backgroundColor = UIColor.clear
        contentView.frame = CGRect(x:10, y:UIScreen.main.bounds.height/2-(450)/2, width:UIScreen.main.bounds.width-20, height:260)
        contentView.backgroundColor = UIColor.yellow
        contentView.layer.cornerRadius = 7
        contentView.layer.borderWidth = 1
       
        deviderLineView.frame = CGRect(x:5, y:35, width:contentView.bounds.width-10,height: 1)
        
        contentView.backgroundColor = UIColor.white
        
        keyContentLabel.frame = CGRect(x:10, y:5,width:contentView.frame.width-20,height: 25)
        keyContentLabel.numberOfLines = 0
        keyContentLabel.text = "Signature"
        keyContentLabel.textAlignment = NSTextAlignment.left
        keyContentLabel.textColor = UIColor(red: 21.0/255.0, green: 162.0/255.0, blue: 198.0/255.0, alpha: 1.0)
        keyContentLabel.backgroundColor = UIColor.clear
        
        contentsLb.frame = CGRect(x:10, y:41,width:contentView.frame.width-20, height:60)
        contentsLb.numberOfLines = 0
        contentsLb.text = "              Your transaction was approved                                                            Please sign below to accept and authorise this purchase "
        contentsLb.textColor = UIColor.black
        
        
        
         digitalSignatureView.frame = CGRect(x:10, y:125, width:UIScreen.main.bounds.width-40,height: 90)
       
        digitalSignatureView.strokeColor = UIColor.red
        digitalSignatureView.backgroundColor = UIColor.white
        

        contentView.layer.borderColor = UIColor.lightGray.cgColor
        
        var submitButton = UIButton()
        submitButton.frame = CGRect(x:contentView.frame.width-100,y:225,width:80, height:25)
        submitButton.setTitle("Submit", for: .normal)
        submitButton.backgroundColor = UIColor(red: 13.0/255.0, green: 102.0/255.0, blue: 202.0/255.0, alpha: 1.0)
        submitButton.tintColor = UIColor.white
        submitButton.addTarget(self, action: #selector(CheckOutVC.signatureCancel), for: UIControlEvents.touchUpInside)
        
        let clearSignBtn = UIButton()
        clearSignBtn.frame = CGRect(x:contentView.frame.width-200,y:225,width:80, height:25)
        clearSignBtn.setTitle("Clear", for: .normal)
        clearSignBtn.backgroundColor = UIColor(red: 13.0/255.0, green: 102.0/255.0, blue: 202.0/255.0, alpha: 1.0)
        clearSignBtn.tintColor = UIColor.white
        clearSignBtn.addTarget(self, action: #selector(CheckOutVC.clearSign), for: UIControlEvents.touchUpInside)
        
        let saveSignature = UIButton()
        saveSignature.frame = CGRect(x:10,y:225,width:80, height:25)
        saveSignature.setTitle("Saves", for: .normal)
        saveSignature.backgroundColor = UIColor(red: 13.0/255.0, green: 102.0/255.0, blue: 202.0/255.0, alpha: 1.0)
        saveSignature.tintColor = UIColor.white
        saveSignature.addTarget(self, action: #selector(CheckOutVC.saveSignatureBtn), for: UIControlEvents.touchUpInside)
        
        
        let cancelButton = UIButton()
        cancelButton.frame = CGRect(x:10,y:15,width:15, height:15)
        
        cancelButton.addTarget(self, action: #selector(CheckOutVC.signatureCancel), for: UIControlEvents.touchUpInside)
        
        //contentLabel.text = content
        contentsLb.font = UIFont(name: "HelveticaNeue-Light", size: 15)
        keyContentLabel.font = UIFont(name: "Bold", size: 15)
        
        hiddensSignatureView.addSubview(cancelButton)
        contentView.addSubview(contentsLb)
        contentView.addSubview(keyContentLabel)
        
        //contentView.addSubview(qualityTextField)
        hiddensSignatureView.addSubview(digitalSignatureView)
        
        
        hiddenView.addSubview(contentView)
        hiddenView.addSubview(hiddensSignatureView)
        contentView.addSubview(saveSignature)
        contentView.addSubview(submitButton)
        contentView.addSubview(clearSignBtn)
        self.messageFrame.removeFromSuperview()
        self.view.bringSubview(toFront: hiddensSignatureView)
    }
    func saveSignatureBtn(){
        if let signatureImage = self.digitalSignatureView.getSignature(scale: 10) {
            
            // Saving signatureImage from the line above to the Photo Roll.
            // The first time you do this, the app asks for access to your pictures.
            UIImageWriteToSavedPhotosAlbum(signatureImage, nil, nil, nil)
            
            // Since the Signature is now saved to the Photo Roll, the View can be cleared anyway.
            self.digitalSignatureView.clear()
        }
    }
    func clearSign(){
        self.digitalSignatureView.clear()
    }
    func submitBtn(){
        self.hiddensView.removeFromSuperview()
        self.contentsLb.removeFromSuperview()
        self.contentView.removeFromSuperview()
       // checkOutTableView.isUserInteractionEnabled = true
       // hiddenView.isHidden = true
        removeItem()
        
       // createSignatureView() //signature view
        
    }
    func removeItem(){
        
        var productId:String = ""
        var removeProductDict:[String:AnyObject]=[:]
  
         let id = productIdArr[selectedIndex]
        
                if let strt = id.characters.count as? Int{
                    if strt == 1{
                        removeProductDict["121.30"] = "0000000000" + id as AnyObject
                    }else if strt == 2{
                        removeProductDict["121.30"] = "000000000" + id as AnyObject
                    }else{
                        removeProductDict["121.30"] = "00000000" + id as AnyObject
                    }
              
        }

         myModel.addManager.removeProduct("020400203", userinfo: removeProductDict, completionResponse: { ( response,  error) in
            print(response)
            
            DispatchQueue.main.async {
                self.imageUrl.removeAll()
              self.checkOutUrl.removeAll()
                self.quantityArray.removeAll()
                self.priceArray.removeAll()
                self.titleArray.removeAll()
                self.logoImageArray.removeAll()
                self.checkOutArrDict.removeAll()
                //self.checkOutDict.removeAll()
                self.shoppingArrayDict.removeAll()
                self.getData()
                self.checkOutTableView.reloadData()
                
                self.dismiss(animated: true, completion: nil)
            }
        })
        
     
    }
    
    
    var allPickingData:[String]=[]
    var optionid:String = ""
    var optionIdArr:[String]=[]
    var pickerArray:[[String:AnyObject]]=[]
    let myGroup = DispatchGroup()
    func getShoppingChoice(){
        var getChoice:[String:AnyObject]=[:]
        //my code
        if selectedIndex > -1{
            if shoppingArrayDict.count>0{
        if let id = shoppingArrayDict[selectedIndex]["productid"] as? [String]{
            if let dataId = id[0] as? String{
                if let strt = dataId.characters.count as? Int{
                    if strt == 1{
                        getChoice["114.144"] = "0000000000" + dataId as AnyObject
                    }else if strt == 2{
                        getChoice["114.144"] = "000000000" + dataId as AnyObject
                    }else{
                        getChoice["114.144"] = "00000000" + dataId as AnyObject
                    }
                }
            }
            }
        }
        }
        myModel.addManager.getOptionsByItem("010100012", userinfo: getChoice, completionResponse: { ( response,  error) in
            
            print(response)
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
                            if let optionid = collectImages["_122_111"] as? String{
                                self.optionid = optionid
                                self.optionIdArr.append(self.optionid)
                            }
                        }
                    }
                }
            }
            
            for item in self.optionIdArr{
                self.myGroup.enter()
                
                // self.pickOption1Str = items
                
                self.getShoppingChoiceSecond(item: item,itemsArr:item)
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
    func getShoppingChoiceSecond(item:String,itemsArr:String){
        var getChoice2:[String:AnyObject]=[:]
        getChoice2["53"] = loginUserId as AnyObject
        //for item in optionIdArr{
        if let strt = item.characters.count as? Int{
            if strt == 1{
                 getChoice2["122.111"] = "0000000000" + item as AnyObject
            }else if strt == 2{
                 getChoice2["122.111"] = "000000000" + item as AnyObject
            }else{
                 getChoice2["122.111"] = "00000000" + item as AnyObject
            }
        }
       // getChoice2["122.111"] = "000000000"+item as AnyObject
        myModel.addManager.getOptionsByItemId("010100013", userinfo: getChoice2, completionResponse: { ( response,  error) in
            var optionElement:String = ""
            
            if let res:[[String:AnyObject]]=response as? [[String:AnyObject]]{
                for items in res{
                    if var images = items["_122_135"] as? String{
                        if self.optionIdDict[item] != nil{
                            self.optionIdDict[item]?.append(images as AnyObject)
                            
                        }else{
                            self.optionIdDict[item] = [images as AnyObject]
                        }
                        self.getChiceOption2.append(images)
                    }else{
                        self.getChiceOption2.append("Default")
                    }
                    //optionIdDict[item] = images
                }
                self.optionIdArrDict.append(self.optionIdDict as [String : AnyObject])
                print( self.optionIdArrDict)
                self.optionIdDict.removeAll()
            }
            
            
            self.myGroup.leave()
            DispatchQueue.main.async {
                
                self.progressView.stopAnimating()
                self.progressView.isHidden=true
                self.hiddenView.isHidden = true
                
                self.checkOutTableView.isUserInteractionEnabled = true
                self.checkOutTableView.reloadData()
            }
        })
        
        // }
    }
    
    var hiddenPaymentView = UIView()
    var totalAmount = UIView()
    var paymentLabel = UILabel()
    var visaLabel = UILabel()
    let payButton = UIButton()
    let removeBtn = UIButton()
    @IBAction func submitBtnAction(_ sender: Any) {
    
        hiddenView.isHidden = false
        editView.isHidden=false
        hiddenView.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
        hiddenPaymentView.frame = CGRect(x:10, y:UIScreen.main.bounds.height/2-(350)/2-25, width:UIScreen.main.bounds.width-20,height: 500)
        hiddenPaymentView.backgroundColor = UIColor.clear
        contentView.frame = CGRect(x:20, y:UIScreen.main.bounds.height/2-(350)/2, width:UIScreen.main.bounds.width-40, height:200)
        contentView.backgroundColor = UIColor.yellow
        contentView.layer.cornerRadius = 7
        contentView.layer.borderWidth = 1
        //  contentView.layer.borderColor = UIColor(red: 21.0/255.0, green: 162.0/255.0, blue: 198.0/255.0, alpha: 1.0).cgColor
        deviderLineView.frame = CGRect(x:5, y:35, width:contentView.bounds.width-10,height: 1)
        // deviderLineView.backgroundColor = UIColor(red: 21.0/255.0, green: 162.0/255.0, blue: 198.0/255.0, alpha: 1.0)
        contentView.backgroundColor = UIColor.white
        
        
        totalAmount.frame = CGRect(x:20, y:UIScreen.main.bounds.height/2-(350)/2, width:UIScreen.main.bounds.width-40, height:40)
        totalAmount.backgroundColor = UIColor.yellow
       // totalAmount.layer.cornerRadius = 7
        totalAmount.layer.borderWidth = 1
        //  contentView.layer.borderColor = UIColor(red: 21.0/255.0, green: 162.0/255.0, blue: 198.0/255.0, alpha: 1.0).cgColor
        totalAmount.backgroundColor = UIColor.gray.withAlphaComponent(0.1)
        
        
        paymentLabel.frame = CGRect(x:10, y:5,width:totalAmount.frame.width-50,height: 25)
        paymentLabel.numberOfLines = 0
        if let accNum = self.getPaymentJson["48.15"] as? String{
        paymentLabel.text = accNum
        }else{
            paymentLabel.text = "Select Account Number"
        }
        paymentLabel.textAlignment = NSTextAlignment.left
        paymentLabel.textColor = UIColor(red: 21.0/255.0, green: 162.0/255.0, blue: 198.0/255.0, alpha: 1.0)
        paymentLabel.backgroundColor = UIColor.clear
        
        
//        visaLabel.frame = CGRect(x:paymentLabel.frame.width+5, y:5,width:totalAmount.frame.width-20,height: 25)
//        visaLabel.numberOfLines = 0
//        visaLabel.text = "VISA"
//        visaLabel.textAlignment = NSTextAlignment.left
//        visaLabel.textColor = UIColor(red: 21.0/255.0, green: 162.0/255.0, blue: 198.0/255.0, alpha: 1.0)
//        visaLabel.backgroundColor = UIColor.clear
        
        
        
        
        payButton.frame = CGRect(x:totalAmount.frame.width-100,y:155,width:80, height:25)
        payButton.setTitle("Pay", for: .normal)
        payButton.backgroundColor = UIColor(red: 21.0/255.0, green: 162.0/255.0, blue: 198.0/255.0, alpha: 1.0)
        payButton.tintColor = UIColor.white
        payButton.addTarget(self, action: #selector(CheckOutVC.payBtnTapped), for: UIControlEvents.touchUpInside)
        
        
        
        removeBtn.frame = CGRect(x:30,y:155,width:80, height:25)
        removeBtn.setTitle("Remove", for: .normal)
        removeBtn.backgroundColor = UIColor(red: 21.0/255.0, green: 162.0/255.0, blue: 198.0/255.0, alpha: 1.0)
        removeBtn.tintColor = UIColor.white
        removeBtn.addTarget(self, action: #selector(CheckOutVC.removeBtnTapped), for: UIControlEvents.touchUpInside)
        
        keyContentLabel.frame = CGRect(x:10, y:5,width:contentView.frame.width-20,height: 25)
        keyContentLabel.numberOfLines = 0
        keyContentLabel.text = "Select Card For Payment"
        keyContentLabel.textAlignment = NSTextAlignment.left
        keyContentLabel.textColor = UIColor(red: 21.0/255.0, green: 162.0/255.0, blue: 198.0/255.0, alpha: 1.0)
        keyContentLabel.backgroundColor = UIColor.clear
        totalAmount.addSubview(paymentLabel)
        totalAmount.addSubview(visaLabel)
        contentView.addSubview(keyContentLabel)
        contentView.addSubview(deviderLineView)
        contentView.addSubview(contentsLb)
        hiddenView.addSubview(contentView)
        hiddenPaymentView.addSubview(payButton)
        hiddenPaymentView.addSubview(removeBtn)
        hiddenView.addSubview(totalAmount)
        hiddenView.addSubview(hiddenPaymentView)
        
        self.messageFrame.removeFromSuperview()
        self.view.bringSubview(toFront: hiddenPaymentView)
    }
    func checkRemoveBtn(sender:UIButton!){
        if (sender.isSelected == true)
        {
            sender.setBackgroundImage(UIImage(named: ""), for: UIControlState.normal)
            
            sender.isSelected = false;
        }
        else
        {
            sender.setBackgroundImage(UIImage(named: "checkBox"), for: UIControlState.normal)
            
            sender.isSelected = true;
        }
    }
    func checkSavebtn(sender:UIButton){
        if (sender.isSelected == true)
        {
            sender.setBackgroundImage(UIImage(named: ""), for: UIControlState.normal)
            
            sender.isSelected = false;
        }
        else
        {
            sender.setBackgroundImage(UIImage(named: "checkBox"), for: UIControlState.normal)
            
            sender.isSelected = true;
        }
    }
    
    @IBAction func closeBtn(_ sender: Any) {
        
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yy:MM:dd"
        
        let result = formatter.string(from: date)
        
        
        
//        let date = Date()
//        let calendar = Calendar.current
//        let hour = calendar.component(.hour, from: date)
//       
//        let minutes = calendar.component(.minute, from: date)
//        let sec = calendar.component(.second, from: date)
//        
//        var dated = String(hour) + ":"  + String(minutes) + ":"  + String(sec)
        if let result = UserDefaults.standard.value(forKey: "loginUserID") as? String{
            loginUserId = result as! String
            print(result)
        }
        if var merchantid = shoppingAddressId["_114_179"] as? String{
            getPaymentJson["114.179"] = merchantid as AnyObject
        }
        if let id = shoppingAddressId["_55_3"] as? String{
            getPaymentJson["55.3"] = id as AnyObject
        }
        print(shoppingAddressId)
        
        if let id = shoppingAddressId["_122_31"] as? String{
            shoppingCartDictparam["122.31"] = "000000000" + id as AnyObject
        }
        let paymentJson:[String:Any] = ["13": result as AnyObject,
                                        "53": loginUserId as AnyObject,
                                        "114.179":  getPaymentJson["114.179"] as AnyObject,
                                        "122.29":  shoppingCartDictparam["122.31"] as AnyObject,
                                        // "122.29":"00000000031" as AnyObject,
            "55.3":  getPaymentJson["55.3"] as AnyObject,
            "120.109": "0.00" as AnyObject,
            "114.115": "00000001043" as AnyObject,
            "122.109": "00000000163" as AnyObject,
            "120.38": "37.785834" as AnyObject,
            "120.39": "-122.406417" as AnyObject,
            "KT":[[
                "48.15": self.getPaymentJson["48.15"] as AnyObject
                ]],
            "AM":[[
                "48.30":  getPaymentJson["55.3"] as AnyObject
                ]],
            "TX":[[
                "121.97": "10.00" as AnyObject
                ]],
            "CH":[[
                "121.30":  shoppingCartDictparam["122.31"] as AnyObject,
                "121.104": "4501" as AnyObject,
                "114.98": "0.00" as AnyObject,
                "114.144": "00000000003" as AnyObject
                ]]]
        progressView.isHidden=false
        progressView.startAnimating()
        // setLoadingScreen()
        hiddenView.isHidden = false
        hiddenView.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
        checkOutTableView.isUserInteractionEnabled = false
        
        var jsonArr:[String:AnyObject]=paymentJson as [String : AnyObject]
        
        myModel.addManager.getPaymentJsonArray("030300023", userinfo: paymentJson, completionResponse: { ( response,  error) in
            
            print(response)
            if let res = response as? [[String:AnyObject]]{
                
               self.progressView.stopAnimating()
               // // setLoadingScreen()
              //  self.hiddenView.isHidden = true
               // self.checkOutTableView.isUserInteractionEnabled = true
            let alertController = UIAlertController(title: "Message", message: "Item Purchase Succesfully", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                    self.createSignatureView()
                }))
            //
               // alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
            }else{
                let alertController = UIAlertController(title: "Error", message: "Oops! item not purchase seucessfully", preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
            //present(alertController, animated: true, completion: nil)
            
            
        })
        hiddenPaymentView.removeFromSuperview()
        contentView.removeFromSuperview()
        totalAmount.removeFromSuperview()
        visaLabel.removeFromSuperview()
        payButton.removeFromSuperview()
        checkOutTableView.isUserInteractionEnabled = true
        hiddenView.isHidden = true
        //addCartView()
    }
    func addCartView(){
        
        createShoppingCartView()
        
  
        
    }
    func cancel(){
        
        self.hiddensView.removeFromSuperview()
        self.contentsLb.removeFromSuperview()
        self.contentView.removeFromSuperview()
        checkOutTableView.isUserInteractionEnabled = true
        hiddenView.isHidden = true
        
    }
    func payBtnTapped(){
        
        
        
    }
    func removeBtnTapped(){
        hiddenPaymentView.removeFromSuperview()
        contentView.removeFromSuperview()
        totalAmount.removeFromSuperview()
        visaLabel.removeFromSuperview()
        payButton.removeFromSuperview()
        checkOutTableView.isUserInteractionEnabled = true
        hiddenView.isHidden = true
    }
    var didSelectSpecials: ((Int,Bool) -> ())?
    func signatureCancel(){
        var didSelectSpecialsIten: ((Int,Bool) -> ())?
        self.hiddensSignatureView.removeFromSuperview()
        self.contentsLb.removeFromSuperview()
        self.contentView.removeFromSuperview()
        checkOutTableView.isUserInteractionEnabled = true
        hiddenView.isHidden = true
        let vc = storyboard?.instantiateViewController(withIdentifier: "PagerVC") as! PagerVC
        TestClass.doubleVar = 0;
        TestClass2.doubleVarBool = true;
       // didSelectSpecialsIten!(0,true)
        
        self.navigationController?.pushViewController(vc, animated: true)
       // let vc = storyboard?.instantiateViewController(withIdentifier: "HomeVC1") as!  HomeVC
        
       // self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func itemCloseBtn(_ sender: UIButton) {
        let cell = returnTableview.cellForRow(at: IndexPath(row: 0, section: 2)) as! itemreturnInfoCell
        if sender.currentTitle == "Close"{
            cell.closeBtn.setTitle("Submit", for: .normal)
            cell.closeBtn.isHidden = false
        }else{
            cell.closeBtn.setTitle("Close", for: .normal)
            hiddenView.isHidden=true
            returnTableview.isHidden=true
            checkOutTableView.isUserInteractionEnabled=true
        }
    }
    var setText:String=""
    var qualityTxtData:String=""
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if let str = removeLbl.text as? String{
            qualityTxtData = str
        }
        if pickerView2.tag == 501{
           return cityNames.count
        }
        if pickerView2.tag == 502{
            return deleiveryArr.count
        }
        if pickerView2.tag == 503{
            return paymentArray.count
        }
        if pickerView2.tag == 504{
            return quantityArray.count
        }
        if pickerView2.tag == 1001{
            
            for (key,val) in dict1{
                if  removeLbl.text == key{
                    return val.count
                    
                }
            }
        }
        if pickerView2.tag == 1002{
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
        if pickerView2.tag == 501{
            return self.cityNames[row]
        }
        if pickerView2.tag == 502{
            return deleiveryArr[row]
        }
        if pickerView2.tag == 503{
            return paymentArray[row]
        }
        if pickerView2.tag == 1001{
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
        }
        if pickerView2.tag == 1002{
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
            
        }
         return ""
    }
    var pickerOptionValues:[[String:AnyObject]]=[]
    var pickerOptionValuesDict:[String:AnyObject]=[:]
    @IBAction func addRatingBtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "RatingVC") as! RatingVC
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    var productId1:String = ""
    var productId2:String = ""
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView2.tag == 501{
            if cityNames.count>0{
                getPickervalue["shipping adress"] = self.cityNames[row] as AnyObject
            
            }
        }
        if pickerView2.tag == 502{
            if deleiveryArr.count>0{
                  getPickervalue["deleivery method"] = deleiveryArr[row] as AnyObject
           
            }
        }
        if pickerView2.tag == 503{
            if paymentArray.count>0{
                  getPickervalue["payment method"] = paymentArray[row] as AnyObject
           
            }
        }
        if pickerView2.tag == 1001{
            qualityTextField.text  = arrayPick2[row]
            productId2 = arrayProductId2[row]
        }
        if pickerView2.tag == 1002{
            colorTxField.text = arrayPick[row]
            productId1 = arrayProductId1[row]
        }
        checkOutTableView.reloadData()
    }
    func didStart() {
        print("Started Drawing")
    }
    
    // didFinish() is called rigth after the last touch of a gesture is registered in the view.
    // Can be used to enabe scrolling in a scroll view if it has previous been disabled.
    func didFinish() {
        print("Finished Drawing")
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
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
