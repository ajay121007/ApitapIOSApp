//
//  BaseViewController.h
//  SportsPal
//
//  Created by Abhishek Singla on 10/03/16.
//  Copyright © 2016 SportsPal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IQDropDownTextField.h"
#import <CoreLocation/CoreLocation.h>
@interface BaseViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    UIPickerView *myPickerView;
    UIButton *doneButton ;
    NSMutableArray *selectedBtnarr;
}


-(void) initializeNavBar;
-(void) setBarBtnItems;
-(UITextField*)customtxtfield:(UITextField*)txtField withrightIcon:(UIImage*)image bottomLayer:(BOOL)isBottomLayerRequired;
-(void)navigationBarTitle:(NSString*)title;
-(void)navBarLogo;
-(void)setbarButtonItems;
-(void)crEATEVIEW;
-(void)setHomeButton;
-(void)setCollectionViewButton;
-(BOOL)checkInternetConeection;
-(void)createBtn;
@property (nonatomic, retain) CLLocationManager *locationManagers;
@end

