//
//  ShoppingAssistantCollectionViewCell.swift
//  iCaraousal
//
//  Created by appzorro on 3/13/18.
//  Copyright © 2018 appzorro. All rights reserved.
//

import UIKit

class ShoppingAssistantCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var addNewView: UIView!
    @IBOutlet weak var listLbl: UILabel!
    @IBOutlet var backToArrow: UIButton!
    @IBOutlet weak var savedListView: UIView!
    
    @IBOutlet var addEventBtn: UIButton!
    @IBOutlet var addEventTxtView: UITextView!
    @IBOutlet var alertView: UIView!
    @IBOutlet var shoppingAssistantTblView: UITableView!
    override func layoutSubviews() {
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.blue.cgColor
    }
    
}
