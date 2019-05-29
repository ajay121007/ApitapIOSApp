//
//  ShowLeftSliderSpecialsVC.h
//  ApiTap
//
//  Created by Bikramjeet Singh on 9/28/16.
//  Copyright © 2016 ApiTap. All rights reserved.
//

#import "BaseViewController.h"

@interface ShowLeftSliderSpecialsVC : BaseViewController
-(void)add:(NSDictionary *)aFloat withFatness:(int)varFatness flag:(BOOL)varflag;
- (NSDictionary *)stringForKey:(NSDictionary *)key withFatness2:(int)varFatness2 flag2:(BOOL)varflag2 completion:(void(^)(void))callback;


@end
