//
//  ShowAlertView.h
//  LocalDelivery
//
//  Created by Bikramjeet Singh on 8/3/16.
//  Copyright © 2016 appzorro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowAlertView : UIAlertView

@property (copy, nonatomic) void (^completion)(BOOL, NSInteger);

- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles;


@end
