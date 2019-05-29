//
//  HistoryDetailsVC.m
//  ApiTap
//
//  Created by Bikramjeet Singh on 9/29/16.
//  Copyright © 2016 ApiTap. All rights reserved.
//

#import "HistoryDetailsVC.h"
#import "SVProgressHUD.h"
#import "HistoryCell.h"
#import "HistoryHeaderCell.h"

@interface HistoryDetailsVC () <UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource> {
    
    NSMutableArray *arrFinalData;
    BOOL check;
    NSDictionary *animals;
    NSArray *animalSectionTitles;
    NSArray *questionList;
}

@property (weak, nonatomic) IBOutlet UITableView *tblHistoryDetails;

@property (weak, nonatomic) IBOutlet UITableView *tblViewAlert;

@end

  @implementation HistoryDetailsVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _viewForAlert.hidden          = true;
    _tblViewSelectQuestion.hidden = true;
    
    HistoryCell *alert12();
  // alert12().lblAlert.text = @"test";
  //
    animals = @{@"A" : @[@"Bear", @"Black Swan", @"Buffalo"],
                @"S" : @[@"Seagull"],
                @"T" : @[@"Tasmania Devil"],
                @"W" : @[@"Whale"]};
    
    questionList = [[NSArray alloc]
                       initWithObjects:
                    @"Bought by mistake",
                    @"Better price available",
                    @"Product damaged, but shiping box OK",
                    @"Item arrived too late",
                    @"Missing parts of accessories",
                    @"Product and shipping box both damaged",@"Wrrong item was send",
                    @"Item defective or doesn't work",
                    @"Received extra item I didn't buy (no refund needed)",
                    @"No longer needed",@"Didn't approve purchase",
                    @"Inaccurate website description",
                    nil];
    
    //    animals = @{@"B" : @[@"Bear", @"Black Swan", @"Buffalo"],
//                @"C" : @[@"Camel", @"Cockatoo"],
//                @"D" : @[@"Dog", @"Donkey"],
//                @"E" : @[@"Emu"],
//                @"G" : @[@"Giraffe", @"Greater Rhea"],
//                @"H" : @[@"Hippopotamus", @"Horse"],
//                @"K" : @[@"Koala"],
//                @"L" : @[@"Lion", @"Llama"],
//                @"M" : @[@"Manatus", @"Meerkat"],
//                @"P" : @[@"Panda", @"Peacock", @"Pig", @"Platypus", @"Polar Bear"],
//                @"R" : @[@"Rhinoceros"],
//                @"S" : @[@"Seagull"],
//                @"T" : @[@"Tasmania Devil"],
//                @"W" : @[@"Whale"]};
    
    animalSectionTitles = [[animals allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    _tblViewAlert.delegate = self;
    _textFieldInAlert.delegate = self;
   // [self getPlaylistBroadcastMobile];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    self.navigationItem.title=@"History Details";
}

-(void)getPlaylistBroadcastMobile{
    if (![self checkInternetConeection]) {
        
        return;
    }
    [SVProgressHUD showWithStatus:@"Loading....."];
    
    NSMutableDictionary *dictParam = [NSMutableDictionary new];
    
    [dictParam setValue:@"00000000181" forKey:@"121.75"];
  
    
    [model_manager.addManager removeFavoriteItemMobile:@"010100114" userinfo:dictParam completionResponse:^(NSArray *arrImages, NSError *error)
     {
         [SVProgressHUD dismiss];
                  
         if (!error)
         {
             arrFinalData=[NSMutableArray new];
             
             [arrFinalData addObjectsFromArray:[arrImages objectAtIndex:0][@"RESULT"]];
             
             if(arrFinalData.count ==0){
                 
                 //[self.tblHistory reloadData];
                 
             }else {
                 
                 
                 
                 //[self.tblHistory reloadData];
             }
         }
         
         
         
     }];
    
    
}



#pragma mark UITableViewDelegateMethod


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    if(tableView==_tblViewSelectQuestion)
    {
        return 1;
    }
    if(tableView==_tblViewAlert)
    {
        return 1;
    }

    return [animalSectionTitles count];
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return [animalSectionTitles objectAtIndex:section];
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSString *sectionTitle = [animalSectionTitles objectAtIndex:section];
    
    if ([sectionTitle  isEqual: @"W"] || [sectionTitle  isEqual: @"S"] || [sectionTitle  isEqual: @"T"]) {
        
    return 0.0;
        
    }else {
        
        return 50.0;
    }
    
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    static NSString *CellIdentifier = @"HistoryHeaderCell";
    
    HistoryHeaderCell *sectionHeaderCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
   // NSLog(@"%@",self.historyData);
    
    sectionHeaderCell.lblItemName.text=[self.historyData valueForKey:@"_114_70"];
    NSLog(@"%@", [self.historyData valueForKey:@"_114_70"]);
    
    
    sectionHeaderCell.lblQuantity.text=[self.historyData valueForKey:@"_122_148"];
    NSLog(@"%@", [self.historyData valueForKey:@"_120_109"]);

    
    sectionHeaderCell.lblItemPrice.text=[self.historyData valueForKey:@"_55_3"];
    NSLog(@"%@", [self.historyData valueForKey:@"_55_3"]);
    //sectionHeaderCell.myPrettyLabel.text = [animalSectionTitles objectAtIndex:section];
   // sectionHeaderCell.contentView.backgroundColor = [UIColor whiteColor]; // don't leave this transparent
    
    return sectionHeaderCell.contentView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
     if(tableView==_tblViewAlert){
         return 1;
     }
    if(tableView==_tblViewSelectQuestion)
    {
        return questionList.count;
    }
    NSString *sectionTitle = [animalSectionTitles objectAtIndex:section];
    
    NSArray *sectionAnimals = [animals objectForKey:sectionTitle];
    
    return [sectionAnimals count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    self.tblHistoryDetails.estimatedRowHeight = 50.0;
    return UITableViewAutomaticDimension;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==_tblViewAlert){
        static NSString *tblViewAlert = @"tblViewAlert";
        
        HistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:tblViewAlert];
        
        cell.lblAlert.text  =  [self.historyData valueForKey:@"_114_70"];
        cell.lblQty.text    =  [self.historyData valueForKey:@"_122_148"];
        cell.lblPrice.text  =  [self.historyData valueForKey:@"_55_3"];
        return cell;
    }

    if(tableView==_tblViewSelectQuestion){
        static NSString *CellIdentifier = @"alertQuestions";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
           cell.textLabel.text = [questionList objectAtIndex:indexPath.row];
        return cell;
    }

    NSString *sectionTitle = [animalSectionTitles objectAtIndex:indexPath.section];
    
    _lblInvoiceNo.text = [self.historyData valueForKey:@"_121_41"];
    _lblDate.text = [self.historyData valueForKey:@"_120_31"];
    
    
    if ([sectionTitle  isEqual: @"W"]) {
        
        
        static NSString *simpleTableIdentifier = @"HistoryCell3";
        
        HistoryCell *cell = (HistoryCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
       
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
                return cell;

    }
    
    
    
    // Purchase Option
    if ([sectionTitle  isEqual: @"S"]) {
        
        static NSString *simpleTableIdentifier = @"HistoryCell1";
        
        HistoryCell *cell = (HistoryCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        

        cell.lblPurchaseAccount.text = [self.historyData valueForKey:@"_48_6"];
        cell.lblDeliveryMthd.text = [self.historyData valueForKey:@"_121_72"];
               return cell;

        
    }
    // Total
    if ([sectionTitle  isEqual: @"T"]){
       
        static NSString *simpleTableIdentifier = @"HistoryCell2";
        
        HistoryCell *cell = (HistoryCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
     
        // Total-Tip-Tax 114.12 Delivery Address
        
        float total=[[self.historyData valueForKey:@"_55_3"] floatValue];
        
        float tip=[[self.historyData valueForKey:@"_120_109"] floatValue];
        
        float tax=[[self.historyData valueForKey:@"_121_97"] floatValue];
        
        float final=total-tip-tax;
        
        cell.lblSubTotal.text=[NSString stringWithFormat:@"%.02f", final];
        cell.lblTaxes.text=[self.historyData valueForKey:@"_121_97"];
        cell.lblTip.text=[self.historyData valueForKey:@"_120_109"];
        cell.lblTotal.text=[self.historyData valueForKey:@"_55_3"];
        
        
                     return cell;
    }
    
    else {
        
        static NSString *simpleTableIdentifier = @"HistoryCell";
        
        HistoryCell *cell = (HistoryCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
         cell.lblStoreName.text=[self.historyData valueForKey:@"_114_70"];
     
                NSLog(@"%@", _historyData);
        return cell;
        

    }
   // alertQuestions
   }

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(tableView == _tblViewSelectQuestion)
    {
        printf("cell selected");
        
        NSString *questionNumber = [questionList objectAtIndex:indexPath.row];

        self.textFieldInAlert.text = questionNumber ;
        self.tblViewSelectQuestion.hidden = true;

    }
}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
//}

//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
//}

- (IBAction)btnReturn:(id)sender
{
    printf("btn clicked");
      _viewForAlert.hidden = false;
     // _mainSecondView.alpha = .5;
   // [self.view addSubview:_viewForAlert];
    if (!UIAccessibilityIsReduceTransparencyEnabled()) {
        self.view.backgroundColor = [UIColor clearColor];
        
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleProminent];
        UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        blurEffectView.frame = self.view.bounds;
        blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [self.view addSubview:blurEffectView];
        
        [self.view addSubview:_viewForAlert];

    } else {
        self.view.backgroundColor = [UIColor whiteColor];
    }
}


- (IBAction)btnSendMsg:(id)sender
{
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    //[textField selectAll:self];
    _tblViewSelectQuestion.hidden = false;
    [self.view addSubview:_tblViewSelectQuestion];
    printf("text field clicked");
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    //[textField selectAll:self];
    _tblViewSelectQuestion.hidden = false;
[self.view addSubview:_tblViewSelectQuestion];
    printf("text field clicked");
}


//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//   
//    
//    
////    NSString *date1=arrFinalData[indexPath.row][@"_120_31"];
////    
////    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
////    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
////    NSDate *date = [dateFormatter dateFromString:date1];
////    dateFormatter = [[NSDateFormatter alloc] init];
////    [dateFormatter setDateFormat:@"dd MMM yyyy"];
////    
////    NSString *convertedString = [dateFormatter stringFromDate:date];
////    
////    cell.lblDate.text=convertedString;
////    cell.lblStoreName.text=arrFinalData[indexPath.row][@"_114_70"];
////    cell.lblInvoiceNumber.text=arrFinalData[indexPath.row][@"_121_41"];
////    cell.lblAmount.text=arrFinalData[indexPath.row][@"_55_3"];
//    
//    //return cell;
//    
//    if (indexPath.section == 0) {
//        
//        static NSString *simpleTableIdentifier = @"HistoryCell";
//        
//        HistoryCell *cell = (HistoryCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
//        
//        return cell;
//    }
//    
//    return 0;
//    
////    switch (indexPath.section) {
////            
////        case 0:
////        {
////            static NSString *simpleTableIdentifier = @"HistoryCell";
////            
////            HistoryCell *cell = (HistoryCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
////                                  
////            return cell;
////        }
////        case 1:
////        {
////            static NSString *simpleTableIdentifier = @"HistoryCell1";
////            
////            HistoryCell *cell = (HistoryCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
////            
////            return cell;
////
////        }
////        case 2:
////        {
////            static NSString *simpleTableIdentifier = @"HistoryCell2";
////            
////            HistoryCell *cell = (HistoryCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
////            
////            cell.lblcell2.text=@"rrrwirweiorewiorweirweiruwiorwiruwiorwiruwioruwioruwruewirewirwioriwrewrriowriowerieowrwrewoirewirwiriowriowruwiurwiorwuiorwiorwioruwioriowruiowriowriowriowuriowriworwiorewiorwiorwiriowriowriowriowruoiwriowruewiorfsfsfiriworwiorwiorweioruoiwurwioruwiouriworuwioruwiourwoiruiowruiweouriowuroiwriwuriowurwrwrwrwrwrew";
////              cell.lblsecondone.text=@"ioeowrioeweiowriworiworiowriowriowriowriwouriowureiowureiowurewioruewioruewioruieowureiwourieowruewwrwerwrwrwroiuewrowuriowriewuruwioruwioruwioruioruwioruwioureiwouriwouriowuriowuriwureiowureoiwreiowuriowerueiwourwiourwioruwioruwioruwioruwioruewiouriweoruiwoeurioewurioweurioweruiowerueiowurwioruwioruwioureiwoureiowruiourieowuriowureiowruweioruewioruewioruewioruweioruwioruweioruiwoerwioruwioruwieorwioerwioeruweio";
////                        
////            
////            return cell;
////            
////        }
////        case 3:
////        {
////            static NSString *simpleTableIdentifier = @"HistoryCell3";
////            
////            HistoryCell *cell = (HistoryCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
////            
////            return cell;
////            
////        }
////            
////        default:
////            break;
////    }
////    
////    
////    
////    
//    
//    
//    
////    if (indexPath.row==0) {
////        
////        static NSString *CellIdentifier = @"HistoryCell";
////        
////        HistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
////        
////        
////        if (cell == nil)
////        {
////            cell = [[HistoryCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
////        }
////        
////        
////        return cell;
////        
////    } else if (indexPath.row ==1) {
////        
////        static NSString *CellIdentifier = @"HistoryCell1";
////        
////        HistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
////        
////        
////        if (cell == nil)
////        {
////            cell = [[HistoryCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
////        }
////        return cell;
////        
////    } else if (indexPath.row==2) {
////        
////        static NSString *CellIdentifier = @"HistoryCell2";
////        
////        HistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
////        
////        
////        if (cell == nil)
////        {
////            cell = [[HistoryCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
////        }
////        
////        return cell;
////        
////    }else {
////        
////        static NSString *CellIdentifier = @"HistoryCell3";
////        
////        HistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
////        
////        
////        if (cell == nil)
////        {
////            cell = [[HistoryCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
////        }
////        
////        return cell;
////    }
//
//}

-(void)viewDidLayoutSubviews{

    [super viewDidLayoutSubviews];
    
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
