//
//  ShowSearchItemsVC.m
//  ApiTap
//
//  Created by Bikramjeet Singh on 10/27/16.
//  Copyright © 2016 ApiTap. All rights reserved.
//

#import "ShowSearchItemsVC.h"
#import "Home_Cell.h"
#import "Home_CollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ShowSearchItemsVC ()

@property (weak, nonatomic) IBOutlet UITableView *tblSearchItems;

@end

@implementation ShowSearchItemsVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
  // [self crEATEVIEW];
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:YES];
    
    
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


#pragma mark - UITableView Delegate Mehods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.arrSearchItemsData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *simpleTableIdentifier = @"Home_Cell";
    
    Home_Cell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.lblCategoryNumber.text=[self stringFromHexString:self.arrSearchItemsData[indexPath.row][@"_120_83"]];
    
    cell.btnViewAllItems.tag=indexPath.row;
    
    cell.btnViewAllItems.hidden=YES;
    
//    [cell.btnViewAllItems addTarget:self action:@selector(btnViewAllItemsClicked:)
//                   forControlEvents:UIControlEventTouchUpInside];
    
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




- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 1;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"Cell";
    
    Home_CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
        
    NSString *ImageURL =[model_manager.loginManager.login.urlImage stringByAppendingString:self.arrSearchItemsData[indexPath.row][@"_121_170"]];
    
    
    
    [cell.showImages sd_setImageWithURL:[NSURL URLWithString:ImageURL] placeholderImage:[UIImage imageNamed:@"loading"] options:SDWebImageRefreshCached | SDWebImageRetryFailed];
    
    
    
    if ([self.arrSearchItemsData[indexPath.row][@"_114_9"] isEqualToString:@"true"]) {
        
        cell.itemWatchedOrNotImageview.image=[UIImage imageNamed:@"seen"];
        
    }else{
        
        cell.itemWatchedOrNotImageview.image=[UIImage imageNamed:@"eye"];
    }
    
    
    cell.btnShowCategory.tag=indexPath.row;
    
    [cell.btnShowCategory addTarget:self action:@selector(btnImageClicked:)
                   forControlEvents:UIControlEventTouchUpInside];
    
    cell.lblItemPrice.text=[@"$" stringByAppendingString:self.arrSearchItemsData[indexPath.row][@"_114_98"]];
    
    return cell;
    
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
