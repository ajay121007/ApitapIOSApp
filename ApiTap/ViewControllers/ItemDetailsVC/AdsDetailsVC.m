//
//  AdsDetailsVC.m
//  ApiTap
//
//  Created by Bikramjeet Singh on 9/23/16.
//  Copyright © 2016 ApiTap. All rights reserved.
//

#import "AdsDetailsVC.h"
#import <MediaPlayer/MediaPlayer.h>
#import "Home_CollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface AdsDetailsVC () <UIScrollViewDelegate>{
    
    MPMoviePlayerController * moviePlayer;
    NSMutableArray *arrRelatedItems,*arrShowRelatedItems;
}

@property (weak, nonatomic) IBOutlet UICollectionView *relatedItemsCollectionView;

@property (weak, nonatomic) IBOutlet UICollectionView *showAllAdVertisementCollctVoew;

@property (weak, nonatomic) IBOutlet UIView *scrollInnerView;

@property (weak, nonatomic) IBOutlet UIScrollView *scrvSwipeableImages;

@property (weak, nonatomic) IBOutlet UILabel *lblAdsName;

@property (weak, nonatomic) IBOutlet UIImageView *showAdsImages;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *setXPosition;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *setHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *setWidthPosition;

@end

@implementation AdsDetailsVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
   
//    
//    NSString *finalURL=[@"http://100.43.205.74:4224/ServerImage/videos/" stringByAppendingString:_selectedItemURL[0][@"_121_15"]];
//    
//    moviePlayer =[[MPMoviePlayerController alloc] initWithContentURL: [NSURL URLWithString:finalURL]];
//    [moviePlayer prepareToPlay];
//    moviePlayer.shouldAutoplay = YES;
//    [moviePlayer.view setFrame: self.view.bounds];  // player's frame must match parent's
//    moviePlayer.movieSourceType    = MPMovieSourceTypeStreaming;
//    [self.view addSubview: moviePlayer.view];
//    // ...
//    moviePlayer.fullscreen = YES;
//    [moviePlayer play];
    
    
//    NSLog(@"%@",_selectedItemURL[0]);
//    
    _scrvSwipeableImages.delegate = self;
    
    arrRelatedItems = [NSMutableArray new];
    arrShowRelatedItems = [NSMutableArray new];
    
    for (int i=0; i<_selectedItemURL.count; i++) {
        
       // NSLog(@"%@",[[_selectedItemURL objectAtIndex:i]valueForKey:@"IR"]);
        
        [arrRelatedItems addObject:[[_selectedItemURL objectAtIndex:i]valueForKey:@"IR"]];
        
    }
    
//    
//    NSLog(@"%@",_selectedItemURL[0]);
//    
//    NSLog(@"%@",_selectedItemURL[0][@"_120_83"]);
    
    self.navigationItem.title=_selectedItemURL[0][@"_120_83"];
    
    self.lblAdsName.text=_selectedItemURL[0][@"_120_83"];
    [arrShowRelatedItems addObjectsFromArray:[[_selectedItemURL objectAtIndex:0]valueForKey:@"IR"]];
    
   
    
    // Do any additional setup after loading the view.
    
    self.scrollInnerView.backgroundColor=[UIColor redColor];
    
   //[self setScrollView];
}

-(void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    
    [self setScrollView];
}

-(void)setScrollView {
    
    CGFloat x=0;
    
    [self.scrvSwipeableImages setContentSize:CGSizeMake((self.view.frame.size.width-90)*_selectedItemURL.count, self.scrvSwipeableImages.frame.size.height)];
    
    for(int i=0;i<_selectedItemURL.count;i++)
    {
 
        
        UIImageView *addImage=[[UIImageView alloc]initWithFrame:CGRectMake(x+15, 10, self.view.frame.size.width-120, self.scrvSwipeableImages.frame.size.height)];
        
        NSString *ImageURL =[model_manager.loginManager.login.urlImage stringByAppendingString:_selectedItemURL[i][@"_121_170"]];
        
        [addImage sd_setImageWithURL:[NSURL URLWithString:ImageURL] placeholderImage:[UIImage imageNamed:@"loading"] options:SDWebImageRefreshCached | SDWebImageRetryFailed];
        
        addImage.contentMode = UIViewContentModeScaleToFill;
        addImage.clipsToBounds=YES;
        addImage.layer.masksToBounds=YES;
        
        [self.scrvSwipeableImages addSubview:addImage];
        
        x+=self.view.frame.size.width-90;
        
        
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)_scrollView {
    
    [arrShowRelatedItems removeAllObjects];
    
    if(_scrollView == _scrvSwipeableImages)
    {
        CGFloat viewWidth = _scrollView.frame.size.width;
        
        int pageNumber = floor((_scrollView.contentOffset.x - viewWidth/50) / viewWidth) +1;
                
        [arrShowRelatedItems addObjectsFromArray:[[_selectedItemURL objectAtIndex:pageNumber]valueForKey:@"IR"]];
        
        self.lblAdsName.text=_selectedItemURL[pageNumber][@"_120_83"];

        
        [self.relatedItemsCollectionView reloadData];
        
    }else {
        
        
    }
    
}

#pragma mark - UICollectionView Delegate Mehods

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (collectionView == self.relatedItemsCollectionView) {
        
        return CGSizeMake(113.f, 108.f);
    }   
    
    return CGSizeMake((collectionView.frame.size.width)-(collectionView.frame.size.width/4), collectionView.frame.size.height);
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
   return arrShowRelatedItems.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"Cell";
    
    Home_CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    
        NSString *ImageURL =[model_manager.loginManager.login.urlImage stringByAppendingString:arrShowRelatedItems[indexPath.row][@"_121_170"]];
        
        [cell.showImages sd_setImageWithURL:[NSURL URLWithString:ImageURL] placeholderImage:[UIImage imageNamed:@"loading"] options:SDWebImageRefreshCached | SDWebImageRetryFailed];
        cell.lblName.text=arrShowRelatedItems[indexPath.row][@"_120_83"];
        cell.lblItemPrice.text=arrShowRelatedItems[indexPath.row][@"_114_98"];
    
    
        return cell;
        
    }
    
    
//    
//    if (showAddCheck ==YES) {
//        
//        Home_CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
//        
//       
//        
//        NSString *ImageURL =[model_manager.loginManager.login.urlImage stringByAppendingString:arrFinalData[indexPath.row][@"_121_170"]];
//        
//        [cell.showImages sd_setImageWithURL:[NSURL URLWithString:ImageURL] placeholderImage:[UIImage imageNamed:@"image"] options:SDWebImageRefreshCached | SDWebImageRetryFailed];
//        
//        cell.btnShowCategory.tag=indexPath.row;
//        
//        [cell.btnShowCategory addTarget:self action:@selector(btnImageClicked:)
//                       forControlEvents:UIControlEventTouchUpInside];
//        
//        
//        return cell;
//        
//    }else {
//        
//        Home_CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
//        
//        
//            NSString *ImageURL =[model_manager.loginManager.login.urlImage stringByAppendingString:arrFinalData[indexPath.row][@"PC"][0][@"_121_170"]];
//            
//        
//            return cell;
//            
//        }
    
   


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
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
