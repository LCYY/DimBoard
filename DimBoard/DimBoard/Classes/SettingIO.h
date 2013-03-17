//
//  SettingIO.h
//  DimBoard
//
//  Created by conicacui on 15/3/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MortgageDataType.h"

#define SETTINGPLISTFILENAME @"settings.plist"
@interface SettingIO : NSObject
{
    NSString* m_plistpath;
}
@property (retain, nonatomic) NSMutableArray* m_settings;

-(id)initWithLoadSettings;
-(void)save;

-(NSString*) getLang;
@end
