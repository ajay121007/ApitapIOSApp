//
//  Login.m
//  SportsPal
//
//  Created by Abhishek Singla on 10/03/16.
//  Copyright © 2016 SportsPal. All rights reserved.
//

#import "Login.h"
#import "ASService.h"
#import "LoginManager.h"
#import "NSData+Base64.h"
#import "AppDelegate.h"
#import "SVProgressHUD.h"
#import "SignUp.h"
#import "ForgotPasswordVC.h"
#import "ApiTap-Swift.h"
//bikramdhiman01@gmail.com

//Bikram@786

@interface Login ()
{
    
    UIStoryboard *mainStoryboard;
    UIViewController *loginController;
    NSMutableDictionary *dictLoginParams;
    NSString *dateString;
    NSString *strApplicationUUID;
    
    
    __weak IBOutlet UILabel *lblSignUp;
    
    
    //SignIn view outlets
    
    __weak IBOutlet UITextField *loginTxtEmail;
    
    __weak IBOutlet UITextField *LoginTxtPassword;
    
    BOOL isLoginViewVisible;
    
    
    NSString *completeName;
    
    NSArray *arrGender;
    NSString *strGender ;
    
}
@property (nonatomic,strong) PagerVC *PagerVC;
@end

@implementation Login


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    lblSignUp.hidden=YES;
    lbl_GuestLine.hidden=YES;
        
    

    
    [self callInitialWebService];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden=NO;
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.hidden=NO;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
   
}


- (IBAction)clkSignUP:(id)sender {
    
 
    
    SignUp* controller = [self.storyboard instantiateViewControllerWithIdentifier:@"SignUp"];
    
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)runSignUpWebserviceWithServiceCode:(NSString *)serviceCodeID
{
    
    //NSMutableDictionary *dictLoginInfo = [NSMutableDictionary new];
    if (![self checkInternetConeection]) {
        
        return;
    }
    
    NSMutableArray *arrObjectPARAM=nil;
    NSMutableArray *arrKeyPARAM =nil;
    NSMutableDictionary *dictPARAM =nil;
    
    if ([serviceCodeID isEqualToString:kVerifyEmail]) {
        
        arrObjectPARAM= [[NSMutableArray alloc] initWithObjects:txtEmail.text,nil];
        arrKeyPARAM = [[NSMutableArray alloc] initWithObjects:@"114.7", nil];
        dictPARAM=[[NSMutableDictionary alloc]initWithObjects:arrObjectPARAM forKeys:arrKeyPARAM];
        
        [model_manager.loginManager verifyUserEmail:kVerifyEmail userinfo:dictPARAM completionResponse:^(NSDictionary *dict, NSError *err) {
            if (!err)
            {
                
                if (![[dict valueForKey:@"122.73"] boolValue])
                {
                    
                    [self runSignUpWebserviceWithServiceCode:kRequestSignUp];
                }
                else{
                   
                }
            }
        }];
    }
    
    else if ([serviceCodeID isEqualToString:kRequestSignUp]) {
        
       
        NSString *gender=[btnGender titleLabel].text;
        NSString *strgender = [gender stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSString *codeForGender=nil;
        
        if ([strgender isEqualToString:@"Male"]) {
            codeForGender = @"51";
        }
        else if ([strgender isEqualToString:@"Female"]) {
            codeForGender = @"52";
        }
        
        arrObjectPARAM= [[NSMutableArray alloc] initWithObjects:txtEmail.text,txtFirstName.text,txtLastName.text,codeForGender,@"10",@"100", nil];
        
        arrKeyPARAM = [[NSMutableArray alloc] initWithObjects:@"114.7",@"114.3",@"114.5",@"114.11",@"55",@"56", nil];
        
        dictPARAM=[[NSMutableDictionary alloc]initWithObjects:arrObjectPARAM forKeys:arrKeyPARAM];
        
        
        
        [model_manager.loginManager verifyUserEmail:@"030300120" userinfo:dictPARAM completionResponse:^(NSDictionary *dict, NSError *err) {
            if (!err)
            {
                NSLog(@"Signup response : %@",dict);
            }
            
        }];
    }
    
    
    
    
}

-(BOOL)chkTxtFieldFilled:(NSString *)txt
{
    return ([[txt stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] > 0);
}

-(void)createAlertForChkingTxtFields:(NSString *)msg
{
    UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    alert1.message=msg;
    [alert1 show];
}

- (IBAction)createAccount:(id)sender
{
    
    
    
    //[scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    
    
    if(![self chkTxtFieldFilled:txtEmail.text])
    {
        txtEmail.text = @"";
        [self createAlertForChkingTxtFields:@"Enter your first name"];
        return;
    }
    else if(![self chkTxtFieldFilled:txtFirstName.text])
    {
        txtFirstName.text=@"";
        [self createAlertForChkingTxtFields:@"Enter your last name"];
        return;
    }
    else if(![self chkTxtFieldFilled:txtLastName.text])
    {
        txtLastName.text=@"";
        [self createAlertForChkingTxtFields:@"Enter your email"];
        return;
    }
    
    
    if (txtEmail.text.length > 0 ) {
        
        [self performSelector:@selector(runSignUpWebserviceWithServiceCode:) withObject:@"050400009" afterDelay:0.1];
        
        
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Email not match!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

#pragma mark - SignIn Functions


- (IBAction)clkSecureLogin:(id)sender {
    
        
    if (![self checkInternetConeection]) {
        
        return;
    }
    
    NSMutableDictionary *dictLoginInfo = [NSMutableDictionary new];
    
    if ([self validEmail:loginTxtEmail.text])
    {
        [dictLoginInfo setValue:loginTxtEmail.text forKey:@""];
    }
    
    else
    {
        [self showAlert:@"Enter correct email id"];
        return
        ;
    }
    
    
    if (LoginTxtPassword.text.length>4)
    {
        [dictLoginInfo setValue:LoginTxtPassword.text forKey:@""];
    }
    else
    {
        [self showAlert:@"Enter correct password"];
        return
        ;
        
    }
    
    
   
    
    [SVProgressHUD showWithStatus:@"Loading....."];
   
    
    NSString * hexStrPassword = [NSString stringWithFormat:@"%@",
                                 [NSData dataWithBytes:[LoginTxtPassword.text cStringUsingEncoding:NSUTF8StringEncoding]
                                                length:strlen([LoginTxtPassword.text cStringUsingEncoding:NSUTF8StringEncoding])]];
    
    for(NSString * toRemove in [NSArray arrayWithObjects:@"<", @">", @" ", nil])
        hexStrPassword = [hexStrPassword stringByReplacingOccurrencesOfString:toRemove withString:@""];
    
    NSDictionary *dictPARAM=@{@"114.7":loginTxtEmail.text,@"52":hexStrPassword,@"57":[GlobalClass getDeviceUUID]};
    
    [model_manager.loginManager userLogin:kRequestLogin userinfo:dictPARAM completionResponse:^(NSDictionary *dict, NSError *err) {
         [SVProgressHUD dismiss];
        if (!err)
        {
            
           
            NSLog(@"%@",dict[@"RESULT"][0][@"_44"]);
            
        
            if ([dict[@"RESULT"][0][@"_44"] isEqualToString:@"Account Not Found"]) {
                
                [CustomAlertView showAlert:@"Alert" message:@"Account Not Found"];
                
            }else{
                
                
                [[NSUserDefaults standardUserDefaults]setObject:dict[@"RESULT"][0][@"RESULT"][0][@"_53"] forKey:@"loginUserID"];
                [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"checkGuest"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                [self performSegueWithIdentifier:@"PagerVC" sender:nil];
              //  [self performSegueWithIdentifier:@"nav" sender:nil];
              //  [self performSegueWithIdentifier:@"goTo_HomeVC" sender:nil];
              //  [self performSegueWithIdentifier:@"goto_home_vc" sender:nil];
            }
           
        }
        
    }];
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if ([segue.identifier isEqualToString:@"PagerVC"]) {
         _PagerVC = [segue destinationViewController];
     }
   
}


- (NSString *)base64Encode:(NSString *)plainText
{
    NSData *plainTextData = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [plainTextData base64EncodedString];
    return base64String;
}

- (IBAction)clkForgotPassword:(id)sender {
    
    

    
    ForgotPasswordVC* controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ForgotPasswordVC"];
    
    [self.navigationController pushViewController:controller animated:YES];

}

- (IBAction)btnGuestAction:(id)sender {
    
    lbl_GuestLine.hidden=NO;
    [btn_Guest setTitleColor:[UIColor colorWithRed:16.0/255.0 green:124.0/255.0 blue:213.0/255.0 alpha:1] forState:UIControlStateNormal];
    
    lbl_GuestLine.backgroundColor=[UIColor colorWithRed:16.0/255.0 green:124.0/255.0 blue:213.0/255.0 alpha:1];
    [btn_Login setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    lbl_LoginLine.backgroundColor=[UIColor blackColor];
    lbl_LoginLine.hidden=YES;
    
    [self clkGuestUserLogin];
}


-(void)clkGuestUserLogin
{
    if (![self checkInternetConeection]) {
        
        return;
    }
    
    NSMutableDictionary *dictParam = [NSMutableDictionary new];
    [dictParam setValue:@"00011010000000000004" forKey:@"53"];
    
     [SVProgressHUD showWithStatus:@"Loading....."];
    [model_manager.loginManager userGuestLogin:kGuestlogin userinfo:dictParam completionResponse:^(NSDictionary *dictJson, NSError *error)
     {
         if (!error)
         {
             [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"checkGuest"];
             [[NSUserDefaults standardUserDefaults]synchronize];
             
             [self performSegueWithIdentifier:@"goto_home_vc" sender:nil];
         }
     }];
    
}


-(void)callInitialWebService
{
    if (![self checkInternetConeection]) {
        
        return;
    }
    
    [SVProgressHUD showWithStatus:@"Loading....."];
   
    
    NSMutableDictionary *dictLoginInfo = [NSMutableDictionary new];
    
    NSMutableDictionary *dictParam = [NSMutableDictionary new];
    [dictParam setValue:@"MOBILE" forKey:@"127.14"];
    
    NSMutableDictionary *dictInternal = [NSMutableDictionary new];
    [dictInternal setValue:@"010100027" forKey:@"101"];
    [dictInternal setValue:dictParam forKey:@"PARAM"];
    
    
    NSMutableArray *arrData = [NSMutableArray new];
    [arrData addObject:dictInternal];
    
    
    [dictLoginInfo setValue:@"07-26-2016 21:17:46.676 +0530" forKey:@"11"];
    [dictLoginInfo setValue:@"34384244444542452d363633442d343139442d424535392d423834444344393237413742" forKey:@"57"];
    //    8f09eaddb545ff7c94b3c7106eede715
    //    feefc7e1ffc9c1f0aa853c8bac8c6c18
    [dictLoginInfo setValue:@"8f09eaddb545ff7c94b3c7106eede715" forKey:@"192"];
    [dictLoginInfo setValue:@"en" forKey:@"122.45"];
    [dictLoginInfo setValue:@"30.7141193" forKey:@"120.38"];
    [dictLoginInfo setValue:@"76.6898504" forKey:@"120.39"];
    [dictLoginInfo setValue:arrData forKey:@"OPTLST"];
    
    
    [[NSUserDefaults standardUserDefaults]setObject:dictLoginInfo forKey:@"defaultdict"];
    
    
    
    [model_manager.loginManager initialService:dictLoginInfo completion:^(NSDictionary *dictJson, NSError *error) {
        if (!error)
        {
            
            dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
           
            });
 
        }
    }];
    
    
}

#pragma mark - Genric Functions

-(BOOL)validEmail:(NSString*)emailString
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:emailString];
}

-(void)showAlert:(NSString *)errorMsg
{
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Error"
                                  message:errorMsg
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleCancel
                         handler:^(UIAlertAction * action)
                         {
                             //Do some thing here
                             //   [view dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    [alert addAction:ok];
    
}


-(NSString *)getTimeStamp {
    
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"MM-dd-yyyy HH:mm:ss.SSS Z"];
    //[formatter setDateFormat:@"MM-dd-yyyy HH:mm:s.SSS Z"];
    //Optionally for time zone converstions
    //[formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
    NSString *stringFromDate = [formatter stringFromDate:date];
    return stringFromDate;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    return true;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
