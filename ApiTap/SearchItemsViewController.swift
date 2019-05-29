
//
//  SearchItemsViewController.swift
//  ApiTap
//
//  Created by AppZorro on 27/09/17.
//  Copyright © 2017 ApiTap. All rights reserved.
//

import UIKit

class SearchItemsViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
      var myModel = ModelManager()
    @IBOutlet weak var searchItemScrollView: UIScrollView!
    var dictparam:[String:AnyObject]=[:]
    var searchItems:[[String:AnyObject]]=[]
    var arrayFinalData:[String]=[]
    var imageUrl:[String]=[]
    
    @IBOutlet weak var scrollImageView: UIImageView!
    @IBOutlet weak var productandServiceTblView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var specialCollectionView: UICollectionView!
    var urlImage:String = "http://209.46.35.217:8085/ServerImage/images/"
    
    var colors:[UIColor] = [UIColor.red,UIColor.green,UIColor.blue,UIColor.brown]
    var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        specialCollectionView.delegate=self
        specialCollectionView.dataSource=self
         searchItemScrollView.delegate = self
        searchItemScrollView.frame = view.frame
        //searchItemScrollView.contentSize = CGSize(width:375, height:1500)
        searchItemScrollView.isScrollEnabled = true
        
        
//        myModel.addManager.addSearchImages("010100517", userinfo: dictparam, completionResponse: { ( response,  error) in
//            
//            print(response)
//            self.searchItems = response as! [[String : AnyObject]]
//            
//            for items in self.searchItems{
//                if let irImages = items["RESULT"] as? [[String:AnyObject]]{
//                    for imageitem in irImages{
//                        if let image:String = imageitem["_121_170"] as? String{
//                      
//                        print(image)
//                        self.arrayFinalData.append(image)
//                        
//                    }
//                    }
//                    self.getImages()
//                }
//            }
//            
//        })

        getSearchImages()
         getProductAndServiceDataInfo()
        // Do any additional setup after loading the view.
    }
    
    func getImages(){
        for itemImages in self.arrayFinalData{
            if let urlStr:String = itemImages as? String{
             
                let url =  urlImage.appending(urlStr as String)
                imageUrl.append(url)
            }
            
        }
        setImages()
    }
    var allImage:[UIImage]=[]
    func setImages(){
        
        for i in 0..<imageUrl.count{
            if let url = NSURL(string: imageUrl[i]) {
                if let data = NSData(contentsOf: url as URL) {
                    let imageView = UIImageView()
                    allImage.append(UIImage(data: data as Data)!)
                   // imageView.image = UIImage(data: data as Data)
                    
                    
                    
                }
            }
        }
        loadImages()
    }
    func loadImages(){
        for i in 0..<allImage.count{
        let imageView = UIImageView()
          //  imageView.image = allImage[i]
       // let xPosition = self.view.frame.width * CGFloat(i)
       // imageView.frame = CGRect(x: xPosition, y: 0, width: searchItemScrollView.frame.width, height: searchItemScrollView.frame.height)
        
        //searchItemScrollView.contentSize.width =  searchItemScrollView.contentSize.width * CGFloat(i + 1)
       // searchItemScrollView.addSubview(imageView)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    var loadSearchCollectionImage:[[String:AnyObject]]=[]
    var offerSearchImage:[String] = []
    var itemNames:[String]=[]
    var itemPriceName:[String]=[]
    func getSearchImages(){
    
        myModel.addManager.offerSearchImages("010400472", userinfo: dictparam, completionResponse: { ( response,  error) in
            print(response)
            self.loadSearchCollectionImage = response as! [[String : AnyObject]]
            for items in self.loadSearchCollectionImage{
            if let irImages = items["RESULT"] as? [[String:AnyObject]]{
                
                for imageitem in irImages{
                    
                    if let image = imageitem["_121_170"] as? String{
                        self.offerSearchImage.append(image)
                    }
                    if let itemName = imageitem["_120_83"] as? String{
                        self.itemNames.append(itemName)
                    }
                    if let itemPriceName = imageitem["_114_98"] as? String{
                        self.itemPriceName.append(itemPriceName)
                    }
                }
                }
            }
            self.getOfferImages()
        })
    }
    var dataimage:[Data]=[]
    var getTotalOfferImage:[String]=[]
    func getOfferImages(){
        for itemImages in self.offerSearchImage{
            if let urlStr:String = itemImages as? String{
                
                let url =  urlImage.appending(urlStr as String)
                getTotalOfferImage.append(url)
            }
            
        }
        
        for i in 0..<getTotalOfferImage.count{
            
            if let url = NSURL(string: getTotalOfferImage[i]) {
                
                if let data = NSData(contentsOf: url as URL) {
                    let imageView = UIImageView()
                    allImage.append(UIImage(data: data as Data)!)
                    dataimage.append(data as Data)
                }
                
            }
        }
        
        
        for i in 0..<dataimage.count{
            
            
            let imageView = UIImageView()
          //  imageView.image = UIImage(data: dataimage[i])
           // let xPosition = self.view.frame.width * CGFloat(i)
           // imageView.frame = CGRect(x: xPosition, y: 0, width: searchItemScrollView.frame.width, height: searchItemScrollView.frame.height)
            
            
            frame.origin.x = searchItemScrollView.frame.size.width * CGFloat(i)
            frame.size = searchItemScrollView.frame.size
            let image = UIImageView(frame: CGRect(x: 50, y: 20, width: searchItemScrollView.frame.size.width + 100 / 2, height: 100))
           // let image = UIImageView(frame:frame)
            scrollImageView.image = UIImage(data: dataimage[i])
           // view.backgroundColor = colors[pageControl.currentPage]
            
            searchItemScrollView.addSubview(scrollImageView)
            
           // searchItemScrollView.contentSize.width =  searchItemScrollView.contentSize.width * CGFloat(i + 1)
            //searchItemScrollView.addSubview(imageView)
        }
        searchItemScrollView.contentSize = CGSize(width: (searchItemScrollView.frame.size.width * CGFloat(dataimage.count)), height: searchItemScrollView.frame.size.height)
        
        specialCollectionView.reloadData()
        pageControl.numberOfPages = dataimage.count
        
        
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = searchItemScrollView.contentOffset.x / searchItemScrollView.frame.size.width
        pageControl.currentPage = Int(pageNumber)
       // pageControl.currentPageIndicatorTintColor = dataimage[pageControl.currentPage]
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        if collectionView == specialCollectionView{
      if dataimage.count > 0{
        return dataimage.count
      }else{
        return 1
        }
        }else{
            if productAndServiceFinaDatalmage.count > 0{
                return productAndServiceFinaDatalmage.count
            }else{
                return 1
            }
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        if collectionView == specialCollectionView{
         let cell = specialCollectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as! SearchCollectionViewCell
        if dataimage.count > indexPath.row{
            
            
       cell.selectOfferImageView.image = UIImage(data: dataimage[indexPath.row])
            cell.orderItemName.text = itemNames[indexPath.row]
            cell.orderItemPrice.text = itemPriceName[indexPath.row]
           
        }
         return cell
        }else{
            let cell = productandServiceTblView.dequeueReusableCell(withReuseIdentifier: "ProductServiceCollectionViewCell", for: indexPath) as! ProductServiceCollectionViewCell
            if productAndServiceFinaDatalmage.count > indexPath.row{
                
                cell.productAndServiceImageView.image = UIImage(data: productAndServiceFinaDatalmage[indexPath.row])
                cell.productAndServiceItemName.text = productAndServiceItemname[indexPath.row]
                cell.productAndServiceItemPrice.text = productAndServicePriceName[indexPath.row]
                
        }
       return cell
    }
        return UICollectionViewCell()
}
    
    @IBAction func pageChange(_ sender: UIPageControl) {
    }
    
    
    //productAndService
    
    var productAndServiceArray:[[String:AnyObject]]=[]
     var productAndServiceFinalData:[[String:AnyObject]]=[]
    var productAndServiceFinalmageUrl:[String]=[]
    var productAndServiceItemname:[String]=[]
    var productAndServicePriceName:[String]=[]
    
    func getProductAndServiceDataInfo(){
        
        
        myModel.addManager.productAndServiceImages("010400478", userinfo: dictparam, completionResponse: { ( response,  error) in
            print(response)
            self.productAndServiceArray = response as! [[String : AnyObject]]
            for items in self.productAndServiceArray{
                if let irImages = items["RESULT"] as? [[String:AnyObject]]{
                    
                    for imageitem in irImages{
                        
                        if let image = imageitem["PC"] as? [[String:AnyObject]]{
                            for item in image{
                                if let url = item["_121_170"] as? String{
                                    self.productAndServiceFinalmageUrl.append(url)
                                }
                                if let itemName = item["_120_83"] as? String{
                                    self.productAndServiceItemname.append(itemName)
                                }
                                if let itemPriceName = item["_114_98"] as? String{
                                    self.productAndServicePriceName.append(itemPriceName)
                                }
                            }
                            
                        }
                        
                    }
                }
            }
            self.getProductAndServiceData()
        })
    }
    var productAndServiceFinalmage:[String]=[]
    var productAndServiceFinaDatalmage:[Data]=[]
    func getProductAndServiceData(){
        for itemImages in self.productAndServiceFinalmageUrl{
            if let urlStr:String = itemImages as? String{
                
                let url =  urlImage.appending(urlStr as String)
                productAndServiceFinalmage.append(url)
            }
            
        }
        
        for i in 0..<productAndServiceFinalmage.count{
            
            if let url = NSURL(string: productAndServiceFinalmage[i]) {
                
                if let data = NSData(contentsOf: url as URL) {
                    let imageView = UIImageView()
                    //allImage.append(UIImage(data: data as Data)!)
                    productAndServiceFinaDatalmage.append(data as Data)
                }
                
            }
        }
        specialCollectionView.reloadData()
        productandServiceTblView.reloadData()
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        
            
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath as IndexPath) 
            
            headerView.backgroundColor = UIColor.blue
            
            return headerView
      
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
