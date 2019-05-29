//
//  MessageReplyVC.m
//  ApiTap
//
//  Created by deepraj on 9/22/16.
//  Copyright © 2016 ApiTap. All rights reserved.
//

#import "MessageReplyVC.h"
#import "MessageListCell.h"
#import "SVProgressHUD.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface MessageReplyVC () {
    
    NSMutableArray *arrFinalData;
}

@property (weak, nonatomic) IBOutlet UIView *fotterView;


@end

@implementation MessageReplyVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fotterView.hidden=YES;
    
    [self getPlaylistBroadcastMobile];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    self.navigationItem.title=@"Message Reply";
}


-(void)getPlaylistBroadcastMobile{
    if (![self checkInternetConeection]) {
        
        return;
    }

    [SVProgressHUD showWithStatus:@"Loding....."];
    
    NSMutableDictionary *dictParam = [NSMutableDictionary new];
    
    [dictParam setValue:@"true" forKey:@"114.9"];
    
    [model_manager.addManager getHistoryData:@"010100209" userinfo:dictParam completionResponse:^(NSArray *arrImages, NSError *error)
     {
         [SVProgressHUD dismiss];
         
         if (!error)
         {
             arrFinalData=[NSMutableArray new];
             
             [arrFinalData addObjectsFromArray:[arrImages objectAtIndex:0][@"RESULT"]];
             
             if(arrFinalData.count ==0){
                 
                 [self.messageListTableView reloadData];
                 
             }else {
                 
                  self.fotterView.hidden=NO;
                 
                 [self.messageListTableView reloadData];
             }
         }
         
         
         
     }];
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


-(IBAction)clk_btnbackMenu:(id)sender
{
    NSLog(@"clk_btnLeftMenu");
    [self.navigationController popViewControllerAnimated:YES];
    
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
            
            [formatter setDateFormat:@"hh:mm a"];
            strDate = [formatter stringFromDate:date];
            
            timestamp = [NSString stringWithFormat:@"Yesterday at %@", strDate];
            
        } else if (yearDifference == 0
                   && monthDifference == 0
                   && dayDifference < 7) {
            
            //"Tuesday at 7:13 PM"
            
            [formatter setDateFormat:@"EEEE"];
            strDate = [formatter stringFromDate:date];
            [formatter setDateFormat:@"hh:mm a"];
            strDate2 = [formatter stringFromDate:date];
            
            timestamp = [NSString stringWithFormat:@"%@ at %@", strDate, strDate2];
            
        } else if (yearDifference == 0) {
            
            //"July 4 at 7:36 AM"
            
            [formatter setDateFormat:@"MMMM d"];
            strDate = [formatter stringFromDate:date];
            [formatter setDateFormat:@"hh:mm a"];
            strDate2 = [formatter stringFromDate:date];
            
            timestamp = [NSString stringWithFormat:@"%@ at %@", strDate, strDate2];
            
        } else {
            
            //"March 24 2010 at 4:50 AM"
            
            [formatter setDateFormat:@"d MMMM yyyy"];
            strDate = [formatter stringFromDate:date];
            [formatter setDateFormat:@"hh:mm a"];
            strDate2 = [formatter stringFromDate:date];
            
            timestamp = [NSString stringWithFormat:@"%@ at %@", strDate, strDate2];
        }
    }
    
    return timestamp;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
