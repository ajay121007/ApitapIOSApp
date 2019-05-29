//
//  ItemDetailsCell.h
//  ApiTap
//
//  Created by Bikramjeet Singh on 9/7/16.
//  Copyright © 2016 ApiTap. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemDetailsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *showMainItemImage;

@property (weak, nonatomic) IBOutlet UILabel *lblItemPrice;

@property (weak, nonatomic) IBOutlet UIButton *btnAddItemIntoFavourite;

@property (weak, nonatomic) IBOutlet UITableView *tlbMoreImages;

@property (weak, nonatomic) IBOutlet UIImageView *showMoreImages;

@property (strong,nonatomic) NSArray *data;

@end
