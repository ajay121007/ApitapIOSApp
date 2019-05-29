//
//  TaskManager.h
//  Eventuosity
//
//  Created by Leo Macbook on 13/02/14.
//  Copyright (c) 2014 Eventuosity. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestManager.h"
#import "LoginI.h"


@interface LoginManager : NSObject
{
    NSString *strApplicationUUID;
}

@property (nonatomic,strong)LoginI *login;

//verify email

-(void)verifyUserEmail:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSDictionary *, NSError *))completionBlock;


//Signup

-(void)userSignUp:(NSDictionary *)dictParam  completion:(void(^)(NSDictionary *dictJson, NSError *error))completionBlock;

//Logout

-(void)logout:(void(^)(NSDictionary *dict, NSError *error))completionBlock;

//signin

-(void)userLogin:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSDictionary *, NSError *))completionBlock;


//Initial Webservice

-(void)initialService:(NSDictionary *)dictParam completion:(void(^)(NSDictionary *, NSError *error))completionBlock;

-(void)validateUsername:(NSString*)username;

//Temporary Login

-(void)userGuestLogin:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSDictionary *, NSError *))completionBlock;

//-(void)verifyCode:(NSDictionary *)dictParam;

//-(void)resendVerificationCode:(NSDictionary *)dictParam;



@end
