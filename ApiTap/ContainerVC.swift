//
//  ContainerVC.swift
//  ApiTap
//
//  Created by Ashish on 07/11/17.
//  Copyright © 2017 ApiTap. All rights reserved.
//

import UIKit
class TestClass: NSObject {
    
   static var doubleVar: Int = 0
    
}

class containerClassCell:UICollectionViewCell{
    @IBOutlet var itemImageView:UIImageView!
    @IBOutlet var itemNameBtn:UIButton!
}
class ContainerVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate{
    
    var containValue:Int = 0
    var count:Int = 0
    var imageArray:[String]=["icon_home","icon_store","icon_ads-1","icon_specials","icon_items","fav_gray"]
    var elementArr:[String]=["HOME","STORES","ADS","SPECIALS","ITEMS","FAVIORATES"]

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       print(TestClass.doubleVar)
       
        print(containValue)
        collectionView.delegate=self
        collectionView.dataSource=self
     navigationController?.setNavigationBarHidden(false, animated: true)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    var didSelect:Bool=false
    var selectRow:IndexPath = IndexPath()
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        
        
        let cell = collectionView.cellForItem(at: indexPath)
     
                    if indexPath.row == 0{
                        TestClass.doubleVar = 0
                      selectRow=indexPath
                        let vc = storyboard?.instantiateViewController(withIdentifier: "HomeVC1") as! HomeVC
                        self.navigationController?.pushViewController(vc, animated: false)
                        didSelect=true
         //self.collectionView.reloadData()
        
        
                    }
                    if indexPath.row == 1{
                        selectRow=indexPath
                        didSelect=true
                        TestClass.doubleVar = 1
                        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                      
                        let vc = storyboard?.instantiateViewController(withIdentifier: "StoreVC") as! StoreVC
        
                        self.navigationController?.pushViewController(vc, animated: false)
                         //self.collectionView.reloadData()
        
                    }
                    if indexPath.row == 2{
                        selectRow=indexPath
                        didSelect=true
                        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                        TestClass.doubleVar = 2
                      
                        let vc = storyboard?.instantiateViewController(withIdentifier: "AddDetailViewController") as! AddDetailViewController
                        
                        self.navigationController?.pushViewController(vc, animated: false)
                        
                         self.collectionView.reloadData()
        
                    }
                    if indexPath.row == 3{
                        selectRow=indexPath
                        didSelect=true
                        TestClass.doubleVar = 3
                        
                       
                        let vc = storyboard?.instantiateViewController(withIdentifier: "ShowLeftSliderSpecialsVC") as! ShowLeftSliderSpecialsVC
        
                        self.navigationController?.pushViewController(vc, animated: false)
                        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                    }
                    if indexPath.row == 4{
                        selectRow=indexPath
                        didSelect=true
                        TestClass.doubleVar = 4
                       //  MyVariables.counting = 4
                        let vc = storyboard?.instantiateViewController(withIdentifier: "ShowLeftSliderItemsVC") as! ShowLeftSliderItemsVC
        
                        self.navigationController?.pushViewController(vc, animated: false)
        // self.collectionView.reloadData()
        
                    }
                    if indexPath.row == 5{
                        selectRow=indexPath
                        didSelect=true
                        TestClass.doubleVar = 5
                       
                        let vc = storyboard?.instantiateViewController(withIdentifier: "FavioratesVC") as! FavioratesVC
                        self.navigationController?.pushViewController(vc, animated: false)
                       
                         //self.collectionView.reloadData()
                    }
     
      
    }
    var selectedIndex = Int ()
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.size.width
        let page = Int(floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1)
        print("page = \(page)")
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return elementArr.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "containerClassCell", for: indexPath) as! containerClassCell
        if didSelect==true{
        collectionView.scrollToItem(at: selectRow, at: .centeredHorizontally, animated: true)
        }
        if indexPath.row == TestClass.doubleVar{
                 cell.backgroundColor = UIColor(red: 13/256.0, green: 102/256.0, blue: 202/256.0, alpha: 1.0)
            }else{
                cell.backgroundColor = UIColor.white
            }
      
        cell.itemNameBtn.setTitleColor(UIColor.black, for: .normal)
        cell.itemNameBtn.setTitle(elementArr[indexPath.row], for: .normal)
        cell.itemImageView.image = UIImage(named: imageArray[indexPath.row])
        let url = URL(string: "https://www.apple.com")
       
        
        return cell
    }
        @IBAction func clickItemBtn(_ sender: UIButton) {
        
        if let cell = sender.superview?.superview as? UICollectionViewCell {
            let indexPath = collectionView.indexPath(for: cell)
            print(indexPath)
            
        }
    }
    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        // self.performSegue(withIdentifier: "home_vc", sender: self)
    }
    func methodOFReceivedNotication(notification: NSNotification){
        self.performSegue(withIdentifier: "Home", sender: self)
    }
    


}
