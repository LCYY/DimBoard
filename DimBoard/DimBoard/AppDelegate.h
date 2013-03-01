//
//  AppDelegate.h
//  DimBoard
//
//  Created by conicacui on 30/1/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MortgageCalViewController.h"

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//@property (strong, nonatomic) ViewController *viewController;
@property (strong, nonatomic) MortgageCalViewController *viewController;

@end
