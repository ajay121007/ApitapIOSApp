//
//  MessageListVC.m
//  ApiTap
//
//  Created by deepraj on 9/22/16.
//  Copyright © 2016 ApiTap. All rights reserved.
//

#import "MessageListVC.h"
#import "MessageListCell.h"
#import "SVProgressHUD.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MessageListVC () {
    
    NSMutableArray *arrFinalData;
}

@end

@implementation MessageListVC

- (void)viewDidLoad {

    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    [self initializeNavBar];
    
    [self setbarButtonItems];
    
    [self getPlaylistBroadcastMobile];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    self.navigationItem.title=@"Messages";
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:YES];
    
    self.navigationItem.title=@"";
}

-(void)navigationBarTitle:(NSString*)title
{
    UILabel *lblTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 12, self.view.frame.size.width, 25)];
    lblTitle.text = title;
    lblTitle.textAlignment = NSTextAlignmentCenter;
    lblTitle.textColor = [UIColor whiteColor];
    lblTitle.backgroundColor = [UIColor clearColor];
    [self.view addSubview:lblTitle];
}

-(void)setbarButtonItems
{
    
    UIImage *sliderImage = [[UIImage imageNamed:@"slider"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem *btnLeftMenu = [[UIBarButtonItem alloc] initWithImage:sliderImage style:UIBarButtonItemStylePlain target:self action:@selector(clk_btnLeftMenu:)];
    
    
    UIImage *scanImage = [[UIImage imageNamed:@"scan"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem *btnQRCode = [[UIBarButtonItem alloc] initWithImage:scanImage style:UIBarButtonItemStylePlain target:self action:@selector(clk_btnQRCode:)];
    
    
    self.navigationItem.leftBarButtonItems = @[btnLeftMenu,btnQRCode];
    
    /* Image in navigationBar */
    
    UIImage * logoInNavigationBar = [UIImage imageNamed:@"01_logo.png"];
    UIImageView * logoView = [[UIImageView alloc] init];
    [logoView setImage:logoInNavigationBar];
    self.navigationController.navigationItem.titleView = logoView;
    
    /* Right Bar Buttons */
    
    UIImage *messageImage = [[UIImage imageNamed:@"email"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem *btnMessage = [[UIBarButtonItem alloc] initWithImage:messageImage style:UIBarButtonItemStylePlain target:self action:@selector(clk_btnMessage:)];
    
    UIImage *searchrImage = [[UIImage imageNamed:@"search"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem *btnSearch = [[UIBarButtonItem alloc] initWithImage:searchrImage style:UIBarButtonItemStylePlain target:self action:@selector(clk_btnSearch:)];
    
    
    self.navigationItem.rightBarButtonItems = @[btnSearch];
    
}


-(void)getPlaylistBroadcastMobile{
    if (![self checkInternetConeection]) {
        
        return;
    }

    [SVProgressHUD showWithStatus:@"Loding....."];
    
    NSMutableDictionary *dictParam = [NSMutableDictionary new];
    
    [dictParam setValue:@"true" forKey:@"114.9"];
    
    [model_manager.addManager getHistoryData:@"010100209" userinfo:dictParam completionResponse:^(NSArray *arrImages, NSError *error)
     {         [SVProgressHUD dismiss];
         
         if (!error)
         {
             arrFinalData=[NSMutableArray new];
             
             [arrFinalData addObjectsFromArray:[arrImages objectAtIndex:0][@"RESULT"]];
             
             if(arrFinalData.count ==0){
                 
                 [self.messageListTableView reloadData];
                 
             }else {
                 
                 
                 
                 [self.messageListTableView reloadData];
             }
         }
         
         
         
     }];
    
    
}


-(void)clk_btnLeftMenu:(id)sender
{
    NSLog(@"clk_btnLeftMenu");
    
    
    
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{}];
    
}

#pragma mark UITableViewDelegateMethod



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return arrFinalData.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.messageListTableView.estimatedRowHeight = 80.0;
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"MessageList";
    
    MessageListCell *cell = (MessageListCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
   cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    NSString *ImageURL =[model_manager.loginManager.login.urlImage stringByAppendingString:arrFinalData[indexPath.row][@"_121_170"] ];
    
    [cell.personImage sd_setImageWithURL:[NSURL URLWithString:ImageURL] placeholderImage:[UIImage imageNamed:@"loading"] options:SDWebImageRefreshCached | SDWebImageRetryFailed];
    
    cell.messageTitleLable.text=arrFinalData[indexPath.row][@"_122_181"];
    //cell.datelable.text=[NSString stringWithFormat:@"%@",arrFinalData[indexPath.row][@"_114_138"]];
    cell.messageLable.text=[self stringFromHexString:arrFinalData[indexPath.row][@"_120_157"]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:arrFinalData[indexPath.row][@"_114_138"]];
    NSString *date1=[self getTimestampForDate:date];
    cell.datelable.text=date1;
    
    
    
    return cell;
}
- (void)tableView:(UITableView *)TableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![self checkInternetConeection]) {
        
        return;
    }
    UIViewController *controller=[self.storyboard instantiateViewControllerWithIdentifier:@"MessageReplyVC"];
    [self.navigationController pushViewController:controller animated:YES];
    
    
    
}

- (NSString *)stringFromHexString:(NSString *)hexString {
    
    // The hex codes should all be two characters.
    if (([hexString length] % 2) != 0)
        return nil;
    
    NSMutableString *string = [NSMutableString string];
    
    for (NSInteger i = 0; i < [hexString length]; i += 2) {
        
        NSString *hex = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSInteger decimalValue = 0;
        sscanf([hex UTF8String], "%x", &decimalValue);
        [string appendFormat:@"%c", decimalValue];
    }
    
    return string;
}

- (NSString*) getTimestampForDate:(NSDate*)date {
    
    NSDate* sourceDate = date;
    
    // Timezone Offset compensation (optional, if your target users are limited to a single time zone.)
    
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithName:@"America/New_York"];
    NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
    
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:sourceDate];
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:sourceDate];
    
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    
    NSDate* destinationDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:sourceDate];
    
    // Timestamp calculation (based on compensation)
    
    NSCalendar* currentCalendar = [NSCalendar currentCalendar];
    NSCalendarUnit unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit;
    
    NSDateComponents *differenceComponents = [currentCalendar components:unitFlags fromDate:destinationDate toDate:[NSDate date] options:0];//Use `date` instead of `destinationDate` if you are not using Timezone offset correction
    
    NSInteger yearDifference = [differenceComponents year];
    NSInteger monthDifference = [differenceComponents month];
    NSInteger dayDifference = [differenceComponents day];
    NSInteger hourDifference = [differenceComponents hour];
    NSInteger minuteDifference = [differenceComponents minute];
    
    NSString* timestamp;
    
    if (yearDifference == 0
        && monthDifference == 0
        && dayDifference == 0
        && hourDifference == 0
        && minuteDifference <= 2) {
        
        //"Just Now"
        
        timestamp = @"Just Now";
        
    } else if (yearDifference == 0
               && monthDifference == 0
               && dayDifference == 0
               && hourDifference == 0
               && minuteDifference < 60) {
        
        //"13 minutes ago"
        
        timestamp = [NSString stringWithFormat:@"%ld minutes ago", (long)minuteDifference];
        
    } else if (yearDifference == 0
               && monthDifference == 0
               && dayDifference == 0
               && hourDifference == 1) {
        
        //"1 hour ago" EXACT
        
        timestamp = @"1 hour ago";
        
    } else if (yearDifference == 0
               && monthDifference == 0
               && dayDifference == 0
               && hourDifference < 24) {
        
        timestamp = [NSString stringWithFormat:@"%ld hours ago", (long)hourDifference];
        
    } else {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setLocale:[NSLocale currentLocale]];
        
        NSString* strDate, *strDate2 = @"";
        
        if (yearDifference == 0
            && monthDifference == 0
            && dayDifference == 1) {
            
            //"Yesterday at 10:23 AM", "Yesterday at 5:08 PM"
            
//            [formatter setDateFormat:@"hh:mm a"];
//            strDate = [formatter stringFromDate:date];
            
            timestamp = [NSString stringWithFormat:@"Yesterday"];
            
        } else if (yearDifference == 0
                   && monthDifference == 0
                   && dayDifference < 7) {
            
            //"Tuesday at 7:13 PM"
            
            [formatter setDateFormat:@"EEEE"];
            strDate = [formatter stringFromDate:date];
//            [formatter setDateFormat:@"hh:mm a"];
//            strDate2 = [formatter stringFromDate:date];
            
            timestamp = [NSString stringWithFormat:@"%@", strDate];
            
        } else if (yearDifference == 0) {
            
            //"July 4 at 7:36 AM"
            
            [formatter setDateFormat:@"d MMMM"];
            strDate = [formatter stringFromDate:date];
//            [formatter setDateFormat:@"hh:mm a"];
//            strDate2 = [formatter stringFromDate:date];
            
            timestamp = [NSString stringWithFormat:@"%@", strDate];
            
        } else {
            
            //"March 24 2010 at 4:50 AM"
            
            [formatter setDateFormat:@"MMMM yyyy"];
            strDate = [formatter stringFromDate:date];
//            [formatter setDateFormat:@"hh:mm a"];
//            strDate2 = [formatter stringFromDate:date];
            
            timestamp = [NSString stringWithFormat:@"%@", strDate];
        }
    }
    
    return timestamp;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
