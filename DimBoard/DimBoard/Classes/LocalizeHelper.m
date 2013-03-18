//
//  LocalizeHelper.m
//  DimBoard
//
//  Created by conicacui on 18/3/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import "LocalizeHelper.h"

static LocalizeHelper* SingleLocalSystem = nil;
static NSBundle* myBundle = nil;

@implementation LocalizeHelper
@synthesize m_lang;

+ (LocalizeHelper*) sharedLocalSystem {
    // lazy instantiation
    if (SingleLocalSystem == nil) {
        SingleLocalSystem = [[LocalizeHelper alloc] init];
    }
    return SingleLocalSystem;
}
- (id) init {
    self = [super init];
    if (self) {
        myBundle = [NSBundle mainBundle];
    }
    return self;
}

// LocalizedString(@"Text");
- (NSString*) localizedStringForKey:(NSString*) key {
    return [myBundle localizedStringForKey:key value:@"" table:nil];
}

- (void) setLanguage:(NSInteger) langid {
    m_lang = [[[LangTypes alloc] init] getLangNameById:langid];
    NSString* lang = @"en";
    
    if([m_lang isEqualToString:LANG_ENG]){
        lang = @"en";
    }else if([m_lang isEqualToString:LANG_CHINESE_S]){
        lang = @"zh-Hans";
    }else if([m_lang isEqualToString:LANG_CHINESE_T]){
        lang = @"zh-Hant";
    }
    
    NSString *path = [[NSBundle mainBundle] pathForResource:lang ofType:@"lproj" ];
    if (path == nil) {
        myBundle = [NSBundle mainBundle];
    } else {
        myBundle = [NSBundle bundleWithPath:path];
        if (myBundle == nil) {
            myBundle = [NSBundle mainBundle];
        }
    }
}

-(NSString *)getLanguage{
    return m_lang;
}

@end
