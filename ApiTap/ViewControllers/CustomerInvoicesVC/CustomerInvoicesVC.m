//
//  CustomerInvoicesVC.m
//  ApiTap
//
//  Created by Bikramjeet Singh on 8/27/16.
//  Copyright © 2016 ApiTap. All rights reserved.
//

#import "CustomerInvoicesVC.h"
#import "CustomerInvoicesCell.h"

@interface CustomerInvoicesVC ()

@end

@implementation CustomerInvoicesVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"CustomerInvoicesCell";
    
    CustomerInvoicesCell *cell = (CustomerInvoicesCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![self checkInternetConeection]) {
        
        return;
    }
    [self performSegueWithIdentifier:@"goto_iteminvoicevc" sender:nil];
    
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
