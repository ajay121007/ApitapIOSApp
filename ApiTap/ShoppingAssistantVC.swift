//
//  ShoppingAssistantVC.swift
//  ApiTap
//
//  Created by Ashish on 23/10/17.
//  Copyright © 2017 ApiTap. All rights reserved.
//

import UIKit

class createEventsCell:UITableViewCell{
    
}
class addItemsCell:UITableViewCell{
    
}
class eventsNameCell:UITableViewCell{
    
    @IBOutlet weak var eventsNameLbl: UILabel!
}
class itemsNamesCell:UITableViewCell{
    
    @IBOutlet weak var itemsNameLbl: UILabel!
}
class ShoppingAssistantVC: BaseViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {

    @IBOutlet weak var addItemsTblView: UITableView!
    @IBOutlet weak var createEventTblView: UITableView!
    
    @IBOutlet weak var hiddenView: UIView!
    var createEventArr:[String]=[]
    
    var addItemsArr:[String]=[]
    var myModel = ModelManager()
    var dictparam:[String:AnyObject]=[:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeNavBar()
        self.setbarButtonItems()
        
        addItemsTblView.rowHeight = UITableViewAutomaticDimension
        addItemsTblView.estimatedRowHeight = 100.0
        
        if   let getUserDict:[String:[AnyObject]] = UserDefaults.standard.object(forKey: "user_auth_token") as? [String:[AnyObject]]{
            dict = getUserDict
        }
        if   let getUserDict2:[String] = UserDefaults.standard.object(forKey: "user_auth_token1") as? [String]{
            createEventArr = getUserDict2
        }
        if selectedRef == ""{
            if dict.count>0{
                for itemEle in dict{
                    if let str = itemEle.key as? String{
                        selectedRef = str
                    }
                }
            }
        }
        createEventTblView.reloadData()
        addItemsTblView.reloadData()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
         if tableView == addItemsTblView{
            return 2
        }
        if tableView == createEventTblView{
            return 2
        }
        return 2
    }
    var selectedRef:String = ""
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         if tableView == addItemsTblView{
            if section==0{
                return 1
            }
            if section==1{
                if dict.count>0{
                    for (key,var val) in dict{
                        if selectedRef == key{
                            var val2:[String] = val as! [String]
                            val2 = Array(Set(val2))
                            val2 = val2.filter { $0 != ""
                            }
                            if val2.count>0{
                            return val2.count
                            }else{
                                return 1
                            }
                        }
                    }
                }else{
                    return 1
                }
                
            }
            
        }
        if tableView == createEventTblView{
            if section==0{
                return 1
            }
            if section==1{
                
                if createEventArr.count>section{
                    return createEventArr.count
                }else{
                    return 1
                }
                
            }
           
        }
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == addItemsTblView{
            if indexPath.section == 0{
            let cell = addItemsTblView.dequeueReusableCell(withIdentifier: "addItemsCell") as! addItemsCell
                cell.contentView.layer.borderWidth=1
                cell.contentView.layer.borderColor = UIColor.gray.cgColor
                
                //cell.itemsNameLbl.layer.borderWidth = 1
            return cell
            }
            
            if indexPath.section == 1{
                let cell = addItemsTblView.dequeueReusableCell(withIdentifier: "itemsNamesCell") as! itemsNamesCell
                cell.contentView.layer.borderWidth=1
                cell.contentView.layer.borderColor = UIColor.gray.cgColor
                cell.itemsNameLbl.layer.borderWidth = 1
              //  cell.itemsNameLbl.layer.borderColor = UIColor(red: 13.0/255.0, green: 102.0/255.0, blue: 202.0/255.0, alpha: 1.0).cgColor
                cell.itemsNameLbl.backgroundColor = UIColor(red: 220.0/255.0, green: 220.0/255.0, blue: 220.0/255.0, alpha: 0.4)
                cell.itemsNameLbl.layer.cornerRadius = 8
                cell.selectionStyle = .none
                
                for (key,val) in dict{
                    if selectedRef != ""{
                    if selectedRef == key{
                        var val2:[String] = val as! [String]
                        val2 = Array(Set(val2))
                        val2 = val2.filter { $0 != ""
                        }
                        //return val.count
                        if val2.count>indexPath.row{
                            if let str = val2[indexPath.row] as? String{
                                if str != ""{
                                    cell.itemsNameLbl.text = str
                                }
                            }
                        
                        }
                        }
                    
                    else{
                        
                        }
                    
                    }
                    
                    else{
//                        for itemEle in dict{
//                            if let str = itemEle.key as? String{
//                                 selectedRef = str
                        
                                for (key,val) in dict{
                                    
                                    if selectedRef == key{
                                        var val2:[String] = val as! [String]
                                        val2 = Array(Set(val2))
                                        val2 = val2.filter { $0 != ""
                                        }
                                        //return val.count
                                        if val2.count>indexPath.row{
                                            if let str = val2[indexPath.row] as? String{
                                                if str != ""{
                                                    cell.itemsNameLbl.text = str
                                                }
                                            }
                                            
                                        }
//                                    }
//                                    
//                                }
                                break
                            }
                        }
                        //let item = dict.keys.first
                       // selectedRef = item!
                        
                        
                        
                        
                        
                        
                        // cell.itemsNameLbl.text = ""
                    
                }
                }
                return cell
            }
            
        }
        if tableView == createEventTblView{
             if indexPath.section == 0{
            let cell = createEventTblView.dequeueReusableCell(withIdentifier: "createEventsCell") as! createEventsCell
            
                cell.contentView.layer.borderWidth=1
                cell.contentView.layer.borderColor = UIColor.gray.cgColor
            return cell
            }
            if indexPath.section == 1{
                let cell = createEventTblView.dequeueReusableCell(withIdentifier: "eventsNameCell") as! eventsNameCell
                cell.contentView.layer.borderWidth=1
                cell.contentView.layer.borderColor = UIColor.gray.cgColor
                cell.eventsNameLbl.layer.borderWidth = 1
              
                cell.eventsNameLbl.backgroundColor = UIColor(red: 220.0/255.0, green: 220.0/255.0, blue: 220.0/255.0, alpha: 0.4)
                cell.eventsNameLbl.layer.cornerRadius = 8
                cell.selectionStyle = .none
                
                if createEventArr.count > indexPath.row{
                    
                    cell.eventsNameLbl.text = createEventArr[indexPath.row]
                    if selectedRef == cell.eventsNameLbl.text{
                        cell.eventsNameLbl.backgroundColor = UIColor(red: 13/255.0, green: 102/255.0, blue: 202/255.0, alpha: 1.0)
                        cell.eventsNameLbl.textColor = UIColor.white
                    }
                }else{
                    
                }
                for item in createEventArr{
                    if cell.eventsNameLbl.text == createEventArr.last{
                        let lastRowIndex = tableView.numberOfRows(inSection: tableView.numberOfSections-1)
                        if indexPath.row == lastRowIndex - 1{
                            // cell.eventsNameLbl.backgroundColor = UIColor.blue
                        }
                       
                    }
                }
                return cell
            }
        }
        return UITableViewCell()
    }
    var hiddenPaymentView = UIView()
    var contentView = UIView()
    var deviderLineView = UIView()
    var totalAmount = UIView()
    var paymentLabel = UILabel()
    var visaLabel = UILabel()
    let payButton = UIButton()
    let removeBtn = UIButton()
    let addEventTxtField = UITextField()
    
    @IBAction func createEventBtnTapped(_ sender: Any) {
        
        hiddenItemView.isHidden = true
        contentItemView.isHidden = true
        deviderLineItemView.isHidden = true
        totalItemAmount.isHidden = true
        paymentItemLabel.isHidden = true
        visaItemLabel.isHidden = true
        payItemButton.isHidden = true
        removeItemBtn .isHidden = true
        addItemTxtField.isHidden = true
        
        
         hiddenPaymentView.isHidden = false
         contentView.isHidden = false
         deviderLineView.isHidden = false
         totalAmount.isHidden = false
         paymentLabel.isHidden = false
         visaLabel.isHidden = false
         payButton.isHidden = false
         removeBtn.isHidden = false
         addEventTxtField.isHidden = false
        
        
        hiddenView.isHidden = false
       // editView.isHidden=false
        hiddenView.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
        hiddenPaymentView.frame = CGRect(x:10, y:UIScreen.main.bounds.height/2-(350)/2-25, width:UIScreen.main.bounds.width-20,height: 200)
        hiddenPaymentView.backgroundColor = UIColor.clear
        contentView.frame = CGRect(x:20, y:UIScreen.main.bounds.height/2-(350)/2, width:UIScreen.main.bounds.width-40, height:150)
        contentView.backgroundColor = UIColor.yellow
        contentView.layer.cornerRadius = 7
        contentView.layer.borderWidth = 1
        
        deviderLineView.frame = CGRect(x:5, y:35, width:contentView.bounds.width-10,height: 1)
       
        contentView.backgroundColor = UIColor.white
        
        
        totalAmount.frame = CGRect(x:20, y:UIScreen.main.bounds.height/2-(320)/2, width:UIScreen.main.bounds.width-40, height:40)
        totalAmount.backgroundColor = UIColor.yellow
       
        totalAmount.layer.borderWidth = 1
       
        totalAmount.backgroundColor = UIColor.gray.withAlphaComponent(0.1)
        
        
        paymentLabel.frame = CGRect(x:10, y:5,width:totalAmount.frame.width-50,height: 25)
        paymentLabel.numberOfLines = 0
         paymentLabel.text = "Select Event"
        paymentLabel.textAlignment = NSTextAlignment.left
        paymentLabel.textColor = UIColor(red: 21.0/255.0, green: 162.0/255.0, blue: 198.0/255.0, alpha: 1.0)
        paymentLabel.backgroundColor = UIColor.clear
        
        addEventTxtField.frame = CGRect(x:20, y:90,width:totalAmount.frame.width-50,height: 25)
        addEventTxtField.placeholder = "Event name"
        addEventTxtField.textAlignment = NSTextAlignment.left
        addEventTxtField.textColor = UIColor(red: 21.0/255.0, green: 162.0/255.0, blue: 198.0/255.0, alpha: 1.0)
        addEventTxtField.delegate=self
        addEventTxtField.backgroundColor = UIColor.clear
        
        payButton.frame = CGRect(x:totalAmount.frame.width-120,y:130,width:80, height:25)
        payButton.setTitle("Submit", for: .normal)
        payButton.backgroundColor = UIColor(red: 21.0/255.0, green: 162.0/255.0, blue: 198.0/255.0, alpha: 1.0)
        payButton.tintColor = UIColor.white
        payButton.addTarget(self, action: #selector(ShoppingAssistantVC.submitBtn), for: UIControlEvents.touchUpInside)
        
        removeBtn.frame = CGRect(x:30,y:130,width:80, height:25)
        removeBtn.setTitle("Cancel", for: .normal)
        removeBtn.backgroundColor = UIColor(red: 21.0/255.0, green: 162.0/255.0, blue: 198.0/255.0, alpha: 1.0)
        removeBtn.tintColor = UIColor.white
        removeBtn.addTarget(self, action: #selector(ShoppingAssistantVC.cancelBtn), for: UIControlEvents.touchUpInside)
        

        totalAmount.addSubview(paymentLabel)
        totalAmount.addSubview(visaLabel)
       
        contentView.addSubview(deviderLineView)
       
        hiddenView.addSubview(contentView)
        hiddenPaymentView.addSubview(addEventTxtField)
        hiddenPaymentView.addSubview(payButton)
        hiddenPaymentView.addSubview(removeBtn)
        hiddenView.addSubview(totalAmount)
        hiddenView.addSubview(hiddenPaymentView)
        
    
        self.view.bringSubview(toFront: hiddenPaymentView)
        
    }
    var eventDic:[String:AnyObject]=[:]
    var totalEventDic:[[String:AnyObject]]=[]
    var dict:[String:[AnyObject]]=[:]
    var allKeys:[String]=[]
    var totalEventDic2:[[String:AnyObject]]=[]
    
    func submitItems(){
        
        let cell = addItemsTblView.cellForRow(at: IndexPath(row: 0, section: 1)) as! itemsNamesCell
        
        cell.itemsNameLbl.text = addItemTxtField.text
        
       
       // cell.itemsNameLbl.backgroundColor = UIColor.blue
        
    addItemsArr.append(addItemTxtField.text!)
        for data in addItemsArr{
        for item in createEventArr{
            
                if dict.count>0{
                for (key,val) in dict{
                    if selectedRef == key{
                        
                        dict[selectedRef]?.append(data as AnyObject)
                    }
                    else{
                        if !dict.keys.contains(selectedRef){
                       
                            dict[selectedRef] = [data as AnyObject]
                        }
                        
                    }
                }
                }else{
                    dict[selectedRef] = [data as AnyObject]
                   
                }
          
                
            }
            
        }
      
        print(dict)
        eventDic.removeAll()
        //dict.removeAll()
        hiddenItemView.removeFromSuperview()
        contentItemView.removeFromSuperview()
        totalItemAmount.removeFromSuperview()
        visaItemLabel.removeFromSuperview()
        payItemButton.removeFromSuperview()
        createEventTblView.isUserInteractionEnabled = true
        addItemsTblView.isUserInteractionEnabled = true
        hiddenView.isHidden = true
        createEventTblView.reloadData()
        addItemsTblView.reloadData()
        addItemsArr.removeAll()
        UserDefaults.standard.setValue(dict, forKey: "user_auth_token")
        print("\(UserDefaults.standard.value(forKey: "user_auth_token")!)")
    }
    func cancelItems(){
        
    }
    func submitBtn(){
     
        createEventArr.append(addEventTxtField.text!)
            for item in createEventArr{
                let intIndex = createEventArr.index(of: item)!
              
                selectedRef = addEventTxtField.text!
              
                    
                    if dict.count>0{
                        for (key,val) in dict{
                            if selectedRef == key{
                               
                            }
                            else{
                                if !dict.keys.contains(selectedRef){
                                  
                                }
                                
                            }
                        }
                    }else{
                        dict[selectedRef] = ["" as AnyObject]
                    }
                    
                    
                }
        
        selectedRef = addEventTxtField.text!
        hiddenPaymentView.removeFromSuperview()
        contentView.removeFromSuperview()
        totalAmount.removeFromSuperview()
        visaLabel.removeFromSuperview()
        payButton.removeFromSuperview()
        createEventTblView.isUserInteractionEnabled = true
        addItemsTblView.isUserInteractionEnabled = true
        hiddenView.isHidden = true
        createEventTblView.reloadData()
        addItemsTblView.reloadData()
        UserDefaults.standard.setValue(createEventArr, forKey: "user_auth_token1")
       // print("\(UserDefaults.standard.value(forKey: "user_auth_token")!)")
    }
   
    func createArr(){
        
    }
    func cancelBtn(){
        
    }
    var hiddenItemView = UIView()
    var contentItemView = UIView()
    var deviderLineItemView = UIView()
    var totalItemAmount = UIView()
    var paymentItemLabel = UILabel()
    var visaItemLabel = UILabel()
    let payItemButton = UIButton()
    let removeItemBtn = UIButton()
    let addItemTxtField = UITextField()
    @IBAction func addItemsBtnTapped(_ sender: Any) {
        
        hiddenPaymentView.isHidden = true
        contentView.isHidden = true
        deviderLineView.isHidden = true
        totalAmount.isHidden = true
        paymentLabel.isHidden = true
        visaLabel.isHidden = true
        payButton.isHidden = true
        removeBtn.isHidden = true
        addEventTxtField.isHidden = true
        
         hiddenItemView.isHidden = false
         contentItemView.isHidden = false
         deviderLineItemView.isHidden = false
         totalItemAmount.isHidden = false
         paymentItemLabel.isHidden = false
         visaItemLabel.isHidden = false
         payItemButton.isHidden = false
         removeItemBtn .isHidden = false
         addItemTxtField.isHidden = false
        
        
        hiddenView.isHidden = false
        // editView.isHidden=false
        hiddenView.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
        hiddenItemView.frame = CGRect(x:10, y:UIScreen.main.bounds.height/2-(350)/2-25, width:UIScreen.main.bounds.width-20,height: 200)
        hiddenItemView.backgroundColor = UIColor.clear
        contentItemView.frame = CGRect(x:20, y:UIScreen.main.bounds.height/2-(350)/2, width:UIScreen.main.bounds.width-40, height:150)
        contentItemView.backgroundColor = UIColor.yellow
        contentItemView.layer.cornerRadius = 7
        contentItemView.layer.borderWidth = 1
        
        deviderLineItemView.frame = CGRect(x:5, y:35, width:contentItemView.bounds.width-10,height: 1)
        
        contentItemView.backgroundColor = UIColor.white
        
        
        totalItemAmount.frame = CGRect(x:20, y:UIScreen.main.bounds.height/2-(320)/2, width:UIScreen.main.bounds.width-40, height:40)
        totalItemAmount.backgroundColor = UIColor.yellow
        
        totalItemAmount.layer.borderWidth = 1
        
        totalItemAmount.backgroundColor = UIColor.gray.withAlphaComponent(0.1)
        
        
        paymentItemLabel.frame = CGRect(x:10, y:5,width:totalItemAmount.frame.width-50,height: 25)
        paymentItemLabel.numberOfLines = 0
        paymentItemLabel.text = "Select item name"
        paymentItemLabel.textAlignment = NSTextAlignment.left
        paymentItemLabel.textColor = UIColor(red: 21.0/255.0, green: 162.0/255.0, blue: 198.0/255.0, alpha: 1.0)
        paymentItemLabel.backgroundColor = UIColor.clear
        
        addItemTxtField.frame = CGRect(x:20, y:90,width:totalItemAmount.frame.width-50,height: 25)
        addItemTxtField.placeholder = "Select Item"
        addItemTxtField.textAlignment = NSTextAlignment.left
        addItemTxtField.textColor = UIColor(red: 21.0/255.0, green: 162.0/255.0, blue: 198.0/255.0, alpha: 1.0)
        addItemTxtField.delegate=self
        addItemTxtField.backgroundColor = UIColor.clear
        
        payItemButton.frame = CGRect(x:totalItemAmount.frame.width-120,y:130,width:80, height:25)
        payItemButton.setTitle("Submit", for: .normal)
        payItemButton.backgroundColor = UIColor(red: 21.0/255.0, green: 162.0/255.0, blue: 198.0/255.0, alpha: 1.0)
        payItemButton.tintColor = UIColor.white
        payItemButton.addTarget(self, action: #selector(ShoppingAssistantVC.submitItems), for: UIControlEvents.touchUpInside)
        
        removeItemBtn.frame = CGRect(x:30,y:130,width:80, height:25)
        removeItemBtn.setTitle("Cancel", for: .normal)
        removeItemBtn.backgroundColor = UIColor(red: 21.0/255.0, green: 162.0/255.0, blue: 198.0/255.0, alpha: 1.0)
        removeItemBtn.tintColor = UIColor.white
        removeItemBtn.addTarget(self, action: #selector(ShoppingAssistantVC.cancelItems), for: UIControlEvents.touchUpInside)
        
        
        totalItemAmount.addSubview(paymentItemLabel)
       // totalAmount.addSubview(visaLabel)
        
        contentItemView.addSubview(deviderLineItemView)
        
        hiddenView.addSubview(contentItemView)
        hiddenItemView.addSubview(addItemTxtField)
        hiddenItemView.addSubview(payItemButton)
        hiddenItemView.addSubview(removeItemBtn)
        hiddenView.addSubview(totalItemAmount)
        hiddenView.addSubview(hiddenItemView)
        
        
        self.view.bringSubview(toFront: hiddenItemView)
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         if tableView == addItemsTblView{
            let indexPath = addItemsTblView.indexPathForSelectedRow //optional, to get from any UIButton for example
            
            let currentCell = addItemsTblView.cellForRow(at: indexPath!) as! itemsNamesCell
            
            print(currentCell.textLabel!.text)
       
        }
        if tableView == createEventTblView{
            let indexPath = createEventTblView.indexPathForSelectedRow //optional, to get from any UIButton for example
            
            let currentCell = createEventTblView.cellForRow(at: indexPath!) as! eventsNameCell
            if let ref = currentCell.eventsNameLbl!.text as? String{
                currentCell.eventsNameLbl.backgroundColor = UIColor(red: 13/256.0, green: 102/256.0, blue: 202/256.0, alpha: 1.0)
                currentCell.eventsNameLbl.textColor = UIColor.white
            selectedRef = ref
            print(currentCell.textLabel!.text)
            }
        }
        addItemsTblView.reloadData()
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        var cellToDeSelect = createEventTblView.cellForRow(at: indexPath) as! eventsNameCell
        cellToDeSelect.eventsNameLbl.backgroundColor = UIColor.white
        cellToDeSelect.eventsNameLbl.textColor = UIColor.black
    }
    func  textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
       // checkOutTableView.setContentOffset(CGPoint(x:0, y:0), animated: true)
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func searchAllStores(_ sender: Any) {
        
    }
    var loginUserId:String = ""
    @IBAction func searchNearBy(_ sender: Any) {
        if let result = UserDefaults.standard.value(forKey: "loginUserID") as? String{
            loginUserId = result as! String
            print(result)
        }
        dictparam["53"] = loginUserId as AnyObject
        dictparam["127.10"] = "001" as AnyObject
        dictparam["120.38"] = "30.7114" as AnyObject
        dictparam["120.39"] = "76.6908" as AnyObject
        dictparam["114.127"] = "Cake" as AnyObject
        
        
        myModel.addManager.searchFav("010400221", userinfo: dictparam, completionResponse: { ( response,  error) in
           print(response)
            
        })
        
    }
    var favParam:[String:AnyObject]=[:]
    @IBAction func searchFavBtn(_ sender: Any) {
        if let result = UserDefaults.standard.value(forKey: "loginUserID") as? String{
            loginUserId = result as! String
            print(result)
        }
        favParam["53"] = loginUserId as AnyObject
        favParam["127.10"] = "001" as AnyObject
        favParam["114.112"] = "12" as AnyObject
        myModel.addManager.searchNearby("010400228", userinfo: favParam, completionResponse: { ( response,  error) in
            
            print(response)
        })
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 44
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
