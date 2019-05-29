//
//  TaskManager.m
//  Eventuosity
//
//  Created by Leo Macbook on 13/02/14.
//  Copyright (c) 2014 Eventuosity. All rights reserved.
//

#import "LoginManager.h"
//#import "ProfileManager.h"
#import "AppDelegate.h"
#import "NSData+Base64.h"

//#import <GooglePlus/GooglePlus.h>


@implementation LoginManager
@synthesize login;

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark Service Calls

-(void)userGuestLogin:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSDictionary *, NSError *))completionBlock
{
    
    [RequestManager asynchronousRequestWithPath:@"" requestType:RequestTypePOST params:[GlobalClass callMainDict:serviceCodeID :dictParam] timeOut:200 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json , NSError *error)
     {
         
         
         if((error == nil) && (statusCode==201)) {
             
             completionBlock(json,nil);
         }
         
         else
             completionBlock(nil,nil);
     } ];
    
    
}



-(void)verifyUserEmail:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSDictionary *, NSError *))completionBlock
{
    
    [RequestManager asynchronousRequestWithPath:@"" requestType:RequestTypePOST params:[GlobalClass callMainDict:serviceCodeID :dictParam] timeOut:200 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json , NSError *error)
     {
         
         
         
         if((error == nil) && (statusCode==201)) {
             
             completionBlock(json,nil);
         }
         
         else
             completionBlock(nil,nil);
     } ];
    
}

-(void)userLogin:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSDictionary *, NSError *))completionBlock {
    
    [RequestManager asynchronousRequestWithPath:@"" requestType:RequestTypePOST params:[GlobalClass callMainDict:serviceCodeID :dictParam] timeOut:200 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json , NSError *error)
     {
         
         
         if((error == nil) && (statusCode==201)) {
             
             completionBlock(json,nil);
         }
         
         else
             completionBlock(nil,nil);
     } ];
    
}

-(void)userSignUp:(NSDictionary *)dictParam completion:(void (^)(NSDictionary *, NSError *))completionBlock
{
    
    
    
    [RequestManager asynchronousRequestWithPath:@"" requestType:RequestTypePOST params:dictParam timeOut:200 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json,NSError *err)
     {
         
         if(statusCode==200)
         {
             if([[json valueForKey:@"success"] boolValue])
             {
                 
             }
             completionBlock(json,nil);
         }
         else
             completionBlock(nil,nil);
     } ];
    
    
}


-(void)userLogin:(NSDictionary *)dictParam completion:(void(^)(NSDictionary *, NSError *error))completionBlock
{
    
    [RequestManager asynchronousRequestWithPath:kRequestLogin requestType:RequestTypePOST params:dictParam timeOut:200 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json , NSError *error)
     {
         
         if((error == nil) && (statusCode==201))
         {
             completionBlock(json,nil);
         }
         
         
         else
             completionBlock(nil,nil);
     } ];
}


-(void)initialService:(NSDictionary *)dictParam completion:(void(^)(NSDictionary *, NSError *error))completionBlock
{
    
    [RequestManager asynchronousRequestWithPath:@"" requestType:RequestTypePOST params:dictParam timeOut:200 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json , NSError *error)
     {
        
        
         dispatch_async(dispatch_get_main_queue(), ^{
             
             NSDictionary *jsonDict = nil ;
            
       
         if((error == nil) && (statusCode == 201))
         {
             
             if ([[[[json objectForKey:@"RESULT"]objectAtIndex:0] objectForKey:@"RESULT"] count]>0)
             {
                 
                 LoginI *logI = [[LoginI alloc]init];
                 
                 NSDictionary *dictResult = [json objectForKey:@"RESULT"] ;
                 
                 //logI.arrUrls = [[[json objectForKey:@"RESULT"]objectAtIndex:0] objectForKey:@"RESULT"];
                 
                 logI.userStatus = [dictResult valueForKey:@"_44"];
                 logI.errorCodes = [dictResult valueForKey:@"_39"];
                 logI.serviceCode = [dictResult valueForKey:@"_101"];
                 
                 NSDictionary *dictData = [[[[json objectForKey:@"RESULT"]objectAtIndex:0] objectForKey:@"RESULT"]objectAtIndex:0];
                 
                 logI.urlImage=  [dictData valueForKey:@"_127_12"];
                 
                 
                 logI.loginCode = [json valueForKey:@"_192"];
                 
                 
                 
                 
                 
                 
                 //                 logI.NmcId =[dictInnerResult valueForKey:@"_53"];
                 //                 logI.userType =[dictInnerResult valueForKey:@"_55"];
                 //                 logI.isUserHasPin =[dictInnerResult valueForKey:@"_121_6"];
                 
                 
                 self.login = logI;
                 
             }
             
             jsonDict = @{@"status":@YES};
             
             completionBlock(jsonDict,nil);
         }
         
         else
         {
             jsonDict = @{@"status":@NO};
             
             completionBlock(jsonDict,nil);
         }
             
           });


     } ];
}




-(void)validateUsername:(NSString*)username
{
    
}

-(void)userSignUp:(NSDictionary *)dictParam
{
    
}

-(void)logout:(void(^)(NSDictionary *dict, NSError *error))completionBlock;
{
    
}

#pragma mark - TimeStamp Method

-(NSString *)getTimeStamp {
    
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"MM-dd-yyyy HH:mm:ss.SSS Z"];
    //[formatter setDateFormat:@"MM-dd-yyyy HH:mm:s.SSS Z"];
    //Optionally for time zone converstions
    //[formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
    NSString *stringFromDate = [formatter stringFromDate:date];
    return stringFromDate;
}

/*
 -(void)userSignUp:(NSDictionary *)dictParam
 {
 [model_manager.requestManager asynchronousRequestWithPath:@"user/register" requestType:RequestTypePost params:dictParam timeOut:kTimeout includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json)
 
 {
 
 if(statusCode == 200)
 
 {
 
 int status =[[json valueForKey:@"ErrorCode"] intValue];
 
 if(status==0)
 
 {
 [[NSUserDefaults standardUserDefaults] setObject:[json valueForKey:@"UserID"] forKey:@"UserID"];
 //----Set Profile Manager----
 
 model_manager.profilemanager.full_name = [[json valueForKey:@"UserData"]valueForKey:@"DisplayName"];
 model_manager.profilemanager.email = [[json valueForKey:@"UserData"]valueForKey:@"Email"];
 model_manager.profilemanager.mobile_no = [[json valueForKey:@"UserData"]valueForKey:@"MobileNo"];
 model_manager.profilemanager.profile_pic = [[json valueForKey:@"UserData"]valueForKey:@"UserImg"];
 
 //---------------------------
 
 // fire the notification
 
 [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUserRegistered object:@"success"];
 
 }
 
 else
 
 {
 NSString *message = [json objectForKey:@"ErrorMessage"];
 [appdelegate showAlert:message];
 
 //fire the notification
 
 [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUserRegistered object:@"failure"];
 
 }
 
 }
 
 else if(statusCode==400)
 
 {
 NSString *message = [json objectForKey:@"ErrorMessage"];
 [appdelegate showAlert:message];
 
 //fire the notification
 
 [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUserRegistered object:@"failure"];;
 
 }
 
 else if(statusCode==401)
 
 {
 NSString *message = [json objectForKey:@"ErrorMessage"];
 [appdelegate showAlert:message];
 
 //fire the notification
 
 [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUserRegistered object:@"failure"];;
 
 }
 
 else if(statusCode==500)
 
 {
 NSString *message = [json objectForKey:@"ErrorMessage"];
 [appdelegate showAlert:message];
 
 //fire the notification
 
 [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUserRegistered object:@"failure"];;
 
 }
 
 else
 
 {
 NSString *message = [json objectForKey:@"ErrorMessage"];
 [appdelegate showAlert:message];
 
 //fire the notification
 
 [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUserRegistered object:@"failure"];;
 
 }
 
 
 
 }];
 
 
 }
 
 -(void)authorizeUser:(NSDictionary *)dictParam
 {
 [model_manager.requestManager asynchronousRequestWithPath:@"user/login" requestType:RequestTypePost params:dictParam timeOut:kTimeout includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json)
 {
 if(statusCode == 200)
 
 {
 int status =[[json valueForKey:@"ErrorCode"] intValue];
 
 if(status==0)
 
 {
 model_manager.profilemanager.user_token = [json valueForKey:@"Token"];
 
 //sync database with server
 [model_manager.bookingManager syncDatabaseWithServer];
 
 if(model_manager.profilemanager.svp_LocationInfo==nil)
 {
 CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
 if (status!=kCLAuthorizationStatusRestricted && status != kCLAuthorizationStatusDenied &&
 status!=kCLAuthorizationStatusNotDetermined)
 [appdelegate.location_Manager startUpdatingLocation];
 }
 
 // fire the notification
 [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUserLoggedIn object:@"success"];
 
 }
 
 else
 
 {
 if(![[NSUserDefaults standardUserDefaults] objectForKey:@"FBUserData"] && ![[NSUserDefaults standardUserDefaults] objectForKey:@"GPlusUserData"])
 {
 NSString *message = [json objectForKey:@"ErrorMessage"];
 [appdelegate showAlert:message];
 }
 
 if([[json objectForKey:@"ErrorCode"] intValue]==1000)
 {
 [[NSUserDefaults standardUserDefaults] setObject:@"false" forKey:@"isAutoLogin"];
 }
 
 //fire the notification
 
 [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUserLoggedIn object:@"failure"];
 
 }
 
 }
 
 else if(statusCode==400)
 
 {
 NSString *message = [json objectForKey:@"ErrorMessage"];
 [appdelegate showAlert:message];
 
 //fire the notification
 
 [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUserLoggedIn object:@"failure"];;
 
 }
 
 else if(statusCode==401)
 
 {
 NSString *message = [json objectForKey:@"ErrorMessage"];
 [appdelegate showAlert:message];
 
 //fire the notification
 
 [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUserLoggedIn object:@"failure"];;
 
 }
 
 else if(statusCode==500)
 
 {
 NSString *message = [json objectForKey:@"ErrorMessage"];
 [appdelegate showAlert:message];
 
 //fire the notification
 
 [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUserLoggedIn object:@"failure"];
 
 }
 
 else
 
 {
 NSString *message = [json objectForKey:@"ErrorMessage"];
 [appdelegate showAlert:message];
 
 //fire the notification
 
 [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUserLoggedIn object:@"failure"];
 
 }
 
 
 
 }];
 
 
 }
 
 -(void)verifyCode:(NSDictionary *)dictParam
 {
 [model_manager.requestManager asynchronousRequestWithPath:@"user/ValidatePhone" requestType:RequestTypePost params:dictParam timeOut:kTimeout includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json)
 
 {
 
 if(statusCode == 200)
 
 {
 
 int status =[[json valueForKey:@"ErrorCode"] intValue];
 
 if(status==0)
 
 {
 
 // fire the notification
 
 [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUserVerification object:@"success"];
 
 }
 
 else
 
 {
 NSString *message = [json objectForKey:@"ErrorMessage"];
 [appdelegate showAlert:message];
 
 //fire the notification
 
 [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUserVerification object:@"failure"];
 
 }
 
 }
 
 else if(statusCode==400)
 
 {
 NSString *message = [json objectForKey:@"ErrorMessage"];
 [appdelegate showAlert:message];
 
 //fire the notification
 
 [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUserVerification object:@"failure"];;
 
 }
 
 else if(statusCode==401)
 
 {
 NSString *message = [json objectForKey:@"ErrorMessage"];
 [appdelegate showAlert:message];
 
 //fire the notification
 
 [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUserVerification object:@"failure"];;
 
 }
 
 else if(statusCode==500)
 
 {
 NSString *message = [json objectForKey:@"ErrorMessage"];
 [appdelegate showAlert:message];
 
 //fire the notification
 
 [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUserVerification object:@"failure"];;
 
 }
 
 else
 
 {
 NSString *message = [json objectForKey:@"ErrorMessage"];
 [appdelegate showAlert:message];
 
 //fire the notification
 
 [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUserVerification object:@"failure"];;
 
 }
 
 
 
 }];
 
 }
 
 -(void)resendVerificationCode:(NSDictionary *)dictParam
 {
 [model_manager.requestManager asynchronousRequestWithPath:@"user/ResendOTP" requestType:RequestTypePost params:dictParam timeOut:kTimeout includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json)
 
 {
 
 if(statusCode == 200)
 
 {
 
 int status =[[json valueForKey:@"ErrorCode"] intValue];
 
 if(status==0)
 
 {
 
 // fire the notification
 
 [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationResendVCode object:@"success"];
 
 }
 
 else
 
 {
 NSString *message = [json objectForKey:@"ErrorMessage"];
 [appdelegate showAlert:message];
 
 //fire the notification
 
 [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationResendVCode object:@"failure"];
 
 }
 
 }
 
 else if(statusCode==400)
 
 {
 NSString *message = [json objectForKey:@"ErrorMessage"];
 [appdelegate showAlert:message];
 
 //fire the notification
 
 [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationResendVCode object:@"failure"];;
 
 }
 
 else if(statusCode==401)
 
 {
 NSString *message = [json objectForKey:@"ErrorMessage"];
 [appdelegate showAlert:message];
 
 //fire the notification
 
 [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationResendVCode object:@"failure"];;
 
 }
 
 else if(statusCode==500)
 
 {
 NSString *message = [json objectForKey:@"ErrorMessage"];
 [appdelegate showAlert:message];
 
 //fire the notification
 
 [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationResendVCode object:@"failure"];;
 
 }
 
 else
 
 {
 NSString *message = [json objectForKey:@"ErrorMessage"];
 [appdelegate showAlert:message];
 
 //fire the notification
 
 [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationResendVCode object:@"failure"];;
 
 }
 
 
 
 }];
 
 }
 
 -(void)logout
 {
 
 }
 */

@end
