//
//  SettingVC.m
//  ApiTap
//
//  Created by Bikramjeet Singh on 10/5/16.
//  Copyright © 2016 ApiTap. All rights reserved.
//

#import "SettingVC.h"
#import "SVProgressHUD.h"

@interface SettingVC ()

@property (weak, nonatomic) IBOutlet UIWebView *settingWebView;


@end

@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initializeNavBar];
    
    [self setbarButtonItems];
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    [SVProgressHUD showWithStatus:@"Loding....."];
    
    NSString *convertBase64=[self encodeStringTo64:[[NSUserDefaults standardUserDefaults]valueForKey:@"loginUserID"]];
    
    NSString *urlAddress = [@"http://100.43.205.74:8091/MobileClient/public/index.xhtml?nmcId=" stringByAppendingString:convertBase64];
    
    //Create a URL object.
    NSURL *url = [NSURL URLWithString:urlAddress];
    
    //URL Requst Object
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    //Load the request in the UIWebView.
    [self.settingWebView loadRequest:requestObj];
    
}
- (NSString*)encodeStringTo64:(NSString*)fromString
{
    NSData *plainData = [fromString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String;
    if ([plainData respondsToSelector:@selector(base64EncodedStringWithOptions:)]) {
        base64String = [plainData base64EncodedStringWithOptions:kNilOptions];  // iOS 7+
    } else {
        base64String = [plainData base64Encoding];                              // pre iOS7
    }
    
    return base64String;
}

//-(void)webViewDidStartLoad:(UIWebView *)webView {
//    
////    
//}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    
    
     [SVProgressHUD dismiss];
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
