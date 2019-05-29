//
//  MapVC.m
//  ApiTap
//
//  Created by Bikramjeet Singh on 10/7/16.
//  Copyright © 2016 ApiTap. All rights reserved.
//

#import "MapVC.h"
#import "SVProgressHUD.h"
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>
#import "TermAndConditionVC.h"
#import "RatingView.h"

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define METERS_PER_MILE 1609.344
#define kLabelAllowance 50.0f
#define kStarViewHeight 30.0f
#define kStarViewWidth 160.0f
#define kLeftPadding 5.0f


@interface MapVC () <CLLocationManagerDelegate,RatingViewDelegate> {
    
    NSMutableArray *arrLat,*arrLog;
    NSString *sendTermAndCondition;
}

@property (nonatomic, strong) IBOutlet MKMapView *mapView;

@property(nonatomic, retain) CLLocationManager *locationManager;

@property (weak, nonatomic) IBOutlet UILabel *lblStoreName;

@property (weak, nonatomic) IBOutlet UILabel *lblReviewCount;

@property (weak, nonatomic) IBOutlet UILabel *lblStoreAddress;

@property (weak, nonatomic) IBOutlet UIView *callView;

@property (weak, nonatomic) IBOutlet UIView *messageView;

@property (weak, nonatomic) IBOutlet UIView *termndCondView;

@property (weak, nonatomic) IBOutlet UILabel *lblShowAllStoteItems;

@property (weak, nonatomic) IBOutlet UIView *openWriteAReviewPopUp;

@property (weak, nonatomic) IBOutlet UITextField *txtSubject;

@property (weak, nonatomic) IBOutlet UITextView *txtViewComment;

@property (weak, nonatomic) IBOutlet UIImageView *setBlurImage;

@property (weak, nonatomic) IBOutlet UIImageView *setUpperImage;

@property (weak, nonatomic) IBOutlet UIImageView *image1;

@property (weak, nonatomic) IBOutlet UIImageView *image2;

@property (weak, nonatomic) IBOutlet UIImageView *image3;

@property (weak, nonatomic) IBOutlet UIImageView *image4;

@property (weak, nonatomic) IBOutlet UIImageView *image5;

//@property (strong, nonatomic) IBOutlet RatingView *setRatingView;


@property (strong, nonatomic) RatingView *ratingView;

@end

@implementation MapVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSMutableDictionary *dictParam2 = [NSMutableDictionary new];
    [dictParam2 setValue:@"0001202A000000000192" forKey:@"53"];
   // [dictParam2 setValue:@"0001202A000000000858" forKey:@"127.57"];
    [model_manager.addManager getItemRating:@"010100020" userinfo:dictParam2 completionResponse:^(NSArray *arrImages, NSError *error)
     {
         //NSLog(arrImages);
         [SVProgressHUD dismiss];
         
         if (!error)
         {
             
             self.openWriteAReviewPopUp.hidden = YES;
             self.setBlurImage.hidden = YES;
             self.setUpperImage.hidden = YES;
         }
         
         
     }];
    
    
    
   // [self setHomeButton];
    
    self.setBlurImage.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tapGesture:)];
    
    [self.setBlurImage addGestureRecognizer:tapGesture1];
    
    self.setBlurImage.hidden = YES;
    self.setUpperImage.hidden = YES;
    
//    StarRatingView* starview = [[StarRatingView alloc]initWithFrame:CGRectMake(50, 50, kStarViewWidth+kLabelAllowance+kLeftPadding, kStarViewHeight) andRating:60 withLabel:YES animated:NO];
//    [self.openWriteAReviewPopUp addSubview:starview];
    
    self.ratingView = [[RatingView alloc] initWithFrame:CGRectMake(75, 30, 200, 30)
                                      selectedImageName:@"selected.png"
                                        unSelectedImage:@"unSelected.png"
                                               minValue:0
                                               maxValue:5
                                          intervalValue:0.5
                                             stepByStep:NO];
    

    
    self.ratingView.delegate = self;
    
    [self.openWriteAReviewPopUp addSubview:self.ratingView];
    
    self.openWriteAReviewPopUp.hidden =YES;
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.txtSubject.leftView = paddingView;
    self.txtSubject.leftViewMode = UITextFieldViewModeAlways;
    
    self.txtViewComment.text = @"Comment";
    self.txtViewComment.textColor = [UIColor lightGrayColor]; //optional
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    #ifdef __IPHONE_8_0
    if(IS_OS_8_OR_LATER) {
        // Use one or the other, not both. Depending on what you put in info.plist
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager requestAlwaysAuthorization];
    }
#endif
    [self.locationManager startUpdatingLocation];
    
    [self getPlaylistBroadcastMobile];
    
    //[self initViews];
    
    
    
    [self addGesture];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    self.navigationItem.title=@"Merchant Stores";
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:YES];
    
    self.navigationItem.title=@"";
}

- (void) tapGesture: (id)sender
{
    self.openWriteAReviewPopUp.hidden = YES;
    self.setBlurImage.hidden = YES;
    self.setUpperImage.hidden = YES;
}

-(void)addGesture {
    
        UITapGestureRecognizer *callTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(callAction:)];
        [self.callView addGestureRecognizer:callTap];
    
        UITapGestureRecognizer *messageTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(messageAction:)];
        [self.messageView addGestureRecognizer:messageTap];
    
        UITapGestureRecognizer *termTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(openTermsAction:)];
        [self.termndCondView addGestureRecognizer:termTap];
    
        UITapGestureRecognizer *showAllSrotesTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(showStoresAction:)];
        [self.lblShowAllStoteItems addGestureRecognizer:showAllSrotesTap];
}

-(void)giveReviewForMerchantStore {
    if (![self checkInternetConeection]) {
        
        return;
    }

    [SVProgressHUD showWithStatus:@"Loding....."];
    
    NSMutableDictionary *dictParam = [NSMutableDictionary new];
    
    [dictParam setValue:@"0001202A000000000858" forKey:@"127.57"];
    [dictParam setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"loginUserID"] forKey:@"53"];
    [dictParam setValue:_txtSubject.text forKey:@"120.83"];
    [dictParam setValue:_txtViewComment.text forKey:@"120.157"];
    [dictParam setValue:@"2105" forKey:@"122.129"];
    
    
    
    
    
    [model_manager.addManager showAdds:@"030400103" userinfo:dictParam completionResponse:^(NSArray *arrImages, NSError *error)
     {
         [SVProgressHUD dismiss];
         
         if (!error)
         {
                         
             self.openWriteAReviewPopUp.hidden = YES;
             self.setBlurImage.hidden = YES;
             self.setUpperImage.hidden = YES;
         }
         
         
     }];
    
}

- (IBAction)increaseRating:(id)sender
{
    self.ratingView.value = self.ratingView.value + 1;
}

#pragma mark RatingView delegate

- (void)rateChanged:(RatingView *)ratingView
{
    NSLog(@"rate value = %f", ratingView.value);
}

- (void)callAction:(UITapGestureRecognizer *)recognizer {
 
    NSString *phoneNumber = @"9041294969";
    NSURL *phoneUrl = [NSURL URLWithString:[@"telprompt://" stringByAppendingString:phoneNumber]];
    NSURL *phoneFallbackUrl = [NSURL URLWithString:[@"tel://" stringByAppendingString:phoneNumber]];
    
    if ([UIApplication.sharedApplication canOpenURL:phoneUrl]) {
        [UIApplication.sharedApplication openURL:phoneUrl];
    } else if ([UIApplication.sharedApplication canOpenURL:phoneFallbackUrl]) {
        [UIApplication.sharedApplication openURL:phoneFallbackUrl];
    } else {
        // Show an error message: Your device can not do phone calls.
    }
}

- (void)messageAction:(UITapGestureRecognizer *)recognizer {
    
    NSString *textToShare = @"Look at this awesome website for aspiring iOS Developers!";
    NSURL *myWebsite = [NSURL URLWithString:@"http://www.codingexplorer.com/"];
    
    NSArray *objectsToShare = @[textToShare, myWebsite];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    
    [self presentViewController:activityVC animated:YES completion:^{
        
    }];
}

- (void)openTermsAction:(UITapGestureRecognizer *)recognizer {
    
    [self performSegueWithIdentifier:@"goto_termandcondvc" sender:nil];
}

- (void)showStoresAction:(UITapGestureRecognizer *)recognizer {
    
    
    [self performSegueWithIdentifier:@"goto_merchant_items_vc" sender:nil];
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

-(void)initViews
{
    
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 39.281516;
    zoomLocation.longitude= -76.580806;
    
    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    
    // 3
    [_mapView setRegion:viewRegion animated:YES];
    
//    self.mapView = [[MKMapView alloc] init];
//   // self.mapView.delegate = self;
//    self.mapView.showsUserLocation = YES;
//    
//    MKCoordinateRegion region = self.mapView.region;
//    
//    region.center = CLLocationCoordinate2DMake(12.9752297537231, 80.2313079833984);
//    
//    region.span.longitudeDelta /= 1.0; // Bigger the value, closer the map view
//    region.span.latitudeDelta /= 1.0;
//    [self.mapView setRegion:region animated:NO]; // Choose if you want animate or not
//    
//    [self getAllMerchantStore];
}

-(void)getPlaylistBroadcastMobile {
    if (![self checkInternetConeection]) {
        
        return;
    }

    [SVProgressHUD showWithStatus:@"Loding....."];
    
    NSMutableDictionary *dictParam = [NSMutableDictionary new];
    
    [dictParam setValue:@"0001202A000000000858" forKey:@"53"];
    
    [model_manager.addManager showMapDetails:@"" userinfo:dictParam completionResponse:^(NSArray *arrImages, NSError *error)
     {
         [SVProgressHUD dismiss];
         
         if (!error)
         {
             
             dispatch_async(dispatch_get_main_queue(), ^{
                 [SVProgressHUD dismiss];
                 
                 _lblStoreName.text = [[[[arrImages valueForKey:@"RESULT"] objectAtIndex:0] objectAtIndex:0]valueForKey:@"_114_70"];
                 _lblReviewCount.text = @"_121_80";
                 _lblStoreAddress.text = [[[[arrImages valueForKey:@"RESULT"] objectAtIndex:0] objectAtIndex:0]valueForKey:@"_114_12"];
                 
                 sendTermAndCondition = [self stringFromHexString:[[[[arrImages valueForKey:@"RESULT"] objectAtIndex:0] objectAtIndex:0]valueForKey:@"_119_15"]];
                 
                 
                 NSString *firstLetter = [[[[[arrImages valueForKey:@"RESULT"] objectAtIndex:0] objectAtIndex:0]valueForKey:@"_122_19"] substringToIndex:1];
                 
                 switch([firstLetter intValue]) {
                     case 5:
                         
                         self.image1.image = [UIImage imageNamed:@"rating"];
                         self.image2.image = [UIImage imageNamed:@"rating"];
                         self.image3.image = [UIImage imageNamed:@"rating"];
                         self.image4.image = [UIImage imageNamed:@"rating"];
                         self.image5.image = [UIImage imageNamed:@"rating"];
                         
                         break;
                     case 4:
                         
                         self.image1.image = [UIImage imageNamed:@"rating"];
                         self.image2.image = [UIImage imageNamed:@"rating"];
                         self.image3.image = [UIImage imageNamed:@"rating"];
                         self.image4.image = [UIImage imageNamed:@"rating"];
                         
                         break;
                     case 3:
                         
                         self.image1.image = [UIImage imageNamed:@"rating"];
                         self.image2.image = [UIImage imageNamed:@"rating"];
                         self.image3.image = [UIImage imageNamed:@"rating"];
                         
                         break;
                     case 2:
                         
                         self.image1.image = [UIImage imageNamed:@"rating"];
                         self.image2.image = [UIImage imageNamed:@"rating"];
                         
                         break;
                     case 1:
                         
                         self.image1.image = [UIImage imageNamed:@"rating"];
                         break;
                         
                     default:
                         
                         NSLog(@"its default");
                         
                         break;
                         
                 }
                 
                 NSMutableArray *newArray=[NSMutableArray new];
                 
                 [newArray addObjectsFromArray:[arrImages valueForKey:@"RESULT"][1]];
                 
                 arrLat=[NSMutableArray new];
                 
                 for (int i=0; i<newArray.count; i++) {
                     
                     double latdouble = [newArray[i][@"AD"][@"ZP"][@"_120_38"] doubleValue];
                     double londouble = [newArray[i][@"AD"][@"ZP"][@"_120_39"] doubleValue];
                     
                     CLLocationCoordinate2D coord = {(latdouble),(londouble)};
                     MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
                     [annotation setCoordinate:coord];
                     [annotation setTitle:newArray[i][@"AD"][@"_114_12"]]; //You can set the subtitle too
                     [self.mapView addAnnotation:annotation];
                     
                     [arrLat addObject:annotation];
                     
                 }
                 
                 
                 [self.mapView showAnnotations:arrLat animated:YES];
             });

             }
         
     }];
    
}



//-(void)addAllPins
//{
//   // self.mapView.delegate=self;
//    
//    NSArray *name=[[NSArray alloc]initWithObjects:
//                   @"VelaCherry",
//                   @"Perungudi",
//                   @"Tharamani", nil];
//    
//    NSMutableArray *arrCoordinateStr = [[NSMutableArray alloc] initWithCapacity:name.count];
//    
//    [arrCoordinateStr addObject:@"12.970760345459, 80.2190093994141"];
//    [arrCoordinateStr addObject:@"12.9752297537231, 80.2313079833984"];
//    [arrCoordinateStr addObject:@"12.9788103103638, 80.2412414550781"];
//    
//    for(int i = 0; i < name.count; i++)
//    {
//        [self addPinWithTitle:name[i] AndCoordinate:arrCoordinateStr[i]];
//    }
//}

//-(void)addPinWithTitle:(NSString *)title AndCoordinate:(NSString *)strCoordinate
//{
//    MKPointAnnotation *mapPin = [[MKPointAnnotation alloc] init];
//    
//    // clear out any white space
//    strCoordinate = [strCoordinate stringByReplacingOccurrencesOfString:@" " withString:@""];
//    
//    // convert string into actual latitude and longitude values
//    NSArray *components = [strCoordinate componentsSeparatedByString:@","];
//    
//    double latitude = [components[0] doubleValue];
//    double longitude = [components[1] doubleValue];
//    
//    // setup the map pin with all data and add to map view
//    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
//    
//    mapPin.title = title;
//    mapPin.coordinate = coordinate;
//    
//    [self.mapView addAnnotation:mapPin];
//}

-(void)addPinWithTitle:(NSString *)title andLat:(NSString *)strLat andLong:(NSString *)strLong
{
    MKPointAnnotation *mapPin = [[MKPointAnnotation alloc] init];
    
    // clear out any white space
    //strCoordinate = [strCoordinate stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    // convert string into actual latitude and longitude values
    //NSArray *components = [strCoordinate componentsSeparatedByString:@","];
    
    double latitude = [strLat doubleValue];
    double longitude = [strLong doubleValue];
    
    // setup the map pin with all data and add to map view
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    
    mapPin.title = title;
    mapPin.coordinate = coordinate;
    
    [self.mapView addAnnotation:mapPin];
    
   
    
   // self.mapView showAnnotations:<#(nonnull NSArray<id<MKAnnotation>> *)#> animated:YES
    
    
}

//- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
//{
//    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
//    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
//}

//- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
//{
//    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
//    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
//}
- (NSString *)deviceLocation {
    
    return [NSString stringWithFormat:@"latitude: %f longitude: %f", self.locationManager.location.coordinate.latitude, self.locationManager.location.coordinate.longitude];
}
- (NSString *)deviceLat {
    
    return [NSString stringWithFormat:@"%f", self.locationManager.location.coordinate.latitude];
}
- (NSString *)deviceLon {
    return [NSString stringWithFormat:@"%f", self.locationManager.location.coordinate.longitude];
}
- (NSString *)deviceAlt {
    return [NSString stringWithFormat:@"%f", self.locationManager.location.altitude];
}


- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if (_txtViewComment.textColor == [UIColor lightGrayColor]) {
        _txtViewComment.text = @"";
        _txtViewComment.textColor = [UIColor blackColor];
    }
    
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    if(_txtViewComment.text.length == 0){
        _txtViewComment.textColor = [UIColor lightGrayColor];
        _txtViewComment.text = @"Comment";
        [_txtViewComment resignFirstResponder];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        if(_txtViewComment.text.length == 0){
            _txtViewComment.textColor = [UIColor lightGrayColor];
            _txtViewComment.text = @"Comment";
            [_txtViewComment resignFirstResponder];
        }
        return NO;
    }
    
    return YES;
}

//- (void)textViewDidBeginEditing:(UITextView *)textView
//{
//    if ([textView.text isEqualToString:@"placeholder text here..."]) {
//        textView.text = @"";
//        textView.textColor = [UIColor blackColor]; //optional
//    }
//    //[textView becomeFirstResponder];
//}
//
//- (void)textViewDidEndEditing:(UITextView *)textView
//{
//    if ([textView.text isEqualToString:@""]) {
//        textView.text = @"placeholder text here...";
//        textView.textColor = [UIColor lightGrayColor]; //optional
//    }
//    //[textView resignFirstResponder];
//}

- (IBAction)btnWriteAReviewAction:(UIButton *)sender {
    
     self.openWriteAReviewPopUp.hidden =NO;
     self.setBlurImage.hidden = NO;
     self.setUpperImage.hidden = NO;
}

- (IBAction)btnReviewSubmitAction:(id)sender {
    
    [self giveReviewForMerchantStore];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"goto_termandcondvc"])
    {
       
        TermAndConditionVC *vc = [segue destinationViewController];
        vc.data = sendTermAndCondition;
              
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
