//
//  HistoryDetailsVC.h
//  ApiTap
//
//  Created by Bikramjeet Singh on 9/29/16.
//  Copyright © 2016 ApiTap. All rights reserved.
//

#import "BaseViewController.h"

@interface HistoryDetailsVC : BaseViewController

@property(nonatomic,strong)NSArray *historyData;
@property (weak, nonatomic) IBOutlet UIView *viewForAlert;
@property (weak, nonatomic) IBOutlet UIView *mainSecondView;

@property (weak, nonatomic) IBOutlet UILabel *lblInvoiceNo;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;

//alert view

@property (weak, nonatomic) IBOutlet UITableView *tblViewSelectQuestion;

@property (weak, nonatomic) IBOutlet UITextField *textFieldInAlert;
@end
