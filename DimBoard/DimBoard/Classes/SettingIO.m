//
//  SettingIO.m
//  DimBoard
//
//  Created by conicacui on 15/3/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import "SettingIO.h"

@implementation Settings
@synthesize langId;

-(id)init{
    self = [super init];
    if(self){
        langId = 1;
    }
    return self;
}
@end


@implementation SettingIO
@synthesize m_settings;

-(id)init{
    self = [super init];
    if(self){
        m_plistpath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:SETTINGPLISTFILENAME];
                
        m_settings = [[Settings alloc] init];
    }
    return self;
}

-(id)initWithLoadSettings{
    self = [self init];
    if(self){         
        if(![[NSFileManager defaultManager] fileExistsAtPath:m_plistpath])
            return self;
        
        NSDictionary* settingsDict = [[NSDictionary alloc] initWithContentsOfFile:m_plistpath];
        
        if(settingsDict){
            m_settings.langId = [[settingsDict valueForKey:KEY_SETTING_LANG] integerValue];
        }
    }
    return self;
}

-(void)save{
    NSMutableDictionary* settingsDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                         [NSString stringWithFormat:@"%d",m_settings.langId], KEY_SETTING_LANG,
                                         nil];

    [settingsDict writeToFile:m_plistpath atomically:YES];
}

-(NSString *)getValueByKey:(NSString *)key{
    return [m_settings valueForKey:key];
}

@end