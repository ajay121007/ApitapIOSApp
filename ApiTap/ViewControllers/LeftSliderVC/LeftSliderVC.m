//
//  LeftSliderVC.m
//  ApiTap
//
//  Created by Bikramjeet Singh on 8/16/16.
//  Copyright © 2016 ApiTap. All rights reserved.
//

#import "LeftSliderVC.h"
#import "LeftSliderCell.h"
#import "ApiTap-Swift.h"

#define klblMenuItem 10
#define kimgMenuItem 2

@interface LeftSliderVC () {
    
    NSArray *arrMenuItems, *arrMenuItemsImages;
}

@property (nonatomic,strong) StoreVC *storeVC;
@property (nonatomic,strong) PagerController *pageVC;
@property (weak, nonatomic) IBOutlet UITableView *tblShowLeftItems;


@end

@implementation LeftSliderVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
     arrMenuItems = [NSArray arrayWithObjects:@"Home",@"Stores",@"Ads",@"Special",@"Items",@"Scan Code",@"Shopping Cart",@"Messages",@"Shopping Assistant",@"Favorites",@"Orders,Return & Exchange",@"Settings",@"Logout",nil];
    
    //arrMenuItems = [NSArray arrayWithObjects:@"Home",@"Ads",@"Special",@"Items",@"Scan Code",@"Shopping Cart",@"Messages",@"Shopping Assistant",@"Favourites",@"History",@"Settings",@"Logout",nil];
    
    arrMenuItemsImages = [NSArray arrayWithObjects:@"home.png",@"store_white",@"ads.png",@"special.png",@"item.png",@"scan-slider.png",@"cart-slider.png",@"email-slider.png",@"shop.png",@"favourite.png",@"history.png",@"settings.png",@"logout.png",nil];
    
}

#pragma mark - Table view data source

//-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    return self.tblShowLeftItems.frame.size.height/arrMenuItems.count;
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //#warning Incomplete implementation, return the number of rows
    return [arrMenuItems count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *_simpleTableIdentifier = @"CellIdentifier";
    
    //LeftSliderCell *cell = [tableView dequeueReusableCellWithIdentifier:_simpleTableIdentifier forIndexPath:indexPath];
    
    LeftSliderCell *cell = (LeftSliderCell*)[tableView dequeueReusableCellWithIdentifier:_simpleTableIdentifier];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // Configure the cell...
    if(cell==nil)
    {
        cell = [[LeftSliderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_simpleTableIdentifier];
        
        
    }
    
    cell.lblMenuItem.textColor = LightGreyColor;
    cell.lblMenuItem.text = [arrMenuItems objectAtIndex:indexPath.row] ;
    cell.imgMenuItem.image = [UIImage imageNamed:[arrMenuItemsImages objectAtIndex:indexPath.row]];
    
    cell.backgroundColor = BlackBackground;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


#pragma mark - TableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if (![self checkInternetConeection]) {
        
        return;
    }
    NSString *keyName = arrMenuItems[indexPath.row];
    
    UIViewController *viewController ;
    
    UINavigationController *navi;
    
    if([keyName caseInsensitiveCompare:@"Home"] == NSOrderedSame){
        TestClass.doubleVar = 0;
        TestClass2.doubleVarBool = true;
        storeMerchantClass.storeMerchantIdBool = false;
        viewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"PagerVC"];
    }
    else if ([keyName caseInsensitiveCompare:@"Stores"] == NSOrderedSame){
        
        if ([[NSUserDefaults standardUserDefaults]boolForKey:@"checkGuest"] == YES) {
            
            viewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"login"];
            
        }else{
          TestClass *optTest1a = [[TestClass alloc] init];
            TestClass.doubleVar = 1;
            storeMerchantClass.storeMerchantIdBool = false;
            TestClass2.doubleVarBool = true;
           // _pageVC.selectTabAtIndex(index:TestClass.doubleVar);
            
            PagerController *controller = [[PagerController alloc]init];
            [controller selectTabAtIndex:TestClass.doubleVar];
            viewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"PagerVC"];
           // viewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"StoreVC"];
            // viewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"ShowLeftSliderAdsVC"];
       
        }
        
    }
    else if ([keyName caseInsensitiveCompare:@"Ads"] == NSOrderedSame){
        
        if ([[NSUserDefaults standardUserDefaults]boolForKey:@"checkGuest"] == YES) {
            
            viewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"login"];
            
        }else{
            TestClass.doubleVar = 2;
            TestClass2.doubleVarBool = true;
            viewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"PagerVC"];
            //viewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"AddDetailViewController"];
            // viewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"ShowLeftSliderAdsVC"];
        }
        
       
    }
    else if ([keyName caseInsensitiveCompare:@"Special"] == NSOrderedSame){
        
        if ([[NSUserDefaults standardUserDefaults]boolForKey:@"checkGuest"] == YES) {
            
            viewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"login"];
            
        }else{
            TestClass.doubleVar = 3;
            TestClass2.doubleVarBool = true;
            
            viewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"PagerVC"];
            //  viewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"ShowLeftSliderSpecialsVC"];
        }
      
    }
    else if ([keyName caseInsensitiveCompare:@"Items"] == NSOrderedSame){
        
        if ([[NSUserDefaults standardUserDefaults]boolForKey:@"checkGuest"] == YES) {
            
            viewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"login"];
            
        }else{
            TestClass.doubleVar = 4;
            TestClass2.doubleVarBool = true;
            viewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"PagerVC"];
         //  viewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"ShowLeftSliderItemsVC"];
        }
        
    }
    else if ([keyName caseInsensitiveCompare:@"Scan Code"] == NSOrderedSame){
        
        if ([[NSUserDefaults standardUserDefaults]boolForKey:@"checkGuest"] == YES) {
            
            viewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"login"];
            
        }else{
            

            viewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"ScanCodeVC"];
        }
        
        
    }
    else if ([keyName caseInsensitiveCompare:@"Shopping Cart"] == NSOrderedSame){
      
        if ([[NSUserDefaults standardUserDefaults]boolForKey:@"checkGuest"] == YES) {
            
            viewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"login"];
            
        }else{
            
            viewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"ShoppingCartsVC"];
        }
       
        
    }
    else if ([keyName caseInsensitiveCompare:@"Messages"] == NSOrderedSame){
        
        if ([[NSUserDefaults standardUserDefaults]boolForKey:@"checkGuest"] == YES) {
            
            viewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"login"];
            
        }else{
            
            viewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"SearchMessagesVC"];
           // viewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"MessageListVC"];
        }
        
    }
    else if ([keyName caseInsensitiveCompare:@"Shopping Assistant"] == NSOrderedSame){
        
        if ([[NSUserDefaults standardUserDefaults]boolForKey:@"checkGuest"] == YES) {
            
            viewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"login"];
            
        }else{
            
            viewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"ShoppingAssistantCollectionViewController"];
            //viewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"ShoppingAssistantCollectionViewController"];
           // viewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"ShoppingAssistantVC"];
        }
        
        
    }
    else if ([keyName caseInsensitiveCompare:@"Favorites"] == NSOrderedSame){
        
        if ([[NSUserDefaults standardUserDefaults]boolForKey:@"checkGuest"] == YES) {
            
            viewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"login"];
            
        }else{
            TestClass.doubleVar = 5;
            TestClass2.doubleVarBool = true;
            viewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"PagerVC"];
         //   viewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"FavioratesVC"];
        }
        
    }
    else if ([keyName caseInsensitiveCompare:@"Orders,Return & Exchange"] == NSOrderedSame){
       
        if ([[NSUserDefaults standardUserDefaults]boolForKey:@"checkGuest"] == YES) {
            
            viewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"login"];
            
        }else{
            
            viewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"InvoiceSearchVC"];
        }
        
    }
    else if ([keyName caseInsensitiveCompare:@"Settings"] == NSOrderedSame){

        if ([[NSUserDefaults standardUserDefaults]boolForKey:@"checkGuest"] == YES) {
            
            viewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"login"];
            
        }else{
            
            /// viewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"TemporaryLockerVC"];
            viewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"SettingsVC"];
        }
       
        
    }
    else if ([keyName caseInsensitiveCompare:@"Logout"] == NSOrderedSame){
        
        viewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"login"];
        
    }
    else {
        
        NSLog(@"Not Implemented");
        
    }
    
    navi = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    [self.menuContainerViewController setCenterViewController:navi];
    
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{}];
    
    
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
