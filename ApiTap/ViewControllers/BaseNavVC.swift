//
//  BaseNavVC.swift
//  ApiTap
//
//  Created by Ashish on 14/11/17.
//  Copyright © 2017 ApiTap. All rights reserved.
//

import UIKit

class BaseNavVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let menuButton = UIButton(type: UIButtonType.system)
        menuButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        menuButton.addTarget(self, action: #selector(openSearch), for:    .touchUpInside)
        menuButton.setImage(UIImage(named: "gsearch.png"), for: UIControlState())
        let menuBarButtonItem = UIBarButtonItem(customView: menuButton)
        
        navigationItem.leftBarButtonItems = [menuBarButtonItem]
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func openSearch() {
        
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
