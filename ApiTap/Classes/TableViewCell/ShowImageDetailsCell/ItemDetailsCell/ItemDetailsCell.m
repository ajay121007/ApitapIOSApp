//
//  ItemDetailsCell.m
//  ApiTap
//
//  Created by Bikramjeet Singh on 9/7/16.
//  Copyright © 2016 ApiTap. All rights reserved.
//

#import "ItemDetailsCell.h"

@implementation ItemDetailsCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    //[self.tlbMoreImages reloadData];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//manage datasource and  delegate for submenu tableview

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    
    cell.textLabel.text = @"";
    
    return cell;
    
}

@end
