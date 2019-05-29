//
//  AdsRalatedItemsVC.m
//  ApiTap
//
//  Created by Bikramjeet Singh on 12/13/16.
//  Copyright © 2016 ApiTap. All rights reserved.
//

#import "AdsRalatedItemsVC.h"
#import "Home_CollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <MediaPlayer/MediaPlayer.h>

@interface AdsRalatedItemsVC () {
    
    NSMutableArray *arrGetPreviousViewData;
    MPMoviePlayerController * moviePlayer;
}

@property (weak, nonatomic) IBOutlet UICollectionView *clv_AdsRelatedItems;



@end

@implementation AdsRalatedItemsVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    arrGetPreviousViewData = [NSMutableArray new];
    
    NSLog(@"%@",self.AdsDetails);
    
    self.navigationItem.title=[self.AdsDetails valueForKey:@"_120_83"];
    
    [arrGetPreviousViewData addObjectsFromArray:[self.AdsDetails valueForKey:@"IR"]];
    
    if (![[self.AdsDetails valueForKey:@"_121_15"] isEqualToString:@""]) {
        
        [self showAdsVideo:[self.AdsDetails valueForKey:@"_121_15"]];
        
    }
    
}

-(void)showAdsVideo :(NSString *)videoURL {
    
    
    NSString *finalURL=[@"http://8.41.42.131:4224/ServerImage/videos/" stringByAppendingString:videoURL];
    
    moviePlayer =[[MPMoviePlayerController alloc] initWithContentURL: [NSURL URLWithString:finalURL]];
    [moviePlayer prepareToPlay];
    moviePlayer.shouldAutoplay = YES;
    [moviePlayer.view setFrame: self.view.bounds];  // player's frame must match parent's
    moviePlayer.movieSourceType    = MPMovieSourceTypeStreaming;
    [self.view addSubview: moviePlayer.view];
    
    moviePlayer.fullscreen = YES;
    [moviePlayer play];
}

#pragma mark - UICollectionView Delegate Mehods

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake((collectionView.frame.size.width/2)-3, collectionView.frame.size.height/2.5);
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    
        return [arrGetPreviousViewData count];
    
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"Cell";
    
    Home_CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    NSString *ImageURL =[model_manager.loginManager.login.urlImage stringByAppendingString:arrGetPreviousViewData [indexPath.row][@"_121_170"]];
    
    if ([arrGetPreviousViewData[indexPath.row][@"_114_9"] isEqualToString:@"true"]) {
        
        cell.itemWatchedOrNotImageview.image=[UIImage imageNamed:@"seen"];
        
    }else{
        
        cell.itemWatchedOrNotImageview.image=[UIImage imageNamed:@"eye"];
    }
    
    // cell.lblItemPrice.text=[@"$" stringByAppendingString:[arrGetPreviousViewData valueForKey:@"PC"][indexPath.row][@"_122_158"]];
    
    cell.lblItemPrice.text=[@"$" stringByAppendingString:arrGetPreviousViewData[indexPath.row][@"_114_98"]];
    
    
    cell.lblName.text=arrGetPreviousViewData[indexPath.row][@"_120_83"];
    
    //cell.lblDiscription.text=[self stringFromHexString:[arrGetPreviousViewData valueForKey:@"PC"][indexPath.row][@"_120_157"]];
    
    /////
    
    if ([arrGetPreviousViewData[indexPath.row][@"_114_98"] isEqualToString:arrGetPreviousViewData[indexPath.row][@"_122_158"]]) {
        
        cell.lblItemSalePrice.hidden=YES;
        cell.lblCrossLine.hidden=YES;
        cell.saleView.backgroundColor=[UIColor grayColor];
        
    }else{
        
        if ([arrGetPreviousViewData[indexPath.row][@"_114_98"] isEqualToString:@"0.00"]) {
            cell.saleView.backgroundColor=[UIColor grayColor];
            cell.lblItemSalePrice.hidden=YES;
            cell.lblCrossLine.hidden=YES;
            
        }else{
            
            cell.lblItemSalePrice.hidden=NO;
            cell.lblCrossLine.hidden=NO;
            cell.lblItemSalePrice.text=[@"$" stringByAppendingString:arrGetPreviousViewData[indexPath.row][@"_122_158"]];
            
            cell.saleView.backgroundColor=[UIColor redColor];
        }
        
    }

        [cell.showImages sd_setImageWithURL:[NSURL URLWithString:ImageURL] placeholderImage:[UIImage imageNamed:@"loading"] options:SDWebImageRefreshCached | SDWebImageRetryFailed];

        cell.fillBoarderWidth.layer.borderWidth=1.0;
        cell.fillBoarderWidth.layer.borderColor=[UIColor blackColor].CGColor;

    return cell;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
