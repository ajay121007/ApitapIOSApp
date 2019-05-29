//
//  ShoppingAssistance.m
//  ApiTap
//
//  Created by Abhishek Singla on 16/06/16.
//  Copyright © 2016 ApiTap. All rights reserved.
//

#import "ShoppingAssistance.h"
#import "SVProgressHUD.h"
#import "ShowSearchItemsVC.h"
#import "WishListItemsVC.h"

@interface ShoppingAssistance ()
{
    __weak IBOutlet UITableView *tblItem;
    __weak IBOutlet UITableView *tblCategory;
    
    NSMutableArray *arrCategory,*arrItems,*showWishListItems,*arrFinalData,*arrSaveEventLists,*arrSaveItemLists;
    
    //aaray of dictonary keys
    
    NSMutableArray *arrCategoryDictKeys;
    
    NSString *strSelectedIndex,*searchWord;

}

- (IBAction)clkAddCategory:(id)sender;
- (IBAction)clkAddItem:(id)sender;


@end

@implementation ShoppingAssistance

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initializeNavBar];
    [self setbarButtonItems];
    
    searchWord=@"empty";
    
    //table view border
    tblItem.layer.borderWidth = 1.0;
    tblCategory.layer.borderWidth = 1.0;
    tblItem.allowsMultipleSelectionDuringEditing = YES;
    tblCategory.allowsMultipleSelectionDuringEditing = YES;

    
    tblItem.layer.borderColor = [UIColor lightGrayColor].CGColor;
    tblCategory.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    arrCategory = [[NSMutableArray alloc]initWithObjects:@"ADD EVENT", nil];
    arrItems = [[NSMutableArray alloc]initWithObjects:@"ADD ITEM", nil];
    
    arrCategoryDictKeys = [NSMutableArray new];
    arrSaveEventLists = [NSMutableArray new];
    arrSaveItemLists = [NSMutableArray new];
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    
    NSString *checkValue = [[NSUserDefaults standardUserDefaults]valueForKey:@"eventData"];
    
    NSLog(@"%@",checkValue);
    
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"eventData"]);
    
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"eventData"] isEqual: [NSNull null]]){
        
        
    }
    
    
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"eventData"] isKindOfClass:[NSNull class]]) {
        
        
    }
    
    
    
        arrCategory = [[[NSUserDefaults standardUserDefaults]valueForKey:@"eventData"] mutableCopy];
        
        //NSLog(@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"eventData"]);
        
        
     //   arrItems = [[[NSUserDefaults standardUserDefaults]valueForKey:@"itemData"] mutableCopy];
        
        
        //arrCategoryDictKeys = [[[NSUserDefaults standardUserDefaults]valueForKey:@"itemDataDicts"] mutableCopy];
        
        //NSLog(@"%@",arrCategoryDictKeys);
    
    
    
    
    for (int i =1; i<=arrCategory.count; i++) {
        
        NSMutableDictionary *dictCatKey = [NSMutableDictionary new];
        
        NSMutableArray *newItemArray = [[NSMutableArray alloc]initWithObjects:@"ADD ITEM", nil];
        
        NSString *strIdexpath = [NSString stringWithFormat:@"%d",i];
        
        [dictCatKey setObject:newItemArray forKey:strIdexpath];
        
        [arrCategoryDictKeys addObject:dictCatKey];
    }
    
    
    
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

- (IBAction)clkAddCategory:(id)sender {
}

- (IBAction)clkAddItem:(id)sender {
}

#pragma mark - UITableViewDelegate & DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView
{
    return 1;
}

// number of row in the section, I assume there is only 1 row
- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
{
    if (theTableView == tblCategory) {
        return 1;
       // return arrCategory.count;
    }
    else if (theTableView == tblItem)
        return 1;
        //return arrItems.count;
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (tableView == tblCategory)
    {
        
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.text = [arrCategory objectAtIndex:indexPath.row];
        
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        
        return cell;
    }
    
    else if (tableView == tblItem)
    {
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.textLabel.text = [arrItems objectAtIndex:indexPath.row];
        
        return cell;
    }
    
    return cell;
    
}

// when user tap the row, what action you want to perform
- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    
    if (theTableView == tblCategory) {
        
      
        if (indexPath.row == 0) {
            
            UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"Category Type"
                                                                                      message: @"Choose your category type"
                                                                               preferredStyle:UIAlertControllerStyleAlert];
            [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                textField.placeholder = @"Category Name";
                textField.textColor = [UIColor blueColor];
                textField.clearButtonMode = UITextFieldViewModeWhileEditing;
                textField.borderStyle = UITextBorderStyleRoundedRect;
            }];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                NSArray * textfields = alertController.textFields;
                UITextField * namefield = textfields[0];
                NSString *strCat = namefield.text;
                
                //Empty String Check
                
                NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
                NSString *trimmedString = [strCat stringByTrimmingCharactersInSet:charSet];
                if ([trimmedString isEqualToString:@""])
                {
                    // it's empty or contains only white spaces
                    strCat = nil;
                    return ;
                }
                
                
                else if ([arrCategory containsObject:strCat])
                {
                    return;
                }
                
                //
                NSMutableDictionary *dictCatKey = [NSMutableDictionary new];
                NSMutableArray *newItemArray = [[NSMutableArray alloc]initWithObjects:@"ADD ITEM", nil];
                
                NSString *strIdexpath = [NSString stringWithFormat:@"%ld",(long)arrCategory.count];
                
                [dictCatKey setObject:newItemArray forKey:strIdexpath];
                
                [arrCategoryDictKeys addObject:dictCatKey];
      
                
                [arrCategory addObject:strCat];
                
                [[NSUserDefaults standardUserDefaults]setObject:arrCategory forKey:@"eventData"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                NSLog(@"%@",arrCategoryDictKeys);
                
                [tblCategory reloadData];
                
                
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
            
            strSelectedIndex = @"";
            
        }
        
        else{
            
            NSLog(@"%@",arrCategoryDictKeys);
            
            [[NSUserDefaults standardUserDefaults]setObject:arrCategoryDictKeys forKey:@"itemDataDicts"];
            [[NSUserDefaults standardUserDefaults]synchronize];

            
            NSDictionary *dict = [arrCategoryDictKeys objectAtIndex:(indexPath.row-1)];
            arrItems = [dict valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
            strSelectedIndex = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
            [tblItem reloadData];
            
        }
    }
    
    if (theTableView == tblItem) {
        
        
        if (indexPath.row == 0) {
            //UIalert
            {                
                
                if ([strSelectedIndex isEqualToString:@""] || strSelectedIndex == nil) {
                    return;
                }
                
                UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"List Type"
                                                                                          message: @"Choose your list item"
                                                                                   preferredStyle:UIAlertControllerStyleAlert];
                [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                    textField.placeholder = @"List Item";
                    textField.textColor = [UIColor blueColor];
                    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
                    textField.borderStyle = UITextBorderStyleRoundedRect;
                }];
                [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    NSArray * textfields = alertController.textFields;
                    UITextField * namefield = textfields[0];
                    
                    
                    int selectedIndex = [strSelectedIndex intValue];
                    NSDictionary *currnetDict = [arrCategoryDictKeys objectAtIndex:selectedIndex-1];
                    arrItems = [currnetDict valueForKey:strSelectedIndex];
                    
                    
                    NSString *stritem = namefield.text;
                    
                    NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
                    NSString *trimmedString = [stritem stringByTrimmingCharactersInSet:charSet];
                    if ([trimmedString isEqualToString:@""])
                    {
                        // it's empty or contains only white spaces
                        stritem = nil;
                        return ;
                    }
                    
                    
                    [arrItems addObject:stritem];
                    
                    [[NSUserDefaults standardUserDefaults]setObject:arrItems forKey:@"itemData"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                    
                    [tblItem reloadData];
                    
                }]];
                
                [self presentViewController:alertController animated:YES completion:nil];
                
            }
        }else{
            
            NSLog(@"%@",arrItems[indexPath.row]);
            
            searchWord = arrItems[indexPath.row];
        }
        
        
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle==UITableViewCellEditingStyleDelete)
    {

        
//        NSLog(@"%@",arrCategory);
//        
//        NSLog(@"%lu",(unsigned long)arrCategoryDictKeys.count);
//        
//        NSLog(@"%@",[NSString stringWithFormat:@"%ld", indexPath.row]);
//        
//        NSLog(@"%@",arrCategoryDictKeys[indexPath.row-1]);
        
        if (tableView == tblCategory) {
            
            NSLog(@"%@",arrCategory[indexPath.row]);
            
            [arrCategory removeObjectAtIndex:indexPath.row];
            
            [arrCategoryDictKeys removeObjectAtIndex:indexPath.row-1];
            
            [[NSUserDefaults standardUserDefaults]setObject:arrCategory forKey:@"eventData"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            
           
            
            
            
//            NSLog(@"%@",arrCategoryDictKeys);
//            
//            NSLog(@"%lu",(unsigned long)arrItems.count);
//            
//            NSLog(@"%@",arrItems);
            
            //[arrItems removeObjectAtIndex:indexPath.row];
            
           // NSLog(@"%lu",(unsigned long)[arrItems[indexPath.row] count]);
            
           // NSLog(@"%@",arrItems[indexPath.row]);
            
            
            
           // [arrItems addObject:@"ADD ITEM"];
            
           // NSLog(@"%@",arrItems);
            
        }else{
            
            [arrItems removeObjectAtIndex:indexPath.row];
        }
        
        
        //[dataArray removeObjectAtIndex:indexPath.row];
    }
    
    
    [tblItem reloadData];
    [tblCategory reloadData];
}

-(void)getRelatedItems{
    
    if (![self checkInternetConeection]) {
        
        return;
    }
    
    [SVProgressHUD showWithStatus:@"Loding....."];
    
    NSMutableDictionary *dictParam = [NSMutableDictionary new];
    
    [dictParam setValue:searchWord forKey:@"114.127"];
    
    [dictParam setValue:@"001" forKey:@"127.10"];
    [dictParam setValue:@"21" forKey:@"114.112"];
    
    [dictParam setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"loginUserID"] forKey:@"53"];
    
    
    [model_manager.addManager getRelatedItems:KSearchFavoriteItemsByTypeKey userinfo:dictParam completionResponse:^(NSArray *arrImages, NSError *error)
     {
         
         if (!error)
         {
             [SVProgressHUD dismiss];
             
             showWishListItems=[NSMutableArray new];
             
             [showWishListItems addObjectsFromArray:arrImages[0]];
             
             if (showWishListItems.count == 0) {
                 
                 [CustomAlertView showAlert:@"Alert" message:@"Data Not Found"];
                 
             }else{
                 
                                
                 [showWishListItems removeAllObjects];
                 
                 [showWishListItems addObjectsFromArray:arrImages];

                 
                 //[showWishListItems addObject:arrImages];
                 
                 NSLog(@"%lu",(unsigned long)showWishListItems.count);
               
                 WishListItemsVC *controller=[self.storyboard instantiateViewControllerWithIdentifier:@"wishlistvc"];
                 
                 controller.arrSearchItemsData=showWishListItems;
                 controller.check=YES;
                 [self.navigationController pushViewController:controller animated:YES];

             }
             
            // [self.tblWishList reloadData];
         }
         
     }];
    
}

-(void)searchItemsNear {
    
    if (![self checkInternetConeection]) {
        
        return;
    }
    
    [SVProgressHUD showWithStatus:@"Loding....."];
    
    NSMutableDictionary *dictParam = [NSMutableDictionary new];
    
    [dictParam setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"loginUserID"] forKey:@"53"];
    
    [dictParam setValue:searchWord forKey:@"114.127"];
    
    [dictParam setValue:@"33.965335" forKey:@"120.38"];
    
    [dictParam setValue:@"-118.272739" forKey:@"120.39"];
    
    [dictParam setValue:@"001" forKey:@"127.10"];
    
    [model_manager.addManager showAdds:@"010400228" userinfo:dictParam completionResponse:^(NSArray *arrImages, NSError *error)
     {
         
         [SVProgressHUD dismiss];
         
         if (!error)
         {
             
             
             if ([[arrImages valueForKey:@"RESULT"][0][0][@"_300"] count] == 0) {
                 
                 [CustomAlertView showAlert:@"Alert" message:@"Data Not Found"];
                 
             }else{
                 
                 NSLog(@"%@",arrImages);
                 
                 ShowSearchItemsVC *controller=[self.storyboard instantiateViewControllerWithIdentifier:@"ShowSearchItemsVC"];
                 
                 controller.arrSearchItemsData=[arrImages valueForKey:@"RESULT"][0][0][@"_300"];
                 [self.navigationController pushViewController:controller animated:YES];
                 
             }
             
         }
     }];
}

-(void)getAllMerchantStore {
    
    if (![self checkInternetConeection]) {
        
        return;
    }
    
    [SVProgressHUD showWithStatus:@"Loding....."];
    
    NSMutableDictionary *dictParam = [NSMutableDictionary new];
    
    [dictParam setValue:@"0001202A000000000858" forKey:@"53"];
    [dictParam setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"loginUserID"] forKey:@"114.179"];
    
    [model_manager.addManager showAdds:@"010100557" userinfo:dictParam completionResponse:^(NSArray *arrImages, NSError *error)
     {
         [SVProgressHUD dismiss];
         
         if (!error)
         {
             
             NSLog(@"%@",arrImages);
             
             arrFinalData=[NSMutableArray new];
             
             [arrFinalData addObjectsFromArray:[arrImages valueForKey:@"RESULT"][0]];
             
             if(arrFinalData.count ==0){
                 
                 
                 
             }else {
                 
                 
                
             }
             
         }
         
         
     }];
    
}


#pragma mark -  Button Actions

- (IBAction)clkSearchFav:(id)sender {
    
    
    if ([searchWord isEqualToString:@"empty"]) {
        
        [CustomAlertView showAlert:@"Message" message:@"Please Select Any Item For Search"];
        
    }else{
        
        [self getRelatedItems];
    }
}

- (IBAction)clkSearchNearBy:(id)sender {
    
    
    
    if ([searchWord isEqualToString:@"empty"]) {
        
        [CustomAlertView showAlert:@"Message" message:@"Please Select Any Item For Search"];
        
    }else{
        
        [self searchItemsNear];
    }
    
    
    
}

- (IBAction)clkSearchAllStores:(id)sender {
    
    NSLog(@"clk all store");
    
}

-(void)showAlert:(NSString *)errorMsg
{
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@""
                                  message:errorMsg
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleCancel
                         handler:^(UIAlertAction * action)
                         {
                             //Do some thing here
                             //   [view dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    [alert addAction:ok];
    
}

@end
