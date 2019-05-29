//
//  AddCartCell.h
//  addcartview
//
//  Created by Bikramjeet Singh on 6/23/16.
//  Copyright © 2016 Bikramjeet Singh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddCartCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblCircle;

@property (weak, nonatomic) IBOutlet UIButton *btnItemImage;

@property (weak, nonatomic) IBOutlet UILabel *lblShopingCartName;

@property (weak, nonatomic) IBOutlet UILabel *lblProductName;

@property (weak, nonatomic) IBOutlet UILabel *lblQuantity;

@property (weak, nonatomic) IBOutlet UIImageView *productImage;

@property (weak, nonatomic) IBOutlet UILabel *lblBy;

@property (weak, nonatomic) IBOutlet UILabel *lblProductPrice;

@property (weak, nonatomic) IBOutlet UIButton *btn_DeliveryOptions;

@property (weak, nonatomic) IBOutlet UIButton *btn_RemoveItem;


@end
