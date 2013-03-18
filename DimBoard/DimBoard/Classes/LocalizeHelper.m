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
    m_lang = langid;
    NSString* lang = @"en";
    
    if(m_lang == 0){
        lang = @"en";
    }else if(m_lang == 1){
        lang = @"zh-Hans";
    }else if(m_lang == 2){
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

-(NSInteger)getLanguageId{
    return m_lang;
}

@end
