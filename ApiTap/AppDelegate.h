//
//  AppDelegate.h
//  ApiTap
//
//  Created by Abhishek Singla on 11/03/16.
//  Copyright © 2016 ApiTap. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property(nonatomic,strong) LabeledActivityIndicatorView *objLoader;
@property(nonatomic,strong)NSString *strApplicationUUID;
@property (nonatomic , strong)CLLocationManager *locationManager;
@property (nonatomic , strong)CLLocation *currentLocation;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

-(BOOL)checkInternetConnectivity;

@end

