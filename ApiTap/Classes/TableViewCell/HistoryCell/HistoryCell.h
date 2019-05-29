//
//  HistoryCell.h
//  ApiTap
//
//  Created by Bikramjeet Singh on 9/28/16.
//  Copyright © 2016 ApiTap. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblDate;

@property (weak, nonatomic) IBOutlet UILabel *lblStoreName;

@property (weak, nonatomic) IBOutlet UILabel *lblInvoiceNumber;

@property (weak, nonatomic) IBOutlet UILabel *lblAmount;


@property (weak, nonatomic) IBOutlet UILabel *lblcell2;

@property (weak, nonatomic) IBOutlet UILabel *lblsecondone;

// Total Cell Outlets
@property (weak, nonatomic) IBOutlet UILabel *lblSubTotal;

@property (weak, nonatomic) IBOutlet UILabel *lblTaxes;

@property (weak, nonatomic) IBOutlet UILabel *lblTip;

@property (weak, nonatomic) IBOutlet UILabel *lblTotal;

// Purchase Option
@property (weak, nonatomic) IBOutlet UILabel *lblPurchaseAccount;

@property (weak, nonatomic) IBOutlet UILabel *lblDeliveryMthd;

@property (weak, nonatomic) IBOutlet UILabel *lblDeliveryAddress;

@property (weak, nonatomic) IBOutlet UILabel *lblTips;

@property (weak, nonatomic) IBOutlet UILabel *lblAlert;
@property (weak, nonatomic) IBOutlet UILabel *lblQty;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;

@end
