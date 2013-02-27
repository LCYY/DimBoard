//
//  MortgageRecordIO.m
//  DimBoard
//
//  Created by conicacui on 20/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import "MortgageRecordIO.h"

@implementation MortgageRecordIO
@synthesize m_records;

-(id)initWithLoadRecords{
    self = [self init];
    if(self){
        m_maxId = -1;
        m_plistpath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:PLISTFILENAME];
        m_records = [[NSMutableArray alloc] init];
        
        if(![[NSFileManager defaultManager] fileExistsAtPath:m_plistpath])
            return self;
        
        NSDictionary* recordsDict = [[NSDictionary alloc] initWithContentsOfFile:m_plistpath];
        
        if(recordsDict){
            for(id key in recordsDict){
                NSDictionary* recordDict = [recordsDict objectForKey:key];
                if(recordDict){
                    MortgageRecord* record = [[MortgageRecord alloc]
                                              initWithRecordId:[recordDict objectForKey:KEY_MORTGAGE_RECORDID]
                                              Name:[recordDict objectForKey:KEY_MORTGAGE_NAME]
                                              BankId:[recordDict objectForKey:KEY_MORTGAGE_BANKID]
                                              Date:[recordDict objectForKey:KEY_MORTGAGE_LOANDATE]
                                              HomeValue:[recordDict objectForKey:KEY_MORTGAGE_HOMEVALUE]
                                              LoanYear:[recordDict objectForKey:KEY_MORTGAGE_LOANYEAR]
                                              LoanPercent:[recordDict objectForKey:KEY_MORTGAGE_LOANPERCENT]
                                              LoanRate:[recordDict objectForKey:KEY_MORTGAGE_LOANRATE]];
                    [m_records addObject:record];
                }
                // update m_maxId
                NSInteger maxid = [key integerValue];
                if(m_maxId < maxid){
                    m_maxId = maxid;
                }
            }
            NSSortDescriptor* sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
            m_records = [[m_records sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]] mutableCopy];
        }
    }
    return self;
}

-(NSArray*)getRecords{
    if(m_records)
        return [[NSArray alloc] initWithArray:m_records copyItems:YES];
    else
        return nil;
}

-(MortgageRecord*)getRecordAtIndex:(NSInteger)id{
    if(m_records){
        return [[m_records objectAtIndex:id] copy];
    }else{
        return nil;
    }
}

-(void)addRecord:(MortgageRecord*)record{
    m_maxId ++;
    record->recordId = m_maxId ;
    [m_records addObject:[record copy]];
    NSSortDescriptor* sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    m_records = [[m_records sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]] mutableCopy];
    [self save];
}

-(void)updateRecord:(MortgageRecord*)r{
    NSInteger rid = r->recordId;
    for(NSInteger i = 0; i< [m_records count]; i++){
        MortgageRecord* record = [m_records objectAtIndex:i];
        if(record->recordId == rid){
            [m_records replaceObjectAtIndex:i withObject:[r copy]];
        }
    }
    NSSortDescriptor* sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    m_records = [[m_records sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]] mutableCopy];
    [self save];
}

-(void)deleteRecord:(MortgageRecord*)r{
    NSInteger rid = r->recordId;
    [self deleteRecordbyId:rid];
}

-(void)deleteRecordbyId:(NSInteger)rid{
    for(NSInteger i = 0; i< [m_records count]; i++){
        MortgageRecord* record = [m_records objectAtIndex:i];
        if(record->recordId == rid){
            [m_records removeObjectAtIndex:i];
        }
    }
    [self save];
}

-(void)save{
    //delete the old file
    [[NSFileManager defaultManager] removeItemAtPath:m_plistpath error:nil];
    
    NSMutableDictionary* recordsDict = [[NSMutableDictionary alloc] init];
    for(NSInteger i = 0; i< [m_records count]; i++){
        MortgageRecord* record = [m_records objectAtIndex:i];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat: DATEFORMAT];
        NSString* datestring = [dateFormatter stringFromDate:record.input.date];
        NSDictionary* recordDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    record.name, KEY_MORTGAGE_NAME,
                                    datestring, KEY_MORTGAGE_LOANDATE,
                                    [NSString stringWithFormat:@"%d",record->bankId], KEY_MORTGAGE_BANKID,
                                    [NSString stringWithFormat:@"%d",record->recordId], KEY_MORTGAGE_RECORDID,
                                    [NSString stringWithFormat:@"%0.2f",record.input->homeValue], KEY_MORTGAGE_HOMEVALUE,
                                    [NSString stringWithFormat:@"%0.2f",record.input->loanPercent], KEY_MORTGAGE_LOANPERCENT,
                                    [NSString stringWithFormat:@"%0.2f",record.input->loanRate], KEY_MORTGAGE_LOANRATE,
                                    [NSString stringWithFormat:@"%d",record.input->loanYear], KEY_MORTGAGE_LOANYEAR,
                                    nil];
        [recordsDict setObject:recordDict forKey:[recordDict objectForKey:KEY_MORTGAGE_RECORDID]];
    }
    [recordsDict writeToFile:m_plistpath atomically:YES];
}
@end
