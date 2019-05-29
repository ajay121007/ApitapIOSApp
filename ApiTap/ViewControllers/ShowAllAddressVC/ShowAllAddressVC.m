//
//  ShowAllAddressVC.m
//  ApiTap
//
//  Created by Bikramjeet Singh on 8/26/16.
//  Copyright © 2016 ApiTap. All rights reserved.
//

#import "ShowAllAddressVC.h"
#import "SavedAddressCell.h"
#import "EditAddressVC.h"
#import "SVProgressHUD.h"

@interface ShowAllAddressVC () {
    
    NSMutableArray *arrAllUserAddress;
    NSArray *arrGetAddress;
}


@property (weak, nonatomic) IBOutlet UITableView *tblSavedAddress;

@end

@implementation ShowAllAddressVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = LightGreyColor;
    
    self.navigationController.navigationBarHidden = NO;
    
    self.navigationController.navigationBar.barTintColor = BlueColor;
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    [self getAllAddressLists];
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    
    [self initializeNavBar];
    [self setbarButtonItems];
}

-(void)getAllAddressLists {
    if (![self checkInternetConeection]) {
        
        return;
    }

    [SVProgressHUD showWithStatus:@"Loading....."];
    
    NSMutableDictionary *dictParam = [NSMutableDictionary new];
    
    [dictParam setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"loginUserID"] forKey:@"53"];
        
    
    [model_manager.addressManager getCountryStateCityList:@"010100055" userinfo:dictParam completionResponse:^(NSArray *arrImages, NSError *error)
     
     {
          [SVProgressHUD dismiss];
         
         if (!error)
         {
             if ([arrImages[0][@"AD"] count] ==0) {
                 
                
                 
             }else {
             
                 arrAllUserAddress=[NSMutableArray new];
              
                 [arrAllUserAddress  addObjectsFromArray:arrImages[0][@"AD"]];
                 
                 [self.tblSavedAddress reloadData];
             }
         }
         
     }];
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return arrAllUserAddress.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"SavedAddressCell";
    
    SavedAddressCell *cell = (SavedAddressCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.lblAddressType.text=arrAllUserAddress[indexPath.row][@"_114_53"];
    cell.lblFirstAddress.text=arrAllUserAddress[indexPath.row][@"_114_12"];
    cell.lblSecondAddress.text=arrAllUserAddress[indexPath.row][@"_114_13"];
    cell.lblCity.text=[[arrAllUserAddress[indexPath.row][@"CI"][@"_47_15"] stringByAppendingString:@" - "]stringByAppendingString:arrAllUserAddress[indexPath.row][@"ZP"][@"_122_107"]];
    cell.lblState.text=arrAllUserAddress[indexPath.row][@"ST"][@"_47_16"];
    cell.lblPhoneNumber.text=[@"Mobile - " stringByAppendingString:arrAllUserAddress[indexPath.row][@"_114_18"]];
    
    cell.btnEdit.tag=indexPath.row;
    
    [cell.btnEdit addTarget:self action:@selector(btnEditClicked:)
                   forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
    
}

- (IBAction)btnEditClicked:(UIButton *)sender {
    
    arrGetAddress=arrAllUserAddress[sender.tag];
    
    [self performSegueWithIdentifier:@"got_editvc" sender:nil];
    
}

- (IBAction)btnAddAddressAction:(id)sender {
    
    [self performSegueWithIdentifier:@"goto_newaddressvc" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"got_editvc"])
    {
        EditAddressVC *obj = [segue destinationViewController];
        obj.arrAddress=arrGetAddress;
        
    }
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
