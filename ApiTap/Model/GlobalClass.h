//
//  GlobalClass.h
//  ApiTap
//
//  Created by Bikramjeet Singh on 8/5/16.
//  Copyright © 2016 ApiTap. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalClass : NSObject

+(NSDictionary *)callRatingLists : (NSString *)serviceCodeID : (NSDictionary *)appenddict;
+(NSDictionary *)getMsgReply : (NSString *)serviceCodeID : (NSDictionary *)appenddict : (NSDictionary *)appenddict2;

+(NSDictionary *)callInvoiceDict :(NSString *)serviceCodeID :(NSDictionary *)appenddict;
+(NSDictionary *)callMainDict :(NSString *)serviceCodeID :(NSDictionary *)appenddict;

+(NSDictionary *)callStoreDict : (NSString *)serviceCodeID : (NSDictionary *)appenddict;
+(NSDictionary *)callMainDictForItems : (NSString *)serviceCodeID : (NSDictionary *)appenddict;
+(NSDictionary *)callCheckOutDict : (NSString *)serviceCodeID : (NSDictionary *)appenddict : (NSDictionary *)appenddict2;

+(NSDictionary *)callStoreDetailsDict : (NSString *)serviceCodeID : (NSDictionary *)appenddict;
+(NSDictionary *)callMsgDict : (NSString *)serviceCodeID : (NSDictionary *)appenddict;
+(NSDictionary *)callCountryStateCityList : (NSString *)serviceCodeID : (NSDictionary *)appenddict;

+(NSDictionary *)callMainDictForAddItemIntoCart : (NSString *)serviceCodeID : (NSDictionary *)appenddict;

+(NSDictionary *)getItemsOfShoppingCartByIDDict : (NSString *)serviceCodeID filterData : (NSString *)filterData : (NSDictionary *)appenddict;
+(NSDictionary *)callMainDictForHistory : (NSString *)serviceCodeID : (NSDictionary *)appenddict;

+(NSDictionary *)callHomeDictForItems : (NSString *)serviceCodeID : (NSDictionary *)appenddict;

+(NSDictionary *)callMainDictForMessageLists : (NSString *)serviceCodeID : (NSDictionary *)appenddict;

+(NSDictionary *)callMapDicts : (NSString *)serviceCodeID : (NSDictionary *)appenddict;
    
+(NSString *)getDeviceUUID;

+(NSString *)makeElevenDigitNumber : (NSString *)number;

+(NSDictionary *)callPaymentDict : (NSString *)serviceCodeID : (NSDictionary *)appenddict;

@end
