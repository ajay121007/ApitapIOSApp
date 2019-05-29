//
//  ViewAllItemsVC.h
//  ApiTap
//
//  Created by Bikramjeet Singh on 9/23/16.
//  Copyright © 2016 ApiTap. All rights reserved.
//

#import "BaseViewController.h"

@interface ViewAllItemsVC : BaseViewController

@property (nonatomic,strong) NSArray *arrGetPreviousViewData;
@property (nonatomic,strong) NSString *cateGaryName;
@property BOOL checkForAds;
@property BOOL checkForCategories;
@property BOOL checkForAllStoreItems;

@end
