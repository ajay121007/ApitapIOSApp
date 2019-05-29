//
//  SavedAddressCell.h
//  addcartview
//
//  Created by Bikramjeet Singh on 6/27/16.
//  Copyright © 2016 Bikramjeet Singh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SavedAddressCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblPersonName;

@property (weak, nonatomic) IBOutlet UILabel *lblAddressType;

@property (weak, nonatomic) IBOutlet UILabel *lblFirstAddress;

@property (weak, nonatomic) IBOutlet UILabel *lblSecondAddress;

@property (weak, nonatomic) IBOutlet UILabel *lblCity;

@property (weak, nonatomic) IBOutlet UILabel *lblState;

@property (weak, nonatomic) IBOutlet UILabel *lblPinCode;

@property (weak, nonatomic) IBOutlet UILabel *lblPhoneNumber;

@property (weak, nonatomic) IBOutlet UIButton *btnEdit;

@property (weak, nonatomic) IBOutlet UIButton *btnRemove;


@end
