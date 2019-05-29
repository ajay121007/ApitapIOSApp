//
//  SignUp.m
//  SportsPal
//
//  Created by Abhishek Singla on 10/03/16.
//  Copyright © 2016 SportsPal. All rights reserved.
//

#import "SignUp.h"
#import "SVProgressHUD.h"

@interface SignUp () {
    
    NSArray *arrGender;
    NSString *strGender ;
}

@property (weak, nonatomic) IBOutlet UILabel *lblSignIn;

@property (weak, nonatomic) IBOutlet UITextField *txtFirstName;

@property (weak, nonatomic) IBOutlet UITextField *txtLastName;

@property (weak, nonatomic) IBOutlet UITextField *txtEmail;

@property (weak, nonatomic) IBOutlet UIButton *btnGender;

@property (weak, nonatomic) IBOutlet UIView *pickerView;



@end

@implementation SignUp

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.lblSignIn.hidden=YES;
    self.pickerView.hidden=YES;
    
    arrGender = [NSArray arrayWithObjects:@"Male",@"Female", nil];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden=YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.hidden=NO;
}
- (void)runSignUpWebserviceWithServiceCode:(NSString *)serviceCodeID
{
    
    
    if (![self checkInternetConeection]) {
        
        return;
    }
    
    [SVProgressHUD showWithStatus:@"Loading....."];
    
    //NSMutableDictionary *dictLoginInfo = [NSMutableDictionary new];
    
    NSMutableArray *arrObjectPARAM=nil;
    NSMutableArray *arrKeyPARAM =nil;
    NSMutableDictionary *dictPARAM =nil;
    
    if ([serviceCodeID isEqualToString:kVerifyEmail]) {
        
        arrObjectPARAM= [[NSMutableArray alloc] initWithObjects:self.txtEmail.text,nil];
        arrKeyPARAM = [[NSMutableArray alloc] initWithObjects:@"114.7", nil];
        dictPARAM=[[NSMutableDictionary alloc]initWithObjects:arrObjectPARAM forKeys:arrKeyPARAM];
        
        
        [model_manager.loginManager verifyUserEmail:kVerifyEmail userinfo:dictPARAM completionResponse:^(NSDictionary *dict, NSError *err) {
            
            [SVProgressHUD dismiss];
            
            if (!err)
            {
                
                if (![[dict valueForKey:@"122.73"] boolValue])
                {
                    NSLog(@"hit signup service here");
                    [self runSignUpWebserviceWithServiceCode:kRequestSignUp];
                }
                else{
                    NSLog(@"push to next controler");
                }
            }
        }];
    }
    
    else if ([serviceCodeID isEqualToString:kRequestSignUp]) {
        
        
        NSString *gender=[self.btnGender titleLabel].text;
        NSString *strgender = [gender stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSString *codeForGender=nil;
        
        if ([strgender isEqualToString:@"Male"]) {
            codeForGender = @"51";
        }
        else if ([strgender isEqualToString:@"Female"]) {
            codeForGender = @"52";
        }
        
        arrObjectPARAM= [[NSMutableArray alloc] initWithObjects:self.txtEmail.text,self.txtFirstName.text,self.txtLastName.text,@"51",@"10",@"100", nil];
        
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

#pragma mark PickerView DataSource

- (NSInteger)numberOfComponentsInPickerView: (UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component

{
    return [arrGender count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return  [arrGender objectAtIndex:row];
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    strGender = arrGender[row];
}



- (IBAction)btnLoginAcrtion:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnCreateAccountAction:(id)sender
{    
    
    
    if (self.txtEmail.text.length > 0 ) {
        
        [self performSelector:@selector(runSignUpWebserviceWithServiceCode:) withObject:@"050400009" afterDelay:0.1];
        
        
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Email not match!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (IBAction)btnGenderAction:(id)sender {
    
    self.pickerView.hidden = false;
}

#pragma mark - Custom Functions

- (IBAction)btnDoneAction:(id)sender {
    
    if ((strGender == nil) || [strGender isEqualToString:@""]) {
        strGender = [arrGender objectAtIndex:0];
    }
    
    self.pickerView.hidden = YES;
    [self.btnGender setTitle:strGender forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
