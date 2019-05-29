//
//  ShowLeftSliderSpecialsVC.m
//  ApiTap
//
//  Created by Bikramjeet Singh on 9/28/16.
//  Copyright © 2016 ApiTap. All rights reserved.
//

#import "ShowLeftSliderSpecialsVC.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "SVProgressHUD.h"
#import "Home_CollectionViewCell.h"
#import "Home_Cell.h"
#import "ItemDetail.h"
#import "ViewAllItemsVC.h"
#import "ApiTap-Swift.h"
@interface ShowLeftSliderSpecialsVC (){
    
    NSMutableArray *arrFinalData;
    NSArray *itemURL;
    int selctedItemTag;
    NSString *productId;
   // - (int)intForKey:(NSString *)key;
   //- (NSString *)add:(NSString *)key;
}

@property (weak, nonatomic) IBOutlet UITableView *tblShowAllItems;
@property (nonatomic,strong) ItemDetailVC *itemDetailVC;
@end

@implementation ShowLeftSliderSpecialsVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
   
    [self initializeNavBar];
    
    [self setbarButtonItems];
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    [self searchItemsSpecialsByCategoryMobile];
    
}
- (void)add:(NSDictionary *)aFloat withFatness:(int)varFatness flag:(BOOL)varflag{
   // result += aFloat;
  //  NSLog(@"%f", result);
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    [self initializeNavBar];
    [self setbarButtonItems];
    //self.navigationItem.title=@"Specials";
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:YES];
    
    self.navigationItem.title=@"";
}


-(void)searchItemsSpecialsByCategoryMobile{
    if (![self checkInternetConeection]) {
        
        return;
    }

    [SVProgressHUD showWithStatus:@"Loading....."];
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString *timeString = [formatter stringFromDate:date];
    
    NSMutableDictionary *dictParam = [NSMutableDictionary new];
    [dictParam setValue:timeString forKey:@"121.141"];
    [dictParam setValue:@"3" forKey:@"127.89"];
    
    [dictParam setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"loginUserID"] forKey:@"53"];
    
    
    [model_manager.addManager getItemsSpecialsByCategoryMobile:kSearchItemsSpecialsByCategoryMobile userinfo:dictParam completionResponse:^(NSArray *arrImages, NSError *error)
     {
         
         [SVProgressHUD dismiss];
         
         if (!error)
         {
             arrFinalData=[NSMutableArray new];
             
             [arrFinalData addObjectsFromArray:arrImages];
             
             if(arrFinalData.count ==0){
                 
                 [self.tblShowAllItems reloadData];
                 
             }else {
                 
               
                 [self.tblShowAllItems reloadData];
             }
             
             
         }
         
     }];
    
}


#pragma mark - UITableView Delegate Mehods

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(collectionView.frame.size.width/2.6, 150.f);
}

//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    
////    if ([arrFinalData[collectionView.tag][@"PC"] count] == 1) {
////        
////        return UIEdgeInsetsMake(0 , ((collectionView.frame.size.width)-130)/2, 0, ((collectionView.frame.size.width)-140)/2);
////    }
////    
////    return UIEdgeInsetsMake(0 , 0, 0, 0);
//    
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return arrFinalData.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"Home_Cell";
    
    Home_Cell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.lblCategoryNumber.text=arrFinalData[indexPath.row][@"_120_45"];
    
    
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

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [arrFinalData[collectionView.tag][@"PC"] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"Cell";
    
    Home_CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    //NSString *ImageURL =[model_manager.loginManager.login.urlImage stringByAppendingString:arrFinalData[indexPath.row][@"_121_170"]];
    if ([arrFinalData count] > indexPath.row){
   // if ([arrFinalData[indexPath.row][@"PC"] count] == 1) {
       // itemURL=[arrFinalData[collectionView.tag]mutableCopy];
    NSMutableArray *urlImage = arrFinalData[indexPath.row][@"PC"];
      //  NSString *ImageURL =[model_manager.loginManager.login.urlImage stringByAppendingString:itemURL[indexPath.row][@"_121_170"]];
    NSString *ImageURL = [model_manager.loginManager.login.urlImage stringByAppendingString:arrFinalData[collectionView.tag][@"PC"][indexPath.row][@"_121_170"]];
    
    if ([arrFinalData[indexPath.row][@"PC"][0][@"_114_9"] isEqualToString:@"true"]) {
        
        cell.itemWatchedOrNotImageview.image=[UIImage imageNamed:@"eye"];
        
    }else{
        
        cell.itemWatchedOrNotImageview.image=[UIImage imageNamed:@"seen"];
    }
    
    
    [cell.showImages sd_setImageWithURL:[NSURL URLWithString:ImageURL] placeholderImage:[UIImage imageNamed:@"loading"] options:SDWebImageRefreshCached | SDWebImageRetryFailed];
    
    cell.btnShowCategory.tag=indexPath.row;
    
    [cell.btnShowCategory addTarget:self action:@selector(btnImageClicked:)
                   forControlEvents:UIControlEventTouchUpInside];
    
    
    cell.lblItemPrice.text=[@"$" stringByAppendingString:arrFinalData[indexPath.row][@"PC"][0][@"_114_98"]];
    
    cell.lblName.text=arrFinalData[indexPath.row][@"PC"][0][@"_120_83"];
    
    cell.lblDiscription.text=[self stringFromHexString:arrFinalData[indexPath.row][@"PC"][0][@"_120_157"]];
    /////
    
    
    if ([arrFinalData[indexPath.row][@"PC"][0][@"_114_98"] isEqualToString:arrFinalData[indexPath.row][@"PC"][0][@"_122_158"]]) {
        
        cell.lblItemSalePrice.hidden=YES;
        cell.lblCrossLine.hidden=YES;
        cell.saleView.backgroundColor=[UIColor grayColor];
        
    }else{
        
        if ([arrFinalData[indexPath.row][@"PC"][0][@"_122_158"] isEqualToString:@"0.00"]) {
            cell.saleView.backgroundColor=[UIColor grayColor];
            cell.lblItemSalePrice.hidden=YES;
            cell.lblCrossLine.hidden=YES;
            
        }else{
            
            cell.lblItemSalePrice.hidden=NO;
            cell.lblCrossLine.hidden=NO;
            cell.lblItemSalePrice.text=[@"$" stringByAppendingString:arrFinalData[indexPath.row][@"PC"][0][@"_122_158"]];
            cell.saleView.backgroundColor=[UIColor redColor];
        }
    }
    }
    
    return cell;
    
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (![self checkInternetConeection]) {
        
        return;
    }

    itemURL=[arrFinalData[collectionView.tag]mutableCopy];
    selctedItemTag=(int)indexPath.row;
   // [self add:itemURL];
   // productId = itemURL[selctedItemTag][@"_114_144"];
    
    [self performSegueWithIdentifier:@"goTo_ItemDetail" sender:nil];
    
    
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



- (IBAction)btnViewAllItemsClicked:(UIButton*)sender {
    
    itemURL=arrFinalData[sender.tag];
    
    [self performSegueWithIdentifier:@"goto_showall_vc" sender:nil];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"goTo_ItemDetail"])
    {
        [self stringForKey:itemURL withFatness2:selctedItemTag flag2:true completion:nil];
        ItemDetailVC *itemDetailObj = [segue destinationViewController];
        itemDetailObj.dataComesSpecialFlag = true;
        itemDetailObj.selecteditem = selctedItemTag;
        itemDetailObj.specialItemDict=itemURL;
        
        //[self stringForKey:itemURL withFatness2:selctedItemTag flag2:true];
       // [self add:itemURL withFatness:selctedItemTag flag:true];
        // [self add:itemURL,selctedItemTag,true];
        // itemDetailObj.getselctedItemTag=selctedItemTag;
        //itemDetailObj.getCheck=YES;
        
    }
    
    if ([[segue identifier] isEqualToString:@"goto_showall_vc"])
    {
        
        ViewAllItemsVC *itemDetailObj = [segue destinationViewController];
        itemDetailObj.arrGetPreviousViewData=itemURL;
        
        
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
