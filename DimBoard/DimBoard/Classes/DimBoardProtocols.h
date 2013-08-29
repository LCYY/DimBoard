//
//  DimBoardProtocols.h
//  DimBoard
//
//  Created by Lin Yangyang on 13-3-17.
//  Copyright (c) 2013年 LCYY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MortgageDataType.h"

@protocol UpdateRecordItemProtocol <NSObject>
@required
-(void)updateRecordKey:(NSString*)kay withValue:(id)value;
@optional
-(void)startEditRecordKey:(NSString*)key;
@end

@protocol UpdateRecordProtocol <NSObject>
@optional
-(void)updateRecord:(MortgageRecord*)record;
-(void)addNewRecord:(MortgageRecord*)record;
@end

@protocol UpdateSettingItemProtocol <NSObject>
@required
-(void)updateSettingKey:(NSString*)kay withValue:(id)value;
@end
