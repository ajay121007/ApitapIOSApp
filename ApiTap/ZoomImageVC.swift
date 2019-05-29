//
//  ZoomImageVC.swift
//  ApiTap
//
//  Created by Ashish on 30/10/17.
//  Copyright © 2017 ApiTap. All rights reserved.
//

import UIKit

class ZoomImageVC: BaseViewController {

    @IBOutlet weak var webView: UIWebView!
    var imageURL:URL!
    var isPresented = true
    var videoArr:[String]=[]
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeNavBar()
        self.setBarBtnItems()
          //  isPresented = true
        if videoArr.count>0{
            scrollView.isHidden = true
            webView.isHidden = false
            let videoUrl = NSURL(string: videoArr[0])
            let req = URLRequest(url: videoUrl as! URL)
            
           webView.loadRequest(req)
        }else{
            scrollView.isHidden = false
            webView.isHidden = true
        imageView.sd_setImage(with: imageURL)
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
        }
      let value = UIInterfaceOrientation.landscapeLeft.rawValue
       UIDevice.current.setValue(value, forKey: "orientation")
        
        // Do any additional setup after loading the view.
    }
   
    
    private func shouldAutorotate() -> Bool {
        return true
    }
    private func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscapeLeft
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func dismissBtnClick(_ sender: Any) {
       // isPresented = false
       // self.presentingViewController!.dismiss(animated: true, completion: nil);
    }
    
    override func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        
        return imageView
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
