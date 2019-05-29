//
//  HistoryHeaderCell.h
//  ApiTap
//
//  Created by Bikramjeet Singh on 10/3/16.
//  Copyright © 2016 ApiTap. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryHeaderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblItemName;

@property (weak, nonatomic) IBOutlet UILabel *lblItemNumber;
@property (weak, nonatomic) IBOutlet UILabel *lblQuantity;

@property (weak, nonatomic) IBOutlet UILabel *lblItemPrice;


@end
