//
//  SettingViewController.h
//  DimBoard
//
//  Created by conicacui on 15/3/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingIO.h"

@interface SettingViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>
{
}
@property (nonatomic, retain) SettingIO* m_settingIO;
@end
