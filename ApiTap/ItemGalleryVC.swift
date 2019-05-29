//
//  ItemGalleryVC.swift
//  ApiTap
//
//  Created by Ashish on 20/11/17.
//  Copyright © 2017 ApiTap. All rights reserved.
//

import UIKit


class otherImagesCollectionCell:UICollectionViewCell{
    @IBOutlet weak var relatedImages: UIImageView!
}
class imageCollectionCell:UITableViewCell{
    @IBOutlet weak var otherImagesCollectionView: UICollectionView!
    
}

class selectedImageCell:UITableViewCell{
    
    @IBOutlet weak var selectedImageView: UIImageView!
}

class ItemGalleryVC: BaseViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var imageGalleryUrl:[URL]=[]
    var imageUrl:URL!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeNavBar()
        self.setBarBtnItems()
    imageUrl = imageGalleryUrl[0]
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 460
        }else{
            return 240
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
        let cell = tableView.dequeueReusableCell(withIdentifier: "selectedImageCell") as! selectedImageCell
        cell.selectedImageView.sd_setImage(with: imageUrl)
        return cell
        }
        if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "imageCollectionCell") as! imageCollectionCell
            cell.otherImagesCollectionView.reloadData()
            return cell
        }
        return UITableViewCell()
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageGalleryUrl.count
    }
    override func viewWillDisappear(_ animated: Bool) {
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }
    override func viewDidAppear(_ animated: Bool) {
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }
    override func viewWillAppear(_ animated: Bool) {
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }
    private func shouldAutorotate() -> Bool {
        return true
    }
    private func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "otherImagesCollectionCell", for: indexPath) as! otherImagesCollectionCell
         cell.relatedImages.sd_setImage(with: imageGalleryUrl[indexPath.row])
        
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        imageUrl = imageGalleryUrl[indexPath.row]
        tableView.reloadData()
    }
    
    @IBAction func goBackBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func zoomBtnTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ZoomImageVC") as! ZoomImageVC
        vc.imageURL = imageUrl
        self.navigationController?.pushViewController(vc, animated: true)
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
