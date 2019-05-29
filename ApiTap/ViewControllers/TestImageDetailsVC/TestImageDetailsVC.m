//
//  TestImageDetailsVC.m
//  ApiTap
//
//  Created by Bikramjeet Singh on 9/7/16.
//  Copyright © 2016 ApiTap. All rights reserved.
//

#import "TestImageDetailsVC.h"
#import "ItemDetailsCell.h"
#import "ItemChoicesCell.h"
#import "ItemDescriptionCell.h"
#import "ItemRelatedImagesCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface TestImageDetailsVC () {
    
    NSMutableArray *arrItemDetails;
}

@property (weak, nonatomic) IBOutlet UILabel *lblItemDetails;

@property (weak, nonatomic) IBOutlet UITableView *tblItemDetails;

@end

@implementation TestImageDetailsVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self getItemDetails];
}


-(void)getItemDetails{
    
    if (![self checkInternetConeection]) {
        
        return;
    }

    NSMutableDictionary *dictParam = [NSMutableDictionary new];
    
    [dictParam setValue:[GlobalClass makeElevenDigitNumber:[[[self.selectedItemURL valueForKey:@"PC"]objectAtIndex:0]valueForKey:@"_114_144"]] forKey:@"114.144"];
    [dictParam setValue:[self.selectedItemURL valueForKey:@"PC"][0][@"_114_112"] forKey:@"114.112"];
    [dictParam setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"loginUserID"] forKey:@"53"];
        
    [model_manager.addManager getItemDetails:KGetItemDetailMobile userinfo:dictParam completionResponse:^(NSArray *arrImages, NSError *error)
     {
         
         if (!error)
         {
             
             arrItemDetails=[NSMutableArray new];
             
             [arrItemDetails addObjectsFromArray:arrImages];
             
             self.lblItemDetails.text=[arrImages valueForKey:@"_120_83"][0];
            
//             
//             
//             NSString *ImageURL =[model_manager.loginManager.login.urlImage stringByAppendingString:[arrImages valueForKey:@"_121_170"][0]];
//             
//             [imgItem sd_setImageWithURL:[NSURL URLWithString:ImageURL] placeholderImage:[UIImage imageNamed:@"image"] options:SDWebImageRefreshCached | SDWebImageRetryFailed];
//             
//
//             
//             lblItemPrice.text=[@"$" stringByAppendingString:[arrImages valueForKey:@"_122_158"][0]];
//             
//             lblMerchantName.text=[arrImages valueForKey:@"_121_150"][0];
//             
//             if ([[arrImages valueForKey:@"_120_15"][0] isEqualToString:@"1"]) {
//                 
//                 btnFavourite.backgroundColor=[UIColor greenColor];
//                 btnFavourite.selected=YES;
//                 
//             }else {
//                 
//                 btnFavourite.backgroundColor=[UIColor redColor];
//                 
//             }
//             
//             [arrItemImages addObjectsFromArray:[arrImages valueForKey:@"IM"]];
//             [arrGetChoices addObjectsFromArray:[arrImages valueForKey:@"OP"][0]];
//             
//             // NSLog(@"%@",arrGetChoices[1][@"_122_134"]);
//
//             [btnFirstChoice setTitle:arrGetChoices[0][@"_122_134"] forState:UIControlStateNormal];
//             
//             [btnSecondChoice setTitle:arrGetChoices[1][@"_122_134"] forState:UIControlStateNormal];
//             
             [self.tblItemDetails reloadData];
             
         }
         
     }];
    
}


#pragma mark - UITableViewDelegate & DataSource Methods

// number of row in the section, I assume there is only 1 row

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (arrItemDetails !=0) {
        
        if (indexPath.row == 0) {
            
            return 360;
            
        }else if (indexPath.row == 1){
            
            return 150;
            
        }else if (indexPath.row == 2) {
            
            return 150;
        }
        else {
            
            return 150;
        }
    }else {
        
        return 0;
    }
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        
        static NSString *CellIdentifier = @"ItemDetailsCell";
        
        ItemDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (cell == nil)
        {
            cell = [[ItemDetailsCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        
        NSString *ImageURL =[model_manager.loginManager.login.urlImage stringByAppendingString:[arrItemDetails valueForKey:@"_121_170"][0]];
        
        [cell.showMainItemImage sd_setImageWithURL:[NSURL URLWithString:ImageURL] placeholderImage:[UIImage imageNamed:@"loading"] options:SDWebImageRefreshCached | SDWebImageRetryFailed];
        
        [cell.tlbMoreImages reloadData];
        
        [cell.showMoreImages sd_setImageWithURL:[NSURL URLWithString:ImageURL] placeholderImage:[UIImage imageNamed:@"loading"] options:SDWebImageRefreshCached | SDWebImageRetryFailed];
        
        cell.lblItemPrice.text=[@"$" stringByAppendingString:[arrItemDetails valueForKey:@"_122_158"][0]];
        
        [cell.btnAddItemIntoFavourite addTarget:nil action:@selector(btnAddItemIntoFavouriteAction) forControlEvents:UIControlEventTouchUpInside];
        
        cell.data=@[@"hii",@"hello"];
        
        return cell;
        
    } else if (indexPath.row ==1) {
        
        static NSString *CellIdentifier = @"ItemChoicesCell";
        
        ItemChoicesCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (cell == nil)
        {
            cell = [[ItemChoicesCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        return cell;
        
    } else if (indexPath.row==2) {
        
        static NSString *CellIdentifier = @"ItemDescriptionCell";
        
        ItemDescriptionCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (cell == nil)
        {
            cell = [[ItemDescriptionCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        
        return cell;
        
    }else {
        
        static NSString *CellIdentifier = @"ItemRelatedImagesCell";
        
        ItemRelatedImagesCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (cell == nil)
        {
            cell = [[ItemRelatedImagesCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        
        return cell;
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
