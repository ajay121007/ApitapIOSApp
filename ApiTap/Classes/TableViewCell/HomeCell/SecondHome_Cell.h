//
//  SecondHome_Cell.h
//  ApiTap
//
//  Created by Bikramjeet Singh on 9/16/16.
//  Copyright © 2016 ApiTap. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondHome_Cell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblCategoryNumber;

@property (weak, nonatomic) IBOutlet UIButton *btnViewAllItems;

@property (weak, nonatomic) IBOutlet UICollectionView *imageCollectionView;

@end
