//
//  ViewAllItemsVC.m
//  ApiTap
//
//  Created by Bikramjeet Singh on 9/23/16.
//  Copyright © 2016 ApiTap. All rights reserved.
//

#import "ViewAllItemsVC.h"
#import "Home_CollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ItemDetail.h"

@interface ViewAllItemsVC () {
    
    NSMutableArray *getInner,*arrGetAllItems,*arrFinalData;
    NSMutableArray *itemURL;
    int selctedItemTag;
    int increment;
    NSMutableDictionary *mainDict;
    BOOL check, showAddCheck;
}

@property (weak, nonatomic) IBOutlet UILabel *lblItemName;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;



@end

@implementation ViewAllItemsVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    arrFinalData=[NSMutableArray new];
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    
    
    NSLog(@"%d",self.checkForAllStoreItems);
    
    if (self.checkForCategories == YES) {
        
        self.navigationItem.title=self.cateGaryName;
        
    }else if (self.checkForAds == YES) {
        
        
    }else if (self.checkForAllStoreItems == YES) {
        
        self.navigationItem.title=[self.arrGetPreviousViewData valueForKey:@"_114_70"];
    }
    
    else{
        
        self.navigationItem.title=[self.arrGetPreviousViewData valueForKey:@"_120_45"];
        
        
    }

}

#pragma mark - UICollectionView Delegate Mehods

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
   return CGSizeMake((collectionView.frame.size.width/2)-3, collectionView.frame.size.height/2.5);
        
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    
    if (self.checkForCategories == YES) {
        
        return [self.arrGetPreviousViewData count];
        
    }else if (self.checkForAds == YES) {
        
        return [[self.arrGetPreviousViewData valueForKey:@"PC"] count];
        
    }else{
        
        return [[self.arrGetPreviousViewData valueForKey:@"PC"] count];
    }
    
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"Cell";
    
    Home_CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    NSString *ImageURL;
    
    
    if (self.checkForCategories == YES) {
        
         ImageURL =[model_manager.loginManager.login.urlImage stringByAppendingString:self.arrGetPreviousViewData[indexPath.row][@"_121_170"]];
        
        if ([self.arrGetPreviousViewData[indexPath.row][@"_114_9"] isEqualToString:@"true"]) {
            
            cell.itemWatchedOrNotImageview.image=[UIImage imageNamed:@"seen"];
            
        }else{
            
            cell.itemWatchedOrNotImageview.image=[UIImage imageNamed:@"eye"];
        }
        
        
        cell.lblItemPrice.text=[@"$" stringByAppendingString:self.arrGetPreviousViewData[indexPath.row][@"_114_98"]];
        
        cell.lblName.text=self.arrGetPreviousViewData[indexPath.row][@"_120_83"];
        
        cell.lblDiscription.text=[self stringFromHexString:self.arrGetPreviousViewData[indexPath.row][@"_120_157"]];
        /////
        
        if ([self.arrGetPreviousViewData[indexPath.row][@"_114_98"] isEqualToString:self.arrGetPreviousViewData[indexPath.row][@"_122_158"]]) {
            
            cell.lblItemSalePrice.hidden=YES;
            cell.lblCrossLine.hidden=YES;
            cell.saleView.backgroundColor=[UIColor grayColor];
            
        }else{
            
            if ([self.arrGetPreviousViewData[indexPath.row][@"_114_98"] isEqualToString:@"0.00"]) {
                cell.saleView.backgroundColor=[UIColor grayColor];
                cell.lblItemSalePrice.hidden=YES;
                cell.lblCrossLine.hidden=YES;
                
            }else{
                
                cell.lblItemSalePrice.hidden=NO;
                cell.lblCrossLine.hidden=NO;
                cell.lblItemSalePrice.text=[@"$" stringByAppendingString:self.arrGetPreviousViewData[indexPath.row][@"_122_158"]];
                cell.saleView.backgroundColor=[UIColor redColor];
            }
            
        }
        
    }else if (self.checkForAds == YES){
        
        
    }else{
        
                
        ImageURL =[model_manager.loginManager.login.urlImage stringByAppendingString:[self.arrGetPreviousViewData valueForKey:@"PC"][indexPath.row][@"_121_170"]];
        
        if ([[self.arrGetPreviousViewData valueForKey:@"PC"][indexPath.row][@"_114_9"] isEqualToString:@"true"]) {
            
            cell.itemWatchedOrNotImageview.image=[UIImage imageNamed:@"seen"];
            
        }else{
            
            cell.itemWatchedOrNotImageview.image=[UIImage imageNamed:@"eye"];
        }
        
       // cell.lblItemPrice.text=[@"$" stringByAppendingString:[self.arrGetPreviousViewData valueForKey:@"PC"][indexPath.row][@"_122_158"]];
        
        cell.lblItemPrice.text=[@"$" stringByAppendingString:[self.arrGetPreviousViewData valueForKey:@"PC"][indexPath.row][@"_114_98"]];
        
        
        cell.lblName.text=[self.arrGetPreviousViewData valueForKey:@"PC"][indexPath.row][@"_120_83"];
        
        cell.lblDiscription.text=[self stringFromHexString:[self.arrGetPreviousViewData valueForKey:@"PC"][indexPath.row][@"_120_157"]];
        
        /////
        
        if ([[self.arrGetPreviousViewData valueForKey:@"PC"][indexPath.row][@"_114_98"] isEqualToString:[self.arrGetPreviousViewData valueForKey:@"PC"][indexPath.row][@"_122_158"]]) {
            
            cell.lblItemSalePrice.hidden=YES;
            cell.lblCrossLine.hidden=YES;
            cell.saleView.backgroundColor=[UIColor grayColor];
            
        }else{
            
            if ([[self.arrGetPreviousViewData valueForKey:@"PC"][indexPath.row][@"_114_98"] isEqualToString:@"0.00"]) {
                cell.saleView.backgroundColor=[UIColor grayColor];
                cell.lblItemSalePrice.hidden=YES;
                cell.lblCrossLine.hidden=YES;
                
            }else{
                
                cell.lblItemSalePrice.hidden=NO;
                cell.lblCrossLine.hidden=NO;
                cell.lblItemSalePrice.text=[@"$" stringByAppendingString:[self.arrGetPreviousViewData valueForKey:@"PC"][indexPath.row][@"_122_158"]];
                
                cell.saleView.backgroundColor=[UIColor redColor];
            }
            
        }
        
    }
    
    
    [cell.showImages sd_setImageWithURL:[NSURL URLWithString:ImageURL] placeholderImage:[UIImage imageNamed:@"loading"] options:SDWebImageRefreshCached | SDWebImageRetryFailed];
    
    cell.fillBoarderWidth.layer.borderWidth=1.0;
    cell.fillBoarderWidth.layer.borderColor=[UIColor blackColor].CGColor;
    
    return cell;
        
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
          //  NSLog(@"%@",self.arrGetPreviousViewData);
    
    
            if (self.checkForCategories == YES) {
                
                itemURL=[self.arrGetPreviousViewData[indexPath.row] mutableCopy];
                selctedItemTag=(int)indexPath.row;
                check=YES;
                
                
                
            }
    
            if (self.checkForAllStoreItems == NO) {
                
               // NSLog(@"%@",self.arrGetPreviousViewData);
                
                itemURL=[[self.arrGetPreviousViewData valueForKey:@"PC"]objectAtIndex:indexPath.row];
                check=YES;
                
            }
    
    
            
     [self performSegueWithIdentifier:@"goto_itemdetailsvc" sender:nil];
    
    
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"goto_itemdetailsvc"])
    {
        ItemDetail *itemDetailObj = [segue destinationViewController];
        itemDetailObj.selectedItemURL=itemURL;
        itemDetailObj.getselctedItemTag=selctedItemTag;
        itemDetailObj.getAllItems=YES;
        
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
