//
//  SettingIO.h
//  DimBoard
//
//  Created by conicacui on 15/3/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SETTINGPLISTFILENAME @"settings.plist"
#define KEY_SETTING_LANG NSLocalizedString(@"Language",nil)

#define LANG_CHINESE_T NSLocalizedString(@"TChinese",nil)
#define LANG_CHINESE_S NSLocalizedString(@"SChinese",nil)
#define LANG_ENG NSLocalizedString(@"English",nil)

@interface SettingIO : NSObject
{
    NSString* m_plistpath;
}
@property (retain, nonatomic) NSMutableArray* m_settings;

-(id)initWithLoadSettings;
-(void)save;
-(void)setLanguage:(NSString*)lang;
-(NSString*)getLanguage;
@end
