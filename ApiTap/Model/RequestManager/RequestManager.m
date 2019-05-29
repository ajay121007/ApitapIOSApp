 //
//  RequestManager.m
//  Voice
//
//  Created by Kabir Chandoke on 7/8/14.
//  Copyright (c) 2014 Kabir Chandoke. All rights reserved.
//

#import "RequestManager.h"
#import "AppDelegate.h"
#import "NSData+Base64.h"


@implementation RequestManager
{
    //Reachability *_internetReachable;
}

@synthesize requestType;
@synthesize isInternetReachable;

#pragma mark - Send asynchronous request



+(void)asynchronousRequestWithPath:(NSString *)strPath
                       requestType:(RequestType)type
                            params:(NSDictionary *)dictParams
                           timeOut:(NSInteger)timeOut
                    includeHeaders:(BOOL)include
                      onCompletion:(JSONResponseBlock)completionBlock
{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictParams options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    NSString *jsonString=nil;
    
    if (! jsonData){
        NSLog(@"Got an error: %@", error);
    }
    else{
        
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    NSData *plainTextData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [plainTextData base64EncodedString];
    
    NSData   *resultdata = [base64String dataUsingEncoding:NSUTF8StringEncoding];
    NSString *strURL = [NSString stringWithFormat:@"%@%@",kBaseUrlPath,strPath] ;
    strURL = [strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:strURL]]; // Upload a file on disk
    
    switch (type)
    {
        case 0:
            [request setRequestMethod:@"POST"];
            break;
        case 1:
            [request setRequestMethod:@"GET"];
            break;
        case 2:
            [request setRequestMethod:@"DELETE"];
            break;
        case 3:
            [request setRequestMethod:@"PUT"];
            break;
    }
    
    if (include)
    {
        [request addRequestHeader:@"Content-Type" value:@"text/plain;charset=utf-8;"];
    }
    
    [request setValidatesSecureCertificate:NO];
    [request setDelegate:self];
    [request setPostBody:(NSMutableData *)resultdata];
    [request setTimeOutSeconds:timeOut];  //30
    [request startAsynchronous];
    
    
    __weak typeof(request) weakrequest = request;
    
    [request setCompletionBlock:^{
        
        NSError *error = nil;
        
        NSDictionary  *dictResponse = [NSJSONSerialization JSONObjectWithData:[weakrequest.responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error: &error];
       
        /////////
        if(error)
            
            NSLog(@"Error in response : %@",error);
        
        completionBlock(weakrequest.responseStatusCode, dictResponse, nil);
    }];
    
    
    [request setFailedBlock:^{
        
        completionBlock(weakrequest.responseStatusCode, nil, weakrequest.error);
        
    }];
    
}

//+(void)asynchronousRequestWithPath2:(NSString *)strPath
//                       requestType:(RequestType)type
//                            params:(NSDictionary *)dictParams
//                           timeOut:(NSInteger)timeOut
//                    includeHeaders:(BOOL)include
//                      onCompletion:(JSONResponseBlock)completionBlock
//{
//    
//    NSError *error;
//    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictParams options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
//                                                         error:&error];
//    NSString *jsonString=nil;
//    
//    if (! jsonData){
//        NSLog(@"Got an error: %@", error);
//    }
//    else{
//        
//        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    }
//    
//    NSData *plainTextData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
//    NSString *base64String = [plainTextData base64EncodedString];
//    
//    NSData   *resultdata = [base64String dataUsingEncoding:NSUTF8StringEncoding];
//    NSString *strURL = [NSString stringWithFormat:@"%@%@",kBaseUrlPathPayment,strPath] ;
//    strURL = [strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//             // [request setRequestMethod:@"PUT"];
//          //  break;
//    
//ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:strURL]];
//    
//    if (include)
//    {
//        [request addRequestHeader:@"Content-Type" value:@"text/plain;charset=utf-8;"];
//    }
//    
//    [request setValidatesSecureCertificate:NO];
//    [request setDelegate:self];
//    [request setPostBody:(NSMutableData *)resultdata];
//    [request setTimeOutSeconds:timeOut];  //30
//    [request startAsynchronous];
//    
//    
//    __weak typeof(request) weakrequest = request;
//    
//    [request setCompletionBlock:^{
//        
//        NSError *error = nil;
//        
//        NSDictionary  *dictResponse = [NSJSONSerialization JSONObjectWithData:[weakrequest.responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error: &error];
//        
//        if(error)
//            NSLog(@"Error in response : %@",error);
//        
//        completionBlock(weakrequest.responseStatusCode, dictResponse, nil);
//    }];
//    
//    
//    [request setFailedBlock:^{
//        
//        completionBlock(weakrequest.responseStatusCode, nil, weakrequest.error);
//        
//    }];
//    
//}


@end
