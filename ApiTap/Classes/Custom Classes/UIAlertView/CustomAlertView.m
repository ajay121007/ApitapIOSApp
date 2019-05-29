
//
//  CustomAlertView.m
//  ApiTap
//
//  Created by Bikramjeet Singh on 10/21/16.
//  Copyright © 2016 ApiTap. All rights reserved.
//

#import "CustomAlertView.h"

@implementation CustomAlertView

+ (void)showAlert :(NSString *)title message:(NSString *)message{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
}

@end
