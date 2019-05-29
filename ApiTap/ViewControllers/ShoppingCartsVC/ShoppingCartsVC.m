//
//  ShoppingCartsVC.m
//  ApiTap
//
//  Created by Bikramjeet Singh on 9/8/16.
//  Copyright © 2016 ApiTap. All rights reserved.
//

#import "ShoppingCartsVC.h"
#import "ShopingCartsCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "SVProgressHUD.h"
#import "AddCartVC.h"
#import "ApiTap-Swift.h"

@interface ShoppingCartsVC () {
    
    NSMutableArray *arrShoppingCarts;
    NSMutableDictionary *arrDict;
    NSString *imgUrl;
    
}
@property (nonatomic,strong) CheckOutVC *checkOutVC;
@property (weak, nonatomic) IBOutlet UITableView *tblShowCarts;

@end

@implementation ShoppingCartsVC


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initializeNavBar];
    
    [self setbarButtonItems];
    
    self.automaticallyAdjustsScrollViewInsets=NO;
        
    [self getItemsByShoppingCart];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    self.navigationItem.title=@"Carts";
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:YES];
    
    self.navigationItem.title=@"";
}

-(void)initializeNavBar
{
    self.navigationController.navigationBarHidden = NO;
    
    self.navigationController.navigationBar.barTintColor = BlueColor;
}

-(void)getItemsByShoppingCart {
    
    if (![self checkInternetConeection]) {
        
        return;
    }

   [SVProgressHUD showWithStatus:@"Loading....."];
    
    NSMutableDictionary *dictParam = [NSMutableDictionary new];
    
    [dictParam setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"loginUserID"] forKey:@"53"];
    
    [model_manager.addManager getItemsSpecialsByCategoryMobile:@"010100200" userinfo:dictParam completionResponse:^(NSArray *arrImages, NSError *error)
     {
         [SVProgressHUD dismiss];
         
         if (!error)
         {
            
             NSLog(@"%@",arrImages);
             
             arrShoppingCarts=[NSMutableArray new];
             
             [arrShoppingCarts addObjectsFromArray:arrImages];
             
             [self.tblShowCarts reloadData];
             
         }
         
     }];
    
}


#pragma mark - UITableViewDelegate & DataSource Methods

// number of row in the section, I assume there is only 1 row

- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
{
    
    return arrShoppingCarts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ShopingCartsCell";
    
    ShopingCartsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
            if (cell == nil) {
                
            cell = [[ShopingCartsCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
    
    NSString *ImageURL =[model_manager.loginManager.login.urlImage stringByAppendingString:arrShoppingCarts[indexPath.row][@"_121_170"]];
    imgUrl = ImageURL;
    
    [cell.shopingCartImage sd_setImageWithURL:[NSURL URLWithString:ImageURL] placeholderImage:[UIImage imageNamed:@"loading"] options:SDWebImageRefreshCached | SDWebImageRetryFailed];
    
    NSString *setStartBracts = [@" (" stringByAppendingString:arrShoppingCarts[indexPath.row][@"_114_121"]];
    
    NSString *setEndBracts = [setStartBracts stringByAppendingString:@")"];
    
   // cell.lblShopingCartName.text=[arrShoppingCarts[indexPath.row][@"_114_70"] stringByAppendingString:setEndBracts]; // my comment
    
    NSString *lbl = [arrShoppingCarts[indexPath.row][@"_114_121"] stringByAppendingString:setEndBracts];
    
    NSString *dateStr = arrShoppingCarts[indexPath.row][@"_114_138"];
    
    // Convert string to date object
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormat dateFromString:dateStr];
      [dateFormat setDateFormat:@"yyyy:MM:dd"];
    NSString *getDate = [dateFormat stringFromDate:date];
   // NSString *str = @"Last added:";
    //str = [str stringByAppendingString:date];
    cell.lastAddedlbl.text = getDate;    //[dateFormat release];
    
    cell.expiringItemlbl.text =  arrShoppingCarts[indexPath.row][@"_114_121"];
    
    cell.lblShopingCartName.text = [@"number of items: " stringByAppendingString:lbl];
    cell.btnDelete.tag=indexPath.row;
    [cell.btnDelete addTarget:self action:@selector(btnDeleteAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
    
}


- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (![self checkInternetConeection]) {
        
        return;
    }
    arrDict = arrShoppingCarts[indexPath.row];
     //[self performSegueWithIdentifier:@"addCart" sender:arrDict];
   // [self performSegueWithIdentifier:@"goto_addcartvc" sender:arrShoppingCarts[indexPath.row]];
    
}

- (IBAction)btnDeleteAction:(UIButton*)sender {
    
    if (![self checkInternetConeection]) {
        
        return;
    }
    
    [SVProgressHUD showWithStatus:@"Loading....."];
    
    NSMutableDictionary *dictParam = [NSMutableDictionary new];
    
    [dictParam setValue:[GlobalClass makeElevenDigitNumber:arrShoppingCarts[sender.tag][@"_122_31"]] forKey:@"122.31"];
    
    [model_manager.loginManager userGuestLogin:@"020400202" userinfo:dictParam completionResponse:^(NSDictionary *dictJson, NSError *error)
     {
         
         [SVProgressHUD dismiss];
         
         if (!error)
         {
             
             NSLog(@"guest login response : %@",dictJson);
             
             [self getItemsByShoppingCart];
             
         }
     }];

}



- (IBAction)checkOutBtnTapped:(id)sender {
    CGPoint buttonPosition = [sender convertPoint:CGPointZero
                                           toView:self.tblShowCarts];
    NSIndexPath *tappedIP = [self.tblShowCarts indexPathForRowAtPoint:buttonPosition];
    arrDict = arrShoppingCarts[tappedIP.row];
//    ShopingCartsCell *cell = [checkOutBtn.su]
//    sender.superview?.superview as? CellView {
//        let indexPath = itemTable.indexPath(for: cell)
//    }
    //[self performSegueWithIdentifier:@"checkOut" sender:arrDict];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"goto_addcartvc"])
    {
        AddCartVC *vc = [segue destinationViewController];
        vc.arrShopingCart=sender;
        
    }
//    if ([[segue identifier] isEqualToString:@"addCart"])
//    {
//        _checkOutVC  = [segue destinationViewController];
//        _checkOutVC.shoppingAddressId = sender;
//        _checkOutVC.checkOutFlag = true;
//        
//    }
    if ([[segue identifier] isEqualToString:@"checkOut"])
    {
        //snipped
        _checkOutVC  = [segue destinationViewController];
        _checkOutVC.shoppingAddressId = arrDict;
        _checkOutVC.imgUrl = imgUrl;
        _checkOutVC.checkOutFlag = true;
        
    }
    
     if ([[segue identifier] isEqualToString:@"inVoice"])
    {
        //snipped
        CheckOutVC *vc = [segue destinationViewController];
        vc.checkOutFlag=false;
        
    }
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
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
