//
//  CustomCollectionVC.swift
//  ApiTap
//
//  Created by Ashish on 06/11/17.
//  Copyright © 2017 ApiTap. All rights reserved.
//

import UIKit

class CustomCollectionVC: UIViewController {
var baseVC = BaseViewController()
    
    @IBOutlet weak var containerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        baseVC.createBtn()
//baseVC.setCollectionViewButton()
        //baseVC.initializeNavBar()
      //  baseVC.setbarButtonItems()
        // Do any additional setup after loading the view.
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

}
