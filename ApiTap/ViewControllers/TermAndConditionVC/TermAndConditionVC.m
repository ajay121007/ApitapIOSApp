//
//  TermAndConditionVC.m
//  ApiTap
//
//  Created by Bikramjeet Singh on 10/14/16.
//  Copyright © 2016 ApiTap. All rights reserved.
//

#import "TermAndConditionVC.h"
#import "SVProgressHUD.h"

@interface TermAndConditionVC ()


@property (weak, nonatomic) IBOutlet UIWebView *showTermandConditionData;

@end

@implementation TermAndConditionVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    [SVProgressHUD showWithStatus:@"Loding....."];
    
    [self.showTermandConditionData loadHTMLString:self.data baseURL:nil];
    
}

-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:YES];
    
    self.navigationItem.title=@"Term and Conditions";
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:YES];
    
    self.navigationItem.title=@"";
}

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
