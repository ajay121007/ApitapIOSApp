//
//  AddCartVC.m
//  ApiTap
//
//  Created by Bikramjeet Singh on 8/26/16.
//  Copyright © 2016 ApiTap. All rights reserved.
//

#import "AddCartVC.h"
#import "AddCartCell.h"
#import "FillAddressInfoCell.h"
#import "SavedAddressCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "SVProgressHUD.h"
#import "AddAddressVC.h"
#import "EditAddressVC.h"
#import "NIDropDown.h"

@interface AddCartVC () <NIDropDownDelegate> {
    
    NSMutableArray *arrAllUserAddress,*arrCartsItems,*arrGetDeliveryOptions;
    NIDropDown *dropDown;
    NSMutableArray *arrGender,*arrSetDelivertPrices;
    NSString *strGender ;
    float totalPrice,addAllCartItemsPrice,addmultipleCharge;
    int selectedIndexPath;
    
}

@property (weak, nonatomic) IBOutlet UIView *pickerView;

@property (weak, nonatomic) IBOutlet UIPickerView *showPickerView;

@property (weak, nonatomic) IBOutlet UIView *blurView;

@property (weak, nonatomic) IBOutlet UIView *addressView;

@property (weak, nonatomic) IBOutlet UITableView *tblAddCart;

@property (weak, nonatomic) IBOutlet UITableView *tblSetAddress;

@property (weak, nonatomic) IBOutlet UITableView *tblShowAllAddress;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *setViewTop;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *hideAlertView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *hideButton;

@property (weak, nonatomic) IBOutlet UILabel *lblHideAlert;

@property (weak, nonatomic) IBOutlet UIButton *btnHideAlert;

@property (weak, nonatomic) IBOutlet UIView *showAllSavedAdrs;

@property (weak, nonatomic) IBOutlet UIView *addNewAddressView;

@property (weak, nonatomic) IBOutlet UIScrollView *showScrollView;

@property (weak, nonatomic) IBOutlet UIView *fotterView;

@property (weak, nonatomic) IBOutlet UILabel *lbl_ShowSubtotal;

@property (weak, nonatomic) IBOutlet UILabel *lbl_ShipingCharge;

@property (weak, nonatomic) IBOutlet UILabel *lbl_Total;

@end

@implementation AddCartVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.pickerView.hidden=YES;
    strGender=@"0.00";
    self.lbl_ShipingCharge.text = strGender;
    
    //[self initializeNavBar];
    
   // [self setbarButtonItems];
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureHandlerMethod:)];
    
    [self.addNewAddressView addGestureRecognizer:tapRecognizer];
    
    self.showScrollView.hidden=YES;
    self.blurView.hidden=YES;
    self.showAllSavedAdrs.hidden=YES;
    self.fotterView.hidden=YES;
    self.tblAddCart.hidden=YES;
    
    
    NSLog(@"cartid%@",[self.arrShopingCart valueForKey:@"_122_31"]);
    
    [self getItemsOfShoppingCartByID:[self.arrShopingCart valueForKey:@"_122_31"]];
    
    // [self getPlaylistBroadcastMobile:[self.arrShopingCart valueForKey:@"_114_179"]];
    
   [self getAllAddressLists];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
        
    self.navigationItem.title=[self.arrShopingCart valueForKey:@"_114_70"];
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:YES];
    
    self.navigationItem.title=@"";
}


- (void)gestureHandlerMethod:(UITapGestureRecognizer*)sender {
    
    
    
}

-(void)getPlaylistBroadcastMobile : (NSString *)filterID {
    
    if (![self checkInternetConeection]) {
        
        return;
    }    [SVProgressHUD showWithStatus:@"Loading....."];
    
    NSMutableDictionary *dictParam = [NSMutableDictionary new];
    
    [dictParam setValue:filterID forKey:@"53"];
    
    [model_manager.addManager showAdds:@"010100015" userinfo:dictParam completionResponse:^(NSArray *arrImages, NSError *error)
     {
         [SVProgressHUD dismiss];
         
         if (!error)
         {
             
             NSLog(@"%@",arrImages);
             
         }
             
     }];
    
}


-(void)getItemsOfShoppingCartByID : (NSString *)filterID{
    
    if (![self checkInternetConeection]) {
        
        return;
    }
    
    [SVProgressHUD showWithStatus:@"Loading....."];
    
    NSMutableDictionary *dictParam = [NSMutableDictionary new];
    
    [dictParam setValue:filterID forKey:@"122.31"];
    
    [model_manager.addManager getItemsOfShoppingCartById:@"010100201" filterData:@"4501" userinfo:dictParam completionResponse:^(NSArray *arrImages, NSError *error) {
        
        [SVProgressHUD dismiss];
        
        if (!error)
        {
            
            if (arrImages.count == 0) {
                
                [CustomAlertView showAlert:@"Alert" message:@"Data Not Found"];
                
            }else{
                
                
               // NSLog(@"%@",[arrImages valueForKey:@"DE"]);
                
                arrCartsItems=[NSMutableArray new];
                
                [arrCartsItems addObjectsFromArray:arrImages];
                
                arrGetDeliveryOptions=[NSMutableArray new];
                
                [arrGetDeliveryOptions removeAllObjects];
                
                [arrGetDeliveryOptions addObjectsFromArray:[arrImages valueForKey:@"DE"]];
                
                //NSLog(@"%@",arrGetDeliveryOptions);
                
               // NSLog(@"%lu",(unsigned long)arrGetDeliveryOptions.count);
                
                self.tblAddCart.hidden=NO;
                
               [self.tblAddCart reloadData];
            }
            
            self.fotterView.hidden=NO;
            
        }
        
    }];
    
}


-(void)getAllAddressLists {
    
    if (![self checkInternetConeection]) {
        
        return;
    }    NSMutableDictionary *dictParam = [NSMutableDictionary new];
    
    [dictParam setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"loginUserID"] forKey:@"53"];
    
    
    [model_manager.addressManager getCountryStateCityList:@"010100055" userinfo:dictParam completionResponse:^(NSArray *arrImages, NSError *error)
     
     {
         
         if (!error)
         {
             if ([arrImages[0][@"AD"] count] ==0) {
                 
                 
                 
             }else {
                 
                 arrAllUserAddress=[NSMutableArray new];
                 
                 [arrAllUserAddress  addObjectsFromArray:arrImages[0][@"AD"]];
                 
                 [self.tblShowAllAddress reloadData];
             }
         }
         
     }];
    
}

- (IBAction)btnRemoveItemClicked:(UIButton*)sender {
    
    if (![self checkInternetConeection]) {
        
        return;
    }
    
    [SVProgressHUD showWithStatus:@"Loading....."];
    
    NSLog(@"%@",arrCartsItems[sender.tag][@"_121_30"]);
    
    NSMutableDictionary *dictParam = [NSMutableDictionary new];
    
    [dictParam setValue:[GlobalClass makeElevenDigitNumber:arrCartsItems[sender.tag][@"_121_30"]] forKey:@"121.30"];
    
    [model_manager.loginManager userGuestLogin:@"020400203" userinfo:dictParam completionResponse:^(NSDictionary *dictJson, NSError *error)
     {
         
         [SVProgressHUD dismiss];
         
         if (!error)
         {
             
             NSLog(@"guest login response : %@",dictJson);
             
             [self getItemsOfShoppingCartByID:[self.arrShopingCart valueForKey:@"_122_31"]];
             
         }
     }];
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
    
    
        strGender = arrSetDelivertPrices[row];
        self.pickerView.hidden=YES;
        [self.tblAddCart reloadData];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == _tblShowAllAddress) {
        
        self.tblShowAllAddress.estimatedRowHeight = 230.0;
        return UITableViewAutomaticDimension;
        
    }else {
        
        self.tblAddCart.estimatedRowHeight = 220.0;
        return UITableViewAutomaticDimension;
    }
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView ==_tblAddCart) {
        
        return arrCartsItems.count;
    }
    else if (tableView ==_tblSetAddress) {
        
        return 8;
    }
    else
    {
        return arrAllUserAddress.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView ==_tblAddCart) {
        
        static NSString *simpleTableIdentifier = @"AddCartCell";
        
        AddCartCell *cell = (AddCartCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.lblCircle.layer.cornerRadius=cell.lblCircle.frame.size.height/2;
        cell.lblCircle.layer.masksToBounds=YES;
        
        cell.btnItemImage.layer.borderWidth=1.0;
        cell.btnItemImage.layer.borderColor=[UIColor blackColor].CGColor;
        cell.btnItemImage.layer.masksToBounds=YES;
        
        cell.lblBy.text=[@"By " stringByAppendingString:[self.arrShopingCart valueForKey:@"_114_70"]];
        
        NSString *ImageURL =[model_manager.loginManager.login.urlImage stringByAppendingString:arrCartsItems[indexPath.row][@"_121_170"]];
        
        [cell.productImage sd_setImageWithURL:[NSURL URLWithString:ImageURL] placeholderImage:[UIImage imageNamed:@"loading"] options:SDWebImageRefreshCached | SDWebImageRetryFailed];
        
        cell.lblProductName.text=arrCartsItems[indexPath.row][@"_123_41"];
        
        cell.lblQuantity.text=[@"QTY: " stringByAppendingString:arrCartsItems[indexPath.row][@"_114_132"]];
        
        
       // NSLog(@"%@",arrGetDeliveryOptions[0][indexPath.row][@"_122_161"]);
        
    
        
        
        if(selectedIndexPath == indexPath.row){
            
            cell.lblProductPrice.text=[@"$ " stringByAppendingString:strGender];
            
            float selectedServiceCharge = [strGender floatValue];
            
            addmultipleCharge = addmultipleCharge + selectedServiceCharge;
            
        }else{
            
             cell.lblProductPrice.text=[@"$ " stringByAppendingString:@"0.00"];
        }
        
        
        cell.btn_DeliveryOptions.tag=indexPath.row;
        
        [cell.btn_DeliveryOptions addTarget:self action:@selector(openDropDownAction:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.btn_RemoveItem.tag=indexPath.row;
        
        [cell.btn_RemoveItem addTarget:self action:@selector(btnRemoveItemClicked:)
                       forControlEvents:UIControlEventTouchUpInside];
        
        float subTotal = [arrCartsItems[indexPath.row][@"_122_75"] floatValue];
        
        addAllCartItemsPrice = addAllCartItemsPrice + subTotal;
        
        self.lbl_ShowSubtotal.text = [@"$ " stringByAppendingString:[NSString stringWithFormat:@"%.02f",addAllCartItemsPrice]];
        
        
        if (arrCartsItems.count-1 == indexPath.row) {
            
            totalPrice = addAllCartItemsPrice + addmultipleCharge;
            
            self.lbl_ShipingCharge.text = [@"$ " stringByAppendingString:[NSString stringWithFormat:@"%.02f",addmultipleCharge]];
            
            self.lbl_Total.text = [@"$ " stringByAppendingString:[NSString stringWithFormat:@"%.02f",totalPrice]];
        }
        
        return cell;
        
    }
    else if (tableView ==_tblSetAddress) {
        
        static NSString *simpleTableIdentifier = @"FillAddressInfoCell";
        
        FillAddressInfoCell *cell = (FillAddressInfoCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSArray *arrAddressData=@[@"Full Name",@"Address Line 1 (Company Name,House No,Building)",@"Address Line 2 (Colony,Street,Locality/Area)",@"Pin Code",@"City/Town",@"State",@"Mobile Number",@"Save this as Home, Work etc. (Optional)"];
        
        cell.txtName.placeholder=[arrAddressData objectAtIndex:indexPath.row];
        
        return cell;
        
    }
    
    else {
        
        static NSString *simpleTableIdentifier = @"SavedAddressCell";
        
        SavedAddressCell *cell = (SavedAddressCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
        cell.lblPersonName.text=arrAllUserAddress[indexPath.row][@"_114_53"];
        cell.lblFirstAddress.text=arrAllUserAddress[indexPath.row][@"_114_12"];
        cell.lblSecondAddress.text=arrAllUserAddress[indexPath.row][@"_114_13"];
        cell.lblPinCode.text=arrAllUserAddress[indexPath.row][@"ZP"][@"_122_107"];
        
       // cell.lblCity.text=[[arrAllUserAddress[indexPath.row][@"CI"][@"_47_15"] stringByAppendingString:@" - "]stringByAppendingString:arrAllUserAddress[indexPath.row][@"ZP"][@"_122_107"]];
        
       // cell.lblState.text=arrAllUserAddress[indexPath.row][@"ST"][@"_47_16"];
        
        cell.lblPhoneNumber.text=arrAllUserAddress[indexPath.row][@"_114_18"];
        
        cell.btnEdit.tag=indexPath.row;
        
        [cell.btnEdit addTarget:self action:@selector(btnEditClicked:)
               forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
        
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //[self performSegueWithIdentifier:@"goto_payment_vc" sender:nil];
    
}

-(void)openDropDownAction:(UIButton *)sender

{
    
    self.pickerView.hidden = false;
    
    selectedIndexPath = (int)sender.tag;
    
    arrGender = [NSMutableArray new];
    arrSetDelivertPrices = [NSMutableArray new];
    
    
    for (int i=0; i<[arrGetDeliveryOptions[sender.tag] count]; i++) {
        
        [arrGender addObject:[[arrGetDeliveryOptions[sender.tag] objectAtIndex:i] valueForKey:@"_122_39"]];
        [arrSetDelivertPrices addObject:[[arrGetDeliveryOptions[sender.tag] objectAtIndex:i] valueForKey:@"_122_161"]];

    }
    
    
    NSLog(@"%@",arrSetDelivertPrices);
    
    [self.showPickerView reloadAllComponents];
    
    /*if(dropDown == nil) {
        
        CGFloat f = 30*allOptions.count;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :allOptions :nil :@"up"];
        dropDown.delegate = self;
    }
    else {
        
        [dropDown hideDropDown:sender];
        [self rel];
    }*/
}

- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
        
    [self rel];
}

-(void)rel{
    
    //    [dropDown release];
    
    
    
    dropDown = nil;
}


- (IBAction)btnEditClicked:(UIButton *)sender {
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                         bundle:nil];
    EditAddressVC *add = [storyboard instantiateViewControllerWithIdentifier:@"EditAddressVC"];
     add.arrAddress =arrAllUserAddress [sender.tag];
    [self presentViewController:add
                       animated:YES
                     completion:nil];
}

- (IBAction)btnSelectAddress:(id)sender {
    
    
    if (arrAllUserAddress.count != 0) {
        
        self.showAllSavedAdrs.hidden=NO;
        
    }else {
        
        self.blurView.hidden=NO;
        self.showScrollView.hidden=NO;
    }
    
    
    
    self.showAllSavedAdrs.hidden=NO;
    
        [UIView animateWithDuration:1.0
                              delay:1.5
                            options: UIViewAnimationCurveEaseIn
                         animations:^{
    
                             self.blurView.hidden=NO;
    
    
                         }
                         completion:^(BOOL finished){
    
                             self.addressView.hidden=NO;
                             self.setViewTop.constant=self.view.frame.size.height/2;
    
                         }];
    
    
}

- (IBAction)btnBackAction:(id)sender {
    
    self.showScrollView.hidden=YES;
    self.blurView.hidden=YES;
}

- (IBAction)btnSaveAction:(id)sender {
    
    self.hideAlertView.constant=35;
    self.lblHideAlert.hidden=NO;
    self.btnHideAlert.hidden=NO;
}


- (IBAction)btnCloseAction:(id)sender {
    
    self.hideAlertView.constant=0;
    self.hideButton.constant=0;
    self.lblHideAlert.hidden=YES;
    self.btnHideAlert.hidden=YES;
}

- (IBAction)btnAddNewAdrs:(id)sender {
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                         bundle:nil];
    AddAddressVC *add = [storyboard instantiateViewControllerWithIdentifier:@"AddAddressVC"];
    
    [self presentViewController:add
                       animated:YES
                     completion:nil];
   
}

- (IBAction)btnAddNewAdrs1:(id)sender {
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                         bundle:nil];
    AddAddressVC *add = [storyboard instantiateViewControllerWithIdentifier:@"AddAddressVC"];
    
    [self presentViewController:add
                       animated:YES
                     completion:nil];
}


- (IBAction)btnDoneSavedAction:(id)sender {
    
    self.showAllSavedAdrs.hidden=YES;
    
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
