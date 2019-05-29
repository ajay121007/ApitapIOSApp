//
//  ASService.h
//  ApiTap
//
//  Created by Abhishek Singla on 13/03/16.
//  Copyright © 2016 ApiTap. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASService : NSObject

typedef void (^ASCompletionBlock)(BOOL success, NSDictionary *response, NSError *error);

- (void)getServerResponseForUrl:(NSString *)url withCallback:(ASCompletionBlock)callback;
@end
