//
//  MortgageRecordIO.h
//  DimBoard
//
//  Created by conicacui on 20/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MortgageDataType.h"
#define PLISTFILENAME @"records.plist"

@interface MortgageRecordIO : NSObject
{
    NSInteger m_maxId;
    NSString* m_plistpath;
}
@property (retain, nonatomic) NSMutableArray* m_records;

-(id)initWithLoadRecords;
-(NSArray*)getRecords;
-(MortgageRecord*)getRecordAtIndex:(NSInteger)id;
-(void)addRecord:(MortgageRecord*)record;
-(void)updateRecord:(MortgageRecord*)record;
-(void)deleteRecord:(MortgageRecord*)record;
-(void)deleteRecordbyId:(NSInteger)rid;
-(void)save;
@end
