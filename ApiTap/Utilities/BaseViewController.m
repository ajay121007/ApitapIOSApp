//
//  BaseViewController.m
//  SportsPal
//
//  Created by Abhishek Singla on 10/03/16.
//  Copyright © 2016 SportsPal. All rights reserved.
//

#import "BaseViewController.h"
#import "ShowSearchItemsVC.h"
#import "SVProgressHUD.h"
#import "NIDropDown.h"
#import "Reachability.h"
#import "ApiTap-Swift.h"
#import<CoreLocation/CoreLocation.h>

@interface BaseViewController ()<NIDropDownDelegate,UITextFieldDelegate,IQDropDownTextFieldDelegate>
 {
     CLGeocoder *geocoder;
     CLPlacemark *placemark;
    
    BOOL isSearchWithAddress;
    UICollectionView *_collectionView;
    UIViewController *viewController ;
    UINavigationController *navi;
    UIBarButtonItem *btnQRCode;
    NIDropDown *dropDown;
    UIView * searchSuperView ;
    IQDropDownTextField *searchTextField;
    UITextField *searchTextField2;
    UITextField *searchTextField3;
    NSMutableArray *arrAllUserAddress,*arrGetAllNames,*arrGetOwnerIDs,*arrGetLatitude,*arrGetLongitude;
    
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic) Reachability *hostReachability;
@property (nonatomic) Reachability *internetReachability;

@end

@implementation BaseViewController
@synthesize locationManagers;
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [indicator startAnimating];
    selectedBtnarr=[[NSMutableArray alloc]init];
    UISwitch *aSwitch = [[UISwitch alloc] init];
//    myPickerView.hidden=YES;
//    myPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 200, 320, 200)];
//    [self.view addSubview:myPickerView];
//    myPickerView.delegate = self;
//    myPickerView.showsSelectionIndicator = YES;
//    
//    
//    doneButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [doneButton addTarget:self
//                   action:@selector(aMethod:)
//         forControlEvents:UIControlEventTouchDown];
//    doneButton.frame = CGRectMake(265.0,202.0,  52.0, 30.0);
//    UIImage *img = [UIImage imageNamed:@"done.png"];
//    [doneButton setImage:img forState:UIControlStateNormal];
//    
//   // [img release];
//    
//    [self.view addSubview:doneButton];
   //  [self getAllAddressLists];
    NSMutableDictionary *searchParam = [NSMutableDictionary new];
    [searchParam setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"loginUserID"] forKey:@"53"];
//    [model_manager.addManager searchCurrentLocation:@"010100055" userinfo:searchParam completionResponse:^(NSArray *arrImages, NSError *error)
//     {
//         [SVProgressHUD dismiss];
//         
//         
//         
//         
//     }];
    
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
//    
//    NSString *remoteHostName = @"www.apple.com";
//  
//    self.hostReachability = [Reachability reachabilityWithHostName:remoteHostName];
//    [self.hostReachability startNotifier];
//    [self updateInterfaceWithReachability:self.hostReachability];
//    
//    self.internetReachability = [Reachability reachabilityForInternetConnection];
//    [self.internetReachability startNotifier];
//    [self updateInterfaceWithReachability:self.internetReachability];

}


-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:YES];
    
    self.navigationItem.title=@"";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initializeNavBar
{
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.barTintColor = BlueColor;
}

-(void)createBtn{
    viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CustomCollectionVC"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(aMethod:)forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Show View" forState:UIControlStateNormal];
    button.frame = CGRectMake(0.0, 10.0, 160.0, 40.0);
    [button setBackgroundColor : [UIColor redColor]];
    //[self.window bringSubviewToFront:button];
   // [viewController.view addSubview:button];
}
-(void)setCollectionViewButton{
    CustomCollectionVC* controller =     [self.storyboard instantiateViewControllerWithIdentifier:@"CustomCollectionVC"];
   // self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 80) collectionViewLayout:layout];
   // _collectionView=[[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
   // [_collectionView setDataSource:self];
  //  [_collectionView setDelegate:self];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [_collectionView setBackgroundColor:[UIColor redColor]];
    
    [self.view addSubview:_collectionView];
   // [controller addSubview:_collectionView];
    //[_collectionView reloadData];
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
}


// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor greenColor];
    return cell;
}


-(void)setHomeButton{
    
     NSArray *viewControlles = self.navigationController.viewControllers;
    
    if (viewControlles.count >3) {
        
        UIImage *sliderImage = [[UIImage imageNamed:@"slider"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        UIBarButtonItem *btnLeftMenu = [[UIBarButtonItem alloc] initWithImage:sliderImage style:UIBarButtonItemStylePlain target:self action:@selector(clk_btnLeftMenu:)];
        
        
        UIImage *scanImage = [[UIImage imageNamed:@"scan"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        btnQRCode = [[UIBarButtonItem alloc] initWithImage:scanImage style:UIBarButtonItemStylePlain target:self action:@selector(clk_btnQRCode:)];
        self.navigationItem.leftBarButtonItems = @[btnLeftMenu];
        
        /* Image in navigationBar */
        
        UIImage * logoInNavigationBar = [UIImage imageNamed:@"01_logo.png"];//
        UIImageView * logoView = [[UIImageView alloc] init];
        [logoView setImage:logoInNavigationBar];
        self.navigationController.navigationItem.titleView = logoView;
        
        /* Right Bar Buttons */
        
        UIImage *messageImage = [[UIImage imageNamed:@"email-slider"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];//email
        UIBarButtonItem *btnMessage = [[UIBarButtonItem alloc] initWithImage:messageImage style:UIBarButtonItemStylePlain target:self action:@selector(clk_btnMessage:)];
        UIImage *searchrImage = [[UIImage imageNamed:@"search"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIBarButtonItem *btnSearch = [[UIBarButtonItem alloc] initWithImage:searchrImage style:UIBarButtonItemStylePlain target:self action:@selector(clk_btnSearch:)];
        
        
        self.navigationItem.rightBarButtonItems = @[btnMessage];
        
    }else{
        
        
    }
}

-(void)getAllAddressLists {
    geocoder = [[CLGeocoder alloc] init];
        locationManagers = [[CLLocationManager alloc] init];
        locationManagers.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        locationManagers.delegate = self;
        [locationManagers startUpdatingLocation];
        [locationManagers requestWhenInUseAuthorization];
    if (![self checkInternetConeection]) {
        
        return;
    }    NSMutableDictionary *dictParam = [NSMutableDictionary new];
    
    [dictParam setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"loginUserID"] forKey:@"53"];
    
   // [SVProgressHUD showWithStatus:@"Loding....."];
    
    [model_manager.addressManager getCountryStateCityList:@"010100055" userinfo:dictParam completionResponse:^(NSArray *arrImages, NSError *error)
     
     {
         
         if (!error)
         {
             if ([arrImages[0][@"AD"] count] ==0) {
                 
                 
                 
             }else {
                 
                 
                 dispatch_async(dispatch_get_main_queue(), ^{
                 //    [SVProgressHUD dismiss];
                    
                     arrAllUserAddress=[NSMutableArray new];
                     
                     arrGetLatitude=[NSMutableArray new];
                     arrGetLongitude=[NSMutableArray new];
                     
                     [arrAllUserAddress  addObjectsFromArray:arrImages[0][@"AD"]];
                     
                     for (int i=0; i<arrAllUserAddress.count; i++) {
                         
                       [arrGetAllNames addObject:arrAllUserAddress[i][@"_114_53"]];
                       //  [arrGetLatitude addObject:arrAllUserAddress[i][@"_120_38"]];
                        // [arrGetLongitude addObject:arrAllUserAddress[i][@"_120_39"]];
                     }
                     
                     [self crEATEVIEW];
                     //[self.tblShowAllAddress reloadData];
                     
                 });
                 
                
             }
         }
         
     }];
    
}


-(void)searchItemsByOfferMobile{
    
    if (![self checkInternetConeection]) {
        
        return;
    }
    if ([searchTextField.text length] == 0) {
        [CustomAlertView showAlert:@"Alert" message:@"Please Enter Any Value For Search"];
        return;
    }
    
    
    [searchTextField resignFirstResponder];
    [SVProgressHUD showWithStatus:@"Loading....."];
    NSMutableDictionary *dictParam = [NSMutableDictionary new];
    [dictParam setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"loginUserID"] forKey:@"53"];
    [dictParam setValue:searchTextField.text forKey:@"114.127"];
    [model_manager.addManager showAdds:@"010400472" userinfo:dictParam completionResponse:^(NSArray *arrImages, NSError *error)
     {
         [SVProgressHUD dismiss];
         
         if (!error)
         {
             
             if ([[arrImages valueForKey:@"RESULT"][0][0] count] == 0) {
                 
                 [CustomAlertView showAlert:@"Alert" message:@"Data Not Found"];
                 
             }else{
                 
                 [self removewSearchView];
                 [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"check"];
                 ShowSearchItemsVC *controller=[self.storyboard instantiateViewControllerWithIdentifier:@"ShowSearchItemsVC"];
                 controller.arrSearchItemsData=[arrImages valueForKey:@"RESULT"][0];
                 [self.navigationController pushViewController:controller animated:YES];
             }
             
             
             
         }
     }];
}


-(void)searchItemsNear {
    
    if (![self checkInternetConeection]) {
        
        return;
    }

    [SVProgressHUD showWithStatus:@"Loading....."];
    
    NSMutableDictionary *dictParam = [NSMutableDictionary new];
    
    [dictParam setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"loginUserID"] forKey:@"53"];
    
    [dictParam setValue:searchTextField.text forKey:@"114.127"];
    
    [dictParam setValue:@"33.965335" forKey:@"120.38"];
    
    [dictParam setValue:@"-118.272739" forKey:@"120.39"];
    
    [dictParam setValue:@"001" forKey:@"127.10"];
    
    [model_manager.addManager showAdds:@"010400228" userinfo:dictParam completionResponse:^(NSArray *arrImages, NSError *error)
     {
         
         [SVProgressHUD dismiss];
         
         if (!error)
         {
             [self removewSearchView];
             
             if ([[arrImages valueForKey:@"RESULT"][0][0][@"_300"] count] == 0) {
                 
                 [CustomAlertView showAlert:@"Alert" message:@"Data Not Found"];
                 
             }else{
                 
                 ShowSearchItemsVC *controller=[self.storyboard instantiateViewControllerWithIdentifier:@"ShowSearchItemsVC"];
                 
                 controller.arrSearchItemsData=[arrImages valueForKey:@"RESULT"][0][0][@"_300"];
                 [self.navigationController pushViewController:controller animated:YES];
                 
             }
             
         }
     }];
}



-(void) goToCart:(id)sender {
    
    NSLog(@"i m in cart");
}

-(void)createTabBar
{
    
}


-(void)removewSearchView
{
    
    searchSuperView.hidden = YES;
    [searchSuperView removeFromSuperview];
    searchSuperView=nil;
    
    
}

-(void)crEATEVIEW
{
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [indicator startAnimating];
    [_collectionView reloadData];
    
    if (searchSuperView == nil) {
        
        
        searchSuperView =[[UIView alloc]initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height-64)];
                
        CGFloat heightOfView = self.view.frame.size.height-478;
        CGFloat searchViewY = 10;
      //  CGFloat searchViewY = heightOfView/2;
        CGFloat WithOfView = self.view.frame.size.width;
      //  CGFloat WithOfView = self.view.frame.size.width-270;
        CGFloat searchViewX = 0;
       // CGFloat searchViewX = WithOfView/2;
        UIView *searchView = [[UIView alloc]initWithFrame:CGRectMake(searchViewX, searchViewY, self.view.frame.size.width, 350)];
        searchView.backgroundColor=[UIColor whiteColor];
        searchView.layer.cornerRadius=5;
        searchView.layer.masksToBounds=true;
        
//        UILabel *titleLable =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, searchView.frame.size.width,50)];
//        
//        titleLable.textAlignment = NSTextAlignmentCenter;
//        titleLable.text = @"Search";
//        titleLable.font=[UIFont systemFontOfSize:19 weight:3];
//        titleLable.textColor=[UIColor whiteColor];
//        titleLable.backgroundColor =BlueColor;
//        [searchView addSubview:titleLable];
        
        
       // UILabel *searchHintLable =[[UILabel alloc]initWithFrame:CGRectMake(20, 55, 200 ,40)];
        UILabel *searchHintLable =[[UILabel alloc]initWithFrame:CGRectMake(5, 5, 200 ,40)];  // my comment
        searchHintLable.textAlignment = NSTextAlignmentLeft;
       // searchHintLable.text = @"What are you looking for?";
        searchHintLable.text = @"Quick Search";  // mycomment
        searchHintLable.font=[UIFont systemFontOfSize:16];
        searchHintLable.textColor=[UIColor blackColor];
        searchHintLable.backgroundColor =[UIColor clearColor];
        [searchView addSubview:searchHintLable];
        
        UILabel *searchCriteria =[[UILabel alloc]initWithFrame:CGRectMake(10, 35, 200 ,20)];  // my comment
        searchCriteria.textAlignment = NSTextAlignmentLeft;
        // searchHintLable.text = @"What are you looking for?";
        searchCriteria.text = @"Search Criteria";  // mycomment
        searchCriteria.font=[UIFont systemFontOfSize:13];
        searchCriteria.textColor=[UIColor blackColor];
        searchCriteria.backgroundColor =[UIColor clearColor];
        [searchView addSubview:searchCriteria];
        
        
        UILabel *lookinForLabl =[[UILabel alloc]initWithFrame:CGRectMake(10, 60, self.view.frame.size.width/2-50 ,20)];  // my comment
        lookinForLabl.textAlignment = NSTextAlignmentLeft;
        // searchHintLable.text = @"What are you looking for?";
        lookinForLabl.text = @"looking for";  // mycomment
        lookinForLabl.font=[UIFont systemFontOfSize:13];
        lookinForLabl.textColor=[UIColor blackColor];
        lookinForLabl.backgroundColor =[UIColor clearColor];
        [searchView addSubview:lookinForLabl];
        
        UILabel *productOrService =[[UILabel alloc]initWithFrame:CGRectMake(lookinForLabl.frame.size.width+90, 60, self.view.frame.size.width/2-80 ,20)];  // my comment
        productOrService.textAlignment = NSTextAlignmentLeft;
        // searchHintLable.text = @"What are you looking for?";
        productOrService.text = @"product or Service";  // mycomment
        productOrService.font=[UIFont systemFontOfSize:13];
        productOrService.textColor=[UIColor blackColor];
        productOrService.backgroundColor =[UIColor clearColor];
        [searchView addSubview:productOrService];
        
        
        
        UILabel *buisnessService =[[UILabel alloc]initWithFrame:CGRectMake(productOrService.frame.size.width+10, 60, 70 ,20)];  // my comment
        buisnessService.textAlignment = NSTextAlignmentLeft;
        // searchHintLable.text = @"What are you looking for?";
        buisnessService.text = @"Buisness";  // mycomment
        buisnessService.font=[UIFont systemFontOfSize:13];
        buisnessService.textColor=[UIColor blackColor];
        buisnessService.backgroundColor =[UIColor clearColor];
        [searchView addSubview:buisnessService];
        
        
        UIButton *selectAddressButton1 = [UIButton buttonWithType:UIButtonTypeRoundedRect] ;
        selectAddressButton1.frame = CGRectMake(productOrService.frame.size.width+80, 60, 20 ,20);
        selectAddressButton1.layer.borderWidth = 1.0;
        selectAddressButton1.layer.borderColor =  [UIColor colorWithRed:13.0/255 green:102.0/255 blue:202.0/255 alpha:0.4f].CGColor;
         [selectAddressButton1 addTarget:self action:@selector(ChkUnChk:) forControlEvents:UIControlEventTouchUpInside];
        [searchView addSubview:selectAddressButton1];
        
        UIButton *selectAddressButton2 = [UIButton buttonWithType:UIButtonTypeRoundedRect] ;
        selectAddressButton2.frame = CGRectMake(lookinForLabl.frame.size.width+210, 60, 20 ,20);
        selectAddressButton2.layer.borderWidth = 1.0;
        selectAddressButton2.layer.borderColor =  [UIColor colorWithRed:13.0/255 green:102.0/255 blue:202.0/255 alpha:0.4f].CGColor;
        
        [selectAddressButton2 addTarget:self action:@selector(ChkUnChk2:) forControlEvents:UIControlEventTouchUpInside];
        [searchView addSubview:selectAddressButton2];
        
        
        UILabel *chooseLocation =[[UILabel alloc]initWithFrame:CGRectMake(10, 85, self.view.frame.size.width ,20)];  // my comment
        chooseLocation.textAlignment = NSTextAlignmentLeft;
        // searchHintLable.text = @"What are you looking for?";
        chooseLocation.text = @"Please choose a lcation to search near";  // mycomment
        chooseLocation.font=[UIFont systemFontOfSize:13];
        chooseLocation.textColor=[UIColor blackColor];
        chooseLocation.backgroundColor =[UIColor clearColor];
        [searchView addSubview:chooseLocation];
        
        
        UILabel *addresslbl =[[UILabel alloc]initWithFrame:CGRectMake(10, 140, self.view.frame.size.width ,20)];  // my comment
        addresslbl.textAlignment = NSTextAlignmentLeft;
        // searchHintLable.text = @"What are you looking for?";
        addresslbl.text = @"Or enter an address to look nearby";  // mycomment
        addresslbl.font=[UIFont systemFontOfSize:13];
        addresslbl.textColor=[UIColor blackColor];
        addresslbl.backgroundColor =[UIColor clearColor];
        [searchView addSubview:addresslbl];
        
        
        UILabel *typeLooking =[[UILabel alloc]initWithFrame:CGRectMake(10, 195, self.view.frame.size.width ,20)];  // my comment
        typeLooking.textAlignment = NSTextAlignmentLeft;
        // searchHintLable.text = @"What are you looking for?";
        typeLooking.text = @"Please type in what it is you're looking for";  // mycomment
        typeLooking.font=[UIFont systemFontOfSize:13];
        typeLooking.textColor=[UIColor blackColor];
        typeLooking.backgroundColor =[UIColor clearColor];
        [searchView addSubview:typeLooking];
        
        
        searchTextField =[[IQDropDownTextField alloc]initWithFrame:CGRectMake(20, 105, self.view.frame.size.width-50 ,30)];
        searchTextField.showDismissToolbar = YES;
        if ([arrGetAllNames count] > 0){
        searchTextField.text = arrGetAllNames[0];
        }
        [searchTextField setItemList:[NSArray arrayWithArray:arrGetAllNames]];
        [searchTextField setItemListUI:[NSArray arrayWithArray:arrGetAllNames]];
        searchTextField.font = [UIFont systemFontOfSize:15];
        searchTextField.placeholder = @" ";
        searchTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        searchTextField.keyboardType = UIKeyboardTypeDefault;
        searchTextField.returnKeyType = UIReturnKeySearch;
        searchTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        searchTextField.delegate = self;
        searchTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        searchTextField.layer.cornerRadius = 3;
        searchTextField.layer.borderWidth=1;
        
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
        searchTextField.leftView = paddingView;
        searchTextField.leftViewMode = UITextFieldViewModeAlways;
        
        [searchView addSubview:searchTextField];
        UIButton *dropDownBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect] ;
        dropDownBtn.frame = CGRectMake(searchTextField.frame.size.width-10, 110, 20 ,20);
        [dropDownBtn setBackgroundImage:[UIImage imageNamed:@"dropDown.png"]    forState:UIControlStateNormal];
        [searchView addSubview:dropDownBtn];
        
        searchTextField2 =[[UITextField alloc]initWithFrame:CGRectMake(20, 165, self.view.frame.size.width-50 ,30)];
        
        searchTextField2.font = [UIFont systemFontOfSize:15];
        searchTextField2.placeholder = @" ";
        searchTextField2.autocorrectionType = UITextAutocorrectionTypeNo;
        searchTextField2.keyboardType = UIKeyboardTypeDefault;
        searchTextField2.returnKeyType = UIReturnKeySearch;
        searchTextField2.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        searchTextField2.delegate = self;
        searchTextField2.layer.borderColor = [UIColor lightGrayColor].CGColor;
        searchTextField2.layer.cornerRadius = 3;
        searchTextField2.layer.borderWidth=1;
        
        [searchView addSubview:searchTextField2];
        
        searchTextField3 =[[UITextField alloc]initWithFrame:CGRectMake(20, 220, self.view.frame.size.width-50 ,30)];
        
        searchTextField3.font = [UIFont systemFontOfSize:15];
        searchTextField3.placeholder = @"abc";
        searchTextField3.autocorrectionType = UITextAutocorrectionTypeNo;
        searchTextField3.keyboardType = UIKeyboardTypeDefault;
        searchTextField3.returnKeyType = UIReturnKeySearch;
        searchTextField3.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        searchTextField3.delegate = self;
        searchTextField3.layer.borderColor = [UIColor lightGrayColor].CGColor;
        searchTextField3.layer.cornerRadius = 3;
        searchTextField3.layer.borderWidth=1;
       
        [searchView addSubview:searchTextField3];
        
        
        
        UIButton *selectAddressButton = [UIButton buttonWithType:UIButtonTypeRoundedRect] ;
                selectAddressButton.frame = CGRectMake(self.view.frame.size.width-250, 270, 60 ,30);
                selectAddressButton.backgroundColor = [UIColor clearColor];
                selectAddressButton.backgroundColor =BlueColor;
                selectAddressButton.tintColor = [UIColor whiteColor];
                [selectAddressButton setTintColor:[UIColor whiteColor]];
        selectAddressButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        selectAddressButton.font=[UIFont systemFontOfSize:13];
                [selectAddressButton setTitle:@"Cancel" forState:UIControlStateNormal];
        
                [selectAddressButton addTarget:self action:@selector(cancelView:) forControlEvents:UIControlEventTouchUpInside];
                selectAddressButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
                [searchView addSubview:selectAddressButton];\
        
        
        UIButton *selectSubmitButton = [UIButton buttonWithType:UIButtonTypeRoundedRect] ;
        selectSubmitButton.frame = CGRectMake(self.view.frame.size.width-160, 270, 60 ,30);
        selectSubmitButton.backgroundColor = [UIColor clearColor];
        selectSubmitButton.backgroundColor =BlueColor;
        selectSubmitButton.tintColor = [UIColor whiteColor];
        [selectSubmitButton setTintColor:[UIColor whiteColor]];
         selectSubmitButton.font=[UIFont systemFontOfSize:13];
        selectSubmitButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [selectSubmitButton setTitle:@"Submit" forState:UIControlStateNormal];
        
        [selectSubmitButton addTarget:self action:@selector(submitBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        selectSubmitButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [searchView addSubview:selectSubmitButton];
        
        
        
        UIButton *currentPromotionButton = [UIButton buttonWithType:UIButtonTypeRoundedRect] ;
        currentPromotionButton.frame = CGRectMake(10, 320, 140 ,10);
        currentPromotionButton.backgroundColor = [UIColor clearColor];
      //  currentPromotionButton.backgroundColor =BlueColor;
        currentPromotionButton.tintColor = [UIColor blueColor];
        [currentPromotionButton setTintColor:[UIColor blueColor]];
        currentPromotionButton.font=[UIFont systemFontOfSize:11];
        currentPromotionButton.hidden=true;
        [currentPromotionButton setTitle:@"Current Promotions" forState:UIControlStateNormal];
        
        [currentPromotionButton addTarget:self action:@selector(openDropDownAction:) forControlEvents:UIControlEventTouchUpInside];
        currentPromotionButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [searchView addSubview:currentPromotionButton];
        
        
        
        UIButton *showAllButton = [UIButton buttonWithType:UIButtonTypeRoundedRect] ;
        showAllButton.frame = CGRectMake(self.view.frame.size.width-90, 320, 80 ,15);
        showAllButton.backgroundColor = [UIColor clearColor];
        showAllButton.hidden=true;
      //  showAllButton.backgroundColor =BlueColor;
        showAllButton.tintColor = [UIColor blackColor];
        [showAllButton setTintColor:[UIColor blueColor]];
        showAllButton.font=[UIFont systemFontOfSize:11];
        [showAllButton setTitle:@"Show All" forState:UIControlStateNormal];
        
        [showAllButton addTarget:self action:@selector(openDropDownAction:) forControlEvents:UIControlEventTouchUpInside];
        showAllButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [searchView addSubview:showAllButton];
//        UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeRoundedRect] ;
//        searchButton.frame = CGRectMake(210, 95, 35, 35);
//        searchButton.backgroundColor = [UIColor clearColor];
//        
//        
//        UIImage *buttonImagePressed = [UIImage imageNamed:@"gsearch"];
//        
//        [searchButton setImage:buttonImagePressed forState:UIControlStateNormal];
//        searchButton.tintColor = [UIColor darkGrayColor];
//        
//        [searchButton addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
//        [searchView addSubview:searchButton];
        
        
        
        
//        UILabel *orLabel =[[UILabel alloc]initWithFrame:CGRectMake(120, 135, 30 ,40)];
//        
//        orLabel.textAlignment = NSTextAlignmentCenter;
//        orLabel.text = @"or";
//        orLabel.font=[UIFont systemFontOfSize:16];
//        orLabel.textColor=[UIColor darkGrayColor];
//        orLabel.backgroundColor =[UIColor clearColor];
//        [searchView addSubview:orLabel];
        
        
        
        
//        UILabel *searchNearAddressLable =[[UILabel alloc]initWithFrame:CGRectMake(20, 160, 200 ,40)];
//        
//        searchNearAddressLable.textAlignment = NSTextAlignmentLeft;
//        searchNearAddressLable.text = @"Search near an address";
//        searchNearAddressLable.font=[UIFont systemFontOfSize:16];
//        searchNearAddressLable.textColor=[UIColor darkGrayColor];
//        searchNearAddressLable.backgroundColor =[UIColor clearColor];
//        [searchView addSubview:searchNearAddressLable];
        
        
        
        
        
//        UIButton *selectAddressButton = [UIButton buttonWithType:UIButtonTypeRoundedRect] ;
//        selectAddressButton.frame = CGRectMake(20, 200, 230 ,35);
//        selectAddressButton.backgroundColor = [UIColor clearColor];
//        selectAddressButton.backgroundColor =BlueColor;
//        selectAddressButton.tintColor = [UIColor whiteColor];
//        [selectAddressButton setTintColor:[UIColor whiteColor]];
//        
//        [selectAddressButton setTitle:@"Select One" forState:UIControlStateNormal];
//        
//        [selectAddressButton addTarget:self action:@selector(openDropDownAction:) forControlEvents:UIControlEventTouchUpInside];
//        selectAddressButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
//        [searchView addSubview:selectAddressButton];
        
        
        searchView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
        
        [searchSuperView addSubview:searchView];
        
        [UIView animateWithDuration:0.3 animations:^{
            searchView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
        } completion:^(BOOL finished) {
            
        }];
        
        
        searchSuperView.backgroundColor = [UIColor colorWithRed:0.0/255 green:0.0/255 blue:0.0/255 alpha:0.4f];
        
        [self.view addSubview:searchSuperView];
        [indicator stopAnimating];
        
    }
    
}

-(void)searchAction:(id)sender
{
    
    if (isSearchWithAddress == YES) {
        
        [self searchItemsNear];
        
    }else{
        
        [self searchItemsByOfferMobile];
    }
}
-(void)submitBtnAction:(id)sender    {
    SetSearchItem.serahcItems = searchTextField3.text;
  //  SetSearchItem.
    SearchItemsVC* controller =     [self.storyboard instantiateViewControllerWithIdentifier:@"SearchItemsVC"];
    
    [self.navigationController pushViewController:controller animated:YES];
//    viewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"SearchItemsViewController"];
//    navi = [[UINavigationController alloc] initWithRootViewController:viewController];
//    
//    [self.menuContainerViewController setCenterViewController:navi];
//    
//    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{}];

}
-(void)cancelView:(id)sender{
    searchSuperView.hidden = YES;
    [searchSuperView removeFromSuperview];
    searchSuperView=nil;
}
-(void)ChkUnChk:(id)sender
{
    
    UIButton *btn=(UIButton *)sender;
    NSString *Str=[NSString stringWithFormat:@"%d",btn.tag];
    BOOL flag=   [selectedBtnarr containsObject:Str];
    
    if (flag==YES)
    {
        [btn setBackgroundImage:[UIImage imageNamed:@"unchk2.png"]    forState:UIControlStateNormal];
        [selectedBtnarr removeObject:Str];
    }
    else
    {
        [selectedBtnarr addObject:Str];
        [btn setBackgroundImage:[UIImage imageNamed:@"chk.png"] forState:UIControlStateNormal];
    }
}
-(void)ChkUnChk2:(id)sender
{
    
    UIButton *btn=(UIButton *)sender;
    NSString *Str=[NSString stringWithFormat:@"%d",btn.tag];
    BOOL flag=   [selectedBtnarr containsObject:Str];
    
    if (flag==YES)
    {
        [btn setBackgroundImage:[UIImage imageNamed:@"unchk2.png"]    forState:UIControlStateNormal];
        [selectedBtnarr removeObject:Str];
    }
    else
    {
        [selectedBtnarr addObject:Str];
        [btn setBackgroundImage:[UIImage imageNamed:@"chk.png"] forState:UIControlStateNormal];
    }
}
-(void)openDropDownAction:(id)sender

{
    
    
    
    [searchTextField resignFirstResponder];
    
//    NSArray * arr = [[NSArray alloc] init];
//    arr = [NSArray arrayWithObjects:@"Hello 0", @"Hello 1", @"Hello 2", @"Hello 3", @"Hello 4", @"Hello 5", @"Hello 6", @"Hello 7", @"Hello 8", @"Hello 9",nil];
    if(dropDown == nil) {
        CGFloat f = 115;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arrGetAllNames :nil :@"down"];
        dropDown.delegate = self;
    }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
    }
    
    
    
}

- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    
        
    isSearchWithAddress=YES;
    
    [self rel];
    
    
}
-(void)rel{
    
    //    [dropDown release];
    
    
    
    dropDown = nil;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
   [self searchItemsByOfferMobile];
    
   
    return true;
}

-(void)navBarLogo
{
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 22, 60, 40)];
    imgView.image = [UIImage imageNamed:@"close.png"];
    imgView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:imgView];
    
}

-(void)navigationBarTitle:(NSString*)title
{
    UILabel *lblTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 12, self.view.frame.size.width, 25)];
    lblTitle.text = title;
    lblTitle.textAlignment = NSTextAlignmentCenter;
    lblTitle.textColor = [UIColor whiteColor];
    lblTitle.backgroundColor = [UIColor clearColor];
    [self.view addSubview:lblTitle];
}
-(void)setBarBtnItems{
    UIImage *img = [UIImage imageNamed:@"header_logo.png"];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [imgView setImage:img];
    // setContent mode aspect fit
    [imgView setContentMode:UIViewContentModeScaleAspectFit];
    self.navigationItem.titleView = imgView;
    //  self.navigationItem.title=@"APITAP";
    //self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"close.png"]];
    
//    UIImage *sliderImage = [[UIImage imageNamed:@"slider"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    
//    UIBarButtonItem *btnLeftMenu = [[UIBarButtonItem alloc] initWithImage:sliderImage style:UIBarButtonItemStylePlain target:self action:@selector(clk_btnLeftMenu:)];
    
    
    UIImage *scanImage = [[UIImage imageNamed:@"scan"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    btnQRCode = [[UIBarButtonItem alloc] initWithImage:scanImage style:UIBarButtonItemStylePlain target:self action:@selector(clk_btnQRCode:)];
    
    
   // self.navigationItem.leftBarButtonItems = @[btnQRCode];
    
    /* Image in navigationBar */
    
    UIImage * logoInNavigationBar = [UIImage imageNamed:@"01_logo.png"];
    UIImageView * logoView = [[UIImageView alloc] init];
    [logoView setImage:logoInNavigationBar];
    self.navigationController.navigationItem.titleView = logoView;
    
    /* Right Bar Buttons */
    
    UIImage *messageImage = [[UIImage imageNamed:@"email"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem *btnMessage = [[UIBarButtonItem alloc] initWithImage:messageImage style:UIBarButtonItemStylePlain target:self action:@selector(clk_btnMessage:)];
    
    UIImage *searchrImage = [[UIImage imageNamed:@"search"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem *btnSearch = [[UIBarButtonItem alloc] initWithImage:searchrImage style:UIBarButtonItemStylePlain target:self action:@selector(clk_btnSearch:)];
    
    
    self.navigationItem.rightBarButtonItems = @[btnSearch,btnMessage];
}
-(void)setbarButtonItems
{
    UIImage *img = [UIImage imageNamed:@"header_logo.png"];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [imgView setImage:img];

    // setContent mode aspect fit
    [imgView setContentMode:UIViewContentModeScaleAspectFit];
    self.navigationItem.titleView = imgView;

//      set custome navigationBar Item
//    UIImageView *sliderImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"slider"]];
//    sliderImage.frame = CGRectMake(0, 0, 20, 20);
//    [sliderImage setImage:[sliderImage.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//     UIImageView *sliderView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
//    [sliderView addSubview:sliderImage];
//    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:sliderView];
    
    UIImage *sliderImage = [[UIImage imageNamed:@"slider"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *btnLeftMenu = [[UIBarButtonItem alloc] initWithImage:sliderImage style:UIBarButtonItemStylePlain target:self action:@selector(clk_btnLeftMenu:)];

    UIImage *scanImage = [[UIImage imageNamed:@"scan"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    btnQRCode = [[UIBarButtonItem alloc] initWithImage:scanImage style:UIBarButtonItemStylePlain target:self action:@selector(clk_btnQRCode:)];

    self.navigationItem.leftBarButtonItems = @[btnLeftMenu,btnQRCode];

    /* Image in navigationBar */
    UIImage * logoInNavigationBar = [UIImage imageNamed:@"01_logo.png"];
    UIImageView * logoView = [[UIImageView alloc] init];
    [logoView setImage:logoInNavigationBar];
    self.navigationController.navigationItem.titleView = logoView;

    /* Right Bar Buttons */

    UIImage *messageImage = [[UIImage imageNamed:@"email"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    

    UIBarButtonItem *btnMessage = [[UIBarButtonItem alloc] initWithImage:messageImage style:UIBarButtonItemStylePlain target:self action:@selector(clk_btnMessage:)];

    UIImage *searchrImage = [[UIImage imageNamed:@"search"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    UIBarButtonItem *btnSearch = [[UIBarButtonItem alloc] initWithImage:searchrImage style:UIBarButtonItemStylePlain target:self action:@selector(clk_btnSearch:)];


    self.navigationItem.rightBarButtonItems = @[btnSearch,btnMessage];

}

-(void)clk_btnLeftMenu:(id)sender
{
    [self removewSearchView];
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{}];
    
}

-(void)clk_btnQRCode:(id)sender
{
    
//    [btnQRCode setEnabled:NO];
//    [btnQRCode setTintColor: [UIColor clearColor]];
    [self removewSearchView];
    
    
    viewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"ScanCodeVC"];
    navi = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    [self.menuContainerViewController setCenterViewController:navi];
    
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{}];
    
}
-(void)clk_btnMessage:(id)sender
{
    NSMutableDictionary *dictParam = [NSMutableDictionary new];
    [dictParam setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"loginUserID"] forKey:@"53"];
    [dictParam setValue:@"0001202A000000000192" forKey:@"114.179"];
    [dictParam setValue:@"00000000092" forKey:@"120.16"];
    [dictParam setValue:@"hi how are you" forKey:@"122.128"];
    [dictParam setValue:@"0001202A000000000192" forKey:@"120.157"];
    
    
    
    
    
    [model_manager.addManager addMessage:@"030300192" userinfo:dictParam completionResponse:^(NSArray *arrImages, NSError *error)
     {
         [SVProgressHUD dismiss];
         
         
         
         
     }];

     [self removewSearchView];
    
    viewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"SearchMessagesVC"];
    navi = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    [self.menuContainerViewController setCenterViewController:navi];
    
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{}];
    
}
-(void)clk_btnSearch:(id)sender
{
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [indicator startAnimating];
    arrGetAllNames=[NSMutableArray new];
    [self.locationManagers requestWhenInUseAuthorization];
    [self.locationManagers requestAlwaysAuthorization];
    
    [self getAllAddressLists];
    
    
    
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    CLLocation *newLocation = [locations lastObject];
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [indicator startAnimating];
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (error == nil && [placemarks count] > 0) {
            placemark = [placemarks lastObject];
           // txtLatitude.text = [NSString stringWithFormat:@"%f",newLocation.coordinate.latitude];
           // txtLongitude.text = [NSString stringWithFormat:@"%f",newLocation.coordinate.longitude];
           // txtState.text = placemark.administrativeArea;
            NSLog(@"placemark %@",placemark.region);
           
            NSLog(@"placemark %@",placemark.country);  // Give Country Name
            NSLog(@"placemark %@",placemark.locality); // Extract the city name
            NSLog(@"location %@",placemark.name);
            NSLog(@"location %@",placemark.ocean);
            NSLog(@"location %@",placemark.postalCode);
            NSLog(@"location %@",placemark.subLocality);
            NSLog(@"location %@",placemark.location);
            
            NSString *str1 = placemark.name;
            NSString *str2 = placemark.locality;
            NSString *str3 = placemark.country;
            
            NSArray *myStrings = [[NSArray alloc] initWithObjects:str1, str2, str3, nil];
            NSString *joinedString = [myStrings componentsJoinedByString:@","];
             [arrGetAllNames addObject:joinedString];
            NSLog(@"%@",arrGetAllNames);
        
           //txtCountry.text = placemark.country;
            
        } else {
            NSLog(@"%@", error.debugDescription);
            
        }
    } ];
    
    // Turn off the location manager to save power.
    [manager stopUpdatingLocation];
}
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    NSLog(@"Cannot find the location.");
}
#pragma mark - Custom View
-(UITextField*)customtxtfield:(UITextField*)txtField withrightIcon:(UIImage*)image bottomLayer:(BOOL)isBottomLayerRequired 
{
    
    CGFloat borderWidth = 1;
    UIColor *graycolor = [UIColor lightGrayColor];
    
    //Bottom border
    if (isBottomLayerRequired) {
        CALayer *border = [CALayer layer];
        border.borderColor = graycolor.CGColor;
        border.frame = CGRectMake(0, txtField.frame.size.height - borderWidth, txtField.frame.size.width, txtField.frame.size.height);
        border.borderWidth = borderWidth;
        [txtField.layer addSublayer:border];
    }
    
    //
    
    //right border
    //    CALayer *rightBorder = [CALayer layer];
    //    rightBorder.frame = CGRectMake(txtField.frame.size.width - 1, 0, 1, txtField.frame.size.width);
    //    rightBorder.borderColor = graycolor.CGColor;
    //    rightBorder.borderWidth = borderWidth;
    //    [txtField.layer addSublayer:rightBorder];
    
    
    //left border
    //    CALayer *leftBorder = [CALayer layer];
    //    leftBorder.frame = CGRectMake(0, 0, 1, txtField.frame.size.width);
    //    leftBorder.borderColor = graycolor.CGColor;
    //    leftBorder.borderWidth = borderWidth;
    //    [txtField.layer addSublayer:leftBorder];
    
    
    
    txtField.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 41)];
    paddingView.backgroundColor=[UIColor clearColor];
    txtField.leftView=paddingView;
    txtField.leftViewMode = UITextFieldViewModeAlways;
    //txtField.layer.borderWidth= 1.0f;
    //    UIImageView*icon=[[UIImageView alloc]initWithFrame:CGRectMake(txtField.frame.size.width-25, txtField.frame.size.height/2-6, 16, 16)];
    //    icon.image=image;
    //    [txtField addSubview:icon];
    
    return txtField;
}

-(void)textField:(nonnull IQDropDownTextField*)textField didSelectItem:(nullable NSString*)item
{
    NSLog(@"%@: %@",NSStringFromSelector(_cmd),item);
}

-(void)textField:(IQDropDownTextField *)textField didSelectDate:(nullable NSDate *)date
{
    NSLog(@"%@: %@",NSStringFromSelector(_cmd),date);
}

-(BOOL)textField:(nonnull IQDropDownTextField*)textField canSelectItem:(nullable NSString*)item
{
    NSLog(@"%@: %@",NSStringFromSelector(_cmd),item);
    return YES;
}

-(IQProposedSelection)textField:(nonnull IQDropDownTextField*)textField proposedSelectionModeForItem:(nullable NSString*)item
{
    NSLog(@"%@: %@",NSStringFromSelector(_cmd),item);
    return IQProposedSelectionBoth;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
    NSLog(@"%@",NSStringFromSelector(_cmd));
}
-(BOOL)checkInternetConeection
{
    
    Reachability *reachabilityCheck = [Reachability  reachabilityForInternetConnection];
    NetworkStatus netStatus = [reachabilityCheck currentReachabilityStatus];
    BOOL connection ;
    
    
    switch (netStatus)
    {
        case NotReachable:
        {
            
            
            
                UIAlertController *controller=   [UIAlertController
                            alertControllerWithTitle:@"Alert"
                            message:@"No Internet Connection"
                            preferredStyle:UIAlertControllerStyleAlert];
            
            
            
            
            
            UIAlertAction* ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleCancel
                                 handler:^(UIAlertAction * action)
                                 {
                                     //Do some thing here
                                     //   [view dismissViewControllerAnimated:YES completion:nil];
                                   
                                     
                                 }];
            [controller addAction:ok];
            
            
            
            [self presentViewController:controller animated:YES completion:nil];
            return  false ;
            break ;
    }
        case ReachableViaWWAN:        {
            return  true ;
            break;
        }
        case ReachableViaWiFi:        {
            return true ;
            break;
        }
    }

    
    
    
    return  connection;
}
//-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
//    
//            return arrGetAllNames[row];
//    
//   
//}
//
//// #6
//-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
//   
//            searchTextField.text = arrGetAllNames[row];
//    
//}
//-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
//   
//            return [arrGetAllNames count];
//       
//}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
