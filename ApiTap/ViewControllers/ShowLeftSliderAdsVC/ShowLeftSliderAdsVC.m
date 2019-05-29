//
//  ShowLeftSliderAdsVC.m
//  ApiTap
//
//  Created by Bikramjeet Singh on 9/28/16.
//  Copyright © 2016 ApiTap. All rights reserved.
//

#import "ShowLeftSliderAdsVC.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "SVProgressHUD.h"
#import "Home_CollectionViewCell.h"
#import "AdsDetailsVC.h"

@interface ShowLeftSliderAdsVC () {
    
     NSMutableArray *arrFinalData;
     NSArray *itemURL;
}

@property (weak, nonatomic) IBOutlet UICollectionView *adsCollectionView;

@end

@implementation ShowLeftSliderAdsVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initializeNavBar];
    
    [self setbarButtonItems];

    
    [self getPlaylistBroadcastMobile];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    self.navigationItem.title=@"Ads";
}


-(void)getPlaylistBroadcastMobile{
    if (![self checkInternetConeection]) {
        
        return;
    }
    [SVProgressHUD showWithStatus:@"Loading....."];
    
    NSMutableDictionary *dictParam = [NSMutableDictionary new];
    
    [dictParam setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"loginUserID"] forKey:@"53"];
    
    [model_manager.addManager showAdds:KGetPlaylistBroadcastMobile userinfo:dictParam completionResponse:^(NSArray *arrImages, NSError *error)
     {
         [SVProgressHUD dismiss];
         
         if (!error)
         {
             
             
                 arrFinalData=[NSMutableArray new];
                 
                 [arrFinalData addObjectsFromArray:[arrImages objectAtIndex:0][@"RESULT"]];
                 
                 if(arrFinalData.count ==0){
                     
                     [self.adsCollectionView reloadData];
                     
                 }else {
                     
                     self.adsCollectionView.hidden=NO;
                     
                     [self.adsCollectionView reloadData];
                 }
         }
         
                 
            
     }];
    
    
}

#pragma mark - UICollectionView Delegate Mehods

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"%f",(collectionView.frame.size.width)-5);
    
    return CGSizeMake((collectionView.frame.size.width)-5, 180);
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [arrFinalData count];
        
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"Cell";
    
        Home_CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    NSLog(@"%@",arrFinalData[indexPath.row][@"_121_170"]);
        NSString *ImageURL =[model_manager.loginManager.login.urlImage stringByAppendingString:arrFinalData[indexPath.row][@"_121_170"]];
        
        [cell.showImages sd_setImageWithURL:[NSURL URLWithString:ImageURL] placeholderImage:[UIImage imageNamed:@"loading"] options:SDWebImageRefreshCached | SDWebImageRetryFailed];
    cell.addNameLbl.text = arrFinalData[indexPath.row][@"_114_70"];
        cell.addTitleLbl.text = arrFinalData[indexPath.row][@"_120_83"];
//        cell.btnShowCategory.tag=indexPath.row;
//        
//        [cell.btnShowCategory addTarget:self action:@selector(btnImageClicked:)
//                       forControlEvents:UIControlEventTouchUpInside];
    
    
        return cell;
        
        
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (![self checkInternetConeection]) {
        
        return;
    }

        itemURL=arrFinalData;
        
        [self performSegueWithIdentifier:@"goto_adsdetailsvc" sender:nil];
        
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    
    if ([[segue identifier] isEqualToString:@"goto_adsdetailsvc"])
    {
        AdsDetailsVC *itemDetailObj = [segue destinationViewController];
        itemDetailObj.selectedItemURL=itemURL;
        
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
