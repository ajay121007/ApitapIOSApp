        //
//  ItemDetail.m
//  ApiTap
//
//  Created by Abhishek Singla on 17/06/16.
//  Copyright © 2016 ApiTap. All rights reserved.
//

/*
 [8/19/16, 10:26:25 PM] poleschuk.ivan: 010100019 - getRelatedItems
 [8/19/16, 10:26:39 PM] poleschuk.ivan: 010100008 - getItemDetails
 [8/19/16, 10:27:00 PM] poleschuk.ivan: 010100101 - getItemReviews
 
 */

#import "ItemDetail.h"
#import "ApiTap-Swift.h"
#import "ItemDetail_itemImages.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "SVProgressHUD.h"
#import "MapVC.h"
#import "ShowAlertView.h"
#import "ProductDetailViewCell.h"
#import "ItemDetails_itemRelated.h"
#import "RelatedItemsClvCell.h"
@interface ItemDetail () <UIPickerViewDelegate, UIPickerViewDataSource,UITextFieldDelegate>
@property (nonatomic,strong) ItemRatingVC *itemRatingVC;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) MapViewController *mapVC;
@end
@implementation ItemDetail

{
   
    __weak UIBlurEffect *blurEffect;
    __weak IBOutlet UIView *containerView;
      __weak  UIVisualEffect *effect;
    __weak IBOutlet UIVisualEffectView *visualEffectView;
    
    __weak IBOutlet UIView *continueShoppingCartView;
    NSMutableArray *arrRelatedImages,*arrRalatedItemsForParticular;
    
    __weak IBOutlet UIView *hiddenView;
    __weak IBOutlet UITextField *opton2TextField;
    
    __weak IBOutlet UITextField *option1TxtField;
    __weak IBOutlet UIView *showZoomView;
    
    __weak IBOutlet UICollectionView *relatedItemsClv;
    
     __weak IBOutlet UICollectionView *productDetailCollectionView;
    
    __weak IBOutlet UIScrollView *scrollView;
    
    __weak IBOutlet UIImageView *imageView;
    
    __weak IBOutlet UIButton *btnLowerCart;
    __weak IBOutlet UIButton *btnLocation;
    __weak IBOutlet UIButton *btnBuyNow;
    __weak IBOutlet UITableView *tableItemsRelated;
    __weak IBOutlet UILabel *lblItemPrice;
    __weak IBOutlet UITableView *tableItemImages;
    __weak IBOutlet UIImageView *imgItem;
    __weak IBOutlet UILabel *lblCartItemsCount;
    __weak IBOutlet UILabel *lblItemDetail;
    
    __weak IBOutlet UIView *cartDetailView;
    
    __weak IBOutlet UIButton *btnFavourite;
    
    __weak IBOutlet UILabel *lblMerchantName;
    
    __weak IBOutlet UILabel *lblShowQuantity;
    
    __weak IBOutlet UIButton *btnPlus;
    
    __weak IBOutlet UIView *shadowView;
    __weak IBOutlet UIButton *btnMinus;
    
    __weak IBOutlet UIButton *btnFirstChoice;
    
    __weak IBOutlet UIButton *btnSecondChoice;
    
    __weak IBOutlet UIPickerView *chooseOptionPickerView;
    
    __weak IBOutlet UIView *hidePickerView;
    
    __weak IBOutlet UIBarButtonItem *btnDone;
    
    
    __weak IBOutlet NSLayoutConstraint *setBottomConst;
    
    
    __weak IBOutlet UITextView *txtViewDescription;
    BOOL check, blureView;
   
    
    NSMutableArray *arrItemImages,*arrrelatedItems,*arrGetChoices;
    NSString *makeElevenDigit, *merchantID, *showItemName,*optionId,*optionName;
    NSMutableArray *pickerArray;
    NSArray *arr;
    int quantity,options;
}


#pragma mark - View Lifecycle Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    UIToolbar *toolBar= [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 44)];
    [toolBar setBarStyle:UIBarStyleDefault];
    UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                      style:UIBarButtonItemStyleBordered
                                                                     target:self
                                                                     action:@selector(doneClicked)];
    toolBar.items = @[flex, barButtonDone];
    barButtonDone.tintColor = [UIColor blackColor];
    
    _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, toolBar.frame.size.height, screenWidth, 200)];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    _pickerView.showsSelectionIndicator = YES;
    
    
    UIView *inputView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, toolBar.frame.size.height + _pickerView.frame.size.height)];
    inputView.backgroundColor = [UIColor clearColor];
    [inputView addSubview:_pickerView];
    [inputView addSubview:toolBar];
    
    option1TxtField.inputView = inputView;
    opton2TextField.inputView = inputView;
         //#2
        self.pickerView.dataSource = self;
        option1TxtField.delegate = self;
        opton2TextField.delegate = self;
    
        option1TxtField.tag = 101;
        opton2TextField.tag = 102;
    
//    self.pickerView = [[UIPickerView alloc] init];
//    UIToolbar *toolBar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,100,44)];
//    [toolBar setBarStyle:UIBarStyleBlackOpaque];
//    UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"
//                                                                      style:UIBarButtonItemStylePlain target:self action:@selector(changeDateFromLabel:)];
//    toolBar.items = @[barButtonDone];
//    barButtonDone.tintColor=[UIColor whiteColor];
//    [self.pickerView addSubview:toolBar];
//   // [self.view addSubview:_pickerView];
//    self.pickerView.delegate = self;     //#2
//    self.pickerView.dataSource = self;
//    option1TxtField.delegate = self;
//    opton2TextField.delegate = self;
//    option1TxtField.inputView = self.pickerView;
//    opton2TextField.inputView = self.pickerView;
//    option1TxtField.tag = 101;
//    opton2TextField.tag = 102;
    
    effect = visualEffectView.effect;
    NSArray *colors = @[@"Yes", @"no"];
    arr = colors;
    visualEffectView.effect = nil;
    NSLog(@"%@",self.selectedItemURL);
    for (NSDictionary* currentString in _selectedItemURL)
    {
         NSString *value = [currentString objectForKey:@"_121_80"];
        _productRating = value;
    }
   
    
    showZoomView.hidden=YES;
    
    float minScale=scrollView.frame.size.width / imageView.frame.size.width;
    scrollView.minimumZoomScale = minScale;
    scrollView.maximumZoomScale = 3.0;
    scrollView.contentSize = imageView.frame.size;
    scrollView.delegate = self;

    imgItem.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tapGesture1:)];
    
    [imgItem addGestureRecognizer:tapGesture1];

    
    self.view.backgroundColor = LightGreyColor;
    
    self.navigationController.navigationBarHidden = NO;
    
    self.navigationController.navigationBar.barTintColor = BlueColor;
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    btnFirstChoice.hidden=YES;
    btnSecondChoice.hidden=YES;
    
    tableItemImages.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    quantity=1;
    hidePickerView.hidden=YES;
    
//    [self initializeNavBar];
//    [self loadCustomUI];
   // [self setbarButtonItems];
    
    //Initialise Objects
  
    //
    
    
    //NSLog(@"%@",[self.selectedItemURL valueForKey:@"_114_144"]);
    
        if (self.getCheck == YES) {
            
            makeElevenDigit=[GlobalClass makeElevenDigitNumber:[[self.selectedItemURL objectAtIndex:self.getselctedItemTag]valueForKey:@"_114_144"]];
            
        }
    
        else if (self.getStoreItemDetails == YES){
            
            
            makeElevenDigit=[GlobalClass makeElevenDigitNumber:[[[self.selectedItemURL valueForKey:@"PC"]objectAtIndex:self.getselctedItemTag]valueForKey:@"_114_144"]];
            
        }else if (self.getAllItems == YES){
            
//if ([GlobalClass makeElevenDigitNumber:[self.selectedItemURL valueForKey:@"_114_144"]].length) {
            
           // [CustomAlertView showAlert:@"Alert" message:@"Data Not Found"];
            
            //return;
        
//            if (self.selectedItemURL != NULL)
//            {
//                NSLog(@"%@",[self.selectedItemURL valueForKey:@"_114_144"] );
         makeElevenDigit=  [GlobalClass makeElevenDigitNumber:[self.selectedItemURL valueForKey:@"_114_144"]];
//                
//            }
//            else
//            {
//                 [CustomAlertView showAlert:@"Alert" message:@"Data Not Found"];
//                
//                return;
//            }
            
                

           // }
            
                   }
        else {
            
            makeElevenDigit=[GlobalClass makeElevenDigitNumber:[NSString stringWithFormat:@"%@",[[[self.selectedItemURL valueForKey:@"PC"]objectAtIndex:self.getselctedItemTag]valueForKey:@"_114_144"]]];
        }
        
    
    
   //[self addProductWatchedByUser];
    
}
- (void)doneClicked {
    [opton2TextField resignFirstResponder];
    [option1TxtField resignFirstResponder];
}
-(void)changeDateFromLabel:(id)sender
{
    _pickerView.hidden = YES;
    
   [hiddenView setFrame:CGRectMake(20,20,self.view.frame.size.width-40,hiddenView.frame.size.height-80)];
}
-(void)viewWillAppear:(BOOL)animated{
    
    [self getItemDetails];
    
    [self getRelatedItems];
    [self getoptionByItem];
    //[self addItemsIntoCart];
    [super viewWillAppear:YES];
    
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:YES];
    
    self.navigationItem.title=@"";
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

-(void)getItemDetails{
    
    if (![self checkInternetConeection]) {
        
        return;
    }

   [SVProgressHUD showWithStatus:@"Loading....."];
    
    NSMutableDictionary *dictParam = [NSMutableDictionary new];
    
    //@"00000000373"
    
    [dictParam setValue:makeElevenDigit forKey:@"114.144"];
    
    if (self.getCheck == YES) {
        
        [dictParam setValue:[self.selectedItemURL objectAtIndex:self.getselctedItemTag][@"_114_112"] forKey:@"114.112"];
        
    }else if (self.getStoreItemDetails == YES){
       
        [dictParam setValue:[self.selectedItemURL valueForKey:@"PC"][self.getselctedItemTag][@"_114_112"] forKey:@"114.112"];
        
    }else if (self.getAllItems == YES){
        
       // makeElevenDigit=[GlobalClass makeElevenDigitNumber:[self.selectedItemURL valueForKey:@"_114_112"]];
        
         [dictParam setValue:[NSString stringWithFormat:@"%@",[self.selectedItemURL valueForKey:@"_114_112"]] forKey:@"114.112"];
    }
    else {
        
        
         [dictParam setValue:[NSString stringWithFormat:@"%@",[self.selectedItemURL valueForKey:@"PC"][self.getselctedItemTag][@"_114_112"]] forKey:@"114.112"];
    }
      
   
    [dictParam setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"loginUserID"] forKey:@"53"];
    
    [model_manager.addManager getItemDetails:KGetItemDetailMobile userinfo:dictParam completionResponse:^(NSArray *arrImages, NSError *error)
     {
         if (!error)
         {
            
             
             [SVProgressHUD dismiss];
          //   NSLog(@"%@",a);
             
             NSLog(@"%@",arrImages);
             
            
             if(arrImages == nil || [arrImages valueForKey:@"_121_170"][0] == nil){
                 
                  [CustomAlertView showAlert:@"Alert" message:@"Data Not Found"];
                 
             }else{
                 
                 
                 
                 
                // NSLog(@"%@",[arrImages valueForKey:@"_120_157"]);
                 
                 arrGetChoices=[NSMutableArray new];
                 
                 txtViewDescription.text=[self stringFromHexString:[arrImages valueForKey:@"_120_157"][0]];
                 _productRating = [arrImages valueForKey:@"_121_80"][0];
                 merchantID=[arrImages valueForKey:@"_53"][0];
                
                 showItemName = [arrImages valueForKey:@"_120_83"][0];
                 
                 NSString *ImageURL =[model_manager.loginManager.login.urlImage stringByAppendingString:[arrImages valueForKey:@"_121_170"][0]];
                 
                 [imgItem sd_setImageWithURL:[NSURL URLWithString:ImageURL] placeholderImage:[UIImage imageNamed:@"loading"] options:SDWebImageRefreshCached | SDWebImageRetryFailed];
                 
                 imageView.contentMode=UIViewContentModeScaleAspectFit;
                 
                  [imageView sd_setImageWithURL:[NSURL URLWithString:ImageURL] placeholderImage:[UIImage imageNamed:@"loading"] options:SDWebImageRefreshCached | SDWebImageRetryFailed];
                 
                 // imageView.image = [UIImage imageNamed: @"wallabi.jpg"];
                 
                 lblItemDetail.text=[@"Sold By: " stringByAppendingString:[arrImages valueForKey:@"_121_150"][0]];
                 
                 self.navigationItem.title=[arrImages valueForKey:@"_120_83"][0];
                 
                 lblItemPrice.text=[@"$" stringByAppendingString:[arrImages valueForKey:@"_122_158"][0]];
                 
                 //lblMerchantName.text=[arrImages valueForKey:@"_121_150"][0];
                 
                 lblItemDetail.userInteractionEnabled=YES;
                 
                 UITapGestureRecognizer *singleFingerTap =
                 [[UITapGestureRecognizer alloc] initWithTarget:self
                                                         action:@selector(handleSingleTap:)];
                 [lblItemDetail addGestureRecognizer:singleFingerTap];
                 
                 //goto_map_vc
                 
                 if ([[arrImages valueForKey:@"_120_15"][0] isEqualToString:@"1"]) {
                     
                     [btnFavourite setImage:[UIImage imageNamed:@"favourite-red"] forState:UIControlStateNormal];
                     btnFavourite.selected=YES;
                     
                 }else {
                     
                     [btnFavourite setImage:[UIImage imageNamed:@"favourite-gray"] forState:UIControlStateNormal];
                     
                 }
                 
                 NSLog(@"%@",arrImages);
                 
                 arrItemImages = [NSMutableArray new];
                 arrrelatedItems = [NSMutableArray new];
                 
                 [arrItemImages addObjectsFromArray:[arrImages valueForKey:@"IM"]];
                 [arrGetChoices addObjectsFromArray:[arrImages valueForKey:@"OP"][0]];
                 
                  arrRelatedImages=[NSMutableArray new];
                 [arrRelatedImages addObjectsFromArray:arrItemImages[0]];
                 
                
                 
                 if (arrGetChoices.count != 0) {
                     
                     for (int i=0; i < arrGetChoices.count; i++) {
                         
                         if (i==0) {
                             
                             btnFirstChoice.hidden=NO;
                             
                             [btnFirstChoice setTitle:arrGetChoices[0][@"_122_134"] forState:UIControlStateNormal];
                             
                             btnSecondChoice.hidden=YES;
                             
                         }
                         if (i == 1) {
                             
                             btnSecondChoice.hidden=NO;
                             [btnSecondChoice setTitle:arrGetChoices[1][@"_122_134"] forState:UIControlStateNormal];
                         }
                     }
                     
                 }
                 
                 
                 [tableItemImages reloadData];
                // [relatedItemsClv reloadData];
             }
             
            }
         
     }];
    
}

- (void) tapGesture1: (id)sender
{
    showZoomView.hidden=NO;
    
    [productDetailCollectionView reloadData];
    
}
- (IBAction)hideZoomViewAction:(id)sender {
    
    
    showZoomView.hidden=YES;

    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"goto_itemratingvc"]) {
        _itemRatingVC = [segue destinationViewController];
        _itemRatingVC.merchantId = merchantID;
        _itemRatingVC.merchantrating  = _productRating;
        _itemRatingVC.descText = txtViewDescription.text;
    }
    if ([segue.identifier isEqualToString:@"go_to_mapVC"]) {
        _mapVC = [segue destinationViewController];
        _mapVC.merchantId = merchantID;
    }
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    
[self performSegueWithIdentifier:@"goto_itemratingvc" sender:merchantID];
    
     //_itemRatingVC.merchantId = @"123";
   // _itemRatingVC.merchantId = merchantId;
    //_itemRatingVC.merchantrating  = _productRating;
    //[self performSegueWithIdentifier:@"goto_itemratingvc" sender:nil];
}
- (IBAction)moreItems:(UIButton *)sender {
    [self performSegueWithIdentifier:@"go_to_mapVC" sender:merchantID];
}

-(void)getRelatedItems{
    
    if (![self checkInternetConeection]) {
        
        return;
    }

    NSMutableDictionary *dictParam = [NSMutableDictionary new];
    
    [dictParam setValue:@"00000000368" forKey:@"114.144"];
    [dictParam setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"loginUserID"] forKey:@"53"];
    
    [model_manager.addManager getRelatedItems:KGetRelatedItemsKey userinfo:dictParam completionResponse:^(NSArray *arrImages, NSError *error)
     {
         
         if (!error)
         {
             
             NSLog(@"%@",arrImages);
             
             if(arrImages.count != 0){
                 
                 arrRalatedItemsForParticular=[NSMutableArray new];
                 
                 [arrRalatedItemsForParticular addObjectsFromArray:arrImages];
                 
                 [relatedItemsClv reloadData];
                 
             }
             
             
             
         }
         
     }];
    
}


-(void)addProductWatchedByUser{
    if (![self checkInternetConeection]) {
        
        return;
    }

    NSMutableDictionary *dictParam = [NSMutableDictionary new];
    
    [dictParam setValue:makeElevenDigit forKey:@"114.144"];
    [dictParam setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"loginUserID"] forKey:@"53"];
    
    [model_manager.addManager addProductWatchedByUser:KAddProductWatchedByUserKey userinfo:dictParam completionResponse:^(NSArray *arrImages, NSError *error)
     {
         
         if (!error)
         {
             
             
         }
         
     }];
    
}

-(void)addFavoriteItemMobile{
    if (![self checkInternetConeection]) {
        
        return;
    }
    [SVProgressHUD showWithStatus:@"Loading....."];
    
    NSMutableDictionary *dictParam = [NSMutableDictionary new];
    
    [dictParam setValue:makeElevenDigit forKey:@"114.144"];
    [dictParam setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"loginUserID"] forKey:@"53"];
    
    [model_manager.addManager addProductWatchedByUser:KAddFavoriteItemMobileKey userinfo:dictParam completionResponse:^(NSArray *arrImages, NSError *error)
     {
         
         [SVProgressHUD dismiss];
         
         if (!error)
         {
             
             [btnFavourite setImage:[UIImage imageNamed:@"favourite-red"] forState:UIControlStateNormal];
             btnFavourite.selected=YES;
             
             
         }
         
     }];
    
}

-(void)removeFavoriteItemMobile{
    
    if (![self checkInternetConeection]) {
        
        return;
    }

    [SVProgressHUD showWithStatus:@"Loading....."];
    
    NSMutableDictionary *dictParam = [NSMutableDictionary new];
    
    [dictParam setValue:makeElevenDigit forKey:@"114.144"];
    [dictParam setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"loginUserID"] forKey:@"53"];
    
    [model_manager.addManager removeFavoriteItemMobile:KRemoveFavoriteItemMobileKey userinfo:dictParam completionResponse:^(NSArray *arrImages, NSError *error)
     {
         
         [SVProgressHUD dismiss];
         
         if (!error)
         {
             [btnFavourite setImage:[UIImage imageNamed:@"favourite-gray"] forState:UIControlStateNormal];
         }
         
     }];
    
}


-(void)loadCustomUI
{
    
    //[self navigationBarTitle:@""];
    [self navBarLogo];
    
    cartDetailView.backgroundColor = LightGreyColor;
    
    lblCartItemsCount.backgroundColor = BlueColor;
    lblCartItemsCount.layer.cornerRadius = 10;
    lblCartItemsCount.clipsToBounds=YES;
    
    
    //    btnBuyNow.alpha = 0.5;
    //    btnLocation.alpha = 0.5;
    //    btnLowerCart.alpha = 0.5;
    
    
    //    CALayer *layer = btnBuyNow.layer;
    //    [btnBuyNow.layer setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.5].CGColor];
    //
    //    layer.backgroundColor = [[UIColor clearColor] CGColor];
    //    layer.borderColor = [[UIColor darkGrayColor] CGColor];
    //    layer.cornerRadius = 8.0f;
    //    layer.borderWidth = 1.0f;
    
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    return imageView;
}

#pragma mark - UICollectionView Delegate Mehods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (collectionView == relatedItemsClv) {
        
         return [arrRalatedItemsForParticular count];
        
    }else{
        
        return arrRelatedImages.count;
        
    }
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView == relatedItemsClv) {
        
        static NSString *identifier = @"RelatedItemsClvCell";
        
        RelatedItemsClvCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
                
        NSString *ImageURL =[model_manager.loginManager.login.urlImage stringByAppendingString:arrRalatedItemsForParticular[indexPath.row][@"_121_170"]];
        
        [cell.relatedImages sd_setImageWithURL:[NSURL URLWithString:ImageURL] placeholderImage:[UIImage imageNamed:@"loading"] options:SDWebImageRefreshCached | SDWebImageRetryFailed];
        
        return cell;

        
        
    }else{
        
        static NSString *identifier = @"Cell";
        
        ProductDetailViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        
        NSString *ImageURL =[model_manager.loginManager.login.urlImage stringByAppendingString:arrRelatedImages[indexPath.row][@"_47_42"]];

        
        [cell.showImages sd_setImageWithURL:[NSURL URLWithString:ImageURL] placeholderImage:[UIImage imageNamed:@"loading"] options:SDWebImageRefreshCached | SDWebImageRetryFailed];
        
        return cell;

     
    }
    
    
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (collectionView == relatedItemsClv) {
        
        NSLog(@"%@",arrRalatedItemsForParticular[indexPath.row][@"_114_112"]);
        
         makeElevenDigit=[GlobalClass makeElevenDigitNumber:arrRalatedItemsForParticular[indexPath.row][@"_114_144"]];
        
        [self getDetrailsRelatedItemsDetails:makeElevenDigit :arrRalatedItemsForParticular[indexPath.row][@"_114_112"]];
        
    }else{
        
        NSString *ImageURL =[model_manager.loginManager.login.urlImage stringByAppendingString:arrRelatedImages[indexPath.row][@"_47_42"]];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:ImageURL] placeholderImage:[UIImage imageNamed:@"loading"] options:SDWebImageRefreshCached | SDWebImageRetryFailed];
    }
    
}

-(void)getDetrailsRelatedItemsDetails : (NSString *)itemID : (NSString *)itemNumber{
    
    if (![self checkInternetConeection]) {
        
        return;
    }
    
    [SVProgressHUD showWithStatus:@"Loading....."];
    
    NSMutableDictionary *dictParam = [NSMutableDictionary new];
    
    //@"00000000373"
    
    [dictParam setValue:itemID forKey:@"114.144"];
    
    [dictParam setValue:itemNumber forKey:@"114.112"];
    
    
    NSLog(@"%@",dictParam);
    
    [dictParam setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"loginUserID"] forKey:@"53"];
    
    [model_manager.addManager getItemDetails:KGetItemDetailMobile userinfo:dictParam completionResponse:^(NSArray *arrImages, NSError *error)
     {
         if (!error)
         {
             [SVProgressHUD dismiss];
             //   NSLog(@"%@",a);
             
             
             if(arrImages == nil || [arrImages valueForKey:@"_121_170"][0] == nil){
                 
                 [CustomAlertView showAlert:@"Alert" message:@"Data Not Found"];
                 
             }else{
                 
                 arrGetChoices=[NSMutableArray new];
                 
                 merchantID=[arrImages valueForKey:@"_53"][0];
                 
                 NSString *ImageURL =[model_manager.loginManager.login.urlImage stringByAppendingString:[arrImages valueForKey:@"_121_170"][0]];
                 
                 [imgItem sd_setImageWithURL:[NSURL URLWithString:ImageURL] placeholderImage:[UIImage imageNamed:@"loading"] options:SDWebImageRefreshCached | SDWebImageRetryFailed];
                 
                 imageView.contentMode=UIViewContentModeScaleAspectFit;
                 
                 [imageView sd_setImageWithURL:[NSURL URLWithString:ImageURL] placeholderImage:[UIImage imageNamed:@"loading"] options:SDWebImageRefreshCached | SDWebImageRetryFailed];
                 
                 // imageView.image = [UIImage imageNamed: @"wallabi.jpg"];
                 
                 lblItemDetail.text=[arrImages valueForKey:@"_120_83"][0];
                 
                 lblItemPrice.text=[@"$" stringByAppendingString:[arrImages valueForKey:@"_122_158"][0]];
                 
                 lblMerchantName.text=[arrImages valueForKey:@"_121_150"][0];
                 
                 lblMerchantName.userInteractionEnabled=YES;
                 
                 UITapGestureRecognizer *singleFingerTap =
                 [[UITapGestureRecognizer alloc] initWithTarget:self
                                                         action:@selector(handleSingleTap:)];
                 [lblMerchantName addGestureRecognizer:singleFingerTap];
                 
                 //goto_map_vc
                 
                 if ([[arrImages valueForKey:@"_120_15"][0] isEqualToString:@"1"]) {
                     
                      [btnFavourite setImage:[UIImage imageNamed:@"favourite-red"] forState:UIControlStateNormal];
                     btnFavourite.selected=YES;
                     
                 }else {
                     
                     [btnFavourite setImage:[UIImage imageNamed:@"favourite-gray"] forState:UIControlStateNormal];
                     
                 }
                 
                 NSLog(@"%@",arrImages);
                 
                 arrItemImages = [NSMutableArray new];
                 arrrelatedItems = [NSMutableArray new];
                 
                 [arrItemImages addObjectsFromArray:[arrImages valueForKey:@"IM"]];
                 [arrGetChoices addObjectsFromArray:[arrImages valueForKey:@"OP"][0]];
                 
                 arrRelatedImages=[NSMutableArray new];
                 [arrRelatedImages addObjectsFromArray:arrItemImages[0]];
                 
                 
                 
                 if (arrGetChoices.count != 0) {
                     
                     for (int i=0; i < arrGetChoices.count; i++) {
                         
                         if (i==0) {
                             
                             btnFirstChoice.hidden=NO;
                             
                             [btnFirstChoice setTitle:arrGetChoices[0][@"_122_134"] forState:UIControlStateNormal];
                             
                             btnSecondChoice.hidden=YES;
                             
                         }
                         if (i == 1) {
                             
                             btnSecondChoice.hidden=NO;
                             [btnSecondChoice setTitle:arrGetChoices[1][@"_122_134"] forState:UIControlStateNormal];
                         }
                     }
                     
                 }
                 
                 
                 [tableItemImages reloadData];
                 // [relatedItemsClv reloadData];
             }
             
         }
         
     }];
    
}


#pragma mark - UITableViewDelegate & DataSource Methods

// number of row in the section, I assume there is only 1 row

- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
{
    
     return arrRelatedImages.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"CellIdentifier";
    
    ItemDetail_itemImages *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (cell == nil)
    {
        cell = [[ItemDetail_itemImages alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    
    NSString *ImageURL =[model_manager.loginManager.login.urlImage stringByAppendingString:arrRelatedImages[indexPath.row][@"_47_42"]];
    
    cell.listImage.tag=indexPath.row;
    
    [cell.listImage sd_setImageWithURL:[NSURL URLWithString:ImageURL] placeholderImage:[UIImage imageNamed:@"loading"] options:SDWebImageRefreshCached | SDWebImageRetryFailed];
    
    return cell;
    
    
//    if (tableView == tableItemImages)
//    {
//        static NSString *CellIdentifier = @"CellIdentifier";
//        
//        ItemDetail_itemImages *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//        
//        if (cell == nil)
//        {
//            cell = [[ItemDetail_itemImages alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
//        }
//        
//        cell.backgroundColor = [UIColor clearColor];
//        cell.contentView.backgroundColor = [UIColor clearColor];
//        
//        NSString *ImageURL =[model_manager.loginManager.login.urlImage stringByAppendingString:arrItemImages[indexPath.row][0][@"_47_42"]];
//        
//        [cell.listImage sd_setImageWithURL:[NSURL URLWithString:ImageURL] placeholderImage:[UIImage imageNamed:@"image"] options:SDWebImageRefreshCached | SDWebImageRetryFailed];
//        
//        return cell;
//    }else
//    {
//        static NSString *CellIdentifier = @"ItemDetails_itemRelated";
//        
//        ItemDetails_itemRelated *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//        
//        if (cell == nil) {
//            
//            cell = [[ItemDetails_itemRelated alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
//        }
//        
//        cell.textLabel.textAlignment = NSTextAlignmentCenter;
//        
//        cell.backgroundColor = [UIColor clearColor];
//        cell.contentView.backgroundColor = [UIColor clearColor];
//        //cell.textLabel.text = [arrItems objectAtIndex:indexPath.row];
//        
//        NSString *ImageURL =[model_manager.loginManager.login.urlImage stringByAppendingString:arrRelatedImages[indexPath.row][@"_47_42"]];
//        
//        [cell.relatedImages sd_setImageWithURL:[NSURL URLWithString:ImageURL] placeholderImage:[UIImage imageNamed:@"image"] options:SDWebImageRefreshCached | SDWebImageRetryFailed];
//
//        return cell;
//    }
    
  
    
}

// when user tap the row, what action you want to perform

- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSLog(@"%ld",(long)indexPath.row);
    
    NSString *ImageURL =[model_manager.loginManager.login.urlImage stringByAppendingString:arrRelatedImages[indexPath.row][@"_47_42"]];
    
    [imgItem sd_setImageWithURL:[NSURL URLWithString:ImageURL] placeholderImage:[UIImage imageNamed:@"loading"] options:SDWebImageRefreshCached | SDWebImageRetryFailed];
    
    
    
//    if (theTableView == tableItemImages)
//    {
//
//    }
//    else if (theTableView == tableItemsRelated)
//    {
//        
//    }
}
- (IBAction)submitBtnClicked:(id)sender {
    [self addItemsIntoCart];
   // shadowView.hidden = true;
   // shadowView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    
}
- (IBAction)cancelBtnClicked:(id)sender {
    hiddenView.hidden = true;
    blureView=NO;
     [self animateOut];
   // [self animateIn];
}
- (IBAction)addToCartBtnTapped:(id)sender {
    hiddenView.hidden = false;
   // shadowView.hidden = false;
   // shadowView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    //hiddenView.backgroundColor = [UIColor whiteColor];
   // [containerView bringSubviewToFront:hiddenView];
  
    blureView=YES;
    [self animateIn];
}
-(void)animateIn {
    blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular];
   // UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular];
    visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
   // UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    visualEffectView.frame = self.view.bounds;
    visualEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    visualEffectView.hidden=true;
   // if (blureView == YES){
    containerView.backgroundColor = [UIColor clearColor];
    visualEffectView.hidden=false;
   
    
    [containerView addSubview:visualEffectView];
    [visualEffectView addSubview:hiddenView];
   
    
    
//    [containerView addSubview:hiddenView];
//    
//    hiddenView.center = containerView.center;
//    hiddenView.transform = CGAffineTransformMakeTranslation(1.3, 1.3);
//    //hiddenView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3);
//    hiddenView.alpha = 0;
//    
//    [UIView animateWithDuration:0.4 animations:^{
//        visualEffectView.effect = effect;
//        hiddenView.alpha = 1;
//        hiddenView.transform = CGAffineTransformIdentity;
//    }];
}
-(void)animateOut {
    [visualEffectView removeFromSuperview];
    // visualEffectView.removeFromSuperview;
    //
    //    [self.view addSubview:hiddenView];
    //
    //    hiddenView.center = self.view.center;
    //    hiddenView.transform = CGAffineTransformMakeTranslation(1.3, 1.3);
    //    //hiddenView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3);
    //    hiddenView.alpha = 0;
//    
//    [UIView animateWithDuration:0.3 animations:^{
//        hiddenView.transform = CGAffineTransformMakeTranslation(1.3, 1.3);
//        visualEffectView.effect = effect;
//        hiddenView.alpha = 0;
//        visualEffectView.effect = nil;
//        
//    } completion:^(BOOL finished) {
//        hiddenView.removeFromSuperview;
//    }];
    
    
}
-(void)addItemsIntoCart {
    NSString *text = nil;
    if (![self checkInternetConeection]) {
        
        return;
    }

    
    if (![self checkInternetConeection]) {
        
        return;
    }
    
    
//    NSMutableDictionary *dictParam = [NSMutableDictionary new];
//    
//    [dictParam setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"loginUserID"] forKey:@"53"];
//    [dictParam setValue:@"00000000088" forKey:@"114.144"];
//    [dictParam setValue:@"0001202A000000000858" forKey:@"114.179"];
//    [dictParam setValue:@"3" forKey:@"114.121"];
//    [dictParam setValue:@[@{@"121.104":@"00000001148"},@{@"121.104":@"00000001152"}] forKey:@"CH"];
//    //[dictParam setValue:@[] forKey:@"FILTER"];
//    
//    
//    [model_manager.addManager addItemIntoCart:@"030400198" userinfo:dictParam completionResponse:^(NSArray *arrImages, NSError *error)
//     {
//         
//         if (!error)
//         {
//             
//             
//         }
//         
//     }];

    
    NSMutableDictionary *dictParam = [NSMutableDictionary new];
    
    [dictParam setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"loginUserID"] forKey:@"53"];
    [dictParam setValue:makeElevenDigit forKey:@"114.144"];
    [dictParam setValue:merchantID forKey:@"114.179"];
   // [dictParam setValue:[NSString stringWithFormat:@"%d", quantity] forKey:@"114.121"];
    [dictParam setValue:@[@{@"121.104":@"00000001148"},@{@"121.104":@"00000001152"}] forKey:@"CH"];
   // [dictParam setValue:@[] forKey:@"FILTER"];
    
    NSLog(@"%@",arrGetChoices);
    
    
    NSMutableArray *new=[NSMutableArray new];
    
    for (int i=0; i<arrGetChoices.count; i++) {
        
        NSMutableDictionary *optDict=[NSMutableDictionary new];
        
        [optDict setValue:[GlobalClass makeElevenDigitNumber:arrGetChoices[i][@"CH"][0][@"_121_179"]] forKey:@"121.104"];
        
        NSLog(@"%@",optDict);
        
        [new addObject:optDict];
    }
    
    NSLog(@"%@",new);
    
    [dictParam setValue:new forKey:@"CH"];
    
    [SVProgressHUD showWithStatus:@"Loading....."];
    
    text = lblShowQuantity.text;
    NSString *myString  = [text stringByReplacingOccurrencesOfString:@"QTY " withString:@""];
    NSString *myString2  = [myString stringByReplacingOccurrencesOfString:@" " withString:@""];
     [dictParam setValue:myString2 forKey:@"114.121"];
    [model_manager.addManager addItemIntoCart:@"030400198" userinfo:dictParam completionResponse:^(NSArray *arrImages, NSError *error)
     {
         
         [SVProgressHUD dismiss];
         
         if (!error)
         {
             
             NSLog(@"%@",arrImages);
            // continueShoppingCartView.hidden = false;
             hiddenView.hidden = true;
             // [CustomAlertView showAlert:@"Alert" message:@"Item Added Into Cart Sucessfully"];
             
         }
         
     }];
    
}

-(void)getoptionByItem {
    NSMutableArray *myArray = [[NSMutableArray alloc] init];
     NSMutableDictionary *dictParam = [NSMutableDictionary new];
     [dictParam setValue:makeElevenDigit forKey:@"114.144"];
    [model_manager.addManager getOptionsByItem:@"010100012" userinfo:dictParam completionResponse:^(NSArray *arrImages, NSError *error)
     {
         
         [SVProgressHUD dismiss];
         
         if (!error)
         {
             
             optionId = [arrImages valueForKey:@"RESULT"][0][0][@"_122_111"];
             optionId = [@"000000000" stringByAppendingString:optionId];
             optionName = [arrImages valueForKey:@"RESULT"][0][0][@"_122_134"];
             [myArray addObject:optionName];
             pickerArray = myArray;
             //[pickerArray addObject: optionName];
            // [pickerArray addObject:optionName];
           
             NSLog(@"%@",arrImages);
            // continueShoppingCartView.hidden = false;
             hiddenView.hidden = true;
            // [CustomAlertView showAlert:@"Alert" message:@"Item Added Into Cart Sucessfully"];
             
         }
         [self getChoiceByOption];
     }];
}
-(void)getChoiceByOption{
    NSMutableDictionary *dictParam = [NSMutableDictionary new];
    [dictParam setValue:optionId forKey:@"122.111"];
    [model_manager.addManager getChoicesByOption:@"010100013" userinfo:dictParam completionResponse:^(NSArray *arrImages, NSError *error)
     {
         
         [SVProgressHUD dismiss];
         
         if (!error)
         {
             
             NSLog(@"%@",arrImages);
            // continueShoppingCartView.hidden = false;
             hiddenView.hidden = true;
            // [CustomAlertView showAlert:@"Alert" message:@"Item Added Into Cart Sucessfully"];
             
         }
         
     }];
}
- (IBAction)continueShopping:(id)sender {
    continueShoppingCartView.hidden = true;
}

#pragma mark - IBAction Methods

- (IBAction)clkLowerCart:(id)sender {
    
    [self addItemsIntoCart];
}

- (IBAction)clkLocation:(id)sender {
    
}

- (IBAction)clkBuyNow:(id)sender {
    
    [self addItemsIntoCart];
}

- (IBAction)clkDots:(id)sender {
}

- (IBAction)clkEye:(id)sender {
    
}

- (IBAction)clkCart:(id)sender {
    
}

- (IBAction)clkBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)clk_btnLeftMenu:(id)sender
{
   [self.menuContainerViewController toggleLeftSideMenuCompletion:^{}];
    
}

- (IBAction)btnAddFavouriteAction:(UIButton *)sender {
    
    
   // [self performSegueWithIdentifier:@"goto_wishlistvc" sender:nil];
    
    if (sender.selected==YES) {
        
        [self removeFavoriteItemMobile];
        sender.selected=NO;
        
    }else {
        
      
        
        [self addFavoriteItemMobile];
        
        sender.selected=YES;
    }
    
}
- (IBAction)cancelBtntapped:(id)sender {
    hiddenView.hidden=true;
}

- (IBAction)btnPlusAction:(id)sender {
    
    if (quantity==50) {
        
        btnPlus.enabled=NO;
        
    }else {
        
        quantity=quantity+1;
        
        lblShowQuantity.text=[@"QTY " stringByAppendingString:[NSString stringWithFormat:@"%d",quantity]];
        
    }
}


- (IBAction)btnMinusAction:(id)sender {
    
    if (quantity==1) {
        
        btnMinus.enabled=NO;
        
    }else {
        
        quantity=quantity-1;
        
        lblShowQuantity.text=[@"QTY " stringByAppendingString:[NSString stringWithFormat:@"%d",quantity]];
        
    }

}

- (IBAction)btnFirstChoiceAction:(id)sender {
    
    [self callAnimation];
  
    options=0;
    
    hidePickerView.hidden=NO;
    
    [chooseOptionPickerView selectRow:0 inComponent:0 animated:NO];
    
    [chooseOptionPickerView reloadAllComponents];
    
    // chooseOptionPickerView = @[@"Item 1", @"Item 2", @"Item 3", @"Item 4", @"Item 5", @"Item 6"];
    
}

-(void)callAnimation {
    
    [UIView animateWithDuration:1.0
                          delay:0.1
                        options: UIViewAnimationCurveEaseIn
                     animations:^{
                         
                         //self.postStatusView.frame = CGRectMake(0, 0, 320, 460);
                         
                         setBottomConst.constant=0;
                     }
                     completion:^(BOOL finished){
                         
                     }];
    

}

- (IBAction)btnSecondChoiceAction:(id)sender {
    
        
    options=1;
    
    hidePickerView.hidden=NO;
    
    [chooseOptionPickerView selectRow:0 inComponent:0 animated:NO];
    
    [chooseOptionPickerView reloadAllComponents];
}

//- (NSInteger)numberOfComponentsInPickerView: (UIPickerView *)pickerView
//{
//    
//    return 1;
//}
//
//- (NSInteger)pickerView:(UIPickerView *)pickerView
//numberOfRowsInComponent:(NSInteger)component
//{
//    
//    return [arrGetChoices[options][@"CH"] count];
//}
//
//- (NSString *)pickerView:(UIPickerView *)pickerView
//             titleForRow:(NSInteger)row
//            forComponent:(NSInteger)component
//{
//    
//    return arrGetChoices[options][@"CH"][row][@"_127_16"];
//    
//}
//
//-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
//      inComponent:(NSInteger)component
//{
//    
//    if (options==0) {
//        
//        [btnFirstChoice setTitle:arrGetChoices[options][@"CH"][row][@"_127_16"] forState:UIControlStateNormal];
//        
//    }else {
//        
//        [btnSecondChoice setTitle:arrGetChoices[options][@"CH"][row][@"_127_16"] forState:UIControlStateNormal];
//    }
//    
//    
//}


- (IBAction)btnCancelAction:(id)sender {
    
    hidePickerView.hidden=YES;
}

- (IBAction)btnDoneAction:(id)sender {
    
    hidePickerView.hidden=YES;
}
- (IBAction)btn_ShareAction:(id)sender {
    
    
   // NSString * message = @"My too cool Son";
    
   // UIImage * image = [UIImage imageNamed:@"boyOnBeach"];
    
    NSArray * shareItems = @[showItemName, imageView.image];
    
    UIActivityViewController * avc = [[UIActivityViewController alloc] initWithActivityItems:shareItems applicationActivities:nil];
    
    [self presentViewController:avc animated:YES completion:nil];
    
    
    
//    NSString *textToShare = @"Look at this awesome website for aspiring iOS Developers!";
//    
//    NSURL *myWebsite = [NSURL URLWithString:@"http://www.codingexplorer.com/"];
//    
//    NSArray *objectsToShare = @[textToShare, myWebsite];
//    
//    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
//    
//    //    NSArray *excludeActivities = @[UIActivityTypeAirDrop,
//    //                                   UIActivityTypePrint,
//    //                                   UIActivityTypeAssignToContact,
//    //                                   UIActivityTypeSaveToCameraRoll,
//    //                                   UIActivityTypeAddToReadingList,
//    //                                   UIActivityTypePostToFlickr,
//    //                                   UIActivityTypePostToVimeo];
//    //
//    //    activityVC.excludedActivityTypes = excludeActivities;
//    
//    [self presentViewController:activityVC animated:YES completion:nil];
    
}


//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//   
//    if ([[segue identifier] isEqualToString:@"goto_map_vc"])
//    {
//        
//        MapVC *vc = [segue destinationViewController];
//        vc.merchantID = merchantID;
//       
//    }
//}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    if (textField.tag == 101){
        _pickerView.hidden = NO;
         _pickerView.tag = 501;
    }
    if (textField.tag == 102){
        _pickerView.hidden = NO;
         _pickerView.tag = 502;
    }
    return YES;
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    [hiddenView endEditing:YES];
    [textField resignFirstResponder];
    return YES;
}


- (void)keyboardDidShow:(NSNotification *)notification
{
    // Assign new frame to your view
    [hiddenView setFrame:CGRectMake(20,-20,hiddenView.frame.size.width,hiddenView.frame.size.height)];
   // [hiddenView setFrame:CGRectMake(20,-20,self.view.frame.size.width-40,self.view.frame.size.height-80)]; //here taken -110 for example i.e. your view will be scrolled to -110. change its value according to your requirement.
    
}

-(void)keyboardDidHide:(NSNotification *)notification
{
    [hiddenView setFrame:CGRectMake(20,30,hiddenView.frame.size.width,hiddenView.frame.size.height)];
   // [hiddenView setFrame:CGRectMake(20,20,self.view.frame.size.width-40,hiddenView.frame.size.height-80)];
}

#pragma mark - Memory Management Method

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (pickerView == self.pickerView) {
        return 1;
    }
    
    return 0;
}

// #4
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView == self.pickerView) {
        if (pickerView.tag == 501){
        return [pickerArray count];
        }else{
            return [arr count];
        }
    }
    
    return 0;
}

#pragma mark - UIPickerViewDelegate

// #5
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (pickerView == self.pickerView) {
        if (pickerView.tag == 501){
        return pickerArray[row];
        }else{
            return arr[row];
        }
    }
    
    return nil;
}

// #6
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (pickerView == self.pickerView) {
         if (pickerView.tag == 501){
        option1TxtField.text = pickerArray[row];
         }else{
              opton2TextField.text = arr[row];
         }
    }
}
@end
