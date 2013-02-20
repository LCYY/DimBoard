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
#define KEY_MORTGAGE_RECORDID @"mortgage_recordid"
#define KEY_MORTGAGE_NAME @"mortgage_name"
#define KEY_MORTGAGE_BANKID @"mortgage_bankid"
#define KEY_MORTGAGE_HOMEVALUE @"mortgage_homevalue"
#define KEY_MORTGAGE_LOANPERCENT @"mortgage_loanpercent"
#define KEY_MORTGAGE_LOANYEAR @"mortgage_loanyear"
#define KEY_MORTGAGE_LOANRATE @"mortgage_loanrate"
#define KEY_MORTGAGE_LOANDATE @"mortgage_loandate"

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
