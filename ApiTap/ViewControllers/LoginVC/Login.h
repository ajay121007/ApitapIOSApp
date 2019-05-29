//
//  Login.h
//  SportsPal
//
//  Created by Abhishek Singla on 10/03/16.
//  Copyright © 2016 SportsPal. All rights reserved.
//

#import <UIKit/UIKit.h>

//testmc@nmc.com
//Aa1#aaaa


//info@appzorro.com
//Appzorro123

@interface Login : BaseViewController {
    
    __weak IBOutlet UIButton *btnLogin;
    
    __weak IBOutlet UIButton *btnSignUp;
    
    __weak IBOutlet UITextField *txtFirstName;
    
    __weak IBOutlet UITextField *txtLastName;
    
    __weak IBOutlet UITextField *txtEmail;
    
    __weak IBOutlet UIButton *btnGender;
    
    __weak IBOutlet UIButton *btnCreateAccount;
    
    __weak IBOutlet UILabel *lblAgreePrivacyPolicy;
    
    __weak IBOutlet UILabel *lbl_Guest;
    
    __weak IBOutlet UILabel *lbl_GuestLine;
    
    __weak IBOutlet UILabel *lbl_LoginLine;
   
    __weak IBOutlet UIButton *btn_Guest;
    
    __weak IBOutlet UIButton *btn_Login;
    
    
}



@end
