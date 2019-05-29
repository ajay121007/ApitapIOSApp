//
//  ItemDetail.h
//  ApiTap
//
//  Created by Abhishek Singla on 17/06/16.
//  Copyright © 2016 ApiTap. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemDetail : BaseViewController <UIPickerViewDataSource, UIPickerViewDelegate, UIScrollViewDelegate>

@property (nonatomic,strong) NSArray *selectedItemURL;
@property (nonatomic,strong) NSString *productRating;
@property int getselctedItemTag;
@property BOOL getCheck, getAdsCheck,getStoreItemDetails,getAllItems;

@end
