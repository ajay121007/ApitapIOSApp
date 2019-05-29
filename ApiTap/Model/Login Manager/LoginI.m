//
//  LoginI.m
//  ApiTap
//
//  Created by Abhishek Singla on 29/07/16.
//  Copyright © 2016 ApiTap. All rights reserved.
//

#import "LoginI.h"

@implementation LoginI

@synthesize userStatus;
@synthesize userType;
@synthesize isRegisterNickName,isUserHasPin;
@synthesize password;
@synthesize serviceCode,errorCodes;
@synthesize NmcId;
@synthesize arrUrls;
@synthesize loginCode;

- (id)init
{
    self = [super init];
    if (self)
    {
        self.userStatus = @"";
        self.userType = @"";
        self.isUserHasPin = @"";
        self.password = @"";
        self.NmcId = @"";
        self.serviceCode = @"";
        self.errorCodes = @"";
        self.sessionID = @"";
        self.loginCode = @"";
        self.arrUrls = [[NSMutableArray alloc]init];
        self.urlImage=@"";
        
    }
    return self;
}
@end
