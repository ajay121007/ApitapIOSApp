//
//  WishListCell.h
//  ApiTap
//
//  Created by Bikramjeet Singh on 8/25/16.
//  Copyright © 2016 ApiTap. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WishListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblItemName;

@property (weak, nonatomic) IBOutlet UILabel *lblItemBy;

@property (weak, nonatomic) IBOutlet UIImageView *showItemImage;

@property (weak, nonatomic) IBOutlet UILabel *lblItemPrice;

@property (weak, nonatomic) IBOutlet UIButton *btnAdd;

@property (weak, nonatomic) IBOutlet UIButton *btnRemove;

@end
