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

@interface Settings : NSObject
@property (nonatomic) NSInteger langId;
@end

@interface SettingIO : NSObject
{
    NSString* m_plistpath;
}
@property (strong, nonatomic) Settings* m_settings;

-(id)initWithLoadSettings;
-(void)save;
-(NSString*) getValueByKey:(NSString*)key;
@end
