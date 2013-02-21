//
//  UpdateRecordItemProtocol.h
//  DimBoard
//
//  Created by conicacui on 21/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MortgageDataType.h"

@protocol UpdateRecordItemProtocol <NSObject>
@required
-(void)updateRecordKey:(NSString*)kay withValue:(id)value;
@end

@protocol UpdateRecordProtocol <NSObject>
-(void)updateRecord:(MortgageRecord*)record;
-(void)addNewRecord:(MortgageRecord*)record;
@end