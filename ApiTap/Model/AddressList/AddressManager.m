//
//  AddressManager.m
//  ApiTap
//
//  Created by Bikramjeet Singh on 8/26/16.
//  Copyright © 2016 ApiTap. All rights reserved.
//

#import "AddressManager.h"

@implementation AddressManager

-(void)getCountryStateCityList:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock {
    
    [RequestManager asynchronousRequestWithPath:@"" requestType:RequestTypePOST params:[GlobalClass callMainDict:serviceCodeID :dictParam] timeOut:200 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json,NSError *err)
     {
                  
         if(statusCode==201)
         {
             NSArray *temp=json[@"RESULT"][0][@"RESULT"];
             
             completionBlock(temp,nil);
         }  
         else
             completionBlock(nil,nil);
     } ];
    
    
}

@end
