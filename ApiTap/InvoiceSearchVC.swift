//
//  InvoiceSearchVC.swift
//  ApiTap
//
//  Created by Ashish on 06/10/17.
//  Copyright © 2017 ApiTap. All rights reserved.
//

import UIKit
class notify{
    static var getTask:Int = 0
}

class serachInvoiceCell:UITableViewCell{
    
    @IBOutlet weak var totalLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var invoiceLbl: UILabel!
    @IBOutlet weak var storeLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var setLbl: UILabel!
}

class InvoiceSearchVC: BaseViewController,UITableViewDelegate,UITableViewDataSource ,UISearchBarDelegate  {
    
    var dictparam:[String:AnyObject]=[:]
      var myModel = ModelManager()
    @IBOutlet weak var invoiceSearchTbleView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var searchController: UISearchController!
    var data = ["Dogs","cats","Goofs","Apples","frogs"]
    var filterData:[String]=[]
    var isSearching:Bool = false
     var searchActive : Bool = false
    var loginUserId:String = ""
    var invoiceArray:[[String:AnyObject]]=[]
    var invoiceDict:[[String:AnyObject]]=[]
    var voiceDict:[String:AnyObject]=[:]
    var filData:[[String:AnyObject]]=[]
    var fillDidArr:[String]=[]
    var fillPickArr:[String]=[]
    var fillPayArr:[String]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notify.getTask = 1
        self.initializeNavBar()
        self.setbarButtonItems()
        invoiceSearchTbleView.delegate=self
        invoiceSearchTbleView.dataSource = self
        
        searchBar.delegate=self
        searchBar.returnKeyType = UIReturnKeyType.done
        
        if let result = UserDefaults.standard.value(forKey: "loginUserID") as? String{
            loginUserId = result as! String
            print(result)
        }
        dictparam["53"] = loginUserId as AnyObject
       // dictparam["EXPECTED"] = "ALL" as AnyObject
        //getCard
        myModel.addManager.getInvoice("010100206", userinfo: dictparam, completionResponse: { ( response,  error) in
            print(response)
            if let res = response as? [[String:AnyObject]]{
                self.invoiceArray = res
                for item in self.invoiceArray{
                    if let result = item["RESULT"] as? [[String:AnyObject]]{
                        for invoiceItem in result{
                            
                            
                            if let res = invoiceItem["_120_31"] as? String{
                              
                                let formatter = DateFormatter()
                                formatter.dateFormat = "yyyy-mm-dd HH:mm:ss"
                                
                                
                                
                                //                     let dateFormatterPrint = DateFormatter()
                                //                     dateFormatterPrint.dateFormat = "MMM dd,yyyy"
                                let result = formatter.date(from: res)
                                let formatter2 = DateFormatter()
                                formatter2.dateFormat = "dd MMM,yyyy"
                                let dateStr = formatter2.string(from: result!)
                                    self.voiceDict["date"] = dateStr as AnyObject
                                
                            }
                            if let res = invoiceItem["_114_70"] as? String{
                                
                                    self.voiceDict["store_name"] = res as AnyObject
                                
                            }
                            if let res = invoiceItem["_124_101"] as? String{
                               
                                    self.voiceDict["invoice_num"] = res as AnyObject
                                
                            }
                            
                            
                            if let didDict = invoiceItem["DE"] as? [[String:AnyObject]]{
                                for itemDid in didDict{
                                    if let did = itemDid["_114_12"] as? String{
                                        self.voiceDict["did"] = did as AnyObject
                                       
                                    }
                                    if let pick = itemDid["_122_133"] as? String{
                                        self.voiceDict["pick"] = pick as AnyObject
                                        
                                    }
                                }
                            }
                            
                            if let pickDict = invoiceItem["KT"] as? [[String:AnyObject]]{
                                for pickDid in pickDict{
                                    if let name = pickDid["_48_6"] as? String{
                                        self.voiceDict["name"] = name as AnyObject
                                        
                                    }
                                    
                                }
                            }
                            
//                            if let date = invoiceItem["_120_31"] as? String{
//                                self.voiceDict["date"] = date as AnyObject
//                            }
                            if let store = invoiceItem["_114_70"] as? String{
                                self.voiceDict["store"] = store as AnyObject
                            }
                            if let invoiceNum = invoiceItem["_121_41"] as? String{
                                self.voiceDict["invoiceNum"] = invoiceNum as AnyObject
                            }
                            if let status = invoiceItem["_114_143"] as? String{
                                if status == "101"{
                                    self.voiceDict["status"] = "success" as AnyObject
                                }else{
                                self.voiceDict["status"] = "failure" as AnyObject
                                }
                            }
                            if let total = invoiceItem["_55_3"] as? String{
                                self.voiceDict["total"] = "$" + total as AnyObject
                            }
                            if let invoiceId = invoiceItem["_121_75"] as? String{
                                self.voiceDict["invoiceId"] = invoiceId as AnyObject
                            }
                            self.invoiceDict.append(self.voiceDict)
                        }
                        
                    }
                }
            }
            
            self.invoiceSearchTbleView.reloadData()
            
        })
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filData.count
        }
        return invoiceDict.count;
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = invoiceSearchTbleView.dequeueReusableCell(withIdentifier: "serachInvoiceCell") as! serachInvoiceCell
        
        var text:String = ""
        
        if(searchActive){
            if filData.count>indexPath.row{
            let data = filData[indexPath.row]
            cell.dateLbl.text = data["date"] as! String
            cell.storeLbl.text = data["store"] as! String
            cell.invoiceLbl.text = data["invoiceNum"] as! String
            cell.statusLbl.text = data["status"] as! String
            cell.totalLbl.text = data["total"] as! String
            }
        }else{
            if invoiceDict.count>indexPath.row{
            let items = invoiceDict[indexPath.row]
            cell.dateLbl.text = items["date"] as! String
            cell.storeLbl.text = items["store"] as! String
            cell.invoiceLbl.text = items["invoiceNum"] as! String
            cell.statusLbl.text = items["status"] as! String
            cell.totalLbl.text =  items["total"] as! String
            }
            
            
       
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(searchActive){
            let dataDict = filData[indexPath.row]
            let vc = storyboard?.instantiateViewController(withIdentifier: "CheckOutVC") as! CheckOutVC
            
            vc.checkOutFlag = false
            vc.invoiceDict = dataDict
            self.navigationController?.pushViewController(vc, animated: true)
            
        }else{
             let itemsDict = invoiceDict[indexPath.row]
            let vc = storyboard?.instantiateViewController(withIdentifier: "CheckOutVC") as! CheckOutVC
            
            vc.checkOutFlag = false
             vc.invoiceDict = itemsDict
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let searchPredicate = NSPredicate(format: "store CONTAINS[C] %@", searchText)
        let array = (invoiceDict as NSArray).filtered(using: searchPredicate)
        
        print ("array = \(array)")
        filData = array as! [[String:AnyObject]]
        if(array.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.invoiceSearchTbleView.reloadData()
        
  }
    
    @IBAction func invoiceBtnTapped(_ sender: Any) {
        
       
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
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
