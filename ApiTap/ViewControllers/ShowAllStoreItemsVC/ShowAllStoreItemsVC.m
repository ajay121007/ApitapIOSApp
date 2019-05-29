//
//  ShowAllStoreItemsVC.m
//  ApiTap
//
//  Created by Bikramjeet Singh on 10/19/16.
//  Copyright © 2016 ApiTap. All rights reserved.
//

#import "ShowAllStoreItemsVC.h"
#import "Home_Cell.h"
#import "Home_CollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "SVProgressHUD.h"
#import "ViewAllItemsVC.h"
#import "ItemDetail.h"

@interface ShowAllStoreItemsVC () {
    
     NSMutableArray *getInner,*arrGetAllItems,*arrFinalData;
     NSMutableArray *new;
     NSArray *itemURL;
    int selctedItemTag;
}

@property (weak, nonatomic) IBOutlet UITableView *tblAllMerchantItems;


@end

@implementation ShowAllStoreItemsVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    new = [NSMutableArray new];
    
    [self getAllMerchantStore];
    
}

-(void)getAllMerchantStore {
    if (![self checkInternetConeection]) {
        
        return;
    }

    [SVProgressHUD showWithStatus:@"Loading....."];
    
    NSMutableDictionary *dictParam = [NSMutableDictionary new];
    
    [dictParam setValue:@"0001202A000000000858" forKey:@"53"];
    [dictParam setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"loginUserID"] forKey:@"114.179"];
    
    [model_manager.addManager showAdds:@"010100557" userinfo:dictParam completionResponse:^(NSArray *arrImages, NSError *error)
     {
         [SVProgressHUD dismiss];
         
         if (!error)
         {
             
             NSLog(@"%@",arrImages);
             
             arrFinalData=[NSMutableArray new];
             
             [arrFinalData addObjectsFromArray:[arrImages valueForKey:@"RESULT"][0]];
             
             if(arrFinalData.count ==0){
                 
                 [self.tblAllMerchantItems reloadData];
                 
             }else {
                 
                 
                 [self.tblAllMerchantItems reloadData];
             }

         }
         
         
     }];
    
}


#pragma mark - UITableView Delegate Mehods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [arrFinalData count];
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
        static NSString *simpleTableIdentifier = @"Home_Cell";
        
        Home_Cell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
       cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
        cell.lblCategoryNumber.text=arrFinalData[indexPath.row][@"_114_70"];
        
        cell.btnViewAllItems.tag=indexPath.row;
        
        [cell.btnViewAllItems addTarget:self action:@selector(btnViewAllItemsClicked:)
                       forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
        
    
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(Home_Cell *) cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.imageCollectionView.tag=indexPath.row;
    [cell.imageCollectionView reloadData];
}

#pragma mark - UICollectionView Delegate Mehods

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(113.f, 108.f);
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
   
        if ([arrFinalData[collectionView.tag][@"PC"] count] == 1) {

            return UIEdgeInsetsMake(0 , 100, 0, 100);
        }

    return UIEdgeInsetsMake(0 , 0, 0, 0);

}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [arrFinalData[collectionView.tag][@"PC"] count];
       
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"Cell";
    
                Home_CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
            [new addObjectsFromArray:arrFinalData[0][@"PC"]];
    
    
            NSString *ImageURL =[model_manager.loginManager.login.urlImage stringByAppendingString:new[indexPath.row][@"_121_170"]];
    
    
    
            [cell.showImages sd_setImageWithURL:[NSURL URLWithString:ImageURL] placeholderImage:[UIImage imageNamed:@"loading"] options:SDWebImageRefreshCached | SDWebImageRetryFailed];
    
            

            if ([new[indexPath.row][@"_114_9"] isEqualToString:@"true"]) {
                
                cell.itemWatchedOrNotImageview.image=[UIImage imageNamed:@"seen"];
                
            }else{
                
                cell.itemWatchedOrNotImageview.image=[UIImage imageNamed:@"eye"];
            }
    
    
            cell.btnShowCategory.tag=indexPath.row;
            
            [cell.btnShowCategory addTarget:self action:@selector(btnImageClicked:)
                           forControlEvents:UIControlEventTouchUpInside];
            
            cell.lblItemPrice.text=[@"$" stringByAppendingString:new[indexPath.row][@"_122_158"]];
    
            return cell;
            
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (![self checkInternetConeection]) {
        
        return;
    }

     NSString *ImageURL =[model_manager.loginManager.login.urlImage stringByAppendingString:new[indexPath.row][@"_121_170"]];
    
    itemURL=arrFinalData[collectionView.tag];
    
    
    selctedItemTag=(int)indexPath.row;
     [self performSegueWithIdentifier:@"goto_itemdetails_vc" sender:nil];
}

- (IBAction)btnViewAllItemsClicked:(UIButton*)sender {
    
   
    itemURL=arrFinalData[sender.tag];
    
    [self performSegueWithIdentifier:@"goto_viewall_vc" sender:nil];
    
}

- (IBAction)btnImageClicked:(UIButton*)sender {
    
    
        itemURL=arrFinalData[sender.tag];
        
        [self performSegueWithIdentifier:@"goto_itemdetails_vc" sender:nil];
    
   
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"goto_viewall_vc"])
    {
        
        ViewAllItemsVC *itemDetailObj = [segue destinationViewController];
        itemDetailObj.arrGetPreviousViewData=itemURL;
        itemDetailObj.checkForAllStoreItems=YES;
        
        
    }
    if ([[segue identifier] isEqualToString:@"goto_itemdetails_vc"])
    {
        
        ItemDetail *itemDetailObj = [segue destinationViewController];
        itemDetailObj.selectedItemURL=itemURL;
        itemDetailObj.getselctedItemTag=selctedItemTag;
        itemDetailObj.getStoreItemDetails = YES;
        
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
