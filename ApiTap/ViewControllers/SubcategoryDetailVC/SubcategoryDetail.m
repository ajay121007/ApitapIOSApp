//
//  SubcategoryDetail.m
//  ApiTap
//
//  Created by Abhishek Singla on 22/06/16.
//  Copyright © 2016 ApiTap. All rights reserved.
//

#import "SubcategoryDetail.h"

@interface SubcategoryDetail ()
{
    
    __weak IBOutlet UITableView *tableSubCat;
    NSMutableArray *arrSubCatDetails;
}
@end

@implementation SubcategoryDetail

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //super class method
    
    [self initializeNavBar];
    
    arrSubCatDetails = [[NSMutableArray alloc]initWithObjects:@"a",@"b",@"c" ,nil];
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

#pragma mark - UITableViewDelegate & DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    
    return cell;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView
{
    return 1;
}

// number of row in the section, I assume there is only 1 row

- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
{
    //    float i = arrSubCatDetails.count / 2;
    //    NSLog(@"%d",i);
    
    if (arrSubCatDetails.count % 2) {
        NSLog(@"odd");
        int count = (int)(arrSubCatDetails.count - 1)/2;
        return count+1;
    }
    else
    {
        
        return arrSubCatDetails.count/2;
    }
    
    return 0;
    
}


// when user tap the row, what action you want to perform

- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (theTableView == tableSubCat)
    {
        
    }
}


@end
