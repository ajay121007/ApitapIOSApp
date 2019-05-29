//
//  SearchMessagesVC.swift
//  ApiTap
//
//  Created by AppZorro on 19/09/17.
//  Copyright © 2017 ApiTap. All rights reserved.
//

import UIKit



class serachMessagesCell:UITableViewCell{
    @IBOutlet weak var repliedlbl: UILabel!
    @IBOutlet weak var statuslbl: UILabel!
    @IBOutlet weak var messagelbl: UILabel!
    @IBOutlet weak var replieslbl: UILabel!
    @IBOutlet weak var subjectLbl: UILabel!
    @IBOutlet weak var storeLbl: UILabel!
    @IBOutlet weak var selBtnImg: UIButton!
    @IBOutlet weak var dateLbl: UILabel!
}

class SearchMessagesVC: BaseViewController,UITableViewDelegate,UITableViewDataSource ,UISearchBarDelegate{

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTxtField: UITextField!
    @IBOutlet weak var searchMsgTableView: UITableView!
    @IBOutlet weak var searchMessageView: UIView!
    var messageBool:Bool=false
    var dateArray:[String]=["08/24/2017","08/24/2017","08/24/2017","08/24/2017","08/24/2017","08/24/2017","08/24/2017","08/24/2017"]
    var storeArray:[String]=["H & M","Ralph","H & M","Ralph","H & M","Ralph","H & M","Ralph"]
    var subjectArray:[String]=["XXXXXXXXXXXXX","XXXXXXXXXXXXX","XXXXXXXXXXXXX","XXXXXXXXXXXXX","XXXXXXXXXXXXX","XXXXXXXXXXXXX","XXXXXXXXXXXXX"]
    var statusArray:[String]=["New","Read","New","Read","New","Read","New"]
    var repliedArray:[String]=["-","12","-","12","-","12","-"]
    var myModel = ModelManager()
    
    var dictParam:[String:AnyObject]=[:]
    
    var loginUserId:String = ""

    var searchActive : Bool = false
    var data:[String]=[]
    var searchMsgDict:[[String:AnyObject]]=[]
    var msgDict:[String:AnyObject]=[:]
    var filData:[[String:AnyObject]]=[]
    override func viewDidLoad(){
        super.viewDidLoad()
        searchBar.showsSearchResultsButton=false
        self.initializeNavBar()
        if messageBool == false{
        self.setbarButtonItems()
        }else{
            self.setBarBtnItems()
        }
        searchMsgTableView.delegate=self
        searchMsgTableView.dataSource=self
      
        
        
        if let result = UserDefaults.standard.value(forKey: "loginUserID") as? String{
            loginUserId = result as! String
            print(result)
        }

        dictParam["114.9"] = "true" as AnyObject
        if messageBool == true{
            getMessages()
        }else{
        myModel.addManager.searchMessages("010100209", userinfo: dictParam, completionResponse: { ( response,  error) in
            
            print(response)
            if let res = response as? [[String:AnyObject]]{
                for results in res{
                if let result = results["RESULT"] as? [[String:AnyObject]]{
                    for item in result{
                       if let reply = item["_127_87"] as? String{
                        if reply == "true"{
                        if let status = item["_114_143"] as? String{
                            self.msgDict["status"] = status as AnyObject
                        }
                        if let msg = item["_122_128"] as? String{
                             self.msgDict["msg"] = msg as AnyObject
                        }
                        if let store = item["_114_53"] as? String{
                            self.msgDict["store"] = store as AnyObject
                        }
                        if let reply = item["_127_87"] as? String{
                             self.msgDict["reply"] = reply as AnyObject
                        }
                        
                        if let date = item["_114_139"] as? String{
                            
                           // let date = Date()
                            let formatter = DateFormatter()
                            formatter.dateFormat = "yyyy-mm-dd hh:mm:ss"
                            
                          //  dateFormatterGet.dateFormat = "yyyy-MM-dd hh:mm:ss"
                            
                           // let dateFormatterPrint = DateFormatter()
                           // dateFormatterPrint.dateFormat = "MMM dd,yyyy"
//                            let result = formatter.date(from: date)
//                            let formatter2 = DateFormatter()
//                            formatter2.dateFormat = "MMM dd,yyyy"
//                            let dateStr = formatter2.string(from: result!)
//                          //  let dates: NSDate? = dateFormatterGet.date(from: date) as! NSDate
//
//                            self.msgDict["date"] = dateStr as AnyObject
                        }
                        if let status = item["_114_179"] as? String{
                            self.msgDict["114.179"] = status as AnyObject
                        }
                        if let status = item["_120_16"] as? String{
                            self.msgDict["120.16"] = status as AnyObject
                        }
                        if let status = item["_114_150"] as? String{
                            self.msgDict["114.150"] = status as AnyObject
                        }
                        if let status = item["_122_128"] as? String{
                            self.msgDict["122.128"] = status as AnyObject
                        }
                        if let status = item["_120_157"] as? String{
                            self.msgDict["120.157"] = status as AnyObject
                        }
                        if let status = item["_121_75"] as? String{
                            self.msgDict["121.75"] = status as AnyObject
                        }
                        self.searchMsgDict.append(self.msgDict)
                        self.msgDict.removeAll()
                    }
                    }
                }
                    }
            }
            }
            
            DispatchQueue.main.async {
            self.searchMsgTableView.reloadData()
            }
        })
        }
        // Do any additional setup after loading the view.
    }

    var productId:String=""
    func getMessages(){
        var dictMsg:[String:AnyObject]=[:]
        if let strt = productId.characters.count as? Int{
            if strt == 1{
                dictMsg["114.144"] = "0000000000"+productId as AnyObject
            }else if strt == 2{
                dictMsg["114.144"] = "000000000"+productId as AnyObject
            }
            else if strt == 3{
                dictMsg["114.144"] = "00000000"+productId as AnyObject
            }
            else if strt == 4{
                dictMsg["114.144"] = "0000000"+productId as AnyObject
            }else{
                dictMsg["114.144"] = "000000"+productId as AnyObject
            }
        }
        myModel.addManager.addsItem("010400265", userinfo: dictMsg, completionResponse: { ( response,  error) in
            
            print(response)
            
            
            
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if section == 0{
//            return 1
//        }
        if section == 0 {
            if(searchActive) {
                return filData.count
            }
            return searchMsgDict.count;
        }
        
        return 0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        vc.chatDict = searchMsgDict[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        if indexPath.section == 0{
            let cell = searchMsgTableView.dequeueReusableCell(withIdentifier: "serachMessagesCell") as! serachMessagesCell
            cell.selBtnImg.tag = indexPath.row+101
            if searchMsgDict.count > indexPath.row{
                let messages = searchMsgDict[indexPath.row]
                
           // cell.dateLbl.text = dateArray[indexPath.row]
          //  cell.storeLbl.text = storeArray[indexPath.row]
                if let sub = messages["msg"] as? String{
                       cell.messagelbl.text = sub
                }
                if let date = messages["date"] as? String{
                    cell.dateLbl.text = date
                }
                if let store = messages["store"] as? String{
                   
                    cell.storeLbl.text = store
                    
                }
                if let status = messages["status"] as? String{
                     if status == "1501"{
                    cell.statuslbl.text = "Read"
                     }else{
                        cell.statuslbl.text = "New"
                    }
                }
                if let reply = messages["reply"] as? String{
                    if reply == "false"{
                    cell.replieslbl.text = "N"
                }else{
                    cell.replieslbl.text = "Y"
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
        
        return UITableViewCell()
    }
    var isSelect:Bool = false
     var selectedIndex = -1
    @IBAction func selBtnImageTapped(_ sender: UIButton) {
        let i =  Int(sender.tag)
        selectedIndex = i - 101
        searchMsgTableView.reloadData()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
            return 70
        
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let searchPredicate = NSPredicate(format: "store CONTAINS[C] %@", searchText)
        let array = (searchMsgDict as NSArray).filtered(using: searchPredicate)
        
        print ("array = \(array)")
        filData = array as! [[String:AnyObject]]
        if(array.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.searchMsgTableView.reloadData()
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
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
}
