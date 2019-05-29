//
//  MoreDetailsView.swift
//  ApiTap
//
//  Created by Ashish on 28/03/18.
//  Copyright © 2018 ApiTap. All rights reserved.
//

import Foundation
class MoreDetailsView:UIView{
    @IBOutlet weak var barCodeLbl: UILabel!
   @IBOutlet weak var moreDetailLbl: UILabel!
     @IBOutlet weak var posSkuLbl: UILabel!
@IBOutlet weak var view: UIView!
    @IBOutlet var ageView: UIView!
    
    @IBOutlet var moreDetailView: UIView!
    @IBOutlet var modelView: UIView!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var ageRegister21: UIButton!
    @IBOutlet weak var ageRegister18: UIButton!
    @IBOutlet weak var limitQuantityLbl: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet var age18Lbl: UILabel!
    
    @IBOutlet var age21Lbl: UILabel!
    
override init(frame: CGRect) {
    super.init(frame: frame)
    nibSetup()
}

required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    nibSetup()
}

private func nibSetup() {
   

    view = loadViewFromNib()

    
    view.frame = bounds
    view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    addSubview(view)
    //view.translatesAutoresizingMaskIntoConstraints = true
}

    @IBAction func doneBtnTap(_ sender: Any) {
        view.isHidden=true
    }
    private func loadViewFromNib() -> UIView {
    let bundle = Bundle(for: type(of: self))
    let nib = UINib(nibName: "MoreDetailsView", bundle: bundle)
    let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        textView.layer.borderWidth = 1.0
        
        textView.layer.borderColor = UIColor.blue.cgColor
        
        modelView.layer.borderWidth = 1
        modelView.layer.borderColor = UIColor(red: 220/256.0, green: 220/256.0, blue: 220/256.0, alpha: 1.0).cgColor
        modelView.layer.cornerRadius = 8.0
       modelView.clipsToBounds = true
        
        modelView.layer.masksToBounds = false
        modelView.layer.shadowColor = UIColor.lightGray.cgColor
        modelView.layer.shadowOpacity = 0.3
        modelView.layer.shadowOffset = CGSize(width: -1, height: 1)
        modelView.layer.shadowRadius = 1
        
      //  modelView.layer.shadowPath = UIBezierPath(rect: self.view.bounds).cgPath
        modelView.layer.shouldRasterize = true
        modelView.layer.rasterizationScale = 1
        
        moreDetailView.layer.borderWidth = 1
        moreDetailView.layer.borderColor = UIColor(red: 220/256.0, green: 220/256.0, blue: 220/256.0, alpha: 1.0).cgColor
        moreDetailView.layer.cornerRadius = 8.0
        moreDetailView.clipsToBounds = true
        
        moreDetailView.layer.masksToBounds = false
        moreDetailView.layer.shadowColor = UIColor.lightGray.cgColor
        moreDetailView.layer.shadowOpacity = 0.3
        moreDetailView.layer.shadowOffset = CGSize(width: -1, height: 1)
        moreDetailView.layer.shadowRadius = 1
        
        //  modelView.layer.shadowPath = UIBezierPath(rect: self.view.bounds).cgPath
        moreDetailView.layer.shouldRasterize = true
        moreDetailView.layer.rasterizationScale = 1
        
        
        
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor(red: 220/256.0, green: 220/256.0, blue: 220/256.0, alpha: 1.0).cgColor
        textView.layer.cornerRadius = 8.0
        textView.clipsToBounds = true
        
        textView.layer.masksToBounds = false
        textView.layer.shadowColor = UIColor.lightGray.cgColor
        textView.layer.shadowOpacity = 0.3
        textView.layer.shadowOffset = CGSize(width: -1, height: 1)
        textView.layer.shadowRadius = 1
        
        //  modelView.layer.shadowPath = UIBezierPath(rect: self.view.bounds).cgPath
        textView.layer.shouldRasterize = true
        textView.layer.rasterizationScale = 1
    return nibView
}
}
