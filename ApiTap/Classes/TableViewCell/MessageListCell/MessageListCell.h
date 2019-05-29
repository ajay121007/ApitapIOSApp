//
//  MessageListCell.h
//  ApiTap
//
//  Created by deepraj on 9/22/16.
//  Copyright © 2016 ApiTap. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *personImage;

@property (weak, nonatomic) IBOutlet UILabel *messageTitleLable;

@property (weak, nonatomic) IBOutlet UILabel *datelable;

@property (weak, nonatomic) IBOutlet UILabel *messageLable;

@end
