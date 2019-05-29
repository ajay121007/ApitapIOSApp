//
//  ASService.m
//  ApiTap
//
//  Created by Abhishek Singla on 13/03/16.
//  Copyright © 2016 ApiTap. All rights reserved.
//

#import "ASService.h"

@implementation ASService

void(^getServerResponseForUrlCallback)(BOOL success, NSDictionary *response, NSError *error);

// --------------
- (void)getServerResponseForUrl:(NSString *)url withCallback:(ASCompletionBlock)callback
{
    getServerResponseForUrlCallback = callback;
    // Start doing some time consuming tasks like sending a request to the backend services
    
    // To see your callback in action uncomment the line below
    [self onBackendResponse:nil withSuccess:YES error:nil];
}

// --------------
- (void)onBackendResponse:(NSDictionary *)response withSuccess:(BOOL)success error:(NSError *)error
{
    getServerResponseForUrlCallback(success, response, error);
}

@end
