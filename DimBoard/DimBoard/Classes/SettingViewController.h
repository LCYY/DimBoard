//
//  SettingViewController.h
//  DimBoard
//
//  Created by conicacui on 15/3/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import "SettingIO.h"
#import "LangPickerViewController.h"
#import "LocalizeHelper.h"

@interface SettingViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ADBannerViewDelegate, UpdateSettingItemProtocol>
{
}
@property (weak, nonatomic) IBOutlet ADBannerView *m_adBannerView;
@property (weak, nonatomic) IBOutlet UITableView *m_tableView;
@property (nonatomic, retain) SettingIO* m_settingIO;
@property (nonatomic, strong) LangPickerViewController* m_langPickerViewController;
@property (nonatomic, strong) NSMutableArray* m_sections;
@property (weak, nonatomic) id<UpdateSettingItemProtocol> m_delegate;
//section 1
//language
-(void)setSectionsWithSettings;
@end
