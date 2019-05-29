//
//  PagerVC.swift
//  ApiTap
//
//  Created by Ashish on 15/12/17.
//  Copyright © 2017 ApiTap. All rights reserved.
//

import UIKit


class TestClass2: NSObject {
    
    static var doubleVarBool: Bool = false
    
}

class storeMerchantClass: NSObject {
    
    static var storeMerchantId: String = ""
    static var storeMerchantIdBool: Bool = false
    
}
class PagerVC:  PagerController, PagerDataSource,storeDetails {

    
    var index:Int = 0
    var vc2 = BaseViewController()
    var imageArray:[String]=["icon_home","icon_store","icon_ads-1","icon_specials","icon_items","fav_gray"]
    var allTabImage:[UIImage]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        for item in imageArray{
            dataImage(imageStr: item)
        }

        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller1 = storyboard.instantiateViewController(withIdentifier: "HomeVC1")
        let controller2 = storyboard.instantiateViewController(withIdentifier: "StoreVC")
        let controller3 = storyboard.instantiateViewController(withIdentifier: "AddDetailViewController")
        let controller4 = storyboard.instantiateViewController(withIdentifier: "SpecialVC")
        let controller5 = storyboard.instantiateViewController(withIdentifier: "ItemVC")
        let controller6 = storyboard.instantiateViewController(withIdentifier: "FavioratesVC")
        let controller7 = storyboard.instantiateViewController(withIdentifier: "CheckOutVC")
        let controller8 = storyboard.instantiateViewController(withIdentifier: "ItemRatingVC")
        let controller9 = storyboard.instantiateViewController(withIdentifier: "AddDetailVC")
        
        
        // Setting up the PagerController with Name of the Tabs and their respective ViewControllers
//        self.setupPager(
//            tabNames: ["Home", "Stores", "Ads", "Specials", "Items", "Favorites"],
//            tabControllers: [controller1, controller2, controller3, controller4, controller5, controller6],tabi
//        )
        self.setupPager(tabNames: [" Home", " Stores", " Ads", " Specials", " Items", " Favorites"], tabControllers: [controller1, controller2, controller3, controller4, controller5, controller6], tabImg: ["icon_home","icon_store","icon_ads-1","icon_specials","icon_items","fav_gray"])

        
        customizeTab()
        

        if let controller = controller4 as? SpecialVC {
            
            controller.didSelectRow = { [weak self] (text: String) in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let detail = storyboard.instantiateViewController(withIdentifier: "ItemDetailVC") as? ItemDetailVC {
                    
                     detail.productId = text
                    self?.navigationController?.pushViewController(detail, animated: true)
                }
            }
        }
        if let controller = controller1 as? HomeVC {
            
            controller.didSelectProductService = { [weak self] (text: Int,flag:Bool) in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let detail = storyboard.instantiateViewController(withIdentifier: "PagerVC") as? PagerVC {
                    
                    // detail.merchantId=text
                    self?.navigationController?.pushViewController(detail, animated: true)
                }
            }
        }
        if let controller = controller1 as? HomeVC {
            
            controller.didSelectfav = { [weak self] (text: Int,flag:Bool) in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let detail = storyboard.instantiateViewController(withIdentifier: "PagerVC") as? PagerVC {
                    
                    // detail.merchantId=text
                    self?.navigationController?.pushViewController(detail, animated: true)
                }
            }
        }
        if let controller = controller7 as? CheckOutVC {
            
            controller.didSelectSpecials = { [weak self] (text: Int,flag:Bool) in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let detail = storyboard.instantiateViewController(withIdentifier: "PagerVC") as? PagerVC {
                    
                    // detail.merchantId=text
                    self?.navigationController?.pushViewController(detail, animated: true)
                }
            }
        }
        if let controller = controller1 as? HomeVC {
            
            controller.didSelectSpecial = { [weak self] (text: Int,flag:Bool) in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let detail = storyboard.instantiateViewController(withIdentifier: "PagerVC") as? PagerVC {
                    
                   // detail.merchantId=text
                    self?.navigationController?.pushViewController(detail, animated: true)
                }
            }
        }
        if let controller = controller8 as? ItemRatingVC {
            
            controller.didSelectSpecial = { [weak self] (text: Int,flag:Bool) in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let detail = storyboard.instantiateViewController(withIdentifier: "PagerVC") as? PagerVC {
                    
                    // detail.merchantId=text
                    self?.navigationController?.pushViewController(detail, animated: true)
                }
            }
        }
        if let controller = controller1 as? HomeVC {
            
            controller.didSelectStoreRow = { [weak self] (text: String,imageData:[String]) in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let detail = storyboard.instantiateViewController(withIdentifier: "ItemRatingVC") as? ItemRatingVC {
                    
                    detail.merchantId=text
                    detail.imageGetUrl = imageData
                    self?.navigationController?.pushViewController(detail, animated: true)
                }
            }
        }
        if let controller = controller1 as? HomeVC {
           
            controller.didSelectRow = { [weak self] (text: [String : AnyObject],text2:Int) in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let detail = storyboard.instantiateViewController(withIdentifier: "ItemDetailVC") as? ItemDetailVC {
                   detail.homeItemValue = text
                    
                    //self?.delegateStore=self! as! storeDetailsInfo
                    detail.selecteditem = text2
                    detail.delegateStore=self as! storeDetails
                    self?.navigationController?.pushViewController(detail, animated: true)
                }
            }
        }
        if let controller = controller3 as? AddDetailViewController {
            
            controller.didSelectRow = { [weak self] (text: [String : [AnyObject]]) in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let detail = storyboard.instantiateViewController(withIdentifier: "AddDetailVC") as? AddDetailVC {
                     detail.addDetail = text
                    self?.navigationController?.pushViewController(detail, animated: true)
                }
            }
        }
        
        if let controller = controller6 as? FavioratesVC {
            
            controller.didSelectRow = { [weak self] (text: String) in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let detail = storyboard.instantiateViewController(withIdentifier: "ItemDetailVC") as? ItemDetailVC {
                     detail.productId = text
                    //detail.delegateStore=self as! storeDetails
                    self?.navigationController?.pushViewController(detail, animated: true)
                }
            }
        }
        
        if let controller = controller5 as? ItemVC {
            
            controller.didSelectRow = { [weak self] (text: String) in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let detail = storyboard.instantiateViewController(withIdentifier: "ItemDetailVC") as? ItemDetailVC {
                    detail.productId = text
                    //detail.delegateStore=self as! storeDetails
                    self?.navigationController?.pushViewController(detail, animated: true)
                }
            }
        }
        
        if let controller = controller2 as? StoreVC {
            
            controller.didSelectRow = { [weak self] (text: String,texts: Int,flag:Bool) in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                
                if let detail = storyboard.instantiateViewController(withIdentifier: "PagerVC") as? PagerVC {
                    storeMerchantClass.storeMerchantId = text
                    storeMerchantClass.storeMerchantIdBool = true
                                      //  detail.storeProductId = text
                                        //detail.storeFlag = flag
                                        self?.navigationController?.pushViewController(detail, animated: true)
                                    }

            }
        }
        if let controller = controller9 as? AddDetailVC {
            
            controller.didSelectRowAdd = { [weak self] (text: String,texts: Int,flag:Bool) in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                
                if let detail = storyboard.instantiateViewController(withIdentifier: "PagerVC") as? PagerVC {
                    storeMerchantClass.storeMerchantId = text
                    storeMerchantClass.storeMerchantIdBool = true
                    //  detail.storeProductId = text
                    //detail.storeFlag = flag
                    self?.navigationController?.pushViewController(detail, animated: true)
                }
                
            }
        }
        
        if let controller = controller4 as? GreyViewController {
            controller.didSelectRow = { [weak self] (text: String) in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let detail = storyboard.instantiateViewController(withIdentifier: "greyTableDetail") as? GreyDetailViewController {
                    detail.text = text
                    self?.navigationController?.pushViewController(detail, animated: true)
                }
            }
        }
        // Do any additional setup after loading the view.
    }

    
    func dataImage(imageStr:String){
        var base64String: NSString!
        let myImage = UIImage(named:imageStr)
        let imageData = UIImageJPEGRepresentation(myImage!, 0.9)
        base64String = imageData!.base64EncodedString(options: NSData.Base64EncodingOptions.endLineWithLineFeed) as NSString!
        print(base64String)
        
        
        let thumbnail1Data =  Data(base64Encoded: base64String as String, options: NSData.Base64DecodingOptions())
        let homeImage = UIImage(data: thumbnail1Data as! Data)
        allTabImage.append(homeImage!)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goTo_ItemDetail"{
            let vc = segue.destination as! ItemDetailVC
            //vc.colorString = colorLabel.text!
        }
    }
    func customizeTab() {
        self.view.backgroundColor = UIColor.groupTableViewBackground
        let selectedcolor = UIColor(red: 48/256.0, green: 142/256.0, blue: 218/256.0, alpha: 1.0)
        indicatorColor = selectedcolor
        indicatorBackGroundColor = selectedcolor
        selectedTabTextColor =  UIColor.white
        
        tabsViewBackgroundColor = UIColor.white
        contentViewBackgroundColor = UIColor.gray.withAlphaComponent(0.32)
        startFromSecondTab = false
        centerCurrentTab = true
        tabLocation = PagerTabLocation.top
        tabHeight = 30
        tabOffset = 36
        tabWidth = 90
        indicatorHeight = 2.0
        fixFormerTabsPositions = false
        fixLaterTabsPosition = false
        animation = PagerAnimation.during
        tabsTextFont = UIFont(name: "HelveticaNeue-Bold", size: 2)!
        tabTopOffset = 5.0
        tabsTextColor = UIColor.lightGray
        
        
    }
    
    
    // Programatically selecting a tab. This function is getting called on AppDelegate
    func changeTab(index:Int) {
        self.selectTabAtIndex(index)
    }
 

}
