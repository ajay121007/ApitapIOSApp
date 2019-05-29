        //
//  GlobalClass.m
//  ApiTap
//
//  Created by Bikramjeet Singh on 8/5/16.
//  Copyright © 2016 ApiTap. All rights reserved.
//

#import "GlobalClass.h"
#import "AppDelegate.h"
#import "LoginI.h"
#import "ApiTap-Swift.h"

@implementation GlobalClass

NSString *strApplicationUUID;
+(NSDictionary *)callInvoiceDict : (NSString *)serviceCodeID : (NSDictionary *)appenddict {
    
    NSString *latitude =  [NSString stringWithFormat:@"%f",appdelegate.currentLocation.coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f",appdelegate.currentLocation.coordinate.longitude];
    NSString *all = @"ALL";
    NSMutableArray *arrObject= [[NSMutableArray alloc] initWithObjects:serviceCodeID ,appenddict,all, nil];
    NSMutableArray *arrKey = [[ NSMutableArray alloc] initWithObjects:@"101",@"PARAM",@"EXPECTED", nil];
    
    NSMutableDictionary *dictOPTLIST=[[NSMutableDictionary alloc]initWithObjects:arrObject forKeys:arrKey];
    
    NSMutableArray *arrOPTLST=[NSMutableArray new];
    [arrOPTLST addObject:dictOPTLIST];
    
    NSMutableArray *arrObjects=nil;
    NSMutableArray *arrKeys =nil;
    
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd-yyyy HH:mm:ss.SSS Z"];
    NSString *stringFromDate = [formatter stringFromDate:date];
    
    arrObjects= [[NSMutableArray alloc]initWithObjects:[ModelManager modelManager].loginManager.login.loginCode,stringFromDate,@"en",latitude,longitude,[GlobalClass getDeviceUUID],arrOPTLST, nil];
    
    //arrObjects = [[NSMutableArray alloc] initWithObjects:@"11",@"11",@"11",@"11",@"11",@"11",@"11", nil];
    arrKeys = [[ NSMutableArray alloc] initWithObjects:@"192",@"11",@"122.45",@"120.38",@"120.39",@"57",@"OPTLST", nil];
    
    
    NSMutableDictionary *dictFinal=[[NSMutableDictionary alloc]initWithObjects:arrObjects forKeys:arrKeys];
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictFinal
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    if (! jsonData) {
        
        
    } else {
        
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",jsonString);
        
    }
    
    
    return dictFinal;
}
+(NSDictionary *)callStoreDict : (NSString *)serviceCodeID : (NSDictionary *)appenddict {
    
    NSString *latitude =  [NSString stringWithFormat:@"%f",appdelegate.currentLocation.coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f",appdelegate.currentLocation.coordinate.longitude];
    NSString *all = @"ALL";
    //NSDictionary *dict = @{ @"114.179" : storeMerchantClass.storeMerchantId, @"operator" : @"eq"};
   // NSMutableArray *arrOPTLST2=[NSMutableArray new];
   // [arrOPTLST2 addObject:dict];
    NSMutableArray *arrObject= [[NSMutableArray alloc] initWithObjects:serviceCodeID ,appenddict, nil];
   // NSMutableArray *arrKey = [[ NSMutableArray alloc] initWithObjects:@"101",@"PARAM",@"EXPECTED", nil]; // mycode
    NSMutableArray *arrKey = [[ NSMutableArray alloc] initWithObjects:@"101",@"PARAM", nil];
    NSMutableDictionary *dictOPTLIST=[[NSMutableDictionary alloc]initWithObjects:arrObject forKeys:arrKey];
    
    NSMutableArray *arrOPTLST=[NSMutableArray new];
    [arrOPTLST addObject:dictOPTLIST];
    
    NSMutableArray *arrObjects=nil;
    NSMutableArray *arrKeys =nil;
    
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd-yyyy HH:mm:ss.SSS Z"];
    NSString *stringFromDate = [formatter stringFromDate:date];
    
    arrObjects= [[NSMutableArray alloc]initWithObjects:[ModelManager modelManager].loginManager.login.loginCode,stringFromDate,@"en",latitude,longitude,[GlobalClass getDeviceUUID],arrOPTLST, nil];
    
    //arrObjects = [[NSMutableArray alloc] initWithObjects:@"11",@"11",@"11",@"11",@"11",@"11",@"11", nil];
    arrKeys = [[ NSMutableArray alloc] initWithObjects:@"192",@"11",@"122.45",@"120.38",@"120.39",@"57",@"OPTLST", nil];
    
    
    NSMutableDictionary *dictFinal=[[NSMutableDictionary alloc]initWithObjects:arrObjects forKeys:arrKeys];
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictFinal
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    if (! jsonData) {
        
        
    } else {
        
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",jsonString);
        
    }
    
    
    return dictFinal;
}
+(NSDictionary *)callStoreDetailsDict : (NSString *)serviceCodeID : (NSDictionary *)appenddict {
    
    NSString *latitude =  [NSString stringWithFormat:@"%f",appdelegate.currentLocation.coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f",appdelegate.currentLocation.coordinate.longitude];
    NSString *all = @"ALL";
    NSDictionary *dict = @{ @"114.179" : storeMerchantClass.storeMerchantId, @"operator" : @"eq"};
     NSMutableArray *arrOPTLST2=[NSMutableArray new];
    [arrOPTLST2 addObject:dict];
    NSMutableArray *arrObject= [[NSMutableArray alloc] initWithObjects:serviceCodeID ,appenddict,all,arrOPTLST2, nil];
    NSMutableArray *arrKey = [[ NSMutableArray alloc] initWithObjects:@"101",@"PARAM",@"EXPECTED",@"FILTER", nil];
    
    NSMutableDictionary *dictOPTLIST=[[NSMutableDictionary alloc]initWithObjects:arrObject forKeys:arrKey];
    
    NSMutableArray *arrOPTLST=[NSMutableArray new];
    [arrOPTLST addObject:dictOPTLIST];
    
    NSMutableArray *arrObjects=nil;
    NSMutableArray *arrKeys =nil;
    
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd-yyyy HH:mm:ss.SSS Z"];
    NSString *stringFromDate = [formatter stringFromDate:date];
    
    arrObjects= [[NSMutableArray alloc]initWithObjects:[ModelManager modelManager].loginManager.login.loginCode,stringFromDate,@"en",latitude,longitude,[GlobalClass getDeviceUUID],arrOPTLST, nil];
    
    //arrObjects = [[NSMutableArray alloc] initWithObjects:@"11",@"11",@"11",@"11",@"11",@"11",@"11", nil];
    arrKeys = [[ NSMutableArray alloc] initWithObjects:@"192",@"11",@"122.45",@"120.38",@"120.39",@"57",@"OPTLST", nil];
    
    
    NSMutableDictionary *dictFinal=[[NSMutableDictionary alloc]initWithObjects:arrObjects forKeys:arrKeys];
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictFinal
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    if (! jsonData) {
        
        
    } else {
        
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",jsonString);
        
    }
    
    
    return dictFinal;
}
+(NSDictionary *)callMsgDict : (NSString *)serviceCodeID : (NSDictionary *)appenddict {
    
    NSString *latitude =  [NSString stringWithFormat:@"%f",appdelegate.currentLocation.coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f",appdelegate.currentLocation.coordinate.longitude];
    NSString *all = @"ALL";
    NSDictionary *dict = @{ @"53" : @"00011010000000000254", @"operator" : @"eq"};
    NSMutableArray *arrOPTLST2=[NSMutableArray new];
    [arrOPTLST2 addObject:dict];
    NSMutableArray *arrObject= [[NSMutableArray alloc] initWithObjects:serviceCodeID ,appenddict,all,arrOPTLST2, nil];
    NSMutableArray *arrKey = [[ NSMutableArray alloc] initWithObjects:@"101",@"PARAM",@"EXPECTED",@"FILTER", nil];
    //    NSDictionary *dict = @{@"53" : @"00011010000000000254", @"operator" : @"eq"};
    //
    //    NSMutableArray *arrObject= [[NSMutableArray alloc] initWithObjects:serviceCodeID ,appenddict,all,dict, nil];
    //    NSMutableArray *arrKey = [[ NSMutableArray alloc] initWithObjects:@"101",@"PARAM",@"EXPECTED","FILTER", nil];
    
    NSMutableDictionary *dictOPTLIST=[[NSMutableDictionary alloc]initWithObjects:arrObject forKeys:arrKey];
    
    NSMutableArray *arrOPTLST=[NSMutableArray new];
    [arrOPTLST addObject:dictOPTLIST];
    // NSMutableArray *arrOPTLST2=[NSMutableArray new];
    //[arrOPTLST2 addObject:dict];
    NSMutableArray *arrObjects=nil;
    NSMutableArray *arrKeys =nil;
    
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd-yyyy HH:mm:ss.SSS Z"];
    NSString *stringFromDate = [formatter stringFromDate:date];
    
    arrObjects= [[NSMutableArray alloc]initWithObjects:[ModelManager modelManager].loginManager.login.loginCode,stringFromDate,@"en",latitude,longitude,[GlobalClass getDeviceUUID],arrOPTLST, nil];
    
    //arrObjects = [[NSMutableArray alloc] initWithObjects:@"11",@"11",@"11",@"11",@"11",@"11",@"11", nil];
    arrKeys = [[ NSMutableArray alloc] initWithObjects:@"192",@"11",@"122.45",@"120.38",@"120.39",@"57",@"OPTLST", nil];
    
    
    NSMutableDictionary *dictFinal=[[NSMutableDictionary alloc]initWithObjects:arrObjects forKeys:arrKeys];
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictFinal
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    if (! jsonData) {
        
        
    } else {
        
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",jsonString);
        
    }
    
    
    return dictFinal;
}
+(NSDictionary *)getMsgReply : (NSString *)serviceCodeID : (NSDictionary *)appenddict :(NSMutableArray *)appenddict2{
    
    NSString *latitude =  [NSString stringWithFormat:@"%f",appdelegate.currentLocation.coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f",appdelegate.currentLocation.coordinate.longitude];
    NSString *all = @"ALL";
    //NSDictionary *dict = @{ @"53" : @"00011010000000000254", @"operator" : @"eq"};
   // NSMutableArray *arrOPTLST2=[NSMutableArray new];
   // [arrOPTLST2 addObject:dict];
    NSMutableArray *arrObject= [[NSMutableArray alloc] initWithObjects:serviceCodeID ,appenddict,@"ALL",appenddict2, nil];
    NSMutableArray *arrKey = [[ NSMutableArray alloc] initWithObjects:@"101",@"PARAM",@"EXPECTED",@"FILTER", nil];
//    NSDictionary *dict = @{@"53" : @"00011010000000000254", @"operator" : @"eq"};
//    
//    NSMutableArray *arrObject= [[NSMutableArray alloc] initWithObjects:serviceCodeID ,appenddict,all,dict, nil];
//    NSMutableArray *arrKey = [[ NSMutableArray alloc] initWithObjects:@"101",@"PARAM",@"EXPECTED","FILTER", nil];
    
    NSMutableDictionary *dictOPTLIST=[[NSMutableDictionary alloc]initWithObjects:arrObject forKeys:arrKey];
    
    NSMutableArray *arrOPTLST=[NSMutableArray new];
    [arrOPTLST addObject:dictOPTLIST];
   // NSMutableArray *arrOPTLST2=[NSMutableArray new];
    //[arrOPTLST2 addObject:dict];
    NSMutableArray *arrObjects=nil;
    NSMutableArray *arrKeys =nil;
    
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd-yyyy HH:mm:ss.SSS Z"];
    NSString *stringFromDate = [formatter stringFromDate:date];
    
    arrObjects= [[NSMutableArray alloc]initWithObjects:[ModelManager modelManager].loginManager.login.loginCode,stringFromDate,@"en",latitude,longitude,[GlobalClass getDeviceUUID],arrOPTLST, nil];
    
    //arrObjects = [[NSMutableArray alloc] initWithObjects:@"11",@"11",@"11",@"11",@"11",@"11",@"11", nil];
    arrKeys = [[ NSMutableArray alloc] initWithObjects:@"192",@"11",@"122.45",@"120.38",@"120.39",@"57",@"OPTLST", nil];
    
    
    NSMutableDictionary *dictFinal=[[NSMutableDictionary alloc]initWithObjects:arrObjects forKeys:arrKeys];
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictFinal
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    if (! jsonData) {
        
        
    } else {
        
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",jsonString);
        
    }
    
    
    return dictFinal;
}
+(NSDictionary *)callCheckOutDict : (NSString *)serviceCodeID : (NSDictionary *)appenddict : (NSDictionary *)appenddict2 {
    
    NSString *latitude =  [NSString stringWithFormat:@"%f",appdelegate.currentLocation.coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f",appdelegate.currentLocation.coordinate.longitude];
     NSMutableArray *arrOPTLST3=[NSMutableArray new];
     [arrOPTLST3 addObject:appenddict2];
    NSMutableArray *arrObject= [[NSMutableArray alloc] initWithObjects:serviceCodeID ,appenddict,arrOPTLST3, nil];
    NSMutableArray *arrKey = [[ NSMutableArray alloc] initWithObjects:@"101",@"PARAM",@"FILTER", nil];
    
    NSMutableDictionary *dictOPTLIST=[[NSMutableDictionary alloc]initWithObjects:arrObject forKeys:arrKey];
    
    NSMutableArray *arrOPTLST=[NSMutableArray new];
    [arrOPTLST addObject:dictOPTLIST];
    
    NSMutableArray *arrObjects=nil;
    NSMutableArray *arrKeys =nil;
    
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd-yyyy HH:mm:ss.SSS Z"];
    NSString *stringFromDate = [formatter stringFromDate:date];
    
    arrObjects= [[NSMutableArray alloc]initWithObjects:[ModelManager modelManager].loginManager.login.loginCode,stringFromDate,@"en",latitude,longitude,[GlobalClass getDeviceUUID],arrOPTLST, nil];
    
    //arrObjects = [[NSMutableArray alloc] initWithObjects:@"11",@"11",@"11",@"11",@"11",@"11",@"11", nil];
    arrKeys = [[ NSMutableArray alloc] initWithObjects:@"192",@"11",@"122.45",@"120.38",@"120.39",@"57",@"OPTLST", nil];
    
    
    NSMutableDictionary *dictFinal=[[NSMutableDictionary alloc]initWithObjects:arrObjects forKeys:arrKeys];
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictFinal
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    if (! jsonData) {
        
        
    } else {
        
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",jsonString);
        
    }
    
    
    return dictFinal;
}
+(NSDictionary *)callMainDict : (NSString *)serviceCodeID : (NSDictionary *)appenddict {
    
    NSString *latitude =  [NSString stringWithFormat:@"%f",appdelegate.currentLocation.coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f",appdelegate.currentLocation.coordinate.longitude];
        
    NSMutableArray *arrObject= [[NSMutableArray alloc] initWithObjects:serviceCodeID ,appenddict, nil];
    NSMutableArray *arrKey = [[ NSMutableArray alloc] initWithObjects:@"101",@"PARAM", nil];
    
    NSMutableDictionary *dictOPTLIST=[[NSMutableDictionary alloc]initWithObjects:arrObject forKeys:arrKey];
    
    NSMutableArray *arrOPTLST=[NSMutableArray new];
    [arrOPTLST addObject:dictOPTLIST];
    
    NSMutableArray *arrObjects=nil;
    NSMutableArray *arrKeys =nil;
    
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd-yyyy HH:mm:ss.SSS Z"];
    NSString *stringFromDate = [formatter stringFromDate:date];
        
    arrObjects= [[NSMutableArray alloc]initWithObjects:[ModelManager modelManager].loginManager.login.loginCode,stringFromDate,@"en",latitude,longitude,[GlobalClass getDeviceUUID],arrOPTLST, nil];
    
    //arrObjects = [[NSMutableArray alloc] initWithObjects:@"11",@"11",@"11",@"11",@"11",@"11",@"11", nil];
    arrKeys = [[ NSMutableArray alloc] initWithObjects:@"192",@"11",@"122.45",@"120.38",@"120.39",@"57",@"OPTLST", nil];
    
    
    NSMutableDictionary *dictFinal=[[NSMutableDictionary alloc]initWithObjects:arrObjects forKeys:arrKeys];
    
     NSError *error;
     NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictFinal
     options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
     error:&error];
     
     if (! jsonData) {
         
         
     } else {
     
     NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
     
         NSLog(@"%@",jsonString);
         
     }
    
    
    return dictFinal;
}

//Add Item Into Cart

+(NSDictionary *)callMainDictForAddItemIntoCart : (NSString *)serviceCodeID : (NSDictionary *)appenddict {
    
    NSString *latitude =  [NSString stringWithFormat:@"%f",appdelegate.currentLocation.coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f",appdelegate.currentLocation.coordinate.longitude];
    
    NSMutableArray *arrObject= [[NSMutableArray alloc] initWithObjects:serviceCodeID ,appenddict,@[],nil];
    NSMutableArray *arrKey = [[ NSMutableArray alloc] initWithObjects:@"101",@"PARAM",@"FILTER", nil];
    
    NSMutableDictionary *dictOPTLIST=[[NSMutableDictionary alloc]initWithObjects:arrObject forKeys:arrKey];
    
    NSMutableArray *arrOPTLST=[NSMutableArray new];
    [arrOPTLST addObject:dictOPTLIST];
    
    NSMutableArray *arrObjects=nil;
    NSMutableArray *arrKeys =nil;
    
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd-yyyy HH:mm:ss.SSS Z"];
    NSString *stringFromDate = [formatter stringFromDate:date];
    
    arrObjects= [[NSMutableArray alloc]initWithObjects:[ModelManager modelManager].loginManager.login.loginCode,stringFromDate,@"en",latitude,longitude,[GlobalClass getDeviceUUID],arrOPTLST, nil];
    
    arrKeys = [[ NSMutableArray alloc] initWithObjects:@"192",@"11",@"122.45",@"120.38",@"120.39",@"57",@"OPTLST", nil];
    
    
    NSMutableDictionary *dictFinal=[[NSMutableDictionary alloc]initWithObjects:arrObjects forKeys:arrKeys];
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictFinal
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    if (! jsonData) {
        
        
    } else {
        
            NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
            NSLog(@"%@",jsonString);
        
    }
    
    
    return dictFinal;
}


//Get Items Of Shopping Cart By ID

+(NSDictionary *)getItemsOfShoppingCartByIDDict : (NSString *)serviceCodeID filterData : (NSString *)filterData : (NSDictionary *)appenddict {
    
    NSString *latitude =  [NSString stringWithFormat:@"%f",appdelegate.currentLocation.coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f",appdelegate.currentLocation.coordinate.longitude];
    
    NSMutableArray *arrObject= [[NSMutableArray alloc] initWithObjects:serviceCodeID ,appenddict,@[@{@"114.104" :filterData, @"operator":@"eq"}],nil];
    NSMutableArray *arrKey = [[ NSMutableArray alloc] initWithObjects:@"101",@"PARAM",@"FILTER", nil];
    
    NSMutableDictionary *dictOPTLIST=[[NSMutableDictionary alloc]initWithObjects:arrObject forKeys:arrKey];
    
    NSMutableArray *arrOPTLST=[NSMutableArray new];
    [arrOPTLST addObject:dictOPTLIST];
    
    NSMutableArray *arrObjects=nil;
    NSMutableArray *arrKeys =nil;
    
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd-yyyy HH:mm:ss.SSS Z"];
    NSString *stringFromDate = [formatter stringFromDate:date];
    
    arrObjects= [[NSMutableArray alloc]initWithObjects:[ModelManager modelManager].loginManager.login.loginCode,stringFromDate,@"en",latitude,longitude,[GlobalClass getDeviceUUID],arrOPTLST, nil];
    
    arrKeys = [[ NSMutableArray alloc] initWithObjects:@"192",@"11",@"122.45",@"120.38",@"120.39",@"57",@"OPTLST", nil];
    
    
    NSMutableDictionary *dictFinal=[[NSMutableDictionary alloc]initWithObjects:arrObjects forKeys:arrKeys];
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictFinal
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    if (! jsonData) {
        
       
    } else {
        
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",jsonString);
        
    }
    
    
    return dictFinal;
}

// Send Multiple WebService in One Request

+(NSDictionary *)callMainDictForItems : (NSString *)serviceCodeID : (NSDictionary *)appenddict {
    
    NSString *latitude =  [NSString stringWithFormat:@"%f",appdelegate.currentLocation.coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f",appdelegate.currentLocation.coordinate.longitude];
    
    NSMutableArray *arrObject= [[NSMutableArray alloc] initWithObjects:KGetItemDetailMobile ,appenddict,@[],@"ALL",nil];
    NSMutableArray *arrKey = [[ NSMutableArray alloc] initWithObjects:@"101",@"PARAM",@"FILTER",@"EXPECTED",nil];
    
    NSMutableDictionary *dictOPTLIST=[[NSMutableDictionary alloc]initWithObjects:arrObject forKeys:arrKey];
    
    NSDictionary *dictForReletedItems=@{@"101":@"010100019",@"PARAM": @{@"114.144":appenddict[@"114.144"]}};
    
    NSDictionary *dictForWatchItem=@{@"101":KAddProductWatchedByUserKey,@"PARAM": @{@"53":appenddict[@"53"],@"114.144":appenddict[@"114.144"]}};
    
    
    NSDictionary *dictForItemReviews=@{@"101":@"010100101",@"PARAM":@{},@"FILTER" :@[@{@"114.144":appenddict[@"114.144"],@"operator":@"eq"}]};

    
    NSMutableArray *arrOPTLST=[NSMutableArray new];
    [arrOPTLST addObject:dictOPTLIST];  
    [arrOPTLST addObject:dictForReletedItems];
    [arrOPTLST addObject:dictForWatchItem];
    [arrOPTLST addObject:dictForItemReviews];
    
    NSMutableArray *arrObjects=nil;
    NSMutableArray *arrKeys =nil;
    
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd-yyyy HH:mm:ss.SSS Z"];
    NSString *stringFromDate = [formatter stringFromDate:date];
    
    arrObjects= [[NSMutableArray alloc]initWithObjects:[ModelManager modelManager].loginManager.login.loginCode,stringFromDate,@"en",latitude,longitude,[GlobalClass getDeviceUUID],arrOPTLST, nil];
    
    arrKeys = [[ NSMutableArray alloc] initWithObjects:@"192",@"11",@"122.45",@"120.38",@"120.39",@"57",@"OPTLST", nil];
    
    
    NSMutableDictionary *dictFinal=[[NSMutableDictionary alloc]initWithObjects:arrObjects forKeys:arrKeys];
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictFinal
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    if (! jsonData) {
        
        
    } else {
        
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",jsonString);
        
    }

    
    return dictFinal;
}


// Send Multiple WebService in One Request

+(NSDictionary *)callCountryStateCityList : (NSString *)serviceCodeID : (NSDictionary *)appenddict {
    
    NSString *latitude =  [NSString stringWithFormat:@"%f",appdelegate.currentLocation.coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f",appdelegate.currentLocation.coordinate.longitude];
    
    NSMutableArray *arrObject= [[NSMutableArray alloc] initWithObjects:serviceCodeID ,appenddict, nil];
    NSMutableArray *arrKey = [[ NSMutableArray alloc] initWithObjects:@"101",@"PARAM", nil];
    
    NSMutableDictionary *dictOPTLIST=[[NSMutableDictionary alloc]initWithObjects:arrObject forKeys:arrKey];
    
    NSMutableArray *arrOPTLST=[NSMutableArray new];
    [arrOPTLST addObject:dictOPTLIST];
    
    NSMutableArray *arrObjects=nil;
    NSMutableArray *arrKeys =nil;
    
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd-yyyy HH:mm:ss.SSS Z"];
    NSString *stringFromDate = [formatter stringFromDate:date];
    
    arrObjects= [[NSMutableArray alloc]initWithObjects:[ModelManager modelManager].loginManager.login.loginCode,stringFromDate,@"en",latitude,longitude,[GlobalClass getDeviceUUID],arrOPTLST, nil];
    
    arrKeys = [[ NSMutableArray alloc] initWithObjects:@"192",@"11",@"122.45",@"120.38",@"120.39",@"57",@"OPTLST", nil];
    
    
    NSMutableDictionary *dictFinal=[[NSMutableDictionary alloc]initWithObjects:arrObjects forKeys:arrKeys];
    
    
    return dictFinal;
    
    
}

// Make Eleven Digit Number Metohds

+(NSString *)makeElevenDigitNumber : (NSString *)number {
    
    NSMutableString *str = [NSMutableString string];
    
    for (int i=(int)[number length]; i<=10; i++) {
        
        [str appendString:@"0"];
        
        
    }

    [str appendString:number];
        
    return str;
}

// Set UDID Method

+(NSString *)getDeviceUUID {
    
    strApplicationUUID  = [[[UIDevice currentDevice] identifierForVendor] UUIDString] ;
    strApplicationUUID = [strApplicationUUID stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    
    NSString * hexStrDeviceId = [NSString stringWithFormat:@"%@",
                                 [NSData dataWithBytes:[strApplicationUUID cStringUsingEncoding:NSUTF8StringEncoding]
                                                length:strlen([strApplicationUUID cStringUsingEncoding:NSUTF8StringEncoding])]];
    
    for(NSString * toRemove in [NSArray arrayWithObjects:@"<", @">", @" ", nil])
        hexStrDeviceId = [hexStrDeviceId stringByReplacingOccurrencesOfString:toRemove withString:@""];
    
    return hexStrDeviceId;

}

// Call Home WebService

+(NSDictionary *)callHomeDictForItems : (NSString *)serviceCodeID : (NSDictionary *)appenddict {
    
    NSString *latitude =  [NSString stringWithFormat:@"%f",appdelegate.currentLocation.coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f",appdelegate.currentLocation.coordinate.longitude];
    
    // First
    
    NSMutableArray *arrForSpecials= [[NSMutableArray alloc] initWithObjects:kSearchItemsSpecialsByCategoryMobile ,appenddict, nil];
    
    NSMutableArray *arrForSpecialsKey = [[ NSMutableArray alloc] initWithObjects:@"101",@"PARAM", nil];
    
    NSMutableDictionary *dictOPTLIST=[[NSMutableDictionary alloc]initWithObjects:arrForSpecials forKeys:arrForSpecialsKey];
    
    // Second
    
    NSMutableArray *arrForItems= [[NSMutableArray alloc] initWithObjects:kSearchItemsByCategoryMobile ,appenddict, nil];
    
    NSMutableArray *arrForItemKey = [[ NSMutableArray alloc] initWithObjects:@"101",@"PARAM", nil];
    
    NSMutableDictionary *dictOPTLIST2=[[NSMutableDictionary alloc]initWithObjects:arrForItems forKeys:arrForItemKey];
    
    NSMutableArray *arrOPTLST=[NSMutableArray new];
    [arrOPTLST addObject:dictOPTLIST];
    [arrOPTLST addObject:dictOPTLIST2];
    
    NSMutableArray *arrObjects=nil;
    NSMutableArray *arrKeys =nil;
    
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd-yyyy HH:mm:ss.SSS Z"];
    NSString *stringFromDate = [formatter stringFromDate:date];
    
    arrObjects= [[NSMutableArray alloc]initWithObjects:[ModelManager modelManager].loginManager.login.loginCode,stringFromDate,@"en",latitude,longitude,[GlobalClass getDeviceUUID],arrOPTLST, nil];
    
   // arrObjects = [[ NSMutableArray alloc] initWithObjects:@"192",@"11",@"122.45",@"120.38",@"120.39",@"57",@"OPTLST", nil];
    
    arrKeys = [[ NSMutableArray alloc] initWithObjects:@"192",@"11",@"122.45",@"120.38",@"120.39",@"57",@"OPTLST", nil];
    
    
    NSMutableDictionary *dictFinal=[[NSMutableDictionary alloc]initWithObjects:arrObjects forKeys:arrKeys];
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictFinal
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    if (! jsonData) {
        
       
    } else {
        
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",jsonString);
        
    }
    
    
    return dictFinal;
    
   
//    NSString *latitude =  [NSString stringWithFormat:@"%f",appdelegate.currentLocation.coordinate.latitude];
//    NSString *longitude = [NSString stringWithFormat:@"%f",appdelegate.currentLocation.coordinate.longitude];
//    
//    NSMutableArray *arrObject= [[NSMutableArray alloc] initWithObjects:KGetItemDetailMobile ,appenddict,@[],@"ALL",nil];
//    NSMutableArray *arrKey = [[ NSMutableArray alloc] initWithObjects:@"101",@"PARAM",@"FILTER",@"EXPECTED",nil];
//    
//    NSMutableDictionary *dictOPTLIST=[[NSMutableDictionary alloc]initWithObjects:arrObject forKeys:arrKey];
//    
//    NSDictionary *dictForReletedItems=@{@"101":@"010100019",@"PARAM": @{@"114.144":appenddict[@"114.144"]}};
//    
//    NSDictionary *dictForWatchItem=@{@"101":KAddProductWatchedByUserKey,@"PARAM": @{@"53":appenddict[@"53"],@"114.144":appenddict[@"114.144"]}};
//    
//    
//    NSDictionary *dictForItemReviews=@{@"101":@"010100101",@"PARAM":@{},@"FILTER" :@[@{@"114.144":appenddict[@"114.144"],@"operator":@"eq"}]};
//    
//    //    NSLog(@"%@",dictForItemReviews);
//    
//    NSMutableArray *arrOPTLST=[NSMutableArray new];
//    [arrOPTLST addObject:dictOPTLIST];
//    [arrOPTLST addObject:dictForReletedItems];
//    [arrOPTLST addObject:dictForWatchItem];
//    [arrOPTLST addObject:dictForItemReviews];
//    
//    NSMutableArray *arrObjects=nil;
//    NSMutableArray *arrKeys =nil;
//    
//    NSDate *date=[NSDate date];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"MM-dd-yyyy HH:mm:ss.SSS Z"];
//    NSString *stringFromDate = [formatter stringFromDate:date];
//    
//    arrObjects= [[NSMutableArray alloc]initWithObjects:[ModelManager modelManager].loginManager.login.loginCode,stringFromDate,@"en",latitude,longitude,[GlobalClass getDeviceUUID],arrOPTLST, nil];
//    
//    arrKeys = [[ NSMutableArray alloc] initWithObjects:@"192",@"11",@"122.45",@"120.38",@"120.39",@"57",@"OPTLST", nil];
//    
//    
//    NSMutableDictionary *dictFinal=[[NSMutableDictionary alloc]initWithObjects:arrObjects forKeys:arrKeys];
//    
//    return dictFinal;
}


+(NSDictionary *)callMainDictForHistory : (NSString *)serviceCodeID : (NSDictionary *)appenddict {
    
    NSString *latitude =  [NSString stringWithFormat:@"%f",appdelegate.currentLocation.coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f",appdelegate.currentLocation.coordinate.longitude];
    
    NSMutableArray *arrObject= [[NSMutableArray alloc] initWithObjects:serviceCodeID ,appenddict,@"ALL",nil];
    NSMutableArray *arrKey = [[ NSMutableArray alloc] initWithObjects:@"101",@"PARAM",@"EXPECTED",nil];
    
    NSMutableDictionary *dictOPTLIST=[[NSMutableDictionary alloc]initWithObjects:arrObject forKeys:arrKey];
    
    NSMutableArray *arrOPTLST=[NSMutableArray new];
    [arrOPTLST addObject:dictOPTLIST];
    
    NSMutableArray *arrObjects=nil;
    NSMutableArray *arrKeys =nil;
    
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd-yyyy HH:mm:ss.SSS Z"];
    NSString *stringFromDate = [formatter stringFromDate:date];
    
    arrObjects= [[NSMutableArray alloc]initWithObjects:[ModelManager modelManager].loginManager.login.loginCode,stringFromDate,@"en",latitude,longitude,[GlobalClass getDeviceUUID],arrOPTLST, nil];
    
    arrKeys = [[ NSMutableArray alloc] initWithObjects:@"192",@"11",@"122.45",@"120.38",@"120.39",@"57",@"OPTLST", nil];
    
    
    NSMutableDictionary *dictFinal=[[NSMutableDictionary alloc]initWithObjects:arrObjects forKeys:arrKeys];
        
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictFinal
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    if (! jsonData) {
        
        
    } else {
        
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        
        
    }
    
    
    return dictFinal;
}

+(NSDictionary *)callMainDictForMessageLists : (NSString *)serviceCodeID : (NSDictionary *)appenddict {
    
    NSString *latitude =  [NSString stringWithFormat:@"%f",appdelegate.currentLocation.coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f",appdelegate.currentLocation.coordinate.longitude];
    
//    NSMutableArray *arrObject= [[NSMutableArray alloc] initWithObjects:serviceCodeID ,appenddict,@"ALL",nil];
//    NSMutableArray *arrKey = [[ NSMutableArray alloc] initWithObjects:@"101",@"PARAM",@"EXPECTED",nil];
        
    
    NSDictionary *addFirstFilterDict=@{[[NSUserDefaults standardUserDefaults]valueForKey:@"loginUserID"] : @"53",@"eq" :@"operator"};
    
    NSDictionary *addSecondFilterDict=@{@"92" : @"120.16",@"eq" :@"operator"};
    
    NSMutableArray *arrObject= [[NSMutableArray alloc] initWithObjects:serviceCodeID ,appenddict,@[addFirstFilterDict,addSecondFilterDict],@"ALL",nil];
    NSMutableArray *arrKey = [[ NSMutableArray alloc] initWithObjects:@"101",@"PARAM",@"FILTER",@"EXPECTED",nil];
    
    NSMutableDictionary *dictOPTLIST=[[NSMutableDictionary alloc]initWithObjects:arrObject forKeys:arrKey];
    
    NSMutableArray *arrOPTLST=[NSMutableArray new];
    [arrOPTLST addObject:dictOPTLIST];
    
    NSMutableArray *arrObjects=nil;
    NSMutableArray *arrKeys =nil;
    
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd-yyyy HH:mm:ss.SSS Z"];
    NSString *stringFromDate = [formatter stringFromDate:date];
    
    arrObjects= [[NSMutableArray alloc]initWithObjects:[ModelManager modelManager].loginManager.login.loginCode,stringFromDate,@"en",latitude,longitude,[GlobalClass getDeviceUUID],arrOPTLST, nil];
    
    arrKeys = [[ NSMutableArray alloc] initWithObjects:@"192",@"11",@"122.45",@"120.38",@"120.39",@"57",@"OPTLST", nil];
    
    
    NSMutableDictionary *dictFinal=[[NSMutableDictionary alloc]initWithObjects:arrObjects forKeys:arrKeys];
    
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictFinal
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    if (! jsonData) {
        
     
    } else {
        
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
       
        
    }
    
    
    return dictFinal;
}
+(NSDictionary *)callRatingLists : (NSString *)serviceCodeID : (NSDictionary *)appenddict {
    
    NSString *latitude =  [NSString stringWithFormat:@"%f",appdelegate.currentLocation.coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f",appdelegate.currentLocation.coordinate.longitude];
    
    //    NSMutableArray *arrObject= [[NSMutableArray alloc] initWithObjects:serviceCodeID ,appenddict,@"ALL",nil];
    //    NSMutableArray *arrKey = [[ NSMutableArray alloc] initWithObjects:@"101",@"PARAM",@"EXPECTED",nil];
    
    
    NSDictionary *addFirstFilterDict=@{[[NSUserDefaults standardUserDefaults]valueForKey:@"loginUserID"] : @"53",@"eq" :@"operator"};
    
    NSMutableArray *arrOPTLST2=[NSMutableArray new];
    [arrOPTLST2 addObject:addFirstFilterDict];
    
    NSMutableArray *arrObject= [[NSMutableArray alloc] initWithObjects:serviceCodeID ,appenddict,arrOPTLST2,@"ALL",nil];
    NSMutableArray *arrKey = [[ NSMutableArray alloc] initWithObjects:@"101",@"PARAM",@"FILTER",@"EXPECTED",nil];
    
    NSMutableDictionary *dictOPTLIST=[[NSMutableDictionary alloc]initWithObjects:arrObject forKeys:arrKey];
    
    NSMutableArray *arrOPTLST=[NSMutableArray new];
    [arrOPTLST addObject:dictOPTLIST];
    
    NSMutableArray *arrObjects=nil;
    NSMutableArray *arrKeys =nil;
    
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd-yyyy HH:mm:ss.SSS Z"];
    NSString *stringFromDate = [formatter stringFromDate:date];
    
    arrObjects= [[NSMutableArray alloc]initWithObjects:[ModelManager modelManager].loginManager.login.loginCode,stringFromDate,@"en",latitude,longitude,[GlobalClass getDeviceUUID],arrOPTLST, nil];
    
    arrKeys = [[ NSMutableArray alloc] initWithObjects:@"192",@"11",@"122.45",@"120.38",@"120.39",@"57",@"OPTLST", nil];
    
    
    NSMutableDictionary *dictFinal=[[NSMutableDictionary alloc]initWithObjects:arrObjects forKeys:arrKeys];
    
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictFinal
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    if (! jsonData) {
        
        
    } else {
        
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        
        
    }
    
    
    return dictFinal;
}


// Set Map Dicts

// Call Home WebService

+(NSDictionary *)callMapDicts : (NSString *)serviceCodeID : (NSDictionary *)appenddict {
    
    NSString *latitude =  [NSString stringWithFormat:@"%f",appdelegate.currentLocation.coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f",appdelegate.currentLocation.coordinate.longitude];
    
    // First
    
    NSMutableArray *arrForSpecials= [[NSMutableArray alloc] initWithObjects:@"010100020" ,appenddict, nil];
    
    NSMutableArray *arrForSpecialsKey = [[ NSMutableArray alloc] initWithObjects:@"101",@"PARAM", nil];
    
    NSMutableDictionary *dictOPTLIST=[[NSMutableDictionary alloc]initWithObjects:arrForSpecials forKeys:arrForSpecialsKey];
    
    // Second
    
    NSMutableArray *arrForItems= [[NSMutableArray alloc] initWithObjects:@"010100368" ,appenddict, nil];
    
    NSMutableArray *arrForItemKey = [[ NSMutableArray alloc] initWithObjects:@"101",@"PARAM", nil];
    
    NSMutableDictionary *dictOPTLIST2=[[NSMutableDictionary alloc]initWithObjects:arrForItems forKeys:arrForItemKey];
    
    NSMutableArray *arrOPTLST=[NSMutableArray new];
    [arrOPTLST addObject:dictOPTLIST];
    [arrOPTLST addObject:dictOPTLIST2];
    
    NSMutableArray *arrObjects=nil;
    NSMutableArray *arrKeys =nil;
    
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd-yyyy HH:mm:ss.SSS Z"];
    NSString *stringFromDate = [formatter stringFromDate:date];
    
    arrObjects= [[NSMutableArray alloc]initWithObjects:[ModelManager modelManager].loginManager.login.loginCode,stringFromDate,@"en",latitude,longitude,[GlobalClass getDeviceUUID],arrOPTLST, nil];
    
    arrKeys = [[ NSMutableArray alloc] initWithObjects:@"192",@"11",@"122.45",@"120.38",@"120.39",@"57",@"OPTLST", nil];
    
    
    NSMutableDictionary *dictFinal=[[NSMutableDictionary alloc]initWithObjects:arrObjects forKeys:arrKeys];
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictFinal
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    if (! jsonData) {
        
       
    } else {
        
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        
        
    }
    
    
    return dictFinal;
}


+(NSDictionary *)callPaymentDict : (NSString *)serviceCodeID : (NSDictionary *)appenddict {
    
    NSString *latitude =  [NSString stringWithFormat:@"%f",appdelegate.currentLocation.coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f",appdelegate.currentLocation.coordinate.longitude];
    
    NSMutableArray *arrObject= [[NSMutableArray alloc] initWithObjects:serviceCodeID ,appenddict, nil];
    NSMutableArray *arrKey = [[ NSMutableArray alloc] initWithObjects:@"101",@"PARAM", nil];
    
    NSMutableDictionary *dictOPTLIST=[[NSMutableDictionary alloc]initWithObjects:arrObject forKeys:arrKey];
    
    NSMutableArray *arrOPTLST=[NSMutableArray new];
    [arrOPTLST addObject:dictOPTLIST];
    
    NSMutableArray *arrObjects=nil;
    NSMutableArray *arrKeys =nil;
    
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd-yyyy HH:mm:ss.SSS Z"];
    NSString *stringFromDate = [formatter stringFromDate:date];
    
    arrObjects= [[NSMutableArray alloc]initWithObjects:arrOPTLST,[ModelManager modelManager].loginManager.login.loginCode,stringFromDate,@"en",latitude,longitude,[GlobalClass getDeviceUUID], nil];
    
    arrKeys = [[ NSMutableArray alloc] initWithObjects:@"192",@"11",@"122.45",@"120.38",@"120.39",@"57",@"OPTLST", nil];
    
    
    NSMutableDictionary *dictFinal=[[NSMutableDictionary alloc]initWithObjects:arrObjects forKeys:arrKeys];
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictFinal
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    if (! jsonData) {
        
        
    } else {
        
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",jsonString);
        
    }
    
    
    return dictFinal;
}


// Convert Dic into Json

/*   NSError *error;
NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictFinal
                                                   options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                     error:&error];

if (! jsonData) {
    NSLog(@"Got an error: %@", error);
} else {
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@",jsonString);
}*/


@end
