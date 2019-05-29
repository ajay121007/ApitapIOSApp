//
//  SettingsVC.swift
//  ApiTap
//
//  Created by Ashish on 22/11/17.
//  Copyright © 2017 ApiTap. All rights reserved.
//

import UIKit

class SettingsVC: BaseViewController {
    @IBOutlet weak var settingWebViewPage: UIWebView!

    @IBOutlet weak var settingWebView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeNavBar()
        self.setbarButtonItems()
        let url = URL(string: "http://209.46.35.217:8020/SettingsMobile/?nmcId=")
        settingWebViewPage.loadRequest(URLRequest(url: url!))
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
