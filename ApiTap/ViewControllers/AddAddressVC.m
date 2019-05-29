//
//  AddAddressVC.m
//  ApiTap
//
//  Created by Bikramjeet Singh on 8/26/16.
//  Copyright © 2016 ApiTap. All rights reserved.
//

#import "AddAddressVC.h"
#import "ShowLists.h"
#import "SVProgressHUD.h"

@interface AddAddressVC () {
    
    NSMutableArray *arrGetLists,*arrCountryLists,*arrStateLists,*arrCitiesLists;
    NSString *getID,*countryID,*stateID,*cityID,*zipCode;
}

@property (weak, nonatomic) IBOutlet UITextField *txtUserName;

@property (weak, nonatomic) IBOutlet UITextField *txtFirstAddress;

@property (weak, nonatomic) IBOutlet UITextField *txtSecondAddress;

@property (weak, nonatomic) IBOutlet UITextField *txtPinCode;

@property (weak, nonatomic) IBOutlet UITextField *txtMobileNo;

@property (weak, nonatomic) IBOutlet UITableView *tblShowLists;

@property (weak, nonatomic) IBOutlet UIButton *btnCountry;

@property (weak, nonatomic) IBOutlet UIButton *btnState;

@property (weak, nonatomic) IBOutlet UIButton *btnCity;

@property (weak, nonatomic) IBOutlet UIView *AddressView;

@end

@implementation AddAddressVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
        
     self.tblShowLists.hidden=YES;
    
    self.AddressView.layer.cornerRadius = 5 ;
    self.AddressView.layer.masksToBounds = YES ; 
    
    
   
}

- (BOOL) textFieldShouldReturn:(UITextField *)theTextField
{
   
    [theTextField resignFirstResponder];
   
    return YES;
}

-(void)addNewAddress {
    
    if (![self checkInternetConeection]) {
        
        return;
    }
    NSMutableDictionary *dictParam = [NSMutableDictionary new];
    
    [dictParam setValue:_txtUserName.text forKey:@"114.53"];
    
    [dictParam setValue:@"00000000000" forKey:@"121.45"];
    
    [dictParam setValue:_txtFirstAddress.text forKey:@"114.12"];
    
    [dictParam setValue:_txtSecondAddress.text forKey:@"114.13"];
    
    [dictParam setValue:[GlobalClass makeElevenDigitNumber:countryID] forKey:@"122.87"];
    
    [dictParam setValue:stateID forKey:@"120.13"];
    
    [dictParam setValue:[GlobalClass makeElevenDigitNumber:cityID] forKey:@"114.14"];
    
    [dictParam setValue:[GlobalClass makeElevenDigitNumber:zipCode] forKey:@"122.107"];
    
    [dictParam setValue:_txtMobileNo.text forKey:@"114.18"];
    
    [dictParam setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"loginUserID"] forKey:@"53"];
    
    [dictParam setValue:@"" forKey:@"120.38"];
    
    [dictParam setValue:@"" forKey:@"120.39"];
    
   
    [model_manager.loginManager userLogin:@"030400056" userinfo:dictParam completionResponse:^(NSDictionary *dict, NSError *err) {
        if (!err)
        {
            
        }
        
    }];
    
}


-(void)getCountryLists {
    if (![self checkInternetConeection]) {
        
        return;
    }
    [SVProgressHUD showWithStatus:@"Loading....."];
    
    NSMutableDictionary *dictParam = [NSMutableDictionary new];
    
    [dictParam setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"loginUserID"] forKey:@"53"];
    
    [model_manager.addressManager getCountryStateCityList:@"010100232" userinfo:dictParam completionResponse:^(NSArray *arrImages, NSError *error)
     {
         
         [SVProgressHUD dismiss];
         
         if (!error)
         {
             arrGetLists=[NSMutableArray new];
             arrCountryLists=[NSMutableArray new];
             
             [arrGetLists addObjectsFromArray:arrImages[0][@"CO"]];
             
             [arrCountryLists addObjectsFromArray:arrImages[0][@"CO"]];
             
             self.tblShowLists.hidden=NO;
             
             [[NSUserDefaults standardUserDefaults]setObject:arrGetLists forKey:@"countryList"];
             
             [self.tblShowLists reloadData];
             
         }
         
     }];
    
}

-(void)getZipCodeLists {
    if (![self checkInternetConeection]) {
        
        return;
    }
    
    [SVProgressHUD showWithStatus:@"Loading....."];
    
    NSMutableDictionary *dictParam = [NSMutableDictionary new];
    
    [dictParam setValue:[GlobalClass makeElevenDigitNumber:cityID] forKey:@"114.14"];
    [dictParam setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"loginUserID"] forKey:@"53"];
    
    [model_manager.addressManager getCountryStateCityList:@"010100235" userinfo:dictParam completionResponse:^(NSArray *arrImages, NSError *error)
     {
         
         [SVProgressHUD dismiss];
         
         if (!error)
         {
             zipCode=arrImages[0][@"ZP"][0][@"_122_107"];
         }
         
     }];
    
}


-(void)getStateLists :(NSString *)countryCode {
    if (![self checkInternetConeection]) {
        
        return;
    }
    [SVProgressHUD showWithStatus:@"Loading....."];
    
    NSMutableDictionary *dictParam = [NSMutableDictionary new];
    
    [dictParam setValue:[GlobalClass makeElevenDigitNumber:countryCode] forKey:@"122.87"];
    
    [dictParam setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"loginUserID"] forKey:@"53"];
    
    [model_manager.addressManager getCountryStateCityList:@"010100233" userinfo:dictParam completionResponse:^(NSArray *arrImages, NSError *error)
     {
         
         [SVProgressHUD dismiss];
         
         if (!error)
         {
             arrGetLists=[NSMutableArray new];
             arrStateLists=[NSMutableArray new];
             
             if ([arrImages[0][@"ST"] count] ==0) {
                 
                 [arrGetLists addObjectsFromArray:arrImages[0][@"ST"]];
                 [arrStateLists addObjectsFromArray:arrImages[0][@"ST"]];
                 
                self.tblShowLists.hidden=NO;
                 
             }else {
                
                 [arrGetLists addObjectsFromArray:arrImages[0][@"ST"]];
                 [arrStateLists addObjectsFromArray:arrImages[0][@"ST"]];
                 
                 self.tblShowLists.hidden=NO;
                 
                 [[NSUserDefaults standardUserDefaults]setObject:arrGetLists forKey:@"stateList"];
            }
             
           [self.tblShowLists reloadData];
             
         }
         
     }];
    
}

-(void)getCitiesLists :(NSString *)countryCode {
    if (![self checkInternetConeection]) {
        
        return;
    }     [SVProgressHUD showWithStatus:@"Loading....."];
    
    NSMutableDictionary *dictParam = [NSMutableDictionary new];
    
    [dictParam setValue:[GlobalClass makeElevenDigitNumber:countryCode] forKey:@"120.13"];
        
    [dictParam setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"loginUserID"] forKey:@"53"];
    
    [model_manager.addressManager getCountryStateCityList:@"010100234" userinfo:dictParam completionResponse:^(NSArray *arrImages, NSError *error)
     {
         
         [SVProgressHUD dismiss];
         
         if (!error)
         {
             arrGetLists=[NSMutableArray new];
             arrCitiesLists=[NSMutableArray new];
             
             if ([arrImages[0][@"CI"] count] ==0) {
                 
                 [arrGetLists addObjectsFromArray:arrImages[0][@"CI"]];
                 [arrCitiesLists addObjectsFromArray:arrImages[0][@"CI"]];
                 
                 self.tblShowLists.hidden=NO;
                 
             }else {
                 
                 [arrGetLists addObjectsFromArray:arrImages[0][@"CI"]];
                 [arrCitiesLists addObjectsFromArray:arrImages[0][@"CI"]];
                 
                 self.tblShowLists.hidden=NO;
                 
             }

             [self.tblShowLists reloadData];
         }
         
     }];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return arrGetLists.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"ShowLists";
    
    ShowLists *cell = (ShowLists *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    if ([[arrGetLists objectAtIndex:indexPath.row]valueForKey:@"_47_18"]) {
        
        cell.lblShowName.text=arrGetLists[indexPath.row][@"_47_18"];
        
    }else if ([[arrGetLists objectAtIndex:indexPath.row]valueForKey:@"_47_16"]) {
        
        cell.lblShowName.text=arrGetLists[indexPath.row][@"_47_16"];
        
    }else {
        
         cell.lblShowName.text=arrGetLists[indexPath.row][@"_47_15"];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![self checkInternetConeection]) {
        
        return;
    }
    self.tblShowLists.hidden=YES;
    
    if ([[arrGetLists objectAtIndex:indexPath.row]valueForKey:@"_47_18"]) {
        
        getID=arrGetLists[indexPath.row][@"_122_87"];
        
        countryID=arrGetLists[indexPath.row][@"_122_87"];
        
       // _btnCountry.titleLabel.textColor=[UIColor blackColor];
        [_btnCountry setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btnCountry setTitle:arrGetLists[indexPath.row][@"_47_18"] forState:UIControlStateNormal];
        
        
        
    }else if ([[arrGetLists objectAtIndex:indexPath.row]valueForKey:@"_47_16"]) {
        
        getID=arrGetLists[indexPath.row][@"_120_13"];
        stateID=arrGetLists[indexPath.row][@"_120_13"];
        
        [_btnState setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btnState setTitle:arrGetLists[indexPath.row][@"_47_16"] forState:UIControlStateNormal];
        
        
    } else {
        
        NSLog(@"%@",arrGetLists);
        
        cityID=arrGetLists[indexPath.row][@"_114_14"];
        
        [_btnCity setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btnCity setTitle:arrGetLists[indexPath.row][@"_47_15"] forState:UIControlStateNormal];
        
        [self getZipCodeLists];
        
    }
    
}

- (IBAction)btnCountryAction:(id)sender {
    
    
    arrGetLists=[[NSUserDefaults standardUserDefaults]valueForKey:@"countryList"];
    
    if (arrGetLists.count ==0) {
        
        [self getCountryLists];
        
    }else {
        
        self.tblShowLists.hidden=NO;
        [self.tblShowLists reloadData];
        
    }
}

- (IBAction)btnStateAction:(id)sender {
    
    
    if (arrStateLists.count ==0) {
        
         [self getStateLists:getID];
        
    }else {
        
        self.tblShowLists.hidden=NO;
    }
    
   
}


- (IBAction)btnCityAction:(id)sender {
    
    if (arrCitiesLists.count ==0) {
        
        [self getCitiesLists:getID];
        
    }else {
        
        self.tblShowLists.hidden=NO;
    }
    
}

- (IBAction)btnSaveDeliveryAddressAction:(id)sender {
    
    [self addNewAddress];
}

- (IBAction)btnAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
