    //
//  Home.m
//  SportsPal
//
//  Created by Abhishek Singla on 10/03/16.
//  Copyright © 2016 SportsPal. All rights reserved.
//

#import "Home.h"
#import "Home_Cell.h"
#import "Home_CollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIButton+WebCache.h"
#import "ItemDetail.h"
#import "AdsDetailsVC.h"
#import "ViewAllItemsVC.h"
#import "TestImageDetailsVC.h"
#import "SVProgressHUD.h"
#import "NIDropDown.h"
#import "AdsRalatedItemsVC.h"
#import "ApiTap-Swift.h"
@interface Home () <UIGestureRecognizerDelegate,NIDropDownDelegate>{
    UIViewController *viewController ;
    
     NSMutableArray *arrShowFinalData,*getInner,*arrGetAllItems,*arrFinalData, *newSpecialsData,*arrGetAdvertisementData;
     NSMutableArray *itemURL;
    NSDictionary *dict;
     NSDictionary *dicts;
    NSString *productId;
    BOOL diffIndex;
     int selctedItemTag;
     int increment;
     NSMutableDictionary *mainDict;
     BOOL check, showAddCheck;
    BOOL flagCheck, savedCheck;
     NSString *selectedCategory;
     NIDropDown *dropDown;
     NSMutableArray *arrNewOne;
     NSArray *getPaticularItemDetails;

}
@property (weak, nonatomic) IBOutlet UILabel *addStore;
@property ( nonatomic,strong) RatingReviewVC *rtg;
@property (nonatomic,strong) ItemDetailVC *itemDetailVC;
@property (weak, nonatomic) IBOutlet UISegmentedControl *upperSegmentation;
@property (weak, nonatomic) IBOutlet UIView *addInfoView;
@property (weak, nonatomic) IBOutlet UIImageView *addImageName;
@property (weak, nonatomic) IBOutlet UILabel *storeDetailsLbl;

@property (weak, nonatomic) IBOutlet UIScrollView *scrvSwipeableImages;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (weak, nonatomic) IBOutlet UITableView *tblShowAllItems;

@property (weak, nonatomic) IBOutlet UITableView *tblShowAllItemsOneByOne;

@property (weak, nonatomic) IBOutlet UIView *showSecondView;

@property (weak, nonatomic) IBOutlet UICollectionView *adsCollectionView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewHeights;

@property (weak, nonatomic) IBOutlet UIButton *btnAdd;

@property (weak, nonatomic) IBOutlet UIButton *btnSpecials;

@property (weak, nonatomic) IBOutlet UIButton *btnItems;

@property (weak, nonatomic) IBOutlet UIButton *btnSaved;

@property (weak, nonatomic) IBOutlet UIImageView *addImage;

@property (weak, nonatomic) IBOutlet UIImageView *specialImage;

@property (weak, nonatomic) IBOutlet UIImageView *itemImage;

@property (weak, nonatomic) IBOutlet UIImageView *saveImage;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstImageBottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *secondImageBottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *thirdImageBottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fourthImageBottom;

@property (weak, nonatomic) IBOutlet UIView *blurView;

@property (weak, nonatomic) IBOutlet UIView *showSearchView;

@end

@implementation Home

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self getPlaylistBroadcastMobile];
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self callFirstHomeWebservices];
        
    });
    
    
    self.blurView.hidden=YES;
    self.showSearchView.hidden=YES;
    
    itemURL=[NSMutableArray new];
        
    self.adsCollectionView.hidden=YES;
    self.pageControl.hidden=NO;
    self.scrollViewHeights.constant=180;
    showAddCheck=NO;
    //my code
    savedCheck=NO;
    
    self.firstImageBottom.constant=10;
    self.secondImageBottom.constant=10;
    self.thirdImageBottom.constant=10;
    self.fourthImageBottom.constant=10;
   
  }

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    
    [self initializeNavBar];
    [self setbarButtonItems];
    
}

-(void)callFirstHomeWebservices{
    if (![self checkInternetConeection]) {
        
        return;
    }

    [SVProgressHUD showWithStatus:@"Loading....."];
    
    NSMutableDictionary *dictParam = [NSMutableDictionary new];
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString *timeString = [formatter stringFromDate:date];
    
    [dictParam setValue:timeString forKey:@"121.141"];
    [dictParam setValue:@"3" forKey:@"127.89"];
    
    [dictParam setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"loginUserID"] forKey:@"53"];
    
    [model_manager.addManager callHomeWebService:@"" userinfo:dictParam completionResponse:^(NSArray *arrImages, NSError *error)
     {
         
         [SVProgressHUD dismiss];
         
         if (!error)
         {
             
             
             //NSLog(@"%@",arrImages);
             
             mainDict=[NSMutableDictionary new];
             arrShowFinalData=[NSMutableArray new];
             
             for (int i=0; i<[arrImages count]; i++) {
                 
                 arrGetAllItems=[NSMutableArray new];
                 
                 
                 for (int j=0; j<[[arrImages valueForKey:@"RESULT"][i] count]; j++) {
                     
                     
                     for (int k=0; k<[[arrImages valueForKey:@"RESULT"][i][j][@"PC"] count]; k++) {
                         
                         [arrGetAllItems addObject:[arrImages valueForKey:@"RESULT"][i][j][@"PC"][k]];
                         
                         
                     }
                     
                   }
                 
                 NSSortDescriptor * brandDescriptor = [[NSSortDescriptor alloc] initWithKey:@"_120_31" ascending:YES];
                 NSArray * sortedArray = [arrGetAllItems sortedArrayUsingDescriptors:@[brandDescriptor]];
                 
                 NSArray* reversedArray = [[sortedArray reverseObjectEnumerator] allObjects];
                 
                 [arrShowFinalData addObject:reversedArray];
                 
                 NSLog(@"%@",arrShowFinalData);
                 
             }
             
             [self.tblShowAllItems reloadData];
             
             
         }
         
     }];

}



-(void)searchItemsByCategoryMobile{
    
    if (![self checkInternetConeection]) {
        
        return;
    }
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString *timeString = [formatter stringFromDate:date];
    
    NSMutableDictionary *dictParam = [NSMutableDictionary new];
    
    [dictParam setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"loginUserID"] forKey:@"53"];
     [dictParam setValue:timeString forKey:@"121.141"];
    [dictParam setValue:@"3" forKey:@"127.89"];
    
    
    [model_manager.addManager showAllCategoriesName:kSearchItemsByCategoryMobile userinfo:dictParam completionResponse:^(NSArray *arrImages, NSError *error)
     {
         [SVProgressHUD dismiss];
        
         if (!error)
         {
             self.pageControl.hidden=YES;
             self.scrollViewHeights.constant=0;
             
             arrFinalData=[NSMutableArray new];
             
             [arrFinalData addObjectsFromArray:arrImages];
             
             NSLog(@"%@",arrFinalData);
             
             if(arrFinalData.count ==0){
                 
                 [self.tblShowAllItems reloadData];
                 
             }else {
                 
                 self.adsCollectionView.hidden=YES;
                 [self.tblShowAllItems reloadData];
             }
             
            
        }
         
     }];
    
   }


-(void)searchItemsSpecialsByCategoryMobile{
    
    if (![self checkInternetConeection]) {
        
        return;
    }
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString *timeString = [formatter stringFromDate:date];
    
   
    [SVProgressHUD showWithStatus:@"Loading....."];
    
    NSMutableDictionary *dictParam = [NSMutableDictionary new];
    
    [dictParam setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"loginUserID"] forKey:@"53"];
    //my code
    [dictParam setValue:timeString forKey:@"121.141"];
    [dictParam setValue:@"3" forKey:@"127.89"];
    
    [model_manager.addManager getItemsSpecialsByCategoryMobile:kSearchItemsSpecialsByCategoryMobile userinfo:dictParam completionResponse:^(NSArray *arrImages, NSError *error)
     {
         
         [SVProgressHUD dismiss];
         
         if (!error)
         {
             self.pageControl.hidden=YES;
             self.scrollViewHeights.constant=0;
             
             arrFinalData=[NSMutableArray new];
             newSpecialsData=[NSMutableArray new];
                          
             [arrFinalData addObjectsFromArray:arrImages];
             
             [newSpecialsData addObjectsFromArray:arrFinalData[0][@"PC"]];
             
             
             if(arrShowFinalData.count ==0){
                 
                 [self.tblShowAllItems reloadData];
                 
             }else {
                 
                 self.adsCollectionView.hidden=YES;
                 [self.tblShowAllItems reloadData];
             }

             
         }
         
     }];
    
}

-(void)searchSavedItems{
    if (![self checkInternetConeection]) {
        
        return;
    }
    [SVProgressHUD showWithStatus:@"Loading....."];
    
    NSMutableDictionary *dictParam = [NSMutableDictionary new];
    
    [dictParam setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"loginUserID"] forKey:@"53"];
    [dictParam setValue:@"21" forKey:@"114.112"];
    
    [model_manager.addManager getItemsSpecialsByCategoryMobile:@"010100302" userinfo:dictParam completionResponse:^(NSArray *arrImages, NSError *error)
     {
         
         [SVProgressHUD dismiss];
         
         if (!error)
         {
             self.pageControl.hidden=YES;
             self.scrollViewHeights.constant=0;
             
             arrFinalData=[NSMutableArray new];
             
             [arrFinalData addObjectsFromArray:arrImages];
             savedCheck = YES;
             if(arrShowFinalData.count ==0){
                 
                 [self.tblShowAllItems reloadData];
                 
             }else {
                 
                 
                 [self.tblShowAllItems reloadData];
             }
             
             
         }
         
     }];
    
}

-(void)getItemsMobile{
    if (![self checkInternetConeection]) {
        
        return;
    }
    NSMutableDictionary *dictParam = [NSMutableDictionary new];
    [dictParam setValue:@"00011010000000000004" forKey:@"53"];
    
    [model_manager.loginManager userGuestLogin:kGetItemsMobile userinfo:dictParam completionResponse:^(NSDictionary *dictJson, NSError *error)
     {
         if (!error)
         {
             
             
         }
     }];
}

-(void)getPlaylistBroadcastMobile{
    
    if (![self checkInternetConeection]) {
        
        return;
    }
    
    [SVProgressHUD showWithStatus:@"Loading....."];
    
    NSMutableDictionary *dictParam = [NSMutableDictionary new];
    
    [dictParam setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"loginUserID"] forKey:@"53"];
    
    //my code
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString *timeString = [formatter stringFromDate:date];
    
    //[dictParam setValue:timeString forKey:@"121.141"];
   // [dictParam setValue:@"3" forKey:@"127.89"];
    
    [model_manager.addManager showAdds:KGetPlaylistBroadcastMobile userinfo:dictParam completionResponse:^(NSArray *arrImages, NSError *error)
     {
         [SVProgressHUD dismiss];
         
         if (!error)
         {
            
             
             if (showAddCheck ==YES) {
                 
                 self.pageControl.hidden=YES;
                 self.scrollViewHeights.constant=0;
                 
                 arrFinalData=[NSMutableArray new];
                 
                 [arrFinalData addObjectsFromArray:[arrImages objectAtIndex:0][@"RESULT"]];
                 
                 NSLog(@"%@",arrFinalData);
                 
                 NSLog(@"%lu",(unsigned long)arrFinalData.count);
                 
                 if(arrFinalData.count ==0){
                     
                     [self.adsCollectionView reloadData];
                     
                 }else {
                     
                     self.adsCollectionView.hidden=NO;
                     
                     [self.adsCollectionView reloadData];
                 }

                 
             }else {
                 
                 NSMutableArray *arrAdvImages=[NSMutableArray new];
                 
                 arrGetAdvertisementData = [NSMutableArray new];
                 
                 [arrGetAdvertisementData addObjectsFromArray:[[arrImages objectAtIndex:0]valueForKey:@"RESULT"]];
                 
                 for (int i=0; i<[[[arrImages objectAtIndex:0]valueForKey:@"RESULT"] count]; i++) {
                     
                     [arrAdvImages addObject:[[arrImages objectAtIndex:0]valueForKey:@"RESULT"][i][@"_121_170"]];
                     
                 }
                 
                 CGFloat x=0;
                 
                 _pageControl.numberOfPages = arrAdvImages.count;
                 _pageControl.currentPage = 0;
                 
                 
                 
                 for(int i=0;i<arrAdvImages.count;i++)
                 {
                     
                     [self.scrvSwipeableImages setContentSize:CGSizeMake(self.view.frame.size.width*arrAdvImages.count, self.scrvSwipeableImages.frame.size.height)];
                     
                     [self.pageControl addTarget:self action:@selector(pageChanged) forControlEvents:UIControlEventValueChanged];
                     
                     UIButton *imageButton=[[UIButton alloc]initWithFrame:CGRectMake(x+10, 0, self.view.frame.size.width-25, self.scrvSwipeableImages.frame.size.height)];
                     
                     UIImageView *addImage=[[UIImageView alloc]initWithFrame:CGRectMake(x+10, 0, self.view.frame.size.width-25, self.scrvSwipeableImages.frame.size.height)];
                     
                     NSString *ImageURL =[model_manager.loginManager.login.urlImage stringByAppendingString:arrAdvImages[i]];
                     
                     [addImage sd_setImageWithURL:[NSURL URLWithString:ImageURL] placeholderImage:[UIImage imageNamed:@"loading"] options:SDWebImageRefreshCached | SDWebImageRetryFailed];
                     
                     imageButton.tag=i;
                     
                     addImage.layer.cornerRadius=5.0;
                     addImage.layer.masksToBounds=true;
                     
                     [imageButton addTarget:self action:@selector(btnClicked:)
                           forControlEvents:UIControlEventTouchUpInside];
                     
                     [self.scrvSwipeableImages addSubview:imageButton];
                     
                     [self.scrvSwipeableImages addSubview:addImage];
                     
                     x+=self.view.frame.size.width;
                     
                     
                 }
             }
             
         }
     }];
    
    
}

-(void)getBusinessDetails{
    
    NSMutableDictionary *dictParam = [NSMutableDictionary new];
    [dictParam setValue:@"00011010000000000004" forKey:@"53"];
    
//    [model_manager.addManager showAdds:KGetBusinessDetails userinfo:dictParam completionResponse:^(NSDictionary *dictJson, NSError *error)
//     {
//         if (!error)
//         {
//             
//             NSLog(@"guest login response : %@",dictJson);
//             
//             
//         }
//     }];
}


-(void)getFavoriteCategoryByUser {
    
    if (![self checkInternetConeection]) {
        
        return;
    }
    
    NSMutableDictionary *dictParam = [NSMutableDictionary new];
    [dictParam setValue:@"00011010000000000004" forKey:@"53"];
    
    [model_manager.loginManager userGuestLogin:KGetFavoriteCategoryByUser userinfo:dictParam completionResponse:^(NSDictionary *dictJson, NSError *error)
     {
         if (!error)
         {
             
            // NSLog(@"guest login response : %@",dictJson);
             
             
         }
     }];
}

-(void)getFavoriteMerchants {
    if (![self checkInternetConeection]) {
        
        return;
    }
    NSMutableDictionary *dictParam = [NSMutableDictionary new];
    
    
    [dictParam setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"loginUserID"] forKey:@"53"];
    
    [model_manager.loginManager userGuestLogin:KGetFavoriteMerchants userinfo:dictParam completionResponse:^(NSDictionary *dictJson, NSError *error)
     {
         if (!error)
         {
             
            // NSLog(@"guest login response : %@",dictJson);
             
             
         }
     }];
}




- (IBAction)btnClicked:(UIButton*)sender {
    
    NSLog(@"%ld",(long)sender.tag);
    
    NSLog(@"%@",arrGetAdvertisementData[sender.tag]);
    
    getPaticularItemDetails = arrGetAdvertisementData[sender.tag];
    
    [self performSegueWithIdentifier:@"ads_details_vc" sender:nil];
    //[self performSegueWithIdentifier:@"goto_ads_relatedvc" sender:nil];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)_scrollView {
    
    
    if(_scrollView == _scrvSwipeableImages)
    {
        CGFloat viewWidth = _scrollView.frame.size.width;
        
        int pageNumber = floor((_scrollView.contentOffset.x - viewWidth/50) / viewWidth) +1;
        
       // NSLog(@"pageNumber%d",pageNumber);
        
        self.pageControl.currentPage=pageNumber;
    }else {
        
        [getInner removeAllObjects];
    }
    
}
- (IBAction)goBtnTapped:(id)sender {
    RatingReviewVC *yourSwiftVC = [[RatingReviewVC alloc] init];
 //   [self.navigationController pushViewController:yourSwiftVC animated:YES];
    //_rtg = [[RatingReviewVC alloc]init];
    yourSwiftVC.view.backgroundColor = [UIColor whiteColor];
   
    [self presentViewController:yourSwiftVC animated:YES completion:nil];
    
    
}

- (void)pageChanged {
    
    int pageNumber = (int)self.pageControl.currentPage;
    
    CGRect frame = self.scrvSwipeableImages.frame;
    frame.origin.x = frame.size.width*pageNumber;
    frame.origin.y=0;
    
    [self.scrvSwipeableImages scrollRectToVisible:frame animated:YES];
}

#pragma mark - UITableView Delegate Mehods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if ([arrFinalData count] != 0) {
        
        return [arrFinalData count];
        
    }else {
        
        return [arrShowFinalData count];
    }
    
    
    
//    if (tableView == _tblShowAllItems) {
//        
//        return [arrShowFinalData count];
//    }
//    else if (tableView == _tblShowAllItemsOneByOne) {
//        
//        return [arrFinalData count];
//    }
//    
//    return 0;
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        if ([arrFinalData count] != 0) {
            
            static NSString *simpleTableIdentifier = @"Home_Cell";
            
            Home_Cell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (savedCheck == YES) {
            NSDictionary *cA = arrFinalData[indexPath.row][@"CA"];
            NSString *lbl = cA[@"_120_45"];
            cell.lblCategoryNumber.text=lbl;
            }else{
                cell.lblCategoryNumber.text=arrFinalData[indexPath.row][@"_120_45"];
            }
            
          //  cell.lblCategoryNumber.text=arrFinalData[indexPath.row][@"_120_45"];
            
            cell.btnViewAllItems.tag=indexPath.row;
            
            [cell.btnViewAllItems addTarget:self action:@selector(btnViewAllItemsClicked:)
                           forControlEvents:UIControlEventTouchUpInside];
            
            return cell;
            
        }else {
            
            static NSString *simpleTableIdentifier = @"Home_Cell";
            
            Home_Cell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            NSArray *arrItems=@[@"SPECIALS",@"Product & Service"];
            
            cell.lblCategoryNumber.text=arrItems[indexPath.row];
            
            cell.btnViewAllItems.tag=indexPath.row;
            
            [cell.btnViewAllItems addTarget:self action:@selector(btnViewAllItemsClicked:)
                           forControlEvents:UIControlEventTouchUpInside];
            
            return cell;
        }

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
    
    if (showAddCheck ==YES) {
       // return CGSizeMake(120, 145.f);
     return CGSizeMake((collectionView.frame.size.width)-5, 145.f);
    }
    
    return CGSizeMake(collectionView.frame.size.width/2.6, 150);
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    
    if ([arrFinalData count] != 0) {
        //original code
//        if ([arrFinalData[collectionView.tag][@"PC"] count] == 1) {
//            
//            
//            return UIEdgeInsetsMake(0 , ((collectionView.frame.size.width)-130)/2, 0, ((collectionView.frame.size.width)-140)/2);
//        }
        
        //my code
        if (savedCheck == YES){
            return UIEdgeInsetsMake(0 , ((collectionView.frame.size.width)-130)/2, 0, ((collectionView.frame.size.width)-140)/2);
        }
        else { if ([arrFinalData[collectionView.tag][@"PC"] count] == 1) {
            
          //  return UIEdgeInsetsMake(0 , 124, 0, 120);
            return UIEdgeInsetsMake(0 , ((collectionView.frame.size.width)-130)/2, 0, ((collectionView.frame.size.width)-140)/2);
        }
        }
        
        
    }else {
        
        if ([arrShowFinalData[collectionView.tag] count] == 1) {
            
           return UIEdgeInsetsMake(0 , ((collectionView.frame.size.width)-130)/2, 0, ((collectionView.frame.size.width)-140)/2);
        }
        
    }
    

    return UIEdgeInsetsMake(0 , 0, 0, 0);
    
}
- (IBAction)viewAllItemClicked:(id)sender {
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    
    if (showAddCheck ==YES) {
        
        
        return [arrFinalData count];
        
        
    }else{
       
        if ([arrFinalData count] != 0) {
            
            //NSLog(@"%lu",[arrFinalData[collectionView.tag][@"PC"] count]);
            
            arrNewOne=[NSMutableArray new];
            if (savedCheck == YES){
                [arrNewOne addObjectsFromArray:arrFinalData[collectionView.tag][@"CA"]];
                
                return [arrFinalData[collectionView.tag][@"CA"] count];
            }
            else{
            [arrNewOne addObjectsFromArray:arrFinalData[collectionView.tag][@"PC"]];
            
            return [arrFinalData[collectionView.tag][@"PC"] count];
        }
            
    }else {
            
            return [arrShowFinalData[collectionView.tag] count];
        }

    }
    
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
     static NSString *identifier = @"Cell";
    
    if (showAddCheck ==YES) {
        
        Home_CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        
        
        NSString *ImageURL =[model_manager.loginManager.login.urlImage stringByAppendingString:arrFinalData[indexPath.row][@"_121_170"]];
        
        [cell.showImages sd_setImageWithURL:[NSURL URLWithString:ImageURL] placeholderImage:[UIImage imageNamed:@"loading"] options:SDWebImageRefreshCached | SDWebImageRetryFailed];
        
        cell.btnShowCategory.tag=indexPath.row;
        
        [cell.btnShowCategory addTarget:self action:@selector(btnImageClicked:)
                       forControlEvents:UIControlEventTouchUpInside];
        
        
        return cell;
        
    }else {
        
        Home_CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        
        if ([arrFinalData count] != 0) {
            
            //my code:
           
             if (savedCheck == YES){
                 
                 NSMutableArray *urlImage =  arrFinalData[indexPath.row][@"IM"];
                 NSString *imageUrls = [model_manager.loginManager.login.urlImage stringByAppendingString:urlImage[indexPath.row][@"_47_42"]];
                 
                  [cell.showImages sd_setImageWithURL:[NSURL URLWithString:imageUrls] placeholderImage:[UIImage imageNamed:@"loading"] options:SDWebImageRefreshCached | SDWebImageRetryFailed];
                 // NSLog(@"%@",arrNewOne[indexPath.row][@"IM"][@"_47_42"]);
            }else{
                NSLog(@"%@",arrNewOne[indexPath.row][@"_114_112"]);
            
           //
            
//            NSLog(@"%@",arrFinalData[indexPath.row][@"PC"]);
//            
//            NSLog(@"%@",arrFinalData[indexPath.row][@"PC"][0]);
            //my code
            
            NSString *ImageURL =[model_manager.loginManager.login.urlImage stringByAppendingString:arrNewOne[indexPath.row][@"_121_170"]];
            
           // NSString *ImageURL =[model_manager.loginManager.login.urlImage stringByAppendingString:arrNewOne[indexPath.row][@"_47_42"]];
            
            if ([arrNewOne[indexPath.row][@"_114_9"] isEqualToString:@"true"]) {
                
                cell.itemWatchedOrNotImageview.image=[UIImage imageNamed:@"seen"];
                
            }else{
                
                cell.itemWatchedOrNotImageview.image=[UIImage imageNamed:@"eye"];
            }
            
            [cell.showImages sd_setImageWithURL:[NSURL URLWithString:ImageURL] placeholderImage:[UIImage imageNamed:@"loading"] options:SDWebImageRefreshCached | SDWebImageRetryFailed];
            
            cell.btnShowCategory.tag=indexPath.row;
            
            [cell.btnShowCategory addTarget:self action:@selector(btnImageClicked:)
                           forControlEvents:UIControlEventTouchUpInside];
            
            cell.lblItemPrice.text=[@"$" stringByAppendingString:arrNewOne[indexPath.row][@"_114_98"]];
            
            cell.lblName.text=arrNewOne[indexPath.row][@"_120_83"];
            
            cell.lblDiscription.text=[self stringFromHexString:arrNewOne[indexPath.row][@"_120_157"]];
            /////
            
            
            if ([arrNewOne[indexPath.row][@"_114_98"] isEqualToString:arrNewOne[indexPath.row][@"_122_162"]]) {
                
                cell.lblItemSalePrice.hidden=YES;
                cell.lblCrossLine.hidden=YES;
                cell.saleView.backgroundColor=[UIColor grayColor];
                
            }else{
                
                if ([arrNewOne[indexPath.row][@"_122_162"] isEqualToString:@"0.00"]) {
                    cell.saleView.backgroundColor=[UIColor grayColor];
                    cell.lblItemSalePrice.hidden=YES;
                    cell.lblCrossLine.hidden=YES;
                    
                }else{
                    
                    cell.lblItemSalePrice.hidden=NO;
                    cell.lblCrossLine.hidden=NO;
                    cell.lblItemSalePrice.text=[@"$" stringByAppendingString:arrNewOne[indexPath.row][@"_122_162"]];
                    cell.saleView.backgroundColor=[UIColor redColor];
                }
                
            }
        }
        
            return cell;
            
        }else {
            
            
            
            NSString *ImageURL =[model_manager.loginManager.login.urlImage stringByAppendingString:arrShowFinalData[collectionView.tag][indexPath.row][@"_121_170"]];
            
            
            if ([arrShowFinalData[collectionView.tag][indexPath.row][@"_114_9"] isEqualToString:@"true"]) {
                
                cell.itemWatchedOrNotImageview.image=[UIImage imageNamed:@"eye"];
                
            }else{
                
                cell.itemWatchedOrNotImageview.image=[UIImage imageNamed:@"seen"];
            }
            
            [cell.showImages sd_setImageWithURL:[NSURL URLWithString:ImageURL] placeholderImage:[UIImage imageNamed:@"loading"] options:SDWebImageRefreshCached | SDWebImageRetryFailed];
            
            NSString *collectionTag=[NSString stringWithFormat:@"%ld",(long)collectionView.tag];
            NSString *itemTag=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
            
            NSString *finalTag=[collectionTag stringByAppendingString:itemTag];
            
            cell.btnShowCategory.tag=[finalTag intValue];
            
            [cell.btnShowCategory addTarget:self action:@selector(btnImageClicked:)
                           forControlEvents:UIControlEventTouchUpInside];
            
            cell.lblItemPrice.text=[@"$" stringByAppendingString:arrShowFinalData[collectionView.tag][indexPath.row][@"_114_98"]];
            
            cell.lblName.text=arrShowFinalData[collectionView.tag][indexPath.row][@"_120_83"];
            
            cell.lblDiscription.text=[self stringFromHexString:arrShowFinalData[collectionView.tag][indexPath.row][@"_120_157"]];
            
            if ([arrShowFinalData[collectionView.tag][indexPath.row][@"_114_98"] isEqualToString:arrShowFinalData[collectionView.tag][indexPath.row][@"_122_158"]]) {
                
                cell.lblItemSalePrice.hidden=YES;
                cell.lblCrossLine.hidden=YES;
                cell.saleView.backgroundColor=[UIColor grayColor];
                
            }else{
                
                if ([arrShowFinalData[collectionView.tag][indexPath.row][@"_122_158"] isEqualToString:@"0.00"]) {
                        cell.saleView.backgroundColor=[UIColor grayColor];
                        cell.lblItemSalePrice.hidden=YES;
                        cell.lblCrossLine.hidden=YES;
                    
                }else{
                    
                    cell.lblItemSalePrice.hidden=NO;
                    cell.lblCrossLine.hidden=NO;
                    cell.lblItemSalePrice.text=[@"$" stringByAppendingString:arrShowFinalData[collectionView.tag][indexPath.row][@"_122_158"]];
                    cell.saleView.backgroundColor=[UIColor redColor];
                }
                
                
                
            }
            
            return cell;
        }

    }
   
    
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (![self checkInternetConeection]) {
        
        return;
    }

    [itemURL removeAllObjects];
   // [arrFinalData removeAllObjects];
    
    if (showAddCheck == YES) {
        
        
        itemURL=arrFinalData;
        
        [self performSegueWithIdentifier:@"goto_adsdetailsvc" sender:nil];
        
    }else{
        
        if ([arrFinalData count] != 0) {
            
            itemURL=[arrFinalData[collectionView.tag]mutableCopy];
            selctedItemTag=(int)indexPath.row;
            check=NO;
            
            [self performSegueWithIdentifier:@"goTo_ItemDetail" sender:nil];
           // [self performSegueWithIdentifier:@"goto_itemdetailsvc" sender:nil];
            
        }else {
           
            itemURL=[arrShowFinalData[collectionView.tag]mutableCopy];
            selctedItemTag=(int)indexPath.row;                             //items & specials
            
            dict=[itemURL[selctedItemTag]mutableCopy];
            // dicts = [dict[selctedItemTag]mutableCopy];
             [self eyeFunctionality];
            check=YES;
            
             [self performSegueWithIdentifier:@"goTo_ItemDetail" sender:nil];
            //[self performSegueWithIdentifier:@"goto_itemdetailsvc" sender:nil];
        }

    }
}
-(void)eyeFunctionality{
    
   // NSMutableString *productId = dicts[@"_114_144"];
   NSString  *productId = [@"000000000" stringByAppendingString:dict[@"_114_144"]];
    NSMutableDictionary *dictParam = [NSMutableDictionary new];
    
    [dictParam setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"loginUserID"] forKey:@"53"];
    [dictParam setValue:productId forKey:@"114.144"];
    
    [model_manager.addManager getEye:@"030400471" userinfo:dictParam completionResponse:^(NSArray *arrImages, NSError *error)
     {
         
         if (!error)
         {
             NSLog(@"%@",arrImages);
             
         }
         
     }];
    
    
}
- (NSString *)stringFromHexString:(NSString *)hexString {
    
    // The hex codes should all be two characters.
    if (([hexString length] % 2) != 0)
        return nil;
    
    NSMutableString *string = [NSMutableString string];
    
    for (NSInteger i = 0; i < [hexString length]; i += 2) {
        
        NSString *hex = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSInteger decimalValue = 0;
        sscanf([hex UTF8String], "%x", &decimalValue);
        [string appendFormat:@"%c", decimalValue];
    }
    
    return string;
}


- (void) tapGesture: (id)sender
{
    //handle Tap...
}

#pragma mark - Clk Actions


- (IBAction)btnImageClicked:(UIButton*)sender {
    
    
    
    [itemURL removeAllObjects];
    
     itemURL=[NSMutableArray new];
    
    if ([arrFinalData count] != 0) {
        
        itemURL=[arrFinalData[sender.tag]mutableCopy];
        
        [self performSegueWithIdentifier:@"goto_itemdetailsvc" sender:nil];
        
    }else {
        
        itemURL=[arrShowFinalData[sender.tag]mutableCopy];
        
        
        [self performSegueWithIdentifier:@"goto_itemdetailsvc" sender:nil];
    }
    

    
}

-(void)addItemsIntoCart {
    
    if (![self checkInternetConeection]) {
        
        return;
    }

    
    NSMutableDictionary *dictParam = [NSMutableDictionary new];
    
    [dictParam setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"loginUserID"] forKey:@"53"];
    [dictParam setValue:@"00000000088" forKey:@"114.144"];
    [dictParam setValue:@"0001202A000000000858" forKey:@"114.179"];
    [dictParam setValue:@"3" forKey:@"114.121"];
    [dictParam setValue:@[@{@"121.104":@"00000001148"},@{@"121.104":@"00000001152"}] forKey:@"CH"];
    //[dictParam setValue:@[] forKey:@"FILTER"];
    
    
    [model_manager.addManager addItemIntoCart:@"030400198" userinfo:dictParam completionResponse:^(NSArray *arrImages, NSError *error)
     {
         
         if (!error)
         {
             
             
         }
         
     }];
    
}

-(void)getItemsByShoppingCart {
    if (![self checkInternetConeection]) {
        
        return;
    }

    
    NSMutableDictionary *dictParam = [NSMutableDictionary new];
    
    [dictParam setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"loginUserID"] forKey:@"53"];
    
    
    [model_manager.addManager getItemsSpecialsByCategoryMobile:@"010100200" userinfo:dictParam completionResponse:^(NSArray *arrImages, NSError *error)
     {
         
         if (!error)
         {
             
             
         }
         
     }];
    
}

-(void)getItemsOfShoppingCartByID : (NSString *)filterID{
    if (![self checkInternetConeection]) {
        
        return;
    }

    NSMutableDictionary *dictParam = [NSMutableDictionary new];
    
    [dictParam setValue:@"134" forKey:@"122.31"];
    
    [model_manager.addManager getItemsOfShoppingCartById:@"010100201" filterData:@"4501" userinfo:dictParam completionResponse:^(NSArray *arrImages, NSError *error) {
        
        if (!error)
        {
            
            
        }
        
    }];
    
}


- (IBAction)btnViewAllItemsClicked:(UIButton*)sender {
    
  //  [itemURL removeAllObjects];
    
    itemURL=[NSMutableArray new];
    
    if (showAddCheck ==YES) {
        
        
        
        
    }else{
        
        if ([arrFinalData count] != 0) {
            
            itemURL=[arrFinalData[sender.tag] mutableCopy];
            
            
        }else {
            
                        
            NSArray *names=@[@"Specials",@"Items"];
            
            selectedCategory=names[sender.tag];
            itemURL=[arrShowFinalData[sender.tag]mutableCopy];
           
        }
        
    }

   
    if (selectedCategory == @"Specials"){
        TestClass.doubleVar = 3;
        [self performSegueWithIdentifier:@"leftSlide_special" sender:nil];
        
        
        
        
        // [self performSegueWithIdentifier:@"goto_showall_vc" sender:nil];
    }else{
        TestClass.doubleVar = 3;
        [self performSegueWithIdentifier:@"leftslide_item" sender:nil];
   // [self performSegueWithIdentifier:@"goto_showall_vc" sender:nil];
    }
    
}

- (IBAction)sgmtSelectedItemAction:(UISegmentedControl *)sender {
    
   // [arrShowFinalData removeAllObjects];
    
    switch (sender.selectedSegmentIndex) {
        case 0:{
            
            [self searchItemsSpecialsByCategoryMobile];
            
            break;}
            
        case 1:{
            
            [self searchItemsByCategoryMobile];
            
            break;}
            
        case 2:{
            
            
            break;}
    }
}

- (IBAction)btnAddAction:(id)sender {
    
    self.firstImageBottom.constant=0;
    self.secondImageBottom.constant=10;
    self.thirdImageBottom.constant=10;
    self.fourthImageBottom.constant=10;
    
    [_addImage setImage:[UIImage imageNamed:@"blue_bg04"]];
    [_specialImage setImage:[UIImage imageNamed:@"gray_bg03"]];
    [_itemImage setImage:[UIImage imageNamed:@"gray_bg02"]];
    [_saveImage setImage:[UIImage imageNamed:@"gray_bg01"]];
    
    showAddCheck=YES;
    [self getPlaylistBroadcastMobile];
}


- (IBAction)btnSpecialsAction:(id)sender {
    
    self.firstImageBottom.constant=10;
    self.secondImageBottom.constant=0;
    self.thirdImageBottom.constant=10;
    self.fourthImageBottom.constant=10;
    
    [_addImage setImage:[UIImage imageNamed:@"gray_bg04"]];
    [_specialImage setImage:[UIImage imageNamed:@"blue_bg01"]];
    [_itemImage setImage:[UIImage imageNamed:@"gray_bg02"]];
    [_saveImage setImage:[UIImage imageNamed:@"gray_bg01"]];
    
    showAddCheck=NO;
    [arrFinalData removeAllObjects];
    [self searchItemsSpecialsByCategoryMobile];
}

- (IBAction)btnItemsAction:(id)sender {
 
    self.firstImageBottom.constant=10;
    self.secondImageBottom.constant=10;
    self.thirdImageBottom.constant=0;
    self.fourthImageBottom.constant=10;
    
    [_addImage setImage:[UIImage imageNamed:@"gray_bg04"]];
    [_specialImage setImage:[UIImage imageNamed:@"gray_bg03"]];
    [_itemImage setImage:[UIImage imageNamed:@"blue_bg02"]];
    [_saveImage setImage:[UIImage imageNamed:@"gray_bg01"]];
    
    showAddCheck=NO;
    [arrFinalData removeAllObjects];
    [self searchItemsByCategoryMobile];
}

- (IBAction)btnSavedAction:(id)sender {

    self.firstImageBottom.constant=10;
    self.secondImageBottom.constant=10;
    self.thirdImageBottom.constant=10;
    self.fourthImageBottom.constant=0;
    
    [_addImage setImage:[UIImage imageNamed:@"gray_bg04"]];
    [_specialImage setImage:[UIImage imageNamed:@"gray_bg03"]];
    [_itemImage setImage:[UIImage imageNamed:@"gray_bg02"]];
    [_saveImage setImage:[UIImage imageNamed:@"blue_bg03"]];
    
    showAddCheck=NO;
     viewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"wishlistvc"];
    [self.navigationController pushViewController:viewController animated:YES];
   // [self searchSavedItems];
}

//-(void)clk_btnSearch:(id)sender
//{
//    self.blurView.hidden=NO;
//    self.showSearchView.hidden=NO;
//    
//}

//- (IBAction)selectClicked:(id)sender {
//    
//    NSArray * arr = [[NSArray alloc] init];
//    arr = [NSArray arrayWithObjects:@"Hello 0", @"Hello 1", @"Hello 2", @"Hello 3", @"Hello 4", @"Hello 5", @"Hello 6", @"Hello 7", @"Hello 8", @"Hello 9",nil];
//    NSArray * arrImage = [[NSArray alloc] init];
//    arrImage = [NSArray arrayWithObjects:[UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], nil];
//    if(dropDown == nil) {
//        CGFloat f = 100;
//        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arr :arrImage :@"down"];
//        dropDown.delegate = self;
//    }
//    else {
//        [dropDown hideDropDown:sender];
//        [self rel];
//    }
//}
//
//- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
//    
//    
//    [self rel];
//    
//    
//    //NSLog(@"%@", btnSelect.titleLabel.text);
//}
//-(void)rel{
//    //    [dropDown release];
//    
//    
//    
//    dropDown = nil;
//}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"goTo_ItemDetail"])
   // if ([[segue identifier] isEqualToString:@"goto_itemdetailsvc"])
    {
        _itemDetailVC = [segue destinationViewController];
       // ItemDetail *itemDetailObj = [segue destinationViewController];
       // itemDetailObj.selectedItemURL=itemURL;
      //  itemDetailObj.getselctedItemTag=selctedItemTag;
       // itemDetailObj.getCheck=check;
      //  _itemDetailVC.itemDetailvc = itemURL;
       
        if (check==YES){
            _itemDetailVC.itemDetailvc = itemURL;
        _itemDetailVC.selecteditem = selctedItemTag;
        }else{
            _itemDetailVC.specialItmBoolVal = true;
              _itemDetailVC.specialItemDict = itemURL;
        }
    }
    
    if ([[segue identifier] isEqualToString:@"goto_adsdetailsvc"])
    {
        AdsDetailsVC *itemDetailObj = [segue destinationViewController];
        itemDetailObj.selectedItemURL=itemURL;
    
    }
    
    if ([[segue identifier] isEqualToString:@"goto_showall_vc"])
    {
        
        if (showAddCheck ==YES) {
            
            ViewAllItemsVC *itemDetailObj = [segue destinationViewController];
            itemDetailObj.arrGetPreviousViewData=itemURL;
            itemDetailObj.checkForAds=YES;
            
        }else{
            
           
            if ([arrFinalData count] != 0) {
                
                ViewAllItemsVC *itemDetailObj = [segue destinationViewController];
                itemDetailObj.arrGetPreviousViewData=itemURL;
                itemDetailObj.checkForAllStoreItems=NO;
                
                
                
            }else {
                
                
                ViewAllItemsVC *itemDetailObj = [segue destinationViewController];
                itemDetailObj.arrGetPreviousViewData=itemURL;
                itemDetailObj.checkForCategories=YES;
                itemDetailObj.cateGaryName=selectedCategory;
                itemDetailObj.checkForAllStoreItems = true;
                
            }
            
       
        
    }
    
  }
    if ([[segue identifier] isEqualToString:@"goto_ads_relatedvc"])
    {
        AdsRalatedItemsVC *obj = [segue destinationViewController];
        
        obj.AdsDetails = getPaticularItemDetails;
    }
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
