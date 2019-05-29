//
//  AddDetailVC.swift
//  ApiTap
//
//  Created by Ashish on 30/10/17.
//  Copyright © 2017 ApiTap. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
class relatedAddsCollectionCell:UICollectionViewCell{
    @IBOutlet weak var relatedItemNameLbl: UILabel!
    @IBOutlet weak var relatedImageView: UIImageView!
    
    @IBOutlet weak var viewOuter: UIView!
    @IBOutlet weak var relatedItemPriceLbl: UILabel!
}
class addImageCell:UITableViewCell{
    @IBOutlet var storeImgView: UIImageView!
    @IBOutlet var addNameLbl:UILabel!
    @IBOutlet var storeNameLbl: UILabel!
    @IBOutlet var outerView:UIView!
    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet var addImageView:UIImageView!
    @IBOutlet var storeView: UIView!
}

class detailCell:UITableViewCell{
    @IBOutlet var detailTxtView:UITextView!
}
class relatedAddItemCell:UITableViewCell{
    
    
    @IBOutlet var relatedItemCollectionview:UICollectionView!
}
class AddDetailVC: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    var addDetailsArr:[[String:AnyObject]]=[]
    var addDetail:[String:[AnyObject]]=[:]
    var relatedImageArr:[URL]=[]
    @IBOutlet var addDetailTblView:UITableView!
    var nameArr:[String]=[]
    var priceArr:[String]=[]
    var playerVC = AVPlayerViewController()
    var playerView = AVPlayer()
    var videoArray:[String]=[]
    var myModel = ModelManager()
    var loginUserId:String = ""
    var productIds:String = ""
    var tranactionApprovStr:String = ""
    var pId:String = ""
    var getFavItemsId:[String]=[]
    var productIdArray:[String]=[]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeNavBar()
        self.setbarButtonItems()
        addDetailTblView.tableFooterView = UIView()
        print(addDetail)
        if let result = UserDefaults.standard.value(forKey: "loginUserID") as? String{
            loginUserId = result as! String
            print(result)
        }
        var getfav:[String:AnyObject]=[:]
        
        getfav["53"] = loginUserId as AnyObject
                
        if let productId = addDetail["productId"] as? [String]{
            for ids in productId{
                pId = ids
                productIds = "00000000" + ids
            }
        }
        if let video = addDetail["_114_144"] as? [String]{
            for videos in video{
                productIdArray.append(videos)
            }
        }
        
        if let video = addDetail["video"] as? [String]{
            for videos in video{
                videoArray.append(videos)
            }
        }
        if let data = addDetail["relatedImages"] as? [URL]{
            for ele in data{
                relatedImageArr.append(ele)
            }
        }
        if let name = addDetail["relatedItemname"] as? [String]{
            for names in name{
                nameArr.append(names)
            }
        }
        if let name = addDetail["relatedItemPrice"] as? [String]{
            for names in name{
                priceArr.append(names)
            }
        }
        
        
        myModel.addManager.getAddFav("010100496", userinfo: getfav, completionResponse: { ( response,  error) in
            print(response)
            if let res:[[String:AnyObject]]=response as? [[String:AnyObject]]{
                for items in res{
                    if let pIds = items["RESULT"] as? [[String:AnyObject]]{
                        for data in pIds{
                            if let elements = items["_121_18"] as? String{
                                self.getFavItemsId.append(elements)
                            }
                        }
                    }
                }
            }
            DispatchQueue.main.async {
                self.addDetailTblView.reloadData()
            }
        })
        
        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
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
    var didSelectRowAdd: ((String,Int,Bool) -> ())?
    var storeMerchantId:String = ""
    @IBAction func storeDetailBtnTap(_ sender: Any) {
       TestClassStore.storeMerchantId = productIds
        storeMerchantId = productIds
        if let name = addDetail["storeName"] as? [String]{
            for element in name{
               TestClassStore.storeName = element
            }
        }
        if let url = addDetail["storeImage"] as? [String] {
            for element in url{
                 if let urlGet = NSURL(string: element) {
                    TestClassStore.storeNameImage = urlGet as URL!
                }
                
            }
        }
        let vc = storyboard?.instantiateViewController(withIdentifier: "PagerVC") as! PagerVC
        didSelectRowAdd!(storeMerchantId,0,true)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func zoomImageBtnClicked(_ sender: Any) {
        var urlStr:URL!
        if videoArray.count>0{
            let videoUrl = NSURL(string: videoArray[0])
            let vc = storyboard?.instantiateViewController(withIdentifier: "ZoomImageVC") as! ZoomImageVC
            vc.videoArr = videoArray
           // vc.imageURL = videoUrl as! URL
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
        if let url = addDetail["addImage"] as? [URL]{
            for element in url{
                urlStr = element
                //  cell.addImageView.sd_setImage(with: element)
            }
        }
        let vc = storyboard?.instantiateViewController(withIdentifier: "ZoomImageVC") as! ZoomImageVC
        vc.imageURL = urlStr
        self.navigationController?.pushViewController(vc, animated: true)
        }
       // self.navigationController?.present(vc, animated: true, completion: nil)
       // self.navigationController?.pushViewController(vc, animated: true)
    }
  
    @IBAction func shareBtnTapped(_ sender: Any) {
        let textToShare = "Swift is awesome!  Check out this website about it!"
        
        if let myWebsite = NSURL(string: "http://www.codingexplorer.com/") {
            let objectsToShare = [textToShare, myWebsite] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            activityVC.popoverPresentationController?.sourceView = sender as! UIView
            self.present(activityVC, animated: true, completion: nil)
        }
    }
    @IBAction func getFavBtnTapped(_ sender: Any) {
        var addfav:[String:AnyObject]=[:]
        
        
        addfav["53"] = loginUserId as AnyObject
        
        addfav["121.18"] = productIds as AnyObject
        
        
        myModel.addManager.addItemFav("030400497", userinfo: addfav, completionResponse: { ( response,  error) in
            print(response)
            
            if let res:[[String:AnyObject]]=response as? [[String:AnyObject]]{
                for items in res{
                    if let pId = items["_44"] as? String{
                        self.tranactionApprovStr = pId
                        //self.favString = pId
                    }
                }
                
            }
            DispatchQueue.main.async {
                self.addDetailTblView.reloadData()
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        if relatedImageArr.count>0{
            return 3
        }else{
            return 2
        }
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section==0{
            return 320
        }
        if indexPath.section==1{
            return 90
        }
        if indexPath.section==2{
            return 230
        }
        return 44
    }
    
    @IBAction func backBtnPress(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view:UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.size.width, height: 10))
        view.backgroundColor = UIColor.groupTableViewBackground
        
        return view
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
     func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
         return CGSize(width: collectionView.frame.size.height-50, height: collectionView.frame.size.height)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "addImageCell") as! addImageCell
            cell.backgroundColor = UIColor.groupTableViewBackground
            cell.outerView.layer.cornerRadius = 4
            cell.outerView.clipsToBounds = true
            cell.webView.allowsInlineMediaPlayback = true
           // cell.webView.mediaPlaybackRequiresUserAction = false
            if videoArray.count>indexPath.row{
                if let video = videoArray[indexPath.row] as? String{
                    if video != ""{
                         cell.webView.allowsInlineMediaPlayback = true
                        cell.addImageView.isHidden=true
                        cell.webView.isHidden=false
//                        cell.webView.mediaPlaybackRequiresUserAction = true
//                        cell.webView.loadHTMLString("<iframe width=\"\(cell.webView.frame.width)\" height=\"\(cell.webView.frame.height)\" src=\"https://www.youtube.com/embed/FDT343j3zD0?playsinline=1\" frameborder=\"0\" allowfullscreen></iframe>", baseURL: nil)
                        cell.webView.loadHTMLString("<iframe width=\"\(cell.webView.frame.width)\" height=\"\(cell.webView.frame.height)\" src=\"\(video)?playsinline=1\" frameborder=\"0\" allowfullscreen></iframe>", baseURL: nil)
                        let videoUrl = NSURL(string: video)
                        let req = URLRequest(url: videoUrl as! URL)

//                        cell.webView.loadRequest(req)
                        
                        
//                        let videoURL = NSURL(string: video)
//                        let player = AVPlayer(url: videoURL! as URL)
//                        let playerViewController = AVPlayerViewController()
//                        playerViewController.player = player
//                        self.present(playerViewController, animated: true) {
//                            playerViewController.player!.play()
//                        }
                        
                    }
                }
            }else{
                cell.webView.isHidden=true
                cell.addImageView.isHidden=false
                
                if let url = addDetail["addImage"] as? [URL]{
                    for element in url{
                        cell.addImageView.sd_setImage(with: element)
                    }
                }
            }
            if let url = addDetail["storeImage"] as? [String] {
                for element in url{
                    if let urlGet = NSURL(string: element) {
                        // urlPath = url as URL!
                        cell.storeImgView.sd_setImage(with: urlGet as URL!)
                    }
                }
            }
            if getFavItemsId.contains(pId){
                cell.favBtn.setImage(UIImage(named:"favourite-red"), for: .normal)
            }
            if self.tranactionApprovStr != ""{
                cell.favBtn.setImage(UIImage(named:"favourite-red"), for: .normal)
            }
            if let name = addDetail["storeName"] as? [String]{
                for element in name{
                    cell.storeNameLbl.text = element
                }
            }
            if let name = addDetail["name"] as? [String]{
                for element in name{
                    cell.addNameLbl.text = element
                }
            }
            return cell
        }
        if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell") as! detailCell
            if let name = addDetail["detail"] as? [String]{
                for element in name{
                    cell.detailTxtView.text = element
                }
            }
            return cell
        }
        if indexPath.section == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "relatedAddItemCell") as! relatedAddItemCell
            cell.relatedItemCollectionview.reloadData()
            
            return cell
        }
        return UITableViewCell()
    }
    override  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ItemDetailVC" ) as! ItemDetailVC
        vc.productId = productIdArray[indexPath.row]
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
    
//}

//extension  AddDetailVC:UICollectionViewDelegate, UICollectionViewDelegateFlowLayout ,UICollectionViewDataSource{
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return relatedImageArr.count
        
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "relatedAddsCollectionCell", for: indexPath) as! relatedAddsCollectionCell
        
        cell.layer.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4).cgColor
        
        cell.viewOuter.layer.borderWidth = 1
        cell.viewOuter.layer.borderColor = UIColor(red: 220/256.0, green: 220/256.0, blue: 220/256.0, alpha: 1.0).cgColor
        cell.viewOuter.layer.cornerRadius = 8.0
        cell.viewOuter.clipsToBounds = true
        cell.layer.cornerRadius = 8.0
        cell.clipsToBounds = true
        
        cell.viewOuter.layer.masksToBounds = false
        cell.viewOuter.layer.shadowColor = UIColor.lightGray.cgColor
        cell.viewOuter.layer.shadowOpacity = 0.3
        cell.viewOuter.layer.shadowOffset = CGSize(width: -1, height: 1)
        cell.viewOuter.layer.shadowRadius = 1
        
        cell.viewOuter.layer.shadowPath = UIBezierPath(rect: cell.bounds).cgPath
        cell.viewOuter.layer.shouldRasterize = true
        cell.viewOuter.layer.rasterizationScale = 1
        cell.relatedImageView.sd_setImage(with: relatedImageArr[indexPath.row])
        // let specialItem =   addDetail[indexPath.row]
        if let name = addDetail["relatedItemname"] as? [String]{
            let str = self.hexToStr(textValue: name[0])//hexToStr(text: name[0])//name[0]
            cell.relatedItemNameLbl.text =  str
           
        }
        let str = self.hexToStr(textValue: nameArr[indexPath.row])
        cell.relatedItemNameLbl.text = str
        cell.relatedItemPriceLbl.text = "$" + priceArr[indexPath.row]
        return cell

}

}
