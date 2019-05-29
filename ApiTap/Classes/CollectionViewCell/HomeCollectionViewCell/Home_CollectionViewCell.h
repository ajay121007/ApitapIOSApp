//
//  Home_CollectionViewCell.h
//  ApiTap
//
//  Created by Bikramjeet Singh on 6/22/16.
//  Copyright © 2016 ApiTap. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Home_CollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIButton *btnShowCategory;
@property (weak, nonatomic) IBOutlet UILabel *addNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *addTitleLbl;

@property (weak, nonatomic) IBOutlet UIImageView *showImages;

@property (weak, nonatomic) IBOutlet UILabel *lblName;

@property (weak, nonatomic) IBOutlet UILabel *lblDiscription;

@property (weak, nonatomic) IBOutlet UILabel *lblItemPrice;

@property (weak, nonatomic) IBOutlet UILabel *lblItemSalePrice;

@property (weak, nonatomic) IBOutlet UILabel *lblCrossLine;

@property (weak, nonatomic) IBOutlet UIImageView *itemWatchedOrNotImageview;

@property (weak, nonatomic) IBOutlet UIView *fillBoarderWidth;

@property (weak, nonatomic) IBOutlet UIView *saleView;


@end
