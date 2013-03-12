//
//  DimBoardTabBarViewController.h
//  DimBoard
//
//  Created by Lin Yangyang on 13-3-4.
//  Copyright (c) 2013年 LCYY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MortgageCalViewController.h"
#import "MortgageRecordViewController.h"
#import "DimBoardNotifications.h"

@interface DimBoardTabBarViewController : UITabBarController

@property (retain, nonatomic) MortgageCalViewController* m_calViewController;
@property (retain, nonatomic) MortgageRecordViewController* m_recordViewController;
@end
