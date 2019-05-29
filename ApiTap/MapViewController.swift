//
//  MapViewController.swift
//  ApiTap
//
//  Created by Ashish on 13/10/17.
//  Copyright © 2017 ApiTap. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class getLocationCollectionCell:UICollectionViewCell{
    
    @IBOutlet var milesLbl: UILabel!
    @IBOutlet var numLbl: UILabel!
    @IBOutlet var addNameStr: UILabel!
    @IBOutlet weak var addressName: UILabel!
    @IBOutlet weak var countryName: UILabel!
}
class storeCell:UITableViewCell{
    @IBOutlet weak var strBtn3: UIButton!
    
    @IBOutlet var storeNamLbl: UILabel!
    @IBOutlet weak var selectImage: UIImageView!
    @IBOutlet weak var strBtn5: UIButton!
    @IBOutlet weak var strBtn4: UIButton!
    @IBOutlet weak var strBtn2: UIButton!
    @IBOutlet weak var strBtn1: UIButton!
}
class mapCell:UITableViewCell{
    
    @IBOutlet var storeImgView: UIImageView!
    @IBOutlet weak var myMap: MKMapView!
    @IBOutlet weak var itemsScrollView: UIScrollView!
}
class locationCell:UITableViewCell{
    
    @IBOutlet weak var locationCollectionView: UICollectionView!
}
class MapViewController: BaseViewController , MKMapViewDelegate, CLLocationManagerDelegate,UITableViewDelegate,UITableViewDataSource{
    //hArsh
    var latVale:Double = Double()
    var longvale: Double = Double()
    var conditionChakflow:Bool = false
    var storeNameStr:String = ""
    var ratingStr:String = ""
    var storeNameTxt:String = ""
    @IBOutlet weak var progressView: UIActivityIndicatorView!
    
    @IBOutlet weak var hiddenView: UIView!
    var detailTxt:String = ""
    var urlS:URL!
    var urlStr:String = ""
    var urlImage:String = "http://209.46.35.217:8085/ServerImage/images/"
    @IBOutlet weak var mapTblView: UITableView!
    var locArray:[[String:AnyObject]]=[]
    var myModel = ModelManager()
    var dictparam:[String:AnyObject]=[:]
    var loginUserId:String = ""
    var ratingNum:String = ""
   // @IBOutlet weak var myMap: MKMapView!
    var locationManager = CLLocationManager()
    var merchantId:String = ""
static var enable:Bool = true
    var locationDict:[String:AnyObject]=[:]
    var getLocation:[[String:AnyObject]]=[]
    var latitude: CLLocationDegrees = CLLocationDegrees()
    var longitude: CLLocationDegrees = CLLocationDegrees()
    
    var currentLatitu:CLLocationDegrees = CLLocationDegrees()
     var currentLongitude:CLLocationDegrees = CLLocationDegrees()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeNavBar()
        self.setbarButtonItems()
        progressView.startAnimating()
        // setLoadingScreen()
        hiddenView.isHidden = false
         progressView.isHidden=false
        hiddenView.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
        mapTblView.isUserInteractionEnabled = false
        
        
        
        if let result = UserDefaults.standard.value(forKey: "loginUserID") as? String{
            loginUserId = result as! String
            print(result)
        }
        dictparam["53"] = merchantId as AnyObject
        //getCard
        myModel.addManager.getMap("010100368", userinfo: dictparam, completionResponse: { ( response,  error) in
            print(response)
            
            if let res = response as? [[String:AnyObject]]{
                for item in res{
                if let result = item["RESULT"] as? [[String:AnyObject]]{
                    for invoiceItem in result{
                        if let ad = invoiceItem["AD"] as? [String:AnyObject]{
                            print(ad)
                            if let locations = ad["ZP"] as? [String:AnyObject]{
                                //for getLoc in locations{
                                    if let lat = locations["_120_38"] as? String{
                                        self.locationDict["lat"] = lat as AnyObject
                                    }
                                    if let long = locations["_120_39"] as? String{
                                        self.locationDict["long"] = long as AnyObject
                                    }
                                    
                                //}
                            }
                             if let country = ad["CO"] as? [String:AnyObject]{
                                if let contr = country["_47_18"] as? String{
                                    self.locationDict["country"] = contr as AnyObject
                                }
                            }
                            if let subAdd1 = ad["_114_12"] as? String{
                                self.locationDict["subAdd1"] = subAdd1 as AnyObject
                            }
                            if let subAdd2 = ad["_114_13"] as? String{
                                self.locationDict["subAdd2"] = subAdd2 as AnyObject
                            }
                            self.getLocation.append(self.locationDict)
                        }
                       
                    }
                }
            }
            }
            self.getAdd()
            DispatchQueue.main.async {
                
                 self.mapTblView.reloadData()
            }
           
            
        })
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
           
        }
        self.mapTblView.reloadData()
        if conditionChakflow == true{
            
        }
      //  let cell = mapTblView.cellForRow(at: IndexPath(row: 0, section: 1)) as! mapCell
        //getAdd()
        // Do any additional setup after loading the view.
        
       
    }
    //hArsh
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 15.0
    }
    override func viewDidAppear(_ animated: Bool) {
        if conditionChakflow{
            let cordinate = CLLocationCoordinate2D(latitude: self.latVale, longitude: self.longvale)
            let region = MKCoordinateRegionMakeWithDistance(cordinate, 1000, 1000)
            let cell = mapTblView.cellForRow(at: IndexPath(row: 0, section: 1)) as! mapCell
            cell.myMap.setRegion(region, animated: true)
            pin = AnnotationPin(title: "", subtitle: "", coordinate: cordinate)
            cell.myMap.addAnnotation(pin)
            
            
            
            let coo = CLLocationCoordinate2DMake(currentLatitu , currentLongitude)
            let co = CLLocationCoordinate2DMake(self.latVale , self.longvale)
            
            
            
            let sourcePlacemark = MKPlacemark(coordinate: coo, addressDictionary: nil)
            let destinationPlacemark = MKPlacemark(coordinate: co, addressDictionary: nil)
            
            let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
            let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
            
            let sourceAnnotation = MKPointAnnotation()
            
            if let location = sourcePlacemark.location {
                sourceAnnotation.coordinate = location.coordinate
            }
            
            let destinationAnnotation = MKPointAnnotation()
            
            if let location = destinationPlacemark.location {
                destinationAnnotation.coordinate = location.coordinate
            }
            
            cell.myMap.showAnnotations([sourceAnnotation,destinationAnnotation], animated: true )
            
            let directionRequest = MKDirectionsRequest()
            directionRequest.source = sourceMapItem
            directionRequest.destination = destinationMapItem
            directionRequest.transportType = .automobile
            
            // Calculate the direction
            let directions = MKDirections(request: directionRequest)
            
            directions.calculate {
                (response, error) -> Void in
                
                guard let response = response else {
                    if let error = error {
                        print("Error: \(error)")
                    }
                    
                    return
                }
                
                let route = response.routes[0]
                
                cell.myMap.add((route.polyline), level: MKOverlayLevel.aboveRoads)
                
                let rect = route.polyline.boundingMapRect
                cell.myMap.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
            }
            
            
            //let LocationAtual: CLLocation = CLLocation(latitude: self.latVale, longitude: self.longvale)
          //  self.addAnnotations(coords: [LocationAtual])
            conditionChakflow = false
        }
    }
    
    
    var arrayFinalData:[String]=[]
    var imageUrl:[String]=[]
    var allImage:[UIImage]=[]
    var allImages:[UIImage]=[]
    var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    func getAdd(){
        
            if let result = UserDefaults.standard.value(forKey: "loginUserID") as? String{
                loginUserId = result as! String
                print(result)
            }
            let cell = mapTblView.cellForRow(at: IndexPath(row: 0, section: 1)) as! mapCell
            dictparam["53"] = loginUserId as AnyObject
            myModel.addManager.addSearchImages("010100517", userinfo: dictparam, completionResponse: { ( response,  error) in
                
                print(response)
                if let res: [[String : AnyObject]]  = response as? [[String : AnyObject]]{
                    //self.searchItems = res
                    
                    for items in res{
                        if let irImages = items["RESULT"] as? [[String:AnyObject]]{
                            for imageitem in irImages{
                                if let image:String = imageitem["_121_170"] as? String{
                                    
                                    print(image)
                                    self.arrayFinalData.append(image)
                                    
                                }
                            }
                            for itemImages in self.arrayFinalData{
                                if let urlStr:String = itemImages as? String{
                                    
                                    let url =  self.urlImage.appending(urlStr as String)
                                    self.imageUrl.append(url)
                                }
                                
                            }
                            
                           
                         
                        }
                    }
                    
                }else{
                    
                }
                DispatchQueue.main.async {
                    self.progressView.stopAnimating()
                    self.progressView.isHidden=true
                    // setLoadingScreen()
                    self.hiddenView.isHidden = true
                   // hiddenView.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
                    self.mapTblView.isUserInteractionEnabled = true
                    self.mapTblView.reloadData()
                }
            })
        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func addLongPressGesture()
    {
        let cell = mapTblView.cellForRow(at: IndexPath(row: 0, section: 1)) as! mapCell
        let longPressRecogniser:UILongPressGestureRecognizer = UILongPressGestureRecognizer(target:self , action:#selector(MapViewController.handleLongPress(_:)))
        longPressRecogniser.minimumPressDuration = 1.0 //user needs to press for 2 seconds
        cell.myMap.addGestureRecognizer(longPressRecogniser)
    }
    
    func handleLongPress(_ gestureRecognizer:UIGestureRecognizer){
        let cell = mapTblView.cellForRow(at: IndexPath(row: 0, section: 1)) as! mapCell
        if gestureRecognizer.state != .began
        {
            return
        }
        
        let touchPoint:CGPoint = gestureRecognizer.location(in: cell.myMap)
        let touchMapCoordinate:CLLocationCoordinate2D =
            cell.myMap.convert(touchPoint, toCoordinateFrom: cell.myMap)
        
        let annot:MKPointAnnotation = MKPointAnnotation()
        annot.coordinate = touchMapCoordinate
        
        self.resetTracking()
        cell.myMap.addAnnotation(annot)
        self.centerMap(touchMapCoordinate)
    }
    
    
    @IBAction func starBtnTap(_ sender: Any) {
    }
    
    func resetTracking()
    {
        let cell = mapTblView.cellForRow(at: IndexPath(row: 0, section: 1)) as! mapCell
        if (cell.myMap.showsUserLocation)
        {
            cell.myMap.showsUserLocation = false
            cell.myMap.removeAnnotations(cell.myMap.annotations)
            self.locationManager.stopUpdatingLocation()
        }
    }
    
    func centerMap(_ center:CLLocationCoordinate2D)
    {
        let cell = mapTblView.cellForRow(at: IndexPath(row: 0, section: 1)) as! mapCell
        self.saveCurrentLocation(center)
        
        let spanX = 0.007
        let spanY = 0.007
        
        let newRegion = MKCoordinateRegion(center:center , span: MKCoordinateSpanMake(spanX, spanY))
        cell.myMap.setRegion(newRegion, animated: true)
    }
    
    func saveCurrentLocation(_ center:CLLocationCoordinate2D)
    {
        let message = "\(center.latitude) , \(center.longitude)"
        print(message)
        //  self.lable.text = message
        // myLocation = center
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
        
    {
        let cell = mapTblView.cellForRow(at: IndexPath(row: 0, section: 1)) as! mapCell
        
        let location = locations.last! as CLLocation
        if let lat = locations.last?.coordinate.latitude, let long = locations.last?.coordinate.longitude {
            currentLatitu = lat
            currentLongitude = long
            print("\(lat),\(long)")
        } else {
            print("No coordinates")
        }
        if self.latitude != 0.0 || self.longitude != 0.0{
        let center = CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            
            cell.myMap.setRegion(region, animated: true)
            
        }else{
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            
            cell.myMap.setRegion(region, animated: true)
        }
        locationManager.stopUpdatingLocation()
//        self.locationManager.stopUpdatingLocation()
//        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
//        
//        centerMap(locValue)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section==0{
            return 1
        }else if section == 1{
             return 1
        }else{
             return 1
        }
         return 1
    }
    var imgUrl:String = ""
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
        let cell = tableView.dequeueReusableCell(withIdentifier: "storeCell") as! storeCell
            cell.selectionStyle = .none
            cell.storeNamLbl.text = storeNameTxt
            cell.storeNamLbl.layer.cornerRadius = 5.0
            cell.storeNamLbl.layer.borderWidth = 1.0
            cell.storeNamLbl.layer.borderColor = UIColor.blue.cgColor
            
             self.imgUrl =  self.urlImage.appending(urlStr as String)
            if let url = NSURL(string: imgUrl) {
               cell.selectImage.sd_setImage(with: urlS as URL!)
            }
            if ratingNum == "1"{
                cell.strBtn1.setImage(UIImage(named:"yStar"), for: .normal)
                
            }
            if ratingNum == "2"{
                cell.strBtn1.setImage(UIImage(named:"yStar"), for: .normal)
                cell.strBtn2.setImage(UIImage(named:"yStar"), for: .normal)
            }
            if ratingNum == "3"{
                cell.strBtn1.setImage(UIImage(named:"yStar"), for: .normal)
                cell.strBtn2.setImage(UIImage(named:"yStar"), for: .normal)
                cell.strBtn3.setImage(UIImage(named:"yStar"), for: .normal)
            }
            if ratingNum == "4"{
                cell.strBtn1.setImage(UIImage(named:"yStar"), for: .normal)
                cell.strBtn2.setImage(UIImage(named:"yStar"), for: .normal)
                cell.strBtn3.setImage(UIImage(named:"yStar"), for: .normal)
                cell.strBtn4.setImage(UIImage(named:"yStar"), for: .normal)
            }
            if ratingNum == "5"{
                cell.strBtn1.setImage(UIImage(named:"yStar"), for: .normal)
                cell.strBtn2.setImage(UIImage(named:"yStar"), for: .normal)
                cell.strBtn3.setImage(UIImage(named:"yStar"), for: .normal)
                cell.strBtn4.setImage(UIImage(named:"yStar"), for: .normal)
                cell.strBtn5.setImage(UIImage(named:"yStar"), for: .normal)
            }
            
            
            
            return cell
        }
        if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "mapCell") as! mapCell
            cell.selectionStyle = .none
            cell.myMap.delegate=self
            cell.myMap.layer.borderWidth=1
            cell.myMap.layer.borderColor=UIColor.blue.cgColor
            cell.myMap.layer.cornerRadius=5.0
            self.imgUrl =  self.urlImage.appending(urlStr as String)
            if let url = NSURL(string: imgUrl) {
                cell.storeImgView.sd_setImage(with: urlS as URL!)
            }
            // myMap.delegate = self
            cell.myMap.mapType = .standard
            cell.myMap.isZoomEnabled = true
            cell.myMap.isScrollEnabled = true
            if getLocation.count>indexPath.row{
                cell.myMap.isHidden=false
            }else if locArray.count>indexPath.row{
                cell.myMap.isHidden=false
                cell.itemsScrollView.isHidden=true
            }
            else{
                cell.myMap.isHidden = true
                cell.itemsScrollView.isHidden=false
                if imageUrl.count>indexPath.row{
                for i in 0..<self.imageUrl.count{
                     DispatchQueue.global(qos: .userInitiated).async {
                    if let url = NSURL(string: self.imageUrl[i]) {
                        if let data = NSData(contentsOf: url as URL) {
                            // let imageView = UIImageView()
                            self.allImage.append(UIImage(data: data as Data)!)
                            // imageView.image = UIImage(data: data as Data)
                            
                            self.frame.origin.x = cell.itemsScrollView.frame.size.width * CGFloat(i)
                            self.frame.size = cell.itemsScrollView.frame.size
                            let image = UIImageView(frame: self.frame)
                            // let image = UIImageView(frame:frame)
                            image.image = UIImage(data: data as Data)
                            image.contentMode = .scaleAspectFit
                            // view.backgroundColor = colors[pageControl.currentPage]
                             DispatchQueue.main.async(execute: { () -> Void in
                            cell.itemsScrollView.addSubview(image)
                            
                            })
                        }
                    }
                }
                    }
                
                    cell.itemsScrollView.contentSize = CGSize(width: (cell.itemsScrollView.frame.size.width * CGFloat(self.imageUrl.count)), height: cell.itemsScrollView.frame.size.height)
                }
                
            }
            
            
            if let coor = cell.myMap.userLocation.location?.coordinate
            {
                cell.myMap.setCenter(coor, animated: true)
            }
            return cell
        }
        
        if indexPath.section == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell") as! locationCell
            cell.selectionStyle = .none
            cell.locationCollectionView.reloadData()
            return cell
        }
        return UITableViewCell()
    }
    func addAnnotations(coords: [CLLocation]){
        for coord in coords{
            let cell = mapTblView.cellForRow(at: IndexPath(row: 0, section: 1)) as! mapCell
            
            
            let CLLCoordType = CLLocationCoordinate2D(latitude: coord.coordinate.latitude,
                                                      longitude: coord.coordinate.longitude);
            let anno = MKPointAnnotation();
            anno.coordinate = CLLCoordType;
            cell.myMap.addAnnotation(anno);
            
        }
        
        
    }
    
    @IBAction func backBtnPress(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section==0{
            return 120
        }
        else if indexPath.section == 1{
            return 320
        }else{
            return 170
        }
        return 44
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if getLocation.count>0{
            return getLocation.count
        }else{
            return locArray.count
        }
        return 1
    }
  override  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "getLocationCollectionCell", for: indexPath) as! getLocationCollectionCell
    cell.layer.borderWidth = 3
    cell.layer.borderColor = UIColor(red: 220/256.0, green: 220/256.0, blue: 220/256.0, alpha: 1.0).cgColor
    cell.layer.backgroundColor = UIColor.white.cgColor
    //cell.layer.cornerRadius = 5.0
    collectionView.layer.borderWidth=3
   // collectionView.layer.cornerRadius = 5
   collectionView.layer.borderColor = UIColor(red: 220/256.0, green:  220/256.0, blue:  220/256.0, alpha: 1.0).cgColor
        if getLocation.count > indexPath.row{
            let loaction = getLocation[indexPath.row]
            
            //    cell.specialImageView.image = UIImage(data: specialDataImage[indexPath.row])
            if let loc = loaction["subAdd1"] as? String{
                cell.addressName.text = loc
            }
            if let loc = loaction["country"] as? String{
                cell.countryName.text = loc
            }
            if let loc = loaction["subAdd2"] as? String{
                cell.addNameStr.text = loc
            }
            if let lat = loaction["lat"] as? String{
                if let long = loaction["lat"] as? String{
                    let coordinate₀ = CLLocation(latitude: latitude, longitude: longitude)
                    let coordinate₁ = CLLocation(latitude: Double(lat)!, longitude: Double(long)!)
                    
                    let distanceInMeters = coordinate₀.distance(from: coordinate₁)/1609.344
                    print(distanceInMeters)
                    cell.milesLbl.text = "Distance: " + String(distanceInMeters)
                    cell.numLbl.text = "123456789"
                }
            }
        }else if locArray.count>indexPath.row{
            let loaction = locArray[indexPath.row]
            
            //    cell.specialImageView.image = UIImage(data: specialDataImage[indexPath.row])
            if let loc = loaction["subAdd1"] as? String{
                cell.addressName.text = loc
            }
            if let loc = loaction["country"] as? String{
                cell.countryName.text = loc
            }
            if let loc = loaction["subAdd2"] as? String{
                cell.addNameStr.text = loc
            }
            if let lat = loaction["lat"] as? String{
                if let long = loaction["lat"] as? String{
                    let coordinate₀ = CLLocation(latitude: latitude, longitude: longitude)
                    let coordinate₁ = CLLocation(latitude: Double(lat)!, longitude: Double(long)!)
                    
                    let distanceInMeters = coordinate₀.distance(from: coordinate₁)/1609.344
                    print(distanceInMeters)
                    cell.milesLbl.text = "Distance: " + String(distanceInMeters)
                    cell.numLbl.text = "123456789"
                }
            }
        }else{
            cell.addressName.text = "No Location found"
        }
        return cell
    }
    var pin:AnnotationPin!
  override  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    var locationNameSTr:String = ""
    var locationSubNameSTr:String = ""
        if locArray.count>indexPath.row{
            let  item = locArray[indexPath.row]
            
            if let loc = item["lat"] as? String{
                self.latitude = Double(loc)!
            }
            if let long = item["long"] as? String{
                self.longitude = Double(long)!
            }
            if let loc = item["subAdd1"] as? String{
                locationNameSTr = loc
            }
            if let loc = item["subAdd2"] as? String{
                locationSubNameSTr = loc
            }
            let cordinate = CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
            let region = MKCoordinateRegionMakeWithDistance(cordinate, 1000, 1000)
            let cell = mapTblView.cellForRow(at: IndexPath(row: 0, section: 1)) as! mapCell
            cell.myMap.setRegion(region, animated: true)
            pin = AnnotationPin(title: locationNameSTr, subtitle: locationSubNameSTr, coordinate: cordinate)
            cell.myMap.addAnnotation(pin)
            
          //  locationManager.startUpdatingLocation()
            
            
            let coo = CLLocationCoordinate2DMake(currentLatitu , currentLongitude)
            let co = CLLocationCoordinate2DMake(latitude , longitude)
            
            
            
            let sourcePlacemark = MKPlacemark(coordinate: coo, addressDictionary: nil)
            let destinationPlacemark = MKPlacemark(coordinate: co, addressDictionary: nil)
            
            let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
            let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
            
            let sourceAnnotation = MKPointAnnotation()
            
            if let location = sourcePlacemark.location {
                sourceAnnotation.coordinate = location.coordinate
            }
            
            let destinationAnnotation = MKPointAnnotation()
            
            if let location = destinationPlacemark.location {
                destinationAnnotation.coordinate = location.coordinate
            }
            
            cell.myMap.showAnnotations([sourceAnnotation,destinationAnnotation], animated: true )
            
            let directionRequest = MKDirectionsRequest()
            directionRequest.source = sourceMapItem
            directionRequest.destination = destinationMapItem
            directionRequest.transportType = .automobile
            
            // Calculate the direction
            let directions = MKDirections(request: directionRequest)
            
            directions.calculate {
                (response, error) -> Void in
                
                guard let response = response else {
                    if let error = error {
                        print("Error: \(error)")
                    }
                    
                    return
                }
                
                let route = response.routes[0]
                
                cell.myMap.add((route.polyline), level: MKOverlayLevel.aboveRoads)
                
                let rect = route.polyline.boundingMapRect
                cell.myMap.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
            }
            
            
            //let LocationAtual: CLLocation = CLLocation(latitude: self.latitude, longitude: self.longitude)
           // self.addAnnotations(coords: [LocationAtual])
        }else{
            let  item = getLocation[indexPath.row]
            
            if let loc = item["lat"] as? String{
                self.latitude = Double(loc)!
            }
            if let long = item["long"] as? String{
                self.longitude = Double(long)!
            }
            if let loc = item["subAdd1"] as? String{
                locationNameSTr = loc
            }
            if let loc = item["subAdd2"] as? String{
                locationSubNameSTr = loc
            }
            let cordinate = CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
            let region = MKCoordinateRegionMakeWithDistance(cordinate, 1000, 1000)
            let cell = mapTblView.cellForRow(at: IndexPath(row: 0, section: 1)) as! mapCell
            cell.myMap.setRegion(region, animated: true)
            pin = AnnotationPin(title: locationNameSTr, subtitle: locationSubNameSTr, coordinate: cordinate)
            cell.myMap.addAnnotation(pin)
            
         //   locationManager.startUpdatingLocation()
            
            let coo = CLLocationCoordinate2DMake(currentLatitu , currentLongitude)
            let co = CLLocationCoordinate2DMake(latitude , longitude)
          
            
            
            let sourcePlacemark = MKPlacemark(coordinate: coo, addressDictionary: nil)
            let destinationPlacemark = MKPlacemark(coordinate: co, addressDictionary: nil)
            
            let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
            let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
            
            let sourceAnnotation = MKPointAnnotation()
            
            if let location = sourcePlacemark.location {
                sourceAnnotation.coordinate = location.coordinate
            }
            
            let destinationAnnotation = MKPointAnnotation()
            
            if let location = destinationPlacemark.location {
                destinationAnnotation.coordinate = location.coordinate
            }
            
            cell.myMap.showAnnotations([sourceAnnotation,destinationAnnotation], animated: true )
            
            let directionRequest = MKDirectionsRequest()
            directionRequest.source = sourceMapItem
            directionRequest.destination = destinationMapItem
            directionRequest.transportType = .automobile
            
            // Calculate the direction
            let directions = MKDirections(request: directionRequest)
            
            directions.calculate {
                (response, error) -> Void in
                
                guard let response = response else {
                    if let error = error {
                        print("Error: \(error)")
                    }
                    
                    return
                }
                
                let route = response.routes[0]
                
                cell.myMap.add((route.polyline), level: MKOverlayLevel.aboveRoads)
                
                let rect = route.polyline.boundingMapRect
                cell.myMap.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
            }
            
            
//            let request = MKDirectionsRequest()
//            request.source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: currentLatitu, longitude: currentLatitu), addressDictionary: nil))
//            request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude), addressDictionary: nil))
//            request.requestsAlternateRoutes = true
//            request.transportType = .automobile
//
//            let directions = MKDirections(request: request)
//
//            directions.calculate { [unowned self] response, error in
//                guard let unwrappedResponse = response else { return }
//
//                for route in unwrappedResponse.routes {
//                    cell.myMap.add(route.polyline)
//
//                    cell.myMap.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
//                }
//            }
           // let LocationAtual: CLLocation = CLLocation(latitude: self.latitude, longitude: self.longitude)
           // self.addAnnotations(coords: [LocationAtual])
        }
    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        let renderer = MKPolylineRenderer(overlay: overlay)
        
        renderer.strokeColor = UIColor(red: 17.0/255.0, green: 147.0/255.0, blue: 255.0/255.0, alpha: 1)
        
        renderer.lineWidth = 5.0
        
        return renderer
    }
//    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        // Compute the dimension of a cell for an NxN layout with space S between
//        // cells.  Take the collection view's width, subtract (N-1)*S points for
//        // the spaces between the cells, and then divide by N to find the final
//        // dimension for the cell's width and height.
//
//        let cellsAcross: CGFloat = 3
//        let spaceBetweenCells: CGFloat = 1
//        let dim = (collectionView.bounds.width - (cellsAcross - 1) * spaceBetweenCells) / cellsAcross
//        return CGSize(width: dim, height: collectionView.frame.size.height)
//    }
}


//    extension MapViewController:UICollectionViewDelegate,UICollectionViewDataSource{
//        
//        
//        
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

