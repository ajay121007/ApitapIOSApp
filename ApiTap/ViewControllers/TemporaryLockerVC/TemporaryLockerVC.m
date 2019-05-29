//
//  TemporaryLockerVC.m
//  ApiTap
//
//  Created by Bikramjeet Singh on 8/5/16.
//  Copyright © 2016 ApiTap. All rights reserved.
//

#import "TemporaryLockerVC.h"
#import "Home.h"

@interface TemporaryLockerVC () {
    
    NSMutableArray *arrOfPinCodes;
    int countOfButton;
    CGPoint startButtonLocation;
}

@property (strong , nonatomic) NSMutableString *str_randomnumber;
@property(strong , nonatomic)  NSMutableArray *arr_list;

@property (weak, nonatomic) IBOutlet UITextField *txtFieldPinCode;

@end

@implementation TemporaryLockerVC
@synthesize str_randomnumber , arr_list;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    arr_list = [[NSMutableArray alloc]init];
    
    arrOfPinCodes=[[NSMutableArray alloc]initWithCapacity:4];
    
    [self initializeNavBar];
    
    [self setbarButtonItems];
    
    [self createButton];
}

-(void)viewWillLayoutSubviews{
    
    [super viewWillLayoutSubviews];
}

#pragma mark
#pragma mark - Custom Methods

-(void)createButton{
    
    int N=4;
    int M=3;
    UIButton *customButton;
    CGFloat buttonWidthSize=80.0f;
    CGFloat buttonHeightSize=65.0f;
    
    CGFloat paddingInRow=-1.0f;
    CGFloat paddingInColumn=8.0f;
    
    int titleIncrease=1;
    
    if (self.view.frame.size.width == 320) {
        
        startButtonLocation=CGPointMake(40, 150.0f);
        
    }else{
        
        startButtonLocation=CGPointMake(self.view.frame.size.width/5.7, 150.0f);
    }
    
    
    CGPoint buttonLocation;
    
    int k ;
    k = 0; // to check no of buttons
    
    
    for (int i=0; i< N; i++) {
        
        buttonLocation.y=startButtonLocation.y + i*(buttonHeightSize+paddingInColumn);
        
        for (int j=0; j< M ; j++) {
            
            buttonLocation.x=startButtonLocation.x + j*(buttonWidthSize+paddingInRow);
            
            customButton=[UIButton buttonWithType:UIButtonTypeCustom];
            
            customButton.frame=CGRectMake(buttonLocation.x , buttonLocation.y , buttonWidthSize, buttonHeightSize);
            
            
            if (k < 9) {
                int m ;// value from the array
                m=0;
                [self randomnumbergenerater];
                
                NSString *str_rand = [arr_list objectAtIndex:k];
                m = [str_rand intValue];
                //                m = m+1;
                
                [customButton setTitle:[NSString stringWithFormat:@"%d",m] forState:UIControlStateNormal];
                customButton.titleLabel.textColor=[UIColor whiteColor];
            }
            
            k++;
            
            if (k == 10) {
                
                [customButton setBackgroundImage:[UIImage imageNamed:@"btnNumber.png"] forState:UIControlStateNormal];
                
                [customButton setImage:[UIImage imageNamed:@"iconPinClean.png"] forState:UIControlStateNormal];
                
                [customButton addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
                
            }else if (k == 11){
                
                [self randomnumbergenerater];
                
                NSString *str_rand = [arr_list objectAtIndex:9];
                
                 [customButton setBackgroundImage:[UIImage imageNamed:@"btnNumber.png"] forState:UIControlStateNormal];
                
                [customButton setTitle:[NSString stringWithFormat:@"%@",str_rand] forState:UIControlStateNormal];
                customButton.titleLabel.textColor=[UIColor whiteColor];
                
                  [customButton addTarget:self action:@selector(getButtonTitle:) forControlEvents:UIControlEventTouchUpInside];
                

            }else if (k == 12){
                
                [customButton setBackgroundImage:[UIImage imageNamed:@"btnNumber.png"] forState:UIControlStateNormal];
                
                [customButton setImage:[UIImage imageNamed:@"iconPinCancel.png"] forState:UIControlStateNormal];
                
                [customButton addTarget:self action:@selector(clearValue:) forControlEvents:UIControlEventTouchUpInside];
                
            }else{
                
                [customButton setBackgroundImage:[UIImage imageNamed:@"btnNumber.png"] forState:UIControlStateNormal];
                [customButton addTarget:self action:@selector(getButtonTitle:) forControlEvents:UIControlEventTouchUpInside];
                

            }
            
//            if (k == 10) {
//                
//               // customButton.hidden=NO;
//                
//               
//                
//            }
//            if (k == 11) {
//                
//               
//                //  [customButton setTitle:@"0" forState:UIControlStateNormal];
//            }
//            if (k == 12) {
//                
//               // customButton.hidden=YES;
//                
//                
//            }
            //image button random
            customButton.tag=j + titleIncrease;
            
            [self.view addSubview:customButton];
        }
        titleIncrease= titleIncrease + M ;
        
    }
}

#pragma mark -
#pragma Mark - Random

-(void)clearValue:(UIButton *)button{
    
    countOfButton=0;
    _txtFieldPinCode.text=@"";
    [arrOfPinCodes removeAllObjects];
}

-(void)goBack:(UIButton *)button{
    
    UIViewController *viewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"home"];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    [self.menuContainerViewController setCenterViewController:navi];
    
    // enable the menu slide animation
    [self.menuContainerViewController setMenuSlideAnimationEnabled:YES];
    
    // control the exaggeration of the menu slide animation
    [self.menuContainerViewController setMenuSlideAnimationFactor:3.0f];
    
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{}];
    
    
//    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
//                                                             bundle: nil];
//    
//    Home *vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"home"];
//    
//    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)getButtonTitle:(UIButton *)button{
    
    countOfButton ++;
    NSLog(@"%i",countOfButton);
    if (countOfButton <= 4) {
        [arrOfPinCodes addObject:button.titleLabel.text];
        
    }
    
    NSLog(@"%@",arrOfPinCodes);
    
    NSString *result = [[arrOfPinCodes valueForKey:@"description"] componentsJoinedByString:@""];
    NSString *shortString = ([result length]>4 ? [result substringToIndex:4]  : result);
    
    for (int i=1; i<=shortString.length; i++)
    {
        _txtFieldPinCode.text=shortString;
    }
    
}

-(void)backClicked:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - random no genterator

-(void)randomnumbergenerater
{
    int x = arc4random()%10;
    
    NSNumber *someNumber = @(x);
    NSString *randNum = [someNumber stringValue];
    
    if ([arr_list containsObject: randNum]) {
        [self randomnumbergenerater];
        
    }
    else  {
        [arr_list addObject:randNum];
    }
       
    
    randNum = nil;
}


- (IBAction)btnSubmitAction:(id)sender {
    
    if (![self checkInternetConeection]) {
        
        return;
    }
    
//    if ([sender tag]== 0)         //Enter
//    {
    
        NSLog(@"print enter numbers %@",_txtFieldPinCode.text);
    
        NSMutableDictionary *dictParam = [NSMutableDictionary new];
    
        [dictParam setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"loginUserID"] forKey:@"53"];
    
        [dictParam setValue:[GlobalClass getDeviceUUID] forKey:@"57"];
    
        NSString * str = _txtFieldPinCode.text;
    
        NSString * hexStr = [NSString stringWithFormat:@"%@",
                         [NSData dataWithBytes:[str cStringUsingEncoding:NSUTF8StringEncoding]
                                        length:strlen([str cStringUsingEncoding:NSUTF8StringEncoding])]];
    
        for(NSString * toRemove in [NSArray arrayWithObjects:@"<", @">", @" ", nil])
        hexStr = [hexStr stringByReplacingOccurrencesOfString:toRemove withString:@""];
    
        NSLog(@"%@", hexStr);
    
        [dictParam setValue:hexStr forKey:@"64"];
        
        [model_manager.loginManager userLogin:@"050300007" userinfo:dictParam completionResponse:^(NSDictionary *dict, NSError *err) {
            if (!err)
            {
                
                NSLog(@"Signup response : %@",dict[@"RESULT"][0][@"_127_41"]);
                
                if ([[NSString stringWithFormat:@"%@",dict[@"RESULT"][0][@"_127_41"]] isEqualToString:@"0"]) {
                    
                    [self performSegueWithIdentifier:@"goto_setting_vc" sender:nil];
                    
                }else{
                    
                     [CustomAlertView showAlert:@"Alert" message:[NSString stringWithFormat:@"%@",dict[@"RESULT"][0][@"_127_41"]]];
                }
                
            }
            
        }];
    //}
//    else if ([sender tag]== 1)    //Clear
//    {
//        NSString *newTitleStr=nil;
//        NSString *txtFieldText=_txtFieldPinCode.text;
//        if (txtFieldText.length!=0) {
//            newTitleStr =[txtFieldText substringToIndex:[txtFieldText length] - 1];
//            
//            [arrOfPinCodes removeLastObject];
//            countOfButton --;
//            //[arrOfPinCodes removeObjectAtIndex:txtFieldText.length - 1];
//            if ([newTitleStr isEqualToString:@""]) {
//                [arrOfPinCodes removeAllObjects];
//                countOfButton=0;
//            }
//            _txtFieldPinCode.text=newTitleStr;
//            
//        }
//        else
//        {
//            _txtFieldPinCode.text=newTitleStr;
//        }
//    }
//    else if ([sender tag]== 2)   //Cancel
//    {
//        
//        countOfButton=0;
//        _txtFieldPinCode.text=@"";
//        [arrOfPinCodes removeAllObjects];
//        
//    }
//    else if ([sender tag]== 3)   //Sign Out
//    {
//        [self.navigationController popViewControllerAnimated:YES];
//    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
