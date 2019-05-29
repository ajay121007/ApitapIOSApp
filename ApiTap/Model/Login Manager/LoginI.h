//
//  LoginI.h
//  ApiTap
//
//  Created by Abhishek Singla on 29/07/16.
//  Copyright © 2016 ApiTap. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginI : NSObject

@property(nonatomic,retain)NSString *userStatus;
@property(nonatomic,retain)NSString *userType;
@property(nonatomic,retain)NSString *isUserHasPin;
@property(nonatomic,assign)BOOL     isRegisterNickName;
@property(nonatomic,retain)NSString *password;
@property(nonatomic,retain)NSString *NmcId;
@property(nonatomic,retain)NSString *serviceCode;
@property(nonatomic,retain)NSString *errorCodes;
@property(nonatomic,retain)NSString *sessionID;
@property(nonatomic,retain)NSString *loginCode;
@property(nonatomic,strong)NSMutableArray *arrUrls;


//Forgot Password
@property(nonatomic,retain)NSString *userNameForgotPassword;

//initial urls

@property(nonatomic,strong)NSString *urlImage;

@end
