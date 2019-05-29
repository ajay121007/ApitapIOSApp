//
//  ForgotPasswordVC.m
//  ApiTap
//
//  Created by appzorro on 10/25/16.
//  Copyright © 2016 ApiTap. All rights reserved.
//

#import "ForgotPasswordVC.h"


@interface ForgotPasswordVC ()

@property (weak, nonatomic) IBOutlet UITextField *emailtextfield;

@end

@implementation ForgotPasswordVC




- (void)viewDidLoad
{
    [super viewDidLoad];
    
  
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden=YES;
}


-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    

}
-(void)createAlertForChkingTxtFields:(NSString *)msg
{
    UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    alert1.message=msg;
    [alert1 show];
}
- (IBAction)backButonAction:(id)sender {
    
    
    [self.navigationController popViewControllerAnimated:true];
    
}
- (IBAction)passwordResetAction:(id)sender {
    
    if(_emailtextfield.text.length == 0)
    {
        
        [self createAlertForChkingTxtFields:@"Enter your email"];
        return;
    }
    
    if (![self validEmail:_emailtextfield.text])
            {
               
                 [self createAlertForChkingTxtFields:@"Enter valid email"];
                
                return;
            }
    
    [_emailtextfield resignFirstResponder];
   
    if (![self checkInternetConeection]) {
        
        return;
    }
    
        NSMutableArray *arrObjectPARAM= [[NSMutableArray alloc] initWithObjects:_emailtextfield.text, nil];
        NSMutableArray *arrKeyPARAM = [[NSMutableArray alloc] initWithObjects:@"114.7", nil];
    
        NSMutableDictionary *dictPARAM=[[NSMutableDictionary alloc]initWithObjects:arrObjectPARAM forKeys:arrKeyPARAM];
    
    
        [model_manager.loginManager verifyUserEmail:kRequestForForgetPassword userinfo:dictPARAM completionResponse:^(NSDictionary *dict, NSError *err) {
            if (!err)
            {
                NSLog(@"Signup response : %@",dict);
            }
            
        }];
    
    
}

-(BOOL)validEmail:(NSString*)emailString
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:emailString];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    return true;
}

@end
