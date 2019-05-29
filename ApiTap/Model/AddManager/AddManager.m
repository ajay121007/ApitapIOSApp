//
//  AddManager.m
//  ApiTap
//
//  Created by Abhishek Singla on 11/08/16.
//  Copyright © 2016 ApiTap. All rights reserved.
//

#import "AddManager.h"

@implementation AddManager


- (id)init
{
    self = [super init];
    if (self)
    {
        self.arrAdvImages=[NSMutableArray new];
                
    }
    return self;
}

-(void)showAdds:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock {
    
    [self.arrAdvImages removeAllObjects];
    
    [RequestManager asynchronousRequestWithPath:@"" requestType:RequestTypePOST params:[GlobalClass callMainDict:serviceCodeID :dictParam] timeOut:200 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json,NSError *err)
     {
         
         if(statusCode==201)
         {
             
             NSArray *temp=json[@"RESULT"];
             
             completionBlock(temp,nil);
             

         }
         else
             completionBlock(nil,nil);
     } ];

    
}
-(void)addMessage:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock {
    
    [self.arrAdvImages removeAllObjects];
    
    [RequestManager asynchronousRequestWithPath:@"" requestType:RequestTypePOST params:[GlobalClass callMainDict:serviceCodeID :dictParam] timeOut:200 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json,NSError *err)
     {
         
         if(statusCode==201)
         {
             
             NSArray *temp=json[@"RESULT"];
             
             completionBlock(temp,nil);
             
             
         }
         else
             completionBlock(nil,nil);
     } ];
}
-(void)addEditRating:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock {
    
    [self.arrAdvImages removeAllObjects];
    
    [RequestManager asynchronousRequestWithPath:@"" requestType:RequestTypePOST params:[GlobalClass callMainDict:serviceCodeID :dictParam] timeOut:200 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json,NSError *err)
     {
         
         if(statusCode==201)
         {
             
             NSArray *temp=json[@"RESULT"];
             
             completionBlock(temp,nil);
             
             
         }
         else
             completionBlock(nil,nil);
     } ];
}

-(void)addSearchImages:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock {
    
    [self.arrAdvImages removeAllObjects];
    
    [RequestManager asynchronousRequestWithPath:@"" requestType:RequestTypePOST params:[GlobalClass callMainDict:serviceCodeID :dictParam] timeOut:200 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json,NSError *err)
     {
         
         if(statusCode==201)
         {
             
             NSArray *temp=json[@"RESULT"];
             
             completionBlock(temp,nil);
             
             
         }
         else
             completionBlock(nil,nil);
     } ];
}

-(void)getStoreDetail:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock {
    
    [self.arrAdvImages removeAllObjects];
    
    [RequestManager asynchronousRequestWithPath:@"" requestType:RequestTypePOST params:[GlobalClass callMainDict:serviceCodeID :dictParam] timeOut:200 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json,NSError *err)
     {
         
         if(statusCode==201)
         {
             
             NSArray *temp=json[@"RESULT"];
             
             completionBlock(temp,nil);
             
             
         }
         else
             completionBlock(nil,nil);
     } ];
}
-(void)getAddFav:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock {
    
    [self.arrAdvImages removeAllObjects];
    
    [RequestManager asynchronousRequestWithPath:@"" requestType:RequestTypePOST params:[GlobalClass callMainDict:serviceCodeID :dictParam] timeOut:200 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json,NSError *err)
     {
         
         if(statusCode==201)
         {
             
             NSArray *temp=json[@"RESULT"];
             
             completionBlock(temp,nil);
             
             
         }
         else
             completionBlock(nil,nil);
     } ];
}
-(void)addsItem:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock {
    
    [self.arrAdvImages removeAllObjects];
    
    [RequestManager asynchronousRequestWithPath:@"" requestType:RequestTypePOST params:[GlobalClass callMainDict:serviceCodeID :dictParam] timeOut:200 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json,NSError *err)
     {
         
         if(statusCode==201)
         {
             
             NSArray *temp=json[@"RESULT"];
             
             completionBlock(temp,nil);
             
             
         }
         else
             completionBlock(nil,nil);
     } ];
}
-(void)removeProduct:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock {
    
    [self.arrAdvImages removeAllObjects];
    
    [RequestManager asynchronousRequestWithPath:@"" requestType:RequestTypePOST params:[GlobalClass callMainDict:serviceCodeID :dictParam] timeOut:200 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json,NSError *err)
     {
         
         if(statusCode==201)
         {
             
             NSArray *temp=json[@"RESULT"];
             
             completionBlock(temp,nil);
             
             
         }
         else
             completionBlock(nil,nil);
     } ];
}
-(void)searchFav:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock {
    
    [self.arrAdvImages removeAllObjects];
    
    [RequestManager asynchronousRequestWithPath:@"" requestType:RequestTypePOST params:[GlobalClass callMainDict:serviceCodeID :dictParam] timeOut:200 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json,NSError *err)
     {
         
         if(statusCode==201)
         {
             
             NSArray *temp=json[@"RESULT"];
             
             completionBlock(temp,nil);
             
             
         }
         else
             completionBlock(nil,nil);
     } ];
}
-(void)searchNearby:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock {
    
    [self.arrAdvImages removeAllObjects];
    
    [RequestManager asynchronousRequestWithPath:@"" requestType:RequestTypePOST params:[GlobalClass callMainDict:serviceCodeID :dictParam] timeOut:200 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json,NSError *err)
     {
         
         if(statusCode==201)
         {
             
             NSArray *temp=json[@"RESULT"];
             
             completionBlock(temp,nil);
             
             
         }
         else
             completionBlock(nil,nil);
     } ];
}
-(void)searchMessages:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock {
    
    [self.arrAdvImages removeAllObjects];
    
    [RequestManager asynchronousRequestWithPath:@"" requestType:RequestTypePOST params:[GlobalClass callMsgDict:serviceCodeID :dictParam] timeOut:200 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json,NSError *err)
     {
         
         if(statusCode==201)
         {
             
             NSArray *temp=json[@"RESULT"];
             
             completionBlock(temp,nil);
             
             
         }
         else
             completionBlock(nil,nil);
     } ];
}

-(void)getRatingWithDesc:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock {
    
    [self.arrAdvImages removeAllObjects];
    
    [RequestManager asynchronousRequestWithPath:@"" requestType:RequestTypePOST params:[GlobalClass callRatingLists:serviceCodeID :dictParam] timeOut:200 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json,NSError *err)
     {
         
         if(statusCode==201)
         {
             
             NSArray *temp=json[@"RESULT"];
             
             completionBlock(temp,nil);
             
             
         }
         else
             completionBlock(nil,nil);
     } ];
}
-(void)callMainDictForHistory:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock {
    
    [self.arrAdvImages removeAllObjects];
    
    [RequestManager asynchronousRequestWithPath:@"" requestType:RequestTypePOST params:[GlobalClass callMainDictForHistory:serviceCodeID :dictParam] timeOut:200 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json,NSError *err)
     {
         
         if(statusCode==201)
         {
             
             NSArray *temp=json[@"RESULT"];
             
             completionBlock(temp,nil);
             
             
         }
         else
             completionBlock(nil,nil);
     } ];
}
-(void)getMsgReply:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam userinfo2:(NSDictionary *)dictParam2 completionResponse:(void (^)(NSArray *, NSError *))completionBlock {
//-(void)getMsgReply:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam userinfo:(NSMutableArray *)dictParam2 completionResponse:(void (^)(NSArray *, NSError *))completionBlock {
    
    [self.arrAdvImages removeAllObjects];
    
    [RequestManager asynchronousRequestWithPath:@"" requestType:RequestTypePOST params:[GlobalClass getMsgReply:serviceCodeID :dictParam:dictParam2] timeOut:200 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json,NSError *err)
     {
         
         if(statusCode==201)
         {
             
             NSArray *temp=json[@"RESULT"];
             
             completionBlock(temp,nil);
             
             
         }
         else
             completionBlock(nil,nil);
     } ];
}
-(void)chatDetails:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock {
    
    [self.arrAdvImages removeAllObjects];
    
    [RequestManager asynchronousRequestWithPath:@"" requestType:RequestTypePOST params:[GlobalClass callStoreDict:serviceCodeID :dictParam] timeOut:200 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json,NSError *err)
     {
         
         if(statusCode==201)
         {
             
             NSArray *temp=json[@"RESULT"];
             
             completionBlock(temp,nil);
             
             
         }
         else
             completionBlock(nil,nil);
     } ];
}
-(void)getStoreSpecialsDetails:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock {
    
    [self.arrAdvImages removeAllObjects];
    
    [RequestManager asynchronousRequestWithPath:@"" requestType:RequestTypePOST params:[GlobalClass callStoreDict:serviceCodeID :dictParam] timeOut:200 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json,NSError *err)
     {
         
         if(statusCode==201)
         {
             
             NSArray *temp=json[@"RESULT"];
             
             completionBlock(temp,nil);
             
             
         }
         else
             completionBlock(nil,nil);
     } ];
}
-(void)storeDetailAdds:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock {
    
    [self.arrAdvImages removeAllObjects];
    
    [RequestManager asynchronousRequestWithPath:@"" requestType:RequestTypePOST params:[GlobalClass callStoreDetailsDict:serviceCodeID :dictParam] timeOut:200 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json,NSError *err)
     {
         
         if(statusCode==201)
         {
             
             NSArray *temp=json[@"RESULT"];
             
             completionBlock(temp,nil);
             
             
         }
         else
             completionBlock(nil,nil);
     } ];
}
-(void)getItemInvoiceDict:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock {
    
    [self.arrAdvImages removeAllObjects];
    
    [RequestManager asynchronousRequestWithPath:@"" requestType:RequestTypePOST params:[GlobalClass callMainDict:serviceCodeID :dictParam] timeOut:200 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json,NSError *err)
     {
         
         if(statusCode==201)
         {
             
             NSArray *temp=json[@"RESULT"];
             
             completionBlock(temp,nil);
             
             
         }
         else
             completionBlock(nil,nil);
     } ];
}

-(void)getItemDetail:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock {
    
    [self.arrAdvImages removeAllObjects];
    
    [RequestManager asynchronousRequestWithPath:@"" requestType:RequestTypePOST params:[GlobalClass callMainDict:serviceCodeID :dictParam] timeOut:200 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json,NSError *err)
     {
         
         if(statusCode==201)
         {
             
             NSArray *temp=json[@"RESULT"];
             
             completionBlock(temp,nil);
             
             
         }
         else
             completionBlock(nil,nil);
     } ];
}
-(void)getMap:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock {
    
    [self.arrAdvImages removeAllObjects];
    
    [RequestManager asynchronousRequestWithPath:@"" requestType:RequestTypePOST params:[GlobalClass callMainDict:serviceCodeID :dictParam] timeOut:200 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json,NSError *err)
     {
         
         if(statusCode==201)
         {
             
             NSArray *temp=json[@"RESULT"];
             
             completionBlock(temp,nil);
             
             
         }
         else
             completionBlock(nil,nil);
     } ];
}
-(void)getInvoice:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock {
    
    [self.arrAdvImages removeAllObjects];
    
    [RequestManager asynchronousRequestWithPath:@"" requestType:RequestTypePOST params:[GlobalClass callInvoiceDict:serviceCodeID :dictParam] timeOut:200 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json,NSError *err)
     {
         
         if(statusCode==201)
         {
             
             NSArray *temp=json[@"RESULT"];
             
             completionBlock(temp,nil);
             
             
         }
         else
             completionBlock(nil,nil);
     } ];
}
-(void)getChoicesByOption:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock {
    
    [self.arrAdvImages removeAllObjects];
    
    [RequestManager asynchronousRequestWithPath:@"" requestType:RequestTypePOST params:[GlobalClass callMainDict:serviceCodeID :dictParam] timeOut:200 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json,NSError *err)
     {
         
         if(statusCode==201)
         {
             
             NSArray *temp=json[@"RESULT"];
             
             completionBlock(temp,nil);
             
             
         }
         else
             completionBlock(nil,nil);
     } ];
}
-(void)getOptionsByItem:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock {
    
    [self.arrAdvImages removeAllObjects];
    
    [RequestManager asynchronousRequestWithPath:@"" requestType:RequestTypePOST params:[GlobalClass callMainDict:serviceCodeID :dictParam] timeOut:200 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json,NSError *err)
     {
         
         if(statusCode==201)
         {
             
             NSArray *temp=json[@"RESULT"];
             
             completionBlock(temp,nil);
             
             
         }
         else
             completionBlock(nil,nil);
     } ];
}
-(void)getPaymentJsonArray:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock {
    
    [self.arrAdvImages removeAllObjects];
    
    [RequestManager asynchronousRequestWithPath:@"" requestType:RequestTypePOST params:[GlobalClass callMainDict:serviceCodeID :dictParam] timeOut:200 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json,NSError *err)
     {
         
         if(statusCode==201)
         {
             
             NSArray *temp=json[@"RESULT"];
             
             completionBlock(temp,nil);
             
             
         }
         else
             completionBlock(nil,nil);
     } ];
}
-(void)getDeleiveryMethod:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock {
    
    [self.arrAdvImages removeAllObjects];
    
    [RequestManager asynchronousRequestWithPath:@"" requestType:RequestTypePOST params:[GlobalClass callMainDict:serviceCodeID :dictParam] timeOut:200 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json,NSError *err)
     {
         
         if(statusCode==201)
         {
             
             NSArray *temp=json[@"RESULT"];
             
             completionBlock(temp,nil);
             
             
         }
         else
             completionBlock(nil,nil);
     } ];
}

-(void)getShipping:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock {
    
    [self.arrAdvImages removeAllObjects];
    
    [RequestManager asynchronousRequestWithPath:@"" requestType:RequestTypePOST params:[GlobalClass callMainDict:serviceCodeID :dictParam] timeOut:200 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json,NSError *err)
     {
         
         if(statusCode==201)
         {
             
             NSArray *temp=json[@"RESULT"];
             
             completionBlock(temp,nil);
             
             
         }
         else
             completionBlock(nil,nil);
     } ];
}
-(void)getShoppingCartsItem:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam userinfo2:(NSDictionary *)dictParam2 completionResponse:(void (^)(NSArray *, NSError *))completionBlock {
    
    [self.arrAdvImages removeAllObjects];
    
    [RequestManager asynchronousRequestWithPath:@"" requestType:RequestTypePOST params:[GlobalClass callCheckOutDict:serviceCodeID :dictParam:dictParam2] timeOut:200 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json,NSError *err)
     {
         
         if(statusCode==201)
         {
             
             NSArray *temp=json[@"RESULT"];
             
             completionBlock(temp,nil);
             
             
         }
         else
             completionBlock(nil,nil);
     } ];
}
-(void)getShoppingCarts:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock {
    
    [self.arrAdvImages removeAllObjects];
    
    [RequestManager asynchronousRequestWithPath:@"" requestType:RequestTypePOST params:[GlobalClass callMainDict:serviceCodeID :dictParam] timeOut:200 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json,NSError *err)
     {
         
         if(statusCode==201)
         {
             
             NSArray *temp=json[@"RESULT"];
             
             completionBlock(temp,nil);
             
             
         }
         else
             completionBlock(nil,nil);
     } ];
}
-(void)getCard:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock {
    
    [self.arrAdvImages removeAllObjects];
    
    [RequestManager asynchronousRequestWithPath:@"" requestType:RequestTypePOST params:[GlobalClass callMainDict:serviceCodeID :dictParam] timeOut:200 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json,NSError *err)
     {
         
         if(statusCode==201)
         {
             
             NSArray *temp=json[@"RESULT"];
             
             completionBlock(temp,nil);
             
             
         }
         else
             completionBlock(nil,nil);
     } ];
}

-(void)getPayment:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock {
    
    [self.arrAdvImages removeAllObjects];
    
    [RequestManager asynchronousRequestWithPath:@"" requestType:RequestTypePOST params:[GlobalClass callMainDict:serviceCodeID :dictParam] timeOut:200 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json,NSError *err)
     {
         
         if(statusCode==201)
         {
             
             NSArray *temp=json[@"RESULT"];
             
             completionBlock(temp,nil);
             
             
         }
         else
             completionBlock(nil,nil);
     } ];
}
-(void)productAndServiceImages:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock {
    
    [self.arrAdvImages removeAllObjects];
    
    [RequestManager asynchronousRequestWithPath:@"" requestType:RequestTypePOST params:[GlobalClass callMainDict:serviceCodeID :dictParam] timeOut:200 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json,NSError *err)
     {
         
         if(statusCode==201)
         {
             
             NSArray *temp=json[@"RESULT"];
             
             completionBlock(temp,nil);
             
             
         }
         else
             completionBlock(nil,nil);
     } ];
}
-(void)offerSearchImages:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock {
    
    [self.arrAdvImages removeAllObjects];
    
    [RequestManager asynchronousRequestWithPath:@"" requestType:RequestTypePOST params:[GlobalClass callMainDict:serviceCodeID :dictParam] timeOut:200 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json,NSError *err)
     {
         
         if(statusCode==201)
         {
             
             NSArray *temp=json[@"RESULT"];
             
             completionBlock(temp,nil);
             
             
         }
         else
             completionBlock(nil,nil);
     } ];
}
-(void)getItemRating:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock {
    
    [self.arrAdvImages removeAllObjects];
    
    [RequestManager asynchronousRequestWithPath:@"" requestType:RequestTypePOST params:[GlobalClass callMainDict:serviceCodeID :dictParam] timeOut:200 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json,NSError *err)
     {
         
         if(statusCode==201)
         {
             
             NSArray *temp=json[@"RESULT"];
             
             completionBlock(temp,nil);
             
             
         }
         else
             completionBlock(nil,nil);
     } ];
}

// Call Home WebServices

-(void)addItemFav :(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock {
    
    [RequestManager asynchronousRequestWithPath:@"" requestType:RequestTypePOST params:[GlobalClass callHomeDictForItems:serviceCodeID :dictParam] timeOut:200 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json,NSError *err)
     {
         
         if(statusCode==201)
         {
             
             NSArray *temp=json[@"RESULT"];
             
             completionBlock(temp,nil);
         }
         else
             completionBlock(nil,nil);
     } ];
    
}

-(void)callHomeWebService :(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock {
    
    [RequestManager asynchronousRequestWithPath:@"" requestType:RequestTypePOST params:[GlobalClass callHomeDictForItems:serviceCodeID :dictParam] timeOut:200 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json,NSError *err)
     {
         
         if(statusCode==201)
         {
             
             NSArray *temp=json[@"RESULT"];
             
             completionBlock(temp,nil);
         }
         else
             completionBlock(nil,nil);
     } ];
    
}



-(void)getItemsSpecialsByCategoryMobile :(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock {
    
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

// Add Item Into Cart

-(void)addItemIntoCart :(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock {
    
    [RequestManager asynchronousRequestWithPath:@"" requestType:RequestTypePOST params:[GlobalClass callMainDictForAddItemIntoCart:serviceCodeID :dictParam] timeOut:200 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json,NSError *err)
     {
         
         if(statusCode==201)
         {
             NSLog(@"%@",json);
             
             NSArray *temp=json[@"RESULT"][0][@"RESULT"];
             
             completionBlock(temp,nil);
         }
         else
             completionBlock(nil,nil);
     } ];
    
}


-(void)getItemsOfShoppingCartById :(NSString *)serviceCodeID filterData: (NSString *)filterData userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock {
    
    [RequestManager asynchronousRequestWithPath:@"" requestType:RequestTypePOST params:[GlobalClass getItemsOfShoppingCartByIDDict:serviceCodeID filterData:filterData :dictParam] timeOut:200 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json,NSError *err)
     {
         
         if(statusCode==201)
         {
             
             NSArray *temp=json[@"RESULT"][0][@"RESULT"];
             
             NSLog(@"%@",temp);
             
             completionBlock(temp,nil);
         }
         else
             completionBlock(nil,nil);
     } ];
}

-(void)showAllCategoriesName:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock {
    
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

//// Item Details Manager

-(void)getItemDetails:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock {
    
    [RequestManager asynchronousRequestWithPath:@"" requestType:RequestTypePOST params:[GlobalClass callMainDictForItems:serviceCodeID :dictParam] timeOut:200 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json,NSError *err)
     {
         
         if(statusCode==201)
         {
             NSLog(@"%@",json);
             
             
             NSArray *temp=json[@"RESULT"][0][@"RESULT"];
             
             completionBlock(temp,nil);
         }
         else
             completionBlock(nil,nil);
     } ];

    
}


-(void)getAlsoViewedItems:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock {
    
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
-(void)getRelatedItems:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock {
    
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

-(void)addProductWatchedByUser:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock {
    
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

-(void)addFavoriteItem:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock {
    
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

-(void)addItemsIntoCarts:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock {
    
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
-(void)getOptionsByItemId:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock {
    
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
-(void)getFavoriteItem:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock {
    
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
-(void)addFavoriteItemMobile:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock {
    
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

-(void)removeFavoriteItemMobile:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock {
    
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

-(void)searchCurrentLocation:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock {
    
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

-(void)getEye:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock {
    
    [self.arrAdvImages removeAllObjects];
    
    [RequestManager asynchronousRequestWithPath:@"" requestType:RequestTypePOST params:[GlobalClass callMainDictForMessageLists:serviceCodeID :dictParam] timeOut:200 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json,NSError *err)
     {
         
         if(statusCode==201)
         {
             
             NSArray *temp=json[@"RESULT"];
             
             completionBlock(temp,nil);
             
             
         }
         else
             completionBlock(nil,nil);
     } ];
    
    
}
-(void)getHistoryData:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock {
    
    [self.arrAdvImages removeAllObjects];
    
    [RequestManager asynchronousRequestWithPath:@"" requestType:RequestTypePOST params:[GlobalClass callMainDictForMessageLists:serviceCodeID :dictParam] timeOut:200 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json,NSError *err)
     {
         
         if(statusCode==201)
         {
             
             NSArray *temp=json[@"RESULT"];
             
             completionBlock(temp,nil);
             
            
         }
         else
             completionBlock(nil,nil);
     } ];
    
    
}

-(void)getMessageData:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock {
    
    [self.arrAdvImages removeAllObjects];
    
    [RequestManager asynchronousRequestWithPath:@"" requestType:RequestTypePOST params:[GlobalClass callMainDictForHistory:serviceCodeID :dictParam] timeOut:200 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json,NSError *err)
     {
         
         if(statusCode==201)
         {
             
             NSArray *temp=json[@"RESULT"];
             
             completionBlock(temp,nil);
             
             
         }
         else
             completionBlock(nil,nil);
     } ];
    
    
}

// Get Map Data

-(void)showMapDetails:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock {
    
    [self.arrAdvImages removeAllObjects];
    
    [RequestManager asynchronousRequestWithPath:kRequestSignUp requestType:RequestTypePOST params:[GlobalClass callMapDicts:serviceCodeID :dictParam] timeOut:200 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json,NSError *err)
     {
                  
         if(statusCode==201)
         {
             
             NSArray *temp=json[@"RESULT"];
             
             completionBlock(temp,nil);
        
         }
         else
             completionBlock(nil,nil);
     } ];
    
    
}



-(void)setTokenForPayment:(NSString *)serviceCodeID userinfo:(NSDictionary *)dictParam completionResponse:(void (^)(NSArray *, NSError *))completionBlock {
    
    [self.arrAdvImages removeAllObjects];
    
    [RequestManager asynchronousRequestWithPath2:serviceCodeID requestType:RequestTypePOST params:dictParam timeOut:200 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json,NSError *err)
     {
         
         if(statusCode==201)
         {
             
             NSArray *temp=json[@"RESULT"];
             
             completionBlock(temp,nil);
             
             
         }
         else
             completionBlock(nil,nil);
     } ];
    
    
}



@end
