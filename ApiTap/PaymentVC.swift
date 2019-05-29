//
//  PaymentVC.swift
//  ApiTap
//
//  Created by AppZorro on 29/09/17.
//  Copyright © 2017 ApiTap. All rights reserved.
//

import UIKit


class paymentCell:UITableViewCell{
    @IBOutlet weak var fillInfotxtField: UITextField!
    @IBOutlet var infoLbl:UILabel!
    @IBOutlet var fillInfoLbl:UILabel!
}
class addressCell:UITableViewCell{
    
}
class PaymentVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    var pickersView = UIPickerView()
   var myModel = ModelManager()
    @IBOutlet weak var paymentTableView: UITableView!
    var infoArray:[String]=["First Name","Select Card","Card Holder name ","Card Number ","Exp. Date","CVC Code"]
    var pickOption = ["VISA", "American Express", "Master Card"]
    @IBOutlet weak var pickerView: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        paymentTableView.delegate=self
        paymentTableView.dataSource=self
        pickersView.delegate = self
        if let result = UserDefaults.standard.value(forKey: "loginUserID") as? String{
            loginUserId = result as! String
            print(result)
        }
        dictParam["53"] = loginUserId as AnyObject
        //getCard
        myModel.addManager.getPayment("010100017", userinfo: dictParam, completionResponse: { ( response,  error) in
            
            print(response)
            self.getAddressArray = response as! [[String : AnyObject]]
            for item in self.getAddressArray{
                if let add = item["AD"] as? [[String:AnyObject]]{
                    for itemAddress in add{
                        if let addressId = itemAddress["AD"] as? String{
                            self.addressId = addressId
                        }
                    }
                }
                
            }
        })
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section==0{
        return infoArray.count
        }else{
            return 1
        }
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if indexPath.section==0{
             let cell = paymentTableView.dequeueReusableCell(withIdentifier: "paymentCell") as! paymentCell
        cell.infoLbl.text = infoArray[indexPath.row]
        if indexPath.row == 0{
            cell.fillInfotxtField.placeholder = "First Name"
            cell.fillInfotxtField.tag = 101
            cell.fillInfotxtField.delegate = self
            cell.fillInfotxtField.text = houseno
            
        }
        if indexPath.row == 1{
            cell.fillInfotxtField.placeholder = "Select Card"
            cell.fillInfotxtField.tag = 102
            cell.fillInfotxtField.delegate = self
            cell.fillInfotxtField.inputView = pickersView
            cell.fillInfotxtField.text = setText
        }
        if indexPath.row == 2{
            cell.fillInfotxtField.placeholder = "Card Holder name"
            cell.fillInfotxtField.tag = 103
            cell.fillInfotxtField.delegate = self
            cell.fillInfotxtField.text = cityName
        }
        if indexPath.row == 3{
            cell.fillInfotxtField.placeholder = "Card Number"
            cell.fillInfotxtField.tag = 104
            cell.fillInfotxtField.delegate = self
        }
        if indexPath.row == 4{
            cell.fillInfotxtField.placeholder = "Exp. Date"
            cell.fillInfotxtField.tag = 105
        }
          if indexPath.row == 5{
                cell.fillInfotxtField.placeholder = "CVC Code"
                cell.fillInfotxtField.tag = 106
            }
        
        return cell
        }
        else{
            let cell = paymentTableView.dequeueReusableCell(withIdentifier: "addressCell") as! addressCell
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section==0{
            return 80
        }else{
            return 300
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 101{
            paymentTableView.setContentOffset(CGPoint(x:0, y:0), animated: true)
        }
        if textField.tag == 102{
           paymentTableView.setContentOffset(CGPoint(x:0, y:textField.center.y-10), animated: true)
        }
        if textField.tag == 103{
            paymentTableView.setContentOffset(CGPoint(x:0, y:textField.center.y-40), animated: true)
        }
        if textField.tag == 104{
            paymentTableView.setContentOffset(CGPoint(x:0, y:textField.center.y-60), animated: true)
        }
        if textField.tag == 105{
            paymentTableView.setContentOffset(CGPoint(x:0, y:textField.center.y-90), animated: true)
        }
        if textField.tag == 106{
            paymentTableView.setContentOffset(CGPoint(x:0, y:textField.center.y-120), animated: true)
        }
        
        if textField.tag == 501{
            paymentTableView.setContentOffset(CGPoint(x:0, y:textField.center.y-180), animated: true)
        }
        if textField.tag == 502{
            paymentTableView.setContentOffset(CGPoint(x:0, y:textField.center.y-210), animated: true)
        }
        if textField.tag == 503{
            paymentTableView.setContentOffset(CGPoint(x:0, y:textField.center.y-250), animated: true)
        }
    }
    func  textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        paymentTableView.setContentOffset(CGPoint(x:0, y:0), animated: true)
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    var dictParam:[String:AnyObject]=[:]
    var getAddressArray:[[String:AnyObject]]=[]
    var loginUserId:String = ""
     var addressId:String = ""
    var houseno:String = ""
    var sector:String=""
    var cityName:String=""
    @IBAction func submitBtnTapped(_ sender: Any) {
     
        if let result = UserDefaults.standard.value(forKey: "loginUserID") as? String{
            loginUserId = result as! String
            print(result)
        }
        dictParam["53"] = loginUserId as AnyObject
         myModel.addManager.getPayment("010100055", userinfo: dictParam, completionResponse: { ( response,  error) in
            
            print(response)
            self.getAddressArray = response as! [[String : AnyObject]]
            for item in self.getAddressArray{
                if let add = item["RESULT"] as? [[String:AnyObject]]{
                    for itemAddress in add{
                        if let addressId = itemAddress["AD"] as? String{
                              self.addressId = addressId
                        }
                        if let houseno = itemAddress["_114_53"] as? String{
                            self.houseno = houseno
                        }
                        if let sector = itemAddress["_114_12"] as? String{
                            self.sector = sector
                        }
                        if let cityName = itemAddress["_114_13"] as? String{
                            self.cityName = cityName
                        }
                    }
                }
                
            }
        })
    }
    var setText:String=""
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickOption.count
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickOption[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        setText = pickOption[row]
        paymentTableView.reloadData()
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
