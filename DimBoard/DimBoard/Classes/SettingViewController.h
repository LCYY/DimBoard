//
//  SettingViewController.h
//  DimBoard
//
//  Created by conicacui on 15/3/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingIO.h"
#import "LangPickerViewController.h"

@interface SettingViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>
{
}
@property (nonatomic, retain) SettingIO* m_settingIO;
@property (nonatomic, strong) LangPickerViewController* m_langPickerViewController;
@end
