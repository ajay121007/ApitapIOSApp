//
//  ScanCodeVC.m
//  ApiTap
//
//  Created by deepraj on 9/16/16.
//  Copyright © 2016 ApiTap. All rights reserved.
//

#import "ScanCodeVC.h"
#import <AVFoundation/AVFoundation.h>
#import "SVProgressHUD.h"
#import "ApiTap-Swift.h"
@interface ScanCodeVC ()<AVCaptureMetadataOutputObjectsDelegate>

{
     NSString *scnProductId;
    UIAlertView *alert;
}
@property (nonatomic,strong) ItemDetailVC *itemDetailVC;
@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

@property (weak, nonatomic) IBOutlet UIView *viewPreview;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *bbitemStart;
@property (nonatomic) BOOL isReading;
@property (nonatomic) BOOL isFlashActive;

@end

@implementation ScanCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
   [self initializeNavBar];
    
   [self setbarButtonItems];
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    [self startStopReading:nil];
 
    [self getItemsOfShoppingCartByID:@"57412"];
    
    /*if ([QRCodeReader supportsMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]]) {
        static QRCodeReaderViewController *vc = nil;
        static dispatch_once_t onceToken;
        
        dispatch_once(&onceToken, ^{
            QRCodeReader *reader = [QRCodeReader readerWithMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
            vc                   = [QRCodeReaderViewController readerWithCancelButtonTitle:@"Cancel" codeReader:reader startScanningAtLoad:YES showSwitchCameraButton:YES showTorchButton:YES];
            vc.modalPresentationStyle = UIModalPresentationFormSheet;
        });
        vc.delegate = self;
        
        [vc setCompletionWithBlock:^(NSString *resultAsString) {
            NSLog(@"Completion with result: %@", resultAsString);
        }];
        
        [self presentViewController:vc animated:YES completion:NULL];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Reader not supported by the current device" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    }*/
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    self.navigationItem.title=@"Scan";
}

-(void)getItemsOfShoppingCartByID : (NSString *)filterID{
    
    if (![self checkInternetConeection]) {
        
        return;
    }
    
    [SVProgressHUD showWithStatus:@"Loading....."];
    
    NSMutableDictionary *dictParam = [NSMutableDictionary new];
    
   // [dictParam setValue:filterID forKey:@"122.31"];
    
    [model_manager.addManager getItemsOfShoppingCartById:@"010300098" filterData:@"000000000010000000037424" userinfo:dictParam completionResponse:^(NSArray *arrImages, NSError *error) {
        
        [SVProgressHUD dismiss];
        
        if (!error)
        {
            
            NSLog(@"%@",arrImages);
            
            if (arrImages.count == 0) {
                
              //  [CustomAlertView showAlert:@"Alert" message:@"Data Not Found"];
                
            }else{
                
                
                NSLog(@"%@",arrImages);
                
                // NSLog(@"%@",[arrImages valueForKey:@"DE"]);
                
//                arrCartsItems=[NSMutableArray new];
//                
//                [arrCartsItems addObjectsFromArray:arrImages];
//                
//                arrGetDeliveryOptions=[NSMutableArray new];
//                
//                [arrGetDeliveryOptions removeAllObjects];
//                
//                [arrGetDeliveryOptions addObjectsFromArray:[arrImages valueForKey:@"DE"]];
//                
                //NSLog(@"%@",arrGetDeliveryOptions);
                
                // NSLog(@"%lu",(unsigned long)arrGetDeliveryOptions.count);
                
           
            }
            
       
            
        }
        
    }];
    
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

-(void)setbarButtonItems
{
    
    UIImage *sliderImage = [[UIImage imageNamed:@"slider"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem *btnLeftMenu = [[UIBarButtonItem alloc] initWithImage:sliderImage style:UIBarButtonItemStylePlain target:self action:@selector(clk_btnLeftMenu:)];
    
    self.navigationItem.leftBarButtonItems = @[btnLeftMenu];
    
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


#pragma mark - IBAction method implementation
- (IBAction)startStopReading:(id)sender
{
    if (!_isReading) {
        // This is the case where the app should read a QR code when the start button is tapped.
        if ([self startReading]) {
            // If the startReading methods returns YES and the capture session is successfully
            // running, then change the start button title and the status message.
            alert=nil;
            [_bbitemStart setTitle:@"Stop"];
            //[_lblStatus setText:@"Scanning for QR Code..."];
        }
    }
    else{
        // In this case the app is currently reading a QR code and it should stop doing so.
        [self stopReading];
        
        // The bar button item's title should change again.
        
        alert=nil;
        [_bbitemStart setTitle:@"Start!"];
    }
    
    // Set to the flag the exact opposite value of the one that currently has.
    _isReading = !_isReading;
}
- (IBAction)flashOnOff:(id)sender
{
    if (!_isFlashActive) {
   
        _isFlashActive=YES;
        [self startReading];
       
    }
    else
    {
        _isFlashActive=NO;
        [self startReading];
       
    
    }
    

  
}

#pragma mark - Private method implementation

- (BOOL)startReading {
    
    NSError *error;
    
    // Get an instance of the AVCaptureDevice class to initialize a device object and provide the video
    // as the media type parameter.
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
        if ([captureDevice hasTorch]) {
            [captureDevice lockForConfiguration:nil];
            if (_isFlashActive) {
                 [captureDevice setTorchMode:AVCaptureTorchModeOn];
            }
            else
            {
                  [captureDevice setTorchMode:AVCaptureTorchModeOff];
            }
//            [captureDevice setTorchMode:AVCaptureTorchModeOn];  // use AVCaptureTorchModeOff to turn off
//            [captureDevice unlockForConfiguration];
        }

    
   
    // Get an instance of the AVCaptureDeviceInput class using the previous device object.
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    
    NSLog(@"%@",input);
    
    if (!input) {
        // If any error occurs, simply log the description of it and don't continue any more.
        NSLog(@"%@", [error localizedDescription]);
        return NO;
    }
    
    // Initialize the captureSession object.
    _captureSession = [[AVCaptureSession alloc] init];
    // Set the input device on the capture session.
    [_captureSession addInput:input];
    
    
    // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [_captureSession addOutput:captureMetadataOutput];
    
    // Create a new serial dispatch queue.
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("myQueue", NULL);
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    
    // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [_videoPreviewLayer setFrame:_viewPreview.layer.bounds];
    
    
//    NSLog(@"%f",_viewPreview.frame.origin.x);
//    
//    _videoPreviewLayer.frame = CGRectMake(0, 0, _viewPreview.frame.size.width, _viewPreview.frame.size.height);
    [_viewPreview.layer addSublayer:_videoPreviewLayer];
    
    
    // Start video capture.
 
         [_captureSession startRunning];
    
    return YES;
}


-(void)stopReading{
    // Stop video capture and make the capture session object nil.
    [_captureSession stopRunning];
    _captureSession = nil;
    
    // Remove the video preview layer from the viewPreview view's layer.
    [_videoPreviewLayer removeFromSuperlayer];
}


#pragma mark - AVCaptureMetadataOutputObjectsDelegate method implementation

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
    
    // Check if the metadataObjects array is not nil and it contains at least one object.
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        // Get the metadata object.
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            // If the found metadata is equal to the QR code metadata then update the status label's text,
            // stop reading and change the bar button item's title and the flag's value.
            // Everything is done on the main thread.
           // [_lblStatus performSelectorOnMainThread:@selector(setText:) withObject:[metadataObj stringValue] waitUntilDone:NO];
            
            NSLog(@"%@",metadataObj.stringValue);
            scnProductId = metadataObj.stringValue;
            [self performSelector:@selector(stopReading) withObject:nil afterDelay:0];
            [self performSelector:@selector(setTitle:) withObject:@"Start" afterDelay:0];
            
            if (alert == nil)
            {
                alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"QR Code Scanned Sucessfully" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                [alert show];
                UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
                ItemDetailVC *statusView = [story instantiateViewControllerWithIdentifier:@"ItemDetailVC"];
                statusView.itemDetailScanCode = scnProductId;
                statusView.itemDetailFlag = true;
                [self.navigationController pushViewController:statusView animated:YES];
               // [self performSegueWithIdentifier:@"goToItemDetailVC" sender:nil];
                
            }
            
            //[CustomAlertView showAlert:@"Message" message:@"QR Code Scanned Sucessfully"];
            
              _isReading = NO;
            
            
            
            // If the audio player is not nil, then play the sound effect.
            if (_audioPlayer) {
                
                [_audioPlayer play];
                
            }
        }
    }
    });
   
    

    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    
    
//    if ([[segue identifier] isEqualToString:@"goToItemDetailVC"])
//        // if ([[segue identifier] isEqualToString:@"goto_itemdetailsvc"])
//    {
//        _itemDetailVC = [segue destinationViewController];
//        
//        _itemDetailVC.itemDetailScanCode = scnProductId;
//        _itemDetailVC.itemDetailFlag = true;
//        
//    }
}
/*
#pragma mark - QRCodeReader Delegate Methods

- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result
{
    [reader stopScanning];
    
    [self dismissViewControllerAnimated:YES completion:^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"QRCodeReader" message:result delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }];
}

- (void)readerDidCancel:(QRCodeReaderViewController *)reader
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
*/



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
