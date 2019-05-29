//
//  ChatViewController.swift
//  ApiTap
//
//  Created by appzorro on 3/12/18.
//  Copyright © 2018 ApiTap. All rights reserved.
//

import UIKit

class chatCell:UITableViewCell{
    
    @IBOutlet var msgCell: UILabel!
}
class ChatViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate ,UITextViewDelegate{
let maxCharacter = 400
    var chatDict:[String:AnyObject]=[:]
    @IBOutlet var dateLbl: UILabel!
    @IBOutlet var chatTextView: UITextView!
    @IBOutlet var chatTblView: UITableView!
    var dictparam:[String:AnyObject]=[:]
    var loginUserId:String = ""
    var myModel = ModelManager()
    var idParam:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
       getAllChats()
        self.initializeNavBar()
        self.setBarBtnItems()
       // dateLbl.text = chatDict["date"] as! String
        chatTextView.layer.cornerRadius = 5.0
        chatTextView.layer.borderWidth = 1.0
        chatTextView.layer.borderColor = UIColor.blue.cgColor
        chatTextView.delegate = self
       // chatTextView.becomeFirstResponder()
        chatTextView.text = "Type here"
        chatTextView.textColor = UIColor.lightGray
        //for item in chatDict{
            if let str = chatDict["msg"] as? String{
                msgArray.append(str)
            }
        
        // Do any additional setup after loading the view.
    }
    func getAllChats(){
        if let result = UserDefaults.standard.value(forKey: "loginUserID") as? String{
            loginUserId = result as! String
            print(result)
        }
        if let id = chatDict["114.150"] as? String{
            idParam = id
        }
        var dict:[String:AnyObject]=[:]
        dict["114.9"] = "false" as AnyObject
        var dict2:NSMutableArray = []
        dict2 = [["53":loginUserId as AnyObject,"operator":"eq" as AnyObject],["120.16" : "92" as AnyObject,"operator":"eq" as AnyObject],["114.150" : idParam as AnyObject,"operator":"eq" as AnyObject]]
        
        myModel.addManager.getMsgReply("010100209", userinfo: dict,userinfo2: dict2  ,completionResponse: { ( response,  error) in
            
            print(response)
            if let res = response as? [[String : AnyObject]]{
                
                for item in res{
                    if var ratings = item["RESULT"] as? [[String:AnyObject]]{
                        for element in ratings{
                            if let idEleme = element["_120_157"] as? String{
                                let item = self.hexToStr(textValue: idEleme)
                                self.msgArray.append(item)
                            }
                        }
                        
                    }
                }
            }
            self.chatTblView.reloadData()
            
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func sendBtnTap(_ sender: Any) {
        if let result = UserDefaults.standard.value(forKey: "loginUserID") as? String{
            loginUserId = result as! String
            print(result)
        }
        //  let cell = mapTblView.cellForRow(at: IndexPath(row: 0, section: 1)) as! mapCell
        dictparam["53"] = loginUserId as AnyObject
        if var sentDta = chatDict["121.75"] as? String{
            if sentDta.characters.count == 1{
                sentDta = "0000000000" + sentDta
            }
            if sentDta.characters.count == 2{
                sentDta = "000000000" + sentDta
            }
            if sentDta.characters.count == 3{
                sentDta = "00000000" + sentDta
            }
            dictparam["121.75"] = sentDta as AnyObject
        }
        if var sentDta = chatDict["120.16"] as? String{
            if sentDta.characters.count == 1{
                sentDta = "0000000000" + sentDta
            }
            if sentDta.characters.count == 2{
                sentDta = "000000000" + sentDta
            }
            if sentDta.characters.count == 3{
                sentDta = "00000000" + sentDta
            }
            dictparam["120.16"] = sentDta as AnyObject
        }
        if var sentDta = chatDict["114.150"] as? String{
            if sentDta.characters.count == 1{
                sentDta = "0000000000" + sentDta
            }
            if sentDta.characters.count == 2{
                sentDta = "000000000" + sentDta
            }
            if sentDta.characters.count == 3{
                sentDta = "00000000" + sentDta
            }
            if sentDta.characters.count == 4{
                sentDta = "0000000" + sentDta
            }
            dictparam["114.150"] = sentDta as AnyObject
        }
        let data = chatTextView.text.data(using: .utf8)!
        let hexString = data.map{ String(format:"%02x", $0) }.joined()
        dictparam["120.157"] = hexString as AnyObject as AnyObject
        dictparam["122.128"] = chatDict["122.128"]
       // dictparam["114.150"] = chatDict["114.150"]
       // dictparam["120.16"] = chatDict["120.16"]
        dictparam["114.179"] = chatDict["114.179"]
        
       // dictparam["122.12"] = "Welcome" as AnyObject
         myModel.addManager.chatDetails("030300192", userinfo: dictparam, completionResponse: { ( response,  error) in
            
            print(response)
            self.getAllChats()
        })
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return msgArray.count
      }
    var msgArray:[String]=[]
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = chatTblView.dequeueReusableCell(withIdentifier: "chatCell") as! chatCell
   
         if chatDict.count > 0{
          //  msgArray.append(chatDict["msg"] as! String)
        cell.msgCell.text = msgArray[indexPath.row]
        }
        return cell
    }
    
    func textViewDidBeginEditing(_ textView: UITextView){
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
        animateViewMoving(up: true, moveValue: 250)
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.resignFirstResponder()
        msgArray.append(textView.text)
        animateViewMoving(up: false, moveValue: 250)
        
        chatTblView.reloadData()
    }
    
    
    
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
}

