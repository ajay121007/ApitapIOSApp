//
//  ShoppingAssistantCollectionVC.swift
//  ApiTap
//
//  Created by Ashish on 20/03/18.
//  Copyright © 2018 ApiTap. All rights reserved.
//

import UIKit
class collectionViewDataCell:UICollectionViewCell{
    
}

class ShoppingAssistantCollectionVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate {
    
    @IBOutlet weak var deleteListBtn: UIButton!
    @IBOutlet weak var editListTxtView: UITextView!
    @IBOutlet weak var editView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
     var selectedCell:Int = 0
    var selectedtableViewIndex:Int = -1
    var eventName:String = ""
    var itemName:String = ""
    var editListEventItem = ""
    var selectedIndex = -1
    var selectedItemIndex = -1
    var selectedRef:String = ""
    var eventItemArr:[String:[AnyObject]] = [:]
    var addEventArr:[String]=[]
    var addItemsArr:[String]=[]
    var editSelectedIndexval:Int = -1
     var isSelect:Bool = false
    let cellSpacing:CGFloat = 0.7
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.initializeNavBar()
       // self.setbarButtonItems()
        editView.layer.cornerRadius = 5
        deleteListBtn.layer.cornerRadius = 5
        let screenSize = UIScreen.main.bounds.size
        let cellWidth = floor(screenSize.width * cellSpacing)
        let cellHeight = floor(screenSize.height * cellSpacing)

        let insetX = (view.bounds.width - cellWidth) / 2.0
        let insetY = (view.bounds.width - cellHeight) / 2.0

        let layout = collectionView!.collectionViewLayout as! UICollectionViewFlowLayout

      //   layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
           //collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 75)
        //collectionView?.contentInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)
        
        if   let getUserDict:[String:[AnyObject]] = UserDefaults.standard.object(forKey: "user_auth_token") as? [String:[AnyObject]]{
            eventItemArr = getUserDict
        }
        if   let getUserDict2:[String] = UserDefaults.standard.object(forKey: "user_auth_token1") as? [String]{
            addEventArr = getUserDict2
        }
        if selectedRef == ""{
            if eventItemArr.count>0{
                for itemEle in eventItemArr{
                    if let str = itemEle.key as? String{
                        selectedRef = str
                    }
                }
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func selectEventBtnTap(_ sender: UIButton) {
        
        let i =  Int(sender.tag)
        
        selectedItemIndex = i
        
        collectionView.reloadData()
        
    }
    var elementKey:String = ""
    @IBAction func addEventBtnTap(_ sender: UIButton) {
        
        if sender.tag == 0{
            if eventName == ""{
                alert(msg: "please saved any event")
            }else{
                let cell = collectionView.cellForItem(at: IndexPath(row: 0, section: 0)) as! ShoppingAssistantCollectionViewCell
                
                cell.addEventTxtView.text = ""
                addEventArr.append(eventName)
                UserDefaults.standard.setValue(addEventArr, forKey: "user_auth_token1")
            }
        }
        if sender.tag == 1{
            if itemName == ""{
                alert(msg: "please saved any list")
            }else{
                
                let cell = collectionView.cellForItem(at: IndexPath(row: 1, section: 0)) as! ShoppingAssistantCollectionViewCell
                
                cell.addEventTxtView.text = ""
                addItemsArr.append(itemName)
                
                if eventItemArr.count>0{
                    for (key,val) in eventItemArr{
                        if eventItemArr.keys.contains(selectedRef){
                            for item in eventItemArr{
                                if item.key == selectedRef{
                                    let values:[String] = item.value as! [String]
                                    if !values.contains(itemName){
                                        eventItemArr[selectedRef]?.append(itemName as AnyObject)
                                    }
                                }
                            }
                            
                            // itemName = ""
                        }else{
                            if eventItemArr[selectedRef] == nil{
                                eventItemArr[selectedRef] = [itemName as AnyObject]
                            }else{
                                eventItemArr[selectedRef]?.append(itemName as AnyObject)
                            }
                        }
                        
                    }
                }else{
                    eventItemArr[elementKey] = [itemName as AnyObject]
                }
                
                UserDefaults.standard.setValue(eventItemArr, forKey: "user_auth_token")
            }
        }
        
        collectionView.reloadData()
    }
    @IBAction func backToArrowBtnTap(_ sender: UIButton) {
        selectedCell = 0
        let cell = collectionView.cellForItem(at: IndexPath(row: 0, section: 0)) as! ShoppingAssistantCollectionViewCell
        cell.backToArrow.isHidden = true
        let visibleItems: NSArray = self.collectionView.indexPathsForVisibleItems as NSArray
        let currentItem: IndexPath = visibleItems.object(at: 0) as! IndexPath
        let nextItem: IndexPath = IndexPath(item: currentItem.item - 1, section: 0)
        // This part here
        //if nextItem.row < storedLocationsData.count {
        self.collectionView.scrollToItem(at: nextItem, at: .left, animated: true)
    }
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         if addEventArr.count>0{
                     return 2
               }else{
                    return 1
              }
    }
    @IBAction func moveArrowBtnTap(_ sender: UIButton) {
        let i =  Int(sender.tag)
        
        selectedIndex = i
        let cell = collectionView.cellForItem(at: IndexPath(row: 0, section: 0)) as! ShoppingAssistantCollectionViewCell
        //  let cell2 = cell.shoppingAssistantTblView.cellForRow(at: IndexPath(row: 0, section: 0)) as! shoppingAssistanceTableViewCell
        selectedCell = 1
        selectedRef = addEventArr[sender.tag]
        
        elementKey = addEventArr[sender.tag]
        
        cell.backToArrow.isHidden = false
        let visibleItems: NSArray = self.collectionView.indexPathsForVisibleItems as NSArray
        let currentItem: IndexPath = visibleItems.object(at: 0) as! IndexPath
        let nextItem: IndexPath = IndexPath(item: currentItem.item + 1, section: 0)
        // This part here
        //if nextItem.row < storedLocationsData.count {
        self.collectionView.scrollToItem(at: nextItem, at: .left, animated: true)
        
        //}
        collectionView.reloadData()
        
    }
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShoppingAssistantCollectionViewCell", for: indexPath) as! ShoppingAssistantCollectionViewCell
        
        
        //cell.tableView.tag = indexPath.row
        cell.addEventBtn.tag = indexPath.row
        cell.addEventTxtView.tag = indexPath.row
        if indexPath.row == 0{
            cell.backToArrow.isHidden = false
        }
        if indexPath.row == 1{
            if addEventArr.count>0{
                if selectedIndex >= 0{
                let eventList = addEventArr[selectedIndex]
                cell.listLbl.text = eventList
                cell.backToArrow.isHidden = true
                }
            }
        }
        if addEventArr.count>0{
           // cell.tableView.isHidden = false
            cell.alertView.isHidden = true
        }else{
           // cell.tableView.isHidden = true
            cell.alertView.isHidden = false
        }
      
        ////cell.tableView.reloadData()
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView.tag == 0{
            return addEventArr.count
        }else{
            if eventItemArr.count>0{
                for (key,var val) in eventItemArr{
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
                return 0
            }
            // return addItemsArr.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
           
        if tableView.tag == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingAssistanceTableViewCell") as! shoppingAssistanceTableViewCell
            cell.selectEventBtn.tag = indexPath.row
            cell.moveArrowBtn.tag = indexPath.row
            cell.selectionStyle = .none
            cell.moveArrowBtn.isHidden=false
            eventName = ""
            itemName = ""
            if (selectedIndex == indexPath.row) {
                
                cell.moveArrowBtn.isSelected = true
                //cell.violenceBtnSelect.setImage(UIImage(named: "radio-selected"),for:UIControlState.normal)
            } else {
                cell.moveArrowBtn.isSelected = false
                //cell.violenceBtnSelect.setImage(UIImage(named: "radio-unselected"),for:UIControlState.normal)
            }
            
            if(cell.moveArrowBtn.isSelected){
                cell.selectEventBtn.setImage(UIImage(named: "radio-selected"),for:UIControlState.normal)
                isSelect=true
            }
            else{
                cell.selectEventBtn.setImage(UIImage(named: "unselected"),for:UIControlState.normal)
            }
            if addEventArr.count>0{
                
                cell.eventNameLbl.text = addEventArr[indexPath.row]
            }
            return cell
        }
        if tableView.tag == 1{
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "shoppingAssistanceTableViewCell2") as! shoppingAssistanceTableViewCell2
            cell2.selectEventBtn.tag = indexPath.row
            cell2.moveArrowBtn.isHidden=true
            cell2.selectionStyle = .none
            if (selectedItemIndex == indexPath.row) {
                
                cell2.moveArrowBtn.isSelected = true
                //cell.violenceBtnSelect.setImage(UIImage(named: "radio-selected"),for:UIControlState.normal)
            } else {
                cell2.moveArrowBtn.isSelected = false
                //cell.violenceBtnSelect.setImage(UIImage(named: "radio-unselected"),for:UIControlState.normal)
            }
            
            if(cell2.moveArrowBtn.isSelected){
                cell2.selectEventBtn.setImage(UIImage(named: "radio-selected"),for:UIControlState.normal)
                isSelect=true
            }
            else{
                cell2.selectEventBtn.setImage(UIImage(named: "unselected"),for:UIControlState.normal)
            }
            if eventItemArr.count>0{
                for (key,val) in eventItemArr{
                    if selectedRef != ""{
                        if selectedRef == key{
                            var val2:[String] = val as! [String]
                            // val2 = Array(Set(val2))
                            val2 = val2.filter { $0 != ""
                            }
                            
                            if val2.count>indexPath.row{
                                if let str = val2[indexPath.row] as? String{
                                    if str != ""{
                                        cell2.eventNameLbl.text = str
                                    }
                                }
                                
                            }
                        }
                            
                        else{
                            
                        }
                        
                    }
                        
                    else{
                        
                        for (key,val) in eventItemArr{
                            
                            if selectedRef == key{
                                var val2:[String] = val as! [String]
                                val2 = Array(Set(val2))
                                val2 = val2.filter { $0 != ""
                                }
                                
                                if val2.count>indexPath.row{
                                    if let str = val2[indexPath.row] as? String{
                                        if str != ""{
                                            cell2.eventNameLbl.text = str
                                        }
                                    }
                                    
                                }
                                
                            }
                        }
                        
                        
                    }
                }
                
            }
            return cell2
        }
        return UITableViewCell()
            
       
    }
    
    @IBAction func hideEditViewBtnTap(_ sender: UIButton) {
        editView.isHidden = true
    }
    func switchKey<T, U>(_ myDict: inout [T:U], fromKey: T, toKey: T) {
        if let entry = myDict.removeValue(forKey: fromKey) {
            myDict[toKey] = entry
        }
    }
    @IBAction func addListBtnTap(_ sender: UIButton) {
        if selectedtableViewIndex == 1{
            if editListEventItem == ""{
                alert(msg: "Please enter any event to edit")
            }else{
                let eventName = addEventArr[editSelectedIndexval]
                switchKey(&eventItemArr, fromKey: eventName, toKey: editListEventItem)
                //            for var item in eventItemArr{
                //                print(item.key)
                //
                //                eventItemArr[editSelectedIndexval].key = editListEventItem
                ////                if addEventArr[editSelectedIndexval] == item.key{
                ////
                ////                    item.key = editListEventItem
                ////                }
                //            }
                print(eventItemArr)
                addEventArr[editSelectedIndexval] = editListEventItem
                UserDefaults.standard.setValue(addEventArr, forKey: "user_auth_token1")
                UserDefaults.standard.setValue(eventItemArr, forKey: "user_auth_token")
            }
        }
        if selectedtableViewIndex == 2{
            //for (index,item) in
            if editListEventItem == ""{
                alert(msg: "Please enter any saved list to edit")
            }else{
                let eventName = Array(eventItemArr.keys)[selectedIndex]
                var eventVal = Array(eventItemArr.values)[selectedIndex]
                print(eventName)
                print(eventVal)
                eventVal[editSelectedIndexval] = editListEventItem as AnyObject
                print(eventVal)
                
                eventItemArr.updateValue(eventVal, forKey: eventName)
                //switchKey(&eventItemArr, fromKey: eventName, toKey: editListEventItem)
                
                print(eventItemArr)
                //  addEventArr[editSelectedIndexval] = editListEventItem
                
                UserDefaults.standard.setValue(addEventArr, forKey: "user_auth_token1")
                UserDefaults.standard.setValue(eventItemArr, forKey: "user_auth_token")
            }
        }
        editView.isHidden = true
        collectionView.reloadData()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        if tableView.tag == 0{
            let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! shoppingAssistanceTableViewCell
            cell.selectionStyle = .none
            editSelectedIndexval = indexPath.row
            selectedtableViewIndex = 1
            editListTxtView.text = ""
            editView.isHidden = false
        }
        if tableView.tag == 1{
            let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! shoppingAssistanceTableViewCell2
            cell.selectionStyle = .none
            editSelectedIndexval = indexPath.row
            selectedtableViewIndex = 2
            editListTxtView.text = ""
            editView.isHidden = false
        }
    }
    func alert(msg:String){
        let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func textViewDidChange(_ textView: UITextView){
         if textView == editListTxtView{
            editListEventItem = textView.text
        }
        if textView.tag == 0{
            eventName = textView.text
        }
        if textView.tag == 1{
            itemName = textView.text
        }
    }

    func textViewDidBeginEditing(_ textView: UITextView){
        if textView == editListTxtView{
            if textView.textColor == UIColor.lightGray {
                textView.text = nil
                textView.textColor = UIColor.black
            }
            animateViewMoving(up: true, moveValue: 50)
        }else{
            if textView.textColor == UIColor.lightGray {
                textView.text = nil
                textView.textColor = UIColor.black
            }
            animateViewMoving(up: true, moveValue: 250)
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.resignFirstResponder()
        if textView == editListTxtView{
            editListEventItem = textView.text
            animateViewMoving(up: false, moveValue: 50)
        }else{
            if textView.tag == 0{
                eventName = textView.text
            }
            if textView.tag == 1{
                itemName = textView.text
            }
            animateViewMoving(up: false, moveValue: 250)
        }
        
        
    }
    
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let cellsAcross: CGFloat = 3
        let spaceBetweenCells: CGFloat = 1
        let dim = (collectionView.bounds.width - (cellsAcross - 1) * spaceBetweenCells) / cellsAcross
        print(collectionView.frame.size.height)
        return CGSize(width:  collectionView.frame.size.width-110, height: collectionView.frame.size.height - 80)
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
    let maxCharacter = 400
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
