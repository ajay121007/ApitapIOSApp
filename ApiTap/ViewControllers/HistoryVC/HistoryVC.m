//
//  HistoryVC.m
//  ApiTap
//
//  Created by Bikramjeet Singh on 9/27/16.
//  Copyright © 2016 ApiTap. All rights reserved.
//

#import "HistoryVC.h"
#import "HistoryDetailsVC.h"
#import "HistoryCell.h"
#import "SVProgressHUD.h"

@interface HistoryVC () {
    
     NSMutableArray *arrFinalData;
}

@property (weak, nonatomic) IBOutlet UITableView *tblHistory;

@end

@implementation HistoryVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initializeNavBar];
    
    [self setbarButtonItems];
    
    
    
    self.automaticallyAdjustsScrollViewInsets=NO;

    [self getPlaylistBroadcastMobile];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    self.navigationItem.title=@"History";
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:YES];
    
    self.navigationItem.title=@"";
}

-(void)getPlaylistBroadcastMobile{
    
    
    if (![self checkInternetConeection]) {
        
        return;
    }

   // [SVProgressHUD showWithStatus:@"Loding....."];
    
    NSMutableDictionary *dictParam = [NSMutableDictionary new];
    
    [dictParam setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"loginUserID"] forKey:@"53"];
    
//    [model_manager.addManager getHistoryData:@"010100206" userinfo:dictParam completionResponse:^(NSArray *arrImages, NSError *error)
//     {
//         [SVProgressHUD dismiss];
//         
//         if (!error)
//         {             
//             arrFinalData=[NSMutableArray new];
//             
//             [arrFinalData addObjectsFromArray:[arrImages objectAtIndex:0][@"RESULT"]];
//             
//             if(arrFinalData.count ==0){
//                 
//                 [self.tblHistory reloadData];
//                 
//             }else {
//                 
//                 
//                 
//                 [self.tblHistory reloadData];
//             }
//         }
//         
//         
//         
//     }];

}

#pragma mark UITableViewDelegateMethod

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return arrFinalData.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.tblHistory.estimatedRowHeight = 60.0;
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"HistoryCell";
    
    HistoryCell *cell = (HistoryCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSString *date1=arrFinalData[indexPath.row][@"_120_31"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:date1];
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd MMM yyyy"];
    
    NSString *convertedString = [dateFormatter stringFromDate:date];
    
    cell.lblDate.text=convertedString;
    cell.lblStoreName.text=arrFinalData[indexPath.row][@"_114_70"];
    cell.lblInvoiceNumber.text=arrFinalData[indexPath.row][@"_121_41"];
    cell.lblAmount.text=arrFinalData[indexPath.row][@"_55_3"];
    
    return cell;
}
- (void)tableView:(UITableView *)TableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![self checkInternetConeection]) {
        
        return;
    }
    [self performSegueWithIdentifier:@"goto_history_details_vc" sender:arrFinalData[indexPath.row]];
    NSDictionary *value = [NSDictionary alloc];
    value = arrFinalData[indexPath.row];
        
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  
    if ([[segue identifier] isEqualToString:@"goto_history_details_vc"])
    {
                
        HistoryDetailsVC *vc = [segue destinationViewController];
        vc.historyData=sender;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
