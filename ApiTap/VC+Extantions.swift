//
//  VC+Extantions.swift
//  ApiTap
//
//  Created by Appzorro on 20/07/18.
//  Copyright © 2018 ApiTap. All rights reserved.
//

import Foundation
extension UIViewController
{

    func hexToStr(textValue: String) -> String {
        guard textValue.count % 2 == 0 else {
            return textValue
        }
        
        var bytes = [CChar]()
        
        var startIndex = textValue.index(textValue.startIndex, offsetBy: 2)
        while startIndex < textValue.endIndex {
            let endIndex = textValue.index(startIndex, offsetBy: 2)
            let substr = textValue[startIndex..<endIndex]
            
            if let byte = Int8(substr, radix: 16) {
                bytes.append(byte)
            } else {
                return textValue
            }
            
            startIndex = endIndex
        }
        
        bytes.append(0)
        return String(cString: bytes)
    }
}


extension UIView
{
    func cornerRadius(){
        self.layoutIfNeeded()
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
    func edigeRadius(){
        self.layoutIfNeeded()
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
    }
    //set bordercolor
    func borderColor(color: UIColor,boderWidth: CGFloat){
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = boderWidth
    }
    
    //set borderWidth
    func SetCellProparty()
    {
    self.layer.borderWidth = 1
    self.layer.borderColor = UIColor(red: 220/256.0, green: 220/256.0, blue: 220/256.0, alpha: 1.0).cgColor
    self.layer.cornerRadius = 5
    self.clipsToBounds = true
    
    self.layer.masksToBounds = false
    self.layer.shadowColor = UIColor.lightGray.cgColor
    self.layer.shadowOpacity = 0.2
    self.layer.shadowOffset = CGSize(width: -1, height: 1)
    self.layer.shadowRadius = 1
    
    self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    self.layer.shouldRasterize = true
    self.layer.rasterizationScale = 1
    }
  
}

extension UITextField
{
    //check textfield is blank
    func blank() -> Bool{
        let strTrimmed = self.text
        if(strTrimmed?.characters.count == 0)//check textfield is nil or not ,if nil then return false
        {
            return true
        }
        return false
    }
    
    //set begginning space - left space
    func setLeftPadding(paddingValue:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: paddingValue, height: self.frame.size.height))
        self.leftViewMode = .always
        self.leftView = paddingView
    }
    
    //set end of space
    func setRightPadding(paddingValue:CGFloat){
        let paddingView = UIView(frame: CGRect(x: (self.frame.size.width - paddingValue), y: 0, width: paddingValue, height: self.frame.size.height))
        self.rightViewMode = .always
        self.rightView = paddingView
    }
}
