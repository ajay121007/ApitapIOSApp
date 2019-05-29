//
//  ShopingCartsCell.h
//  ApiTap
//
//  Created by Bikramjeet Singh on 9/12/16.
//  Copyright © 2016 ApiTap. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopingCartsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *shopingCartImage;

@property (weak, nonatomic) IBOutlet UIButton *checkOutBtn;
@property (weak, nonatomic) IBOutlet UILabel *lblShopingCartName;

@property (weak, nonatomic) IBOutlet UIButton *btnDelete;
@property (weak, nonatomic) IBOutlet UILabel *lastAddedlbl;
@property (weak, nonatomic) IBOutlet UILabel *expiringItemlbl;

@end
