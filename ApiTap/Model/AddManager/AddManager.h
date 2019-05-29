//
//  AddManager.h
//  ApiTap
//
//  Created by Abhishek Singla on 11/08/16.
//  Copyright © 2016 ApiTap. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestManager.h"

@interface AddManager : NSObject

@property (nonatomic,strong)NSMutableArray *arrAdvImages;


-(void)showAdds:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock;

-(void)getItemsSpecialsByCategoryMobile :(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock;

-(void)showAllCategoriesName:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock;

// Get Item Details Manager

-(void)getItemDetails:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock;

-(void)getRelatedItems:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock;
-(void)getAlsoViewedItems:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock;

-(void)addProductWatchedByUser:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock;
-(void)getFavoriteItem:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock;

-(void)getOptionsByItemId:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock;
-(void)addItemsIntoCarts:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock;
-(void)addFavoriteItem:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock;
-(void)addFavoriteItemMobile:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock;

-(void)removeFavoriteItemMobile:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock;
-(void)searchCurrentLocation:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock;


// Add Item Into Cart

-(void)addItemIntoCart :(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock;

-(void)getItemsOfShoppingCartById :(NSString *)serviceCodeID filterData: (NSString *)filterData userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock;

-(void)callHomeWebService :(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock;

-(void)addItemFav :(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock;


// Get History Data

-(void)getHistoryData:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock;

-(void)getEye:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock;

// Get Message Lists

-(void)getMessageData:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock;

// Show Map Details

-(void)showMapDetails:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock;

// Payment

-(void)setTokenForPayment:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBloc;

-(void)getItemRating:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBloc;

-(void)addSearchImages:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBloc;



-(void)addEditRating:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBloc;

-(void)addMessage:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBloc;

-(void)offerSearchImages:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBloc;



-(void)productAndServiceImages:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBloc;

-(void)getPayment:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBloc;

-(void)getCard:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBloc;

-(void)getShoppingCarts:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBloc;

-(void)getShoppingCartsItem:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam userinfo2:(NSDictionary *)dictParam2 completionResponse:(void (^)(NSArray *, NSError *))completionBloc;

-(void)getShipping:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBloc;

-(void)getDeleiveryMethod:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBloc;

-(void)getPaymentJsonArray:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBloc;

-(void)getOptionsByItem:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBloc;
-(void)getChoicesByOption:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBloc;

-(void)getInvoice:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBloc;

-(void)getMap:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBloc;
-(void)getItemDetail:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBloc;

-(void)getItemInvoiceDict:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBloc;
-(void)searchMessages:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBloc;

-(void)searchNearby:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBloc;

-(void)searchFav:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBloc;

-(void)removeProduct:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBloc;

-(void)addsItem:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBloc;

-(void)getAddFav:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBloc;

-(void)getStoreDetail:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBloc;
-(void)storeDetailAdds:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBloc;

-(void)getStoreSpecialsDetails:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBloc;
-(void)chatDetails:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBloc;

-(void)getMsgReply:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam userinfo2:(NSMutableArray *)dictParam2 completionResponse:(void (^)(NSArray *, NSError *))completionBloc;
-(void)callMainDictForHistory:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBloc;

-(void)getRatingWithDesc:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBloc;
@end
