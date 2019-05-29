//
//  ProductDetailVC.m
//  ApiTap
//
//  Created by deepraj on 9/16/16.
//  Copyright © 2016 ApiTap. All rights reserved.
//

#import "ProductDetailVC.h"
#import "ProductDetailViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ProductDetailVC ()<UIScrollViewDelegate,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *productDetailCollectionView;

@property(strong,nonatomic) IBOutlet NSArray *arrInnerImages;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintRight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *CenterConstraintY;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintBottom;
@property (weak, nonatomic) IBOutlet UIButton *changeImageButton;
@property (nonatomic) CGFloat lastZoomScale;
@end

@implementation ProductDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initializeNavBar];
    
    [self setbarButtonItems];
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    self.imageView.image = [UIImage imageNamed: @"wallabi.jpg"];
    
    _arrInnerImages=@[@"http://placehold.it/120x120&text=image1",@"http://placehold.it/120x120&text=image2",@"http://placehold.it/120x120&text=image3",@"http://placehold.it/120x120&text=image4"];

    [_productDetailCollectionView reloadData];
    float minScale=self.scrollView.frame.size.width / self.imageView.frame.size.width;
    self.scrollView.minimumZoomScale = minScale;
    self.scrollView.maximumZoomScale = 3.0;
    self.scrollView.contentSize = self.imageView.frame.size;
    self.scrollView.delegate = self;

    //[self updateZoom];
    
    
    // Do any additional setup after loading the view.
}




//- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration {
//    [super willAnimateRotationToInterfaceOrientation:interfaceOrientation duration:duration];
//    
//    [self updateZoom];
//}



- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
   
    return self.imageView;
}




/*-(void)showZoomonImage
{
    float minScale=self.productZoomScrollView.frame.size.width / self.productImageView.frame.size.width;
    self.productZoomScrollView.minimumZoomScale = minScale;
    self.productZoomScrollView.maximumZoomScale = 3.0;
    self.productZoomScrollView.contentSize = self.productImageView.frame.size;
    self.productZoomScrollView.delegate = self;
    
}*/


#pragma mark - UICollectionView Delegate Mehods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [_arrInnerImages count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"Cell";

    
    ProductDetailViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
 
   
   
    
    [cell.showImages sd_setImageWithURL:[NSURL URLWithString:_arrInnerImages[indexPath.row]] placeholderImage:[UIImage imageNamed:@"loading"] options:SDWebImageRefreshCached | SDWebImageRetryFailed];
    
    return cell;

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:_arrInnerImages[indexPath.row]] placeholderImage:[UIImage imageNamed:@"loading"] options:SDWebImageRefreshCached | SDWebImageRetryFailed];

    
}



-(void)clk_btnLeftMenu:(id)sender
{
    NSLog(@"clk_btnLeftMenu");
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{}];
    
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
