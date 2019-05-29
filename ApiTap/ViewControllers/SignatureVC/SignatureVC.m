//
//  SignatureVC.m
//  ApiTap
//
//  Created by Bikramjeet Singh on 10/17/16.
//  Copyright © 2016 ApiTap. All rights reserved.
//

#import "SignatureVC.h"
#import "TESignatureView.h"

@interface SignatureVC ()

@property (weak, nonatomic) IBOutlet TESignatureView *signatureView;

@end

@implementation SignatureVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
  
}

-(IBAction)resetButtonPressed:(id)sender {
    
    [self.signatureView clearSignature];
}

-(IBAction)saveButtonPressed:(id)sender {
        
    UIImageWriteToSavedPhotosAlbum([self.signatureView getSignatureImage], nil, nil, nil);
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
