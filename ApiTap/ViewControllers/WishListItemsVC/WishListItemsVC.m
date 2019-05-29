//
//  WishListItemsVC.m
//  ApiTap
//
//  Created by Bikramjeet Singh on 8/25/16.
//  Copyright © 2016 ApiTap. All rights reserved.
//

#import "WishListItemsVC.h"
#import "WishListCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "SVProgressHUD.h"

@interface WishListItemsVC () {
    
    NSMutableArray *showWishListItems;
}

@property (weak, nonatomic) IBOutlet UITableView *tblWishList;

@end

@implementation WishListItemsVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = LightGreyColor;
    
    self.navigationController.navigationBarHidden = NO;
    
    self.navigationController.navigationBar.barTintColor = BlueColor;
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    [self initializeNavBar];
    //[self loadCustomUI];
    [self setbarButtonItems];
    
    showWishListItems=[NSMutableArray new];
    
    if (self.check == YES) {
        
        [showWishListItems addObjectsFromArray:self.self.arrSearchItemsData];
        
        NSLog(@"%@",showWishListItems);
        
        NSLog(@"%lu",(unsigned long)[showWishListItems count]);
        
        [self.tblWishList reloadData];
        
        
    
    }else{
        
        [self getRelatedItems];
    }
    
   
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    self.navigationItem.title=@"Favourites";
}

-(void)getRelatedItems{
    
    if (![self checkInternetConeection]) {
        
        return;
    }

    [SVProgressHUD showWithStatus:@"Loding....."];
    
    NSMutableDictionary *dictParam = [NSMutableDictionary new];
    
    [dictParam setValue:@"001" forKey:@"127.10"];
    [dictParam setValue:@"21" forKey:@"114.112"];
    
    [dictParam setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"loginUserID"] forKey:@"53"];
    
    
    [model_manager.addManager getRelatedItems:KSearchFavoriteItemsByTypeKey userinfo:dictParam completionResponse:^(NSArray *arrImages, NSError *error)
     {
         
         if (!error)
         {
             [SVProgressHUD dismiss];
             
             [showWishListItems addObjectsFromArray:arrImages[0]];
             
             if (showWishListItems.count == 0) {
                 
                 [CustomAlertView showAlert:@"Alert" message:@"Data Not Found"];
                 
             }else{
                 
                 [showWishListItems removeAllObjects];
                 
                 [showWishListItems addObjectsFromArray:arrImages];
             }
             
             [self.tblWishList reloadData];
         }
         
     }];
    
}

-(void)removeFavoriteItemMobile : (NSString *) itemID {
    if (![self checkInternetConeection]) {
        
        return;
    }

    NSMutableDictionary *dictParam = [NSMutableDictionary new];
    
    [dictParam setValue:[GlobalClass makeElevenDigitNumber:itemID] forKey:@"114.144"];
    
    [dictParam setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"loginUserID"] forKey:@"53"];
        
    [model_manager.addManager removeFavoriteItemMobile:KRemoveFavoriteItemMobileKey userinfo:dictParam completionResponse:^(NSArray *arrImages, NSError *error)
     {
         
         if (!error)
         {
             [self getRelatedItems];
             
         }
         
     }];
    
}

- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
{
    return showWishListItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"WishListCell";
    
    WishListCell *cell = (WishListCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.lblItemName.text=[NSString stringWithFormat:@"%@ \nby%@",showWishListItems[indexPath.row][@"_120_83"],showWishListItems[indexPath.row][@"_114_70"]];
    
   
//cell.lblItemBy.text=[@"by " stringByAppendingString:showWishListItems[indexPath.row][@"_114_70"]];
    
    NSString *ImageURL =[model_manager.loginManager.login.urlImage stringByAppendingString:showWishListItems[indexPath.row][@"IM"][0][@"_47_42"]];
    
    [cell.showItemImage sd_setImageWithURL:[NSURL URLWithString:ImageURL] placeholderImage:[UIImage imageNamed:@"loading"] options:SDWebImageRefreshCached | SDWebImageRetryFailed];
    
    cell.lblItemPrice.text=[@"$ " stringByAppendingString:showWishListItems[indexPath.row][@"_122_158"]];
    
    cell.btnAdd.tag=indexPath.row;
    
    [cell.btnAdd addTarget:self action:@selector(btnAddAction:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.btnRemove.tag=indexPath.row;
    
    [cell.btnRemove addTarget:self action:@selector(btnRemoveAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
    
}


// when user tap the row, what action you want to perform

- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}

- (IBAction)btnAddAction:(UIButton *)sender
{
    
    NSLog(@"%ld",(long)sender.tag);
    
}

- (IBAction)btnRemoveAction:(UIButton *)sender
{
    
    [self removeFavoriteItemMobile:showWishListItems[sender.tag][@"_114_144"]];
    
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
