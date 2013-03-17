//
//  SettingIO.m
//  DimBoard
//
//  Created by conicacui on 15/3/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import "SettingIO.h"

@implementation SettingIO
@synthesize m_settings;

-(id)init{
    self = [super init];
    if(self){
        m_plistpath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:SETTINGPLISTFILENAME];
        
        NSMutableArray* language = [[NSMutableArray alloc] initWithObjects:
                                    KEY_SETTING_LANG,LANG_CHINESE_T,
                                    nil];
        
        m_settings = [[NSMutableArray alloc] initWithObjects:
                      language,
                      nil];
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
            for(int i = 0; i< [m_settings count]; i++){
                NSString* key = [[m_settings objectAtIndex:i] objectAtIndex:0];
                NSString* value = [settingsDict valueForKey:key];
                [[m_settings objectAtIndex:i] setObject:value atIndex:1];
            }
        }
    }
    return self;
}

-(void)save{
    NSMutableDictionary* settingsDict = [[NSMutableDictionary alloc] init];
    for(NSInteger i = 0; i< [m_settings count]; i++){
        [settingsDict setObject:[[m_settings objectAtIndex:i] objectAtIndex:1] forKey:[[m_settings objectAtIndex:i] objectAtIndex:0]];
    }
    [settingsDict writeToFile:m_plistpath atomically:YES];

}

-(NSString *)getLang{
    return [[m_settings objectAtIndex:0] objectAtIndex:1];
}
@end