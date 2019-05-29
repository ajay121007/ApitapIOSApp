//
//  AddressManager.h
//  ApiTap
//
//  Created by Bikramjeet Singh on 8/26/16.
//  Copyright © 2016 ApiTap. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressManager : NSObject

-(void)getCountryStateCityList:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock ;

@end
