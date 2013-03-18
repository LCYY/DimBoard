//
//  LocalizeHelper.h
//  DimBoard
//
//  Created by conicacui on 18/3/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MortgageDataType.h"


#define DimBoardLocalizedString(key) [[LocalizeHelper sharedLocalSystem] localizedStringForKey:(key)]
#define LocalizationSetLanguage(language) [[LocalizeHelper sharedLocalSystem] setLanguage:(language)]
#define LocalizationGetLanguage() [[LocalizeHelper sharedLocalSystem] getLanguageId]

@interface LocalizeHelper : NSObject

@property (nonatomic) NSInteger m_lang;

+ (LocalizeHelper*) sharedLocalSystem;
- (NSString*) localizedStringForKey:(NSString*) key;
- (void) setLanguage:(NSInteger) langid;
- (NSInteger) getLanguageId;
@end
