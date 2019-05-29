//
//  ShoppingAssistantCollectionViewController.swift
//  iCaraousal
//
//  Created by appzorro on 3/13/18.
//  Copyright © 2018 appzorro. All rights reserved.
//

import UIKit

extension UIScreen {
    
    enum SizeType: CGFloat {
        case Unknown = 0.0
        case iPhone4 = 960.0
        case iPhone5 = 1136.0
        case iPhone6 = 1334.0
        case iPhone6Plus = 1920.0
    }
    
    var sizeType: SizeType {
        let height = nativeBounds.height
        guard let sizeType = SizeType(rawValue: height) else { return .Unknown }
        return sizeType
    }
}

class shoppingAssistanceTableViewCell:UITableViewCell{
    @IBOutlet var eventNameLbl:UILabel!
    @IBOutlet var moveArrowBtn: UIButton!
    @IBOutlet weak var selectEventBtn: UIButton!
}
class shoppingAssistanceTableViewCell2:UITableViewCell{
    @IBOutlet var eventNameLbl:UILabel!
    @IBOutlet var moveArrowBtn: UIButton!
    @IBOutlet weak var selectEventBtn: UIButton!
}


class ShoppingAssistantCollectionViewController: BaseViewController,UITextViewDelegate {
    
    @IBOutlet weak var storesView: UIView!
    // var myModel = ModelManager()
    @IBOutlet weak var deleteListBtn: UIButton!
    @IBOutlet weak var editListTxtView: UITextView!
    @IBOutlet weak var editView: UIView!
    var editSelectedIndexval:Int = -1
    var selectedIndex = -1
    var selectedItemIndex = -1
    var isSelect:Bool = false
    var selectedCell:Int = 0
    @IBOutlet var collectionView:UICollectionView!
    let cellSpacing:CGFloat = 0.6
    var selectedRef:String = ""
    var eventItemArr:[String:[AnyObject]] = [:]
    var rowsWhichAreChecked = [IndexPath]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.translatesAutoresizingMaskIntoConstraints = true
        self.collectionView.translatesAutoresizingMaskIntoConstraints = true
        self.initializeNavBar()
        self.setbarButtonItems()
        editView.layer.cornerRadius = 5
        deleteListBtn.layer.cornerRadius = 5
        //        let screenSize = UIScreen.main.bounds.size
        //        let cellWidth = floor(screenSize.width * cellSpacing)
        //        let cellHeight = floor(screenSize.height * cellSpacing)
        //
        //        let insetX = (view.bounds.width - cellWidth) / 2.0
        //        let insetY = (view.bounds.width - cellHeight) / 2.0
        //
        //        let layout = collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
        //
        //        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        //        //   collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 75)
        //        collectionView?.contentInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)
        
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
                       // selectedRef = str
                    }
                }
            }
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelBtnTap(_ sender: Any) {
        editView.isHidden = true
    }
    var selectedtableViewIndex:Int = -1
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
                // eventItemArr[editSelectedIndexval]
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
    
    @IBAction func selectEventBtnTap(_ sender: UIButton) {
        
        let i =  Int(sender.tag)
        
        selectedItemIndex = i
        
        collectionView.reloadData()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    var addEventArr:[String]=[]
    var addItemsArr:[String]=[]
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
    var eventName:String = ""
    var itemName:String = ""
    var editListEventItem = ""
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
    
    @IBAction func backToArrowBtnTap(_ sender: UIButton) {
        selectedCell = 0
        selectedRef = ""
        let cell = collectionView.cellForItem(at: IndexPath(row: 0, section: 0)) as! ShoppingAssistantCollectionViewCell
        let cell2 = cell.shoppingAssistantTblView.cellForRow(at: IndexPath(row: 0, section: 0)) as! shoppingAssistanceTableViewCell
          let cell3 = collectionView.cellForItem(at: IndexPath(row: 1, section: 0)) as! ShoppingAssistantCollectionViewCell
        cell3.addNewView.isHidden = true
        cell3.shoppingAssistantTblView.isHidden = true
        cell.shoppingAssistantTblView.isHidden = false
        cell.addNewView.isHidden = false
        cell2.moveArrowBtn.isHidden = false
        cell.backToArrow.isHidden = true
        let visibleItems: NSArray = self.collectionView.indexPathsForVisibleItems as NSArray
        let currentItem: IndexPath = visibleItems.object(at: 0) as! IndexPath
        if currentItem.row == 1{
            let nextItem: IndexPath = IndexPath(item: currentItem.item - 1, section: 0)
            self.collectionView.scrollToItem(at: nextItem, at: .left, animated: true)
        }
        collectionView.reloadData()
        // This part here
        //if nextItem.row < storedLocationsData.count {
        
    }
    var elementKey:String = ""
    var moveFlag:Bool = false
    @IBAction func moveArrowBtnTap(_ sender: UIButton) {
        let i =  Int(sender.tag)
        moveFlag = true
        selectedIndex = i
        let cell = collectionView.cellForItem(at: IndexPath(row: 0, section: 0)) as! ShoppingAssistantCollectionViewCell
        let cell3 = collectionView.cellForItem(at: IndexPath(row: 1, section: 0)) as! ShoppingAssistantCollectionViewCell

         let cell2 = cell.shoppingAssistantTblView.cellForRow(at: IndexPath(row: 0, section: 0)) as! shoppingAssistanceTableViewCell
         cell3.addNewView.isHidden = false
        cell3.shoppingAssistantTblView.isHidden = false
        cell2.moveArrowBtn.isHidden = true
        cell.shoppingAssistantTblView.isHidden = true
        cell.addNewView.isHidden = true
        //  let cell2 = cell.shoppingAssistantTblView.cellForRow(at: IndexPath(row: 0, section: 0)) as! shoppingAssistanceTableViewCell
        selectedCell = 1
        selectedRef =  Array(eventItemArr.keys)[sender.tag]
        elementKey = Array(eventItemArr.keys)[sender.tag]
        // selectedRef = addEventArr[sender.tag]
        
        //elementKey = addEventArr[sender.tag]
        
        cell.backToArrow.isHidden = false
        let visibleItems: NSArray = self.collectionView.indexPathsForVisibleItems as NSArray
        let currentItem: IndexPath = visibleItems.object(at: 0) as! IndexPath
        var nextItem: IndexPath = IndexPath(item: currentItem.item + 1, section: 0)
        nextItem = IndexPath(row: 1, section: 0)
        // This part here
        //if nextItem.row < storedLocationsData.count {
        self.collectionView.scrollToItem(at: nextItem, at: .left, animated: true)
        
        //}
       collectionView.reloadData()
        
    }
    
    @IBAction func searchStore(_ sender: Any) {
        alert(msg: "Functionality is in progress")
    }
    @IBAction func nearByBtnTap(_ sender: Any) {
        alert(msg: "Functionality is in progress")
    }
    @IBAction func favStoreBtnTap(_ sender: Any) {
        alert(msg: "Functionality is in progress")
    }
    func alert(msg:String){
        let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func addEventBtnTap(_ sender: UIButton) {
        
        if sender.tag == 0{
            if eventName == ""{
                alert(msg: "please saved any event")
            }else{
                let cell = collectionView.cellForItem(at: IndexPath(row: 0, section: 0)) as! ShoppingAssistantCollectionViewCell
                
                cell.addEventTxtView.text = ""
                if eventItemArr.keys.contains(eventName){
                    alert(msg: "event allready exist")
                }else{
                    eventItemArr[eventName]=["" as AnyObject]
                }
                //addEventArr.append(eventName)
                UserDefaults.standard.setValue(eventItemArr, forKey: "user_auth_token")
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
    
    @IBAction func deleteList(_ sender: UIButton) {
        if selectedtableViewIndex == 1{
            let item = Array(eventItemArr)[editSelectedIndexval].key
            //  let eventName = addEventArr[editSelectedIndexval]
            //  addEventArr.remove(at: editSelectedIndexval)
            if let idx = eventItemArr.index(forKey: item) {
                eventItemArr.remove(at: idx)
                print(eventItemArr) // ["baz": 3, "foo": 1]
                UserDefaults.standard.setValue(addEventArr, forKey: "user_auth_token1")
                UserDefaults.standard.setValue(eventItemArr, forKey: "user_auth_token")
            }
        }
        if selectedtableViewIndex == 2{
            let eventName = Array(eventItemArr.keys)[selectedIndex]
            var eventVal = Array(eventItemArr.values)[selectedIndex]
            print(eventName)
            print(eventVal)
            eventVal.remove(at: editSelectedIndexval)
            
            eventItemArr.updateValue(eventVal, forKey: eventName)
            
            //UserDefaults.standard.setValue(addEventArr, forKey: "user_auth_token1")
            UserDefaults.standard.setValue(eventItemArr, forKey: "user_auth_token")
        }
        collectionView.reloadData()
        editView.isHidden = true
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
    
    @IBAction func hideEditViewBtnTap(_ sender: UIButton) {
        editView.isHidden = true
    }
    var dictparam:[String:AnyObject]=[:]
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
        
        
        //        myModel.addManager.searchFav("010400221", userinfo: dictparam, completionResponse: { ( response,  error) in
        //            print(response)
        //
        //        })
        
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
        //        myModel.addManager.searchNearby("010400228", userinfo: favParam, completionResponse: { ( response,  error) in
        //
        //            print(response)
        //        })
    }
    func handleLongPress(longPressGestureRecognizer: UILongPressGestureRecognizer){
        
        let cell = collectionView.cellForItem(at: IndexPath(row: 0, section: 0)) as! ShoppingAssistantCollectionViewCell
        let cell2 = collectionView.cellForItem(at: IndexPath(row: 1, section: 0)) as! ShoppingAssistantCollectionViewCell
        if cell.shoppingAssistantTblView.tag == 0{
            if longPressGestureRecognizer.state == UIGestureRecognizerState.began {
                let touchPoint = longPressGestureRecognizer.location(in: cell.shoppingAssistantTblView)
                if let indexPath = cell.shoppingAssistantTblView.indexPathForRow(at: touchPoint) {
                    print(indexPath)
                    //  cell.selectionStyle = .none
                    editSelectedIndexval = indexPath.row
                    selectedtableViewIndex = 1
                    editListTxtView.text = ""
                    editView.isHidden = false
                    // your code here, get the row for the indexPath or do whatever you want
                }
            }
        }
        if cell2.shoppingAssistantTblView.tag == 1{
            if longPressGestureRecognizer.state == UIGestureRecognizerState.began {
                let touchPoint = longPressGestureRecognizer.location(in: cell2.shoppingAssistantTblView)
                if let indexPath = cell2.shoppingAssistantTblView.indexPathForRow(at: touchPoint) {
                    print(indexPath)
                    //  cell.selectionStyle = .none
                    editSelectedIndexval = indexPath.row
                    selectedtableViewIndex = 2
                    editListTxtView.text = ""
                    editView.isHidden = false
                    // your code here, get the row for the indexPath or do whatever you want
                }
            }
        }
    }
    //}
    
    //extension ShoppingAssistantCollectionViewController:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if eventItemArr.count>0{
            return 2
        }else{
            return 1
        }
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShoppingAssistantCollectionViewCell", for: indexPath) as! ShoppingAssistantCollectionViewCell
        //  collectionView.contentInset = .zero
        self.automaticallyAdjustsScrollViewInsets = false
        
        // cell.selectionStyle = .none
        if UIScreen.main.sizeType == .iPhone5 {
            
            
            let screenSize = UIScreen.main.bounds.size
            let cellWidth = floor(screenSize.width * cellSpacing)
            let cellHeight = floor(screenSize.height * cellSpacing)
            
            let insetX = (view.bounds.width - cellWidth) / 2.0
            let insetY = (view.bounds.width - cellHeight) / 2.0
            
            let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            
            layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
            //   collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 75)
            collectionView.contentInset = UIEdgeInsets(top: -80, left: insetX, bottom: insetY, right: insetX)
            
            
            cell.savedListView.translatesAutoresizingMaskIntoConstraints = true
            cell.savedListView.frame = CGRect(x: 0, y: 0, width: 200, height: 40)
            //            cell.shoppingAssistantTblView.contentInset = .zero
            //           let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            //           layout.itemSize = CGSize(width: 200, height: 360)
            //            cell.alertView.frame = CGRect(x: 0, y: 30, width: collectionView.frame.width, height: 20)
            cell.shoppingAssistantTblView.translatesAutoresizingMaskIntoConstraints = true
            cell.shoppingAssistantTblView.frame = CGRect(x: 0, y: 40, width: 200, height: 270)
            cell.addNewView.translatesAutoresizingMaskIntoConstraints = true
            cell.addNewView.frame = CGRect(x: 0, y: 310, width: 200, height: 30)
            storesView.translatesAutoresizingMaskIntoConstraints = true
            storesView.frame = CGRect(x: 0, y: 510, width: storesView.frame.width, height: 60)
            // Make specific layout for small devices.
        }
        // collectionView.contentInset = UIEdgeInsetsMake(-40, 0, 0, 0)
        //        if UIScreen.main.sizeType == .iPhone5 {
        //           // let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        //         //   layout.itemSize = CGSize(width: 260, height: collectionView.frame.height-120)
        //            collectionView.translatesAutoresizingMaskIntoConstraints = true
        //            collectionView.frame = CGRect(x: 0, y: 140, width: collectionView.frame.width, height: 380)
        //            cell.alertView.frame = CGRect(x: 0, y: 30, width: collectionView.frame.width, height: 20)
        //            cell.shoppingAssistantTblView.translatesAutoresizingMaskIntoConstraints = true
        //            cell.shoppingAssistantTblView.frame = CGRect(x: 0, y: 80, width: collectionView.frame.width, height: 350)
        //            // Make specific layout for small devices.
        //        }
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(ShoppingAssistantCollectionViewController.handleLongPress))
        cell.shoppingAssistantTblView.addGestureRecognizer(longPress)
        cell.shoppingAssistantTblView.tag = indexPath.row
        cell.addEventBtn.tag = indexPath.row
        cell.addEventTxtView.tag = indexPath.row
        //        if cell.shoppingAssistantTblView.tag == 0{
        //            cell.backToArrow.isUserInteractionEnabled = false
        //        }
        //        if cell.shoppingAssistantTblView.tag == 1{
        //            cell.backToArrow.isUserInteractionEnabled = true
        //        }
        if indexPath.row == 0{
            cell.backToArrow.isHidden = false
        }
        if indexPath.row == 1{
            if eventItemArr.count>0{
                if selectedIndex >= 0{
                    let eventList =   Array(eventItemArr)[selectedIndex].key
                    //let eventList = addEventArr[selectedIndex]
                    cell.listLbl.text = eventList
                    cell.backToArrow.isHidden = true
                }
            }
        }
        if moveFlag == false{
            //selectedRef = ""
        if eventItemArr.count>0{
            cell.shoppingAssistantTblView.isHidden = false
            cell.alertView.isHidden = true
        }else{
            cell.shoppingAssistantTblView.isHidden = true
            cell.alertView.isHidden = false
        }
        }
        cell.shoppingAssistantTblView.reloadData()
        
        
        return cell
    }
    //    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //        // Compute the dimension of a cell for an NxN layout with space S between
    //        // cells.  Take the collection view's width, subtract (N-1)*S points for
    //        // the spaces between the cells, and then divide by N to find the final
    //        // dimension for the cell's width and height.
    //
    //        let cellsAcross: CGFloat = 1
    //        let spaceBetweenCells: CGFloat = 1
    //        let dim = (collectionView.bounds.width - (cellsAcross - 1) * spaceBetweenCells) / cellsAcross
    //        return CGSize(width:  dim, height: dim)
    //    }
    func textViewDidChange(_ textView: UITextView){
        if textView.tag == 0{
            
            eventName = textView.text
        }
        if textView.tag == 1{
            itemName = textView.text
        }
    }
}
//}
extension ShoppingAssistantCollectionViewController:UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 0{
            return eventItemArr.count
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
                            return 0
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
        
         let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingAssistanceTableViewCell") as! shoppingAssistanceTableViewCell
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "shoppingAssistanceTableViewCell2") as! shoppingAssistanceTableViewCell2
        if tableView.tag == 0{
            //cell.moveArrowBtn.isHidden = false
            cell.selectEventBtn.tag = indexPath.row
            cell.moveArrowBtn.tag = indexPath.row
            
            cell.selectionStyle = .none
            //cell.moveArrowBtn.isHidden=false
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
            if eventItemArr.count>0{
                let item:[String]=Array(eventItemArr.keys)
                cell.eventNameLbl.text = item[indexPath.row]
                
                
            }
            //            if addEventArr.count>0{
            //
            //                cell.eventNameLbl.text = addEventArr[indexPath.row]
            //            }
            return cell
        }
        if tableView.tag == 1{
    
            cell2.selectEventBtn.tag = indexPath.row
            cell2.moveArrowBtn.isHidden=true
//            if moveFlag == false{
//                selectedRef = ""
//            }
           // cell.moveArrowBtn.isHidden = true
            cell2.selectionStyle = .none
            if (selectedItemIndex == indexPath.row) {
                
                cell2.moveArrowBtn.isSelected = true
                //cell.violenceBtnSelect.setImage(UIImage(named: "radio-selected"),for:UIControlState.normal)
            } else {
                cell2.moveArrowBtn.isSelected = false
                //cell.violenceBtnSelect.setImage(UIImage(named: "radio-unselected"),for:UIControlState.normal)
            }
            if(rowsWhichAreChecked.contains(indexPath) == false){
                cell.selectEventBtn.isSelected = true
                
                 cell2.selectEventBtn.setImage(UIImage(named: "check"),for:UIControlState.normal)
            }else{
                cell.selectEventBtn.isSelected = false
                 cell2.selectEventBtn.setImage(UIImage(named: "circle"),for:UIControlState.normal)
            }
        
//            if(cell2.moveArrowBtn.isSelected){
//                cell2.selectEventBtn.setImage(UIImage(named: "radio-selected"),for:UIControlState.normal)
//                isSelect=true
//            }
//            else{
//                cell2.selectEventBtn.setImage(UIImage(named: "unselected"),for:UIControlState.normal)
//            }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        if tableView.tag == 0{
            let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! shoppingAssistanceTableViewCell
            //            cell.selectionStyle = .none
            //            editSelectedIndexval = indexPath.row
            //            selectedtableViewIndex = 1
            //            editListTxtView.text = ""
            //            editView.isHidden = false
        }
        if tableView.tag == 1{
          //  let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! shoppingAssistanceTableViewCell2
            
            let cell:shoppingAssistanceTableViewCell2 = tableView.cellForRow(at: indexPath) as! shoppingAssistanceTableViewCell2
            // cross checking for checked rows
            if(rowsWhichAreChecked.contains(indexPath) == false){
                cell.selectEventBtn.isSelected = true
                rowsWhichAreChecked.append(indexPath)
            }else{
                cell.selectEventBtn.isSelected = false
                // remove the indexPath from rowsWhichAreCheckedArray
                if let checkedItemIndex = rowsWhichAreChecked.index(of: indexPath){
                    rowsWhichAreChecked.remove(at: checkedItemIndex)
                }
            }
            //            cell.selectionStyle = .none
            //            editSelectedIndexval = indexPath.row
            //            selectedtableViewIndex = 2
            //            editListTxtView.text = ""
            //            editView.isHidden = false
        }
        tableView.reloadData()
        
    }
}

