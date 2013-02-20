//
//  MortgageDataType.m
//  DimBoard
//
//  Created by conicacui on 5/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import "MortgageDataType.h"

@implementation BankTypes
@synthesize m_banks;

-(id)init{
    self = [super init];
    if(self){
        m_banks = [[NSArray alloc] initWithObjects:
                    @"渣打銀行",
                    @"匯豐銀行",
                    @"中國建設銀行",
                    @"中國銀行",
                    @"東亞銀行",
                    @"恆生銀行",
                    @"大新銀行",
                    @"中國工商銀行",
                    @"花旗銀行",
                    @"中信銀行",
                    @"星展銀行",
                    @"富邦銀行",
                    @"創興銀行",
                    @"豐明銀行",
                    @"南洋商業銀行",
                    @"大眾銀行",
                    @"上海商業銀行",
                    @"標準銀行銀行",
                    @"大生銀行",
                    @"大有銀行",
                    @"永亨銀行",
                    @"永隆銀行",
        nil];
    }
    return self;
    
}

-(NSString*)getBankNameById:(NSInteger)bid{
    return [m_banks objectAtIndex:bid];
}

-(NSInteger)getBankCount{
    return [m_banks count];
}
@end


@implementation MortgageInput

-(id)init{
    self = [super init];
    if(self){
        homeValue = 0.0;
        loanYear = 0;
        loanPercent = 0.0;
        loanRate = 0.0;
    }
    return self;
}

-(id)initWithHomeValue:(double)hv LoanYear:(NSInteger)ly LoanPercent:(double)lp LoanRate:(double)lr{
    self = [self init];
    if(self){
        homeValue = hv;
        loanYear = ly;
        loanPercent = lp;
        loanRate = lr;
    }
    return self;
}

-(void)setInput:(MortgageInput*) input{
    homeValue = input->homeValue;
    loanYear = input->loanYear;
    loanPercent = input->loanPercent;
    loanRate = input->loanRate;
}

-(void)setHomeValue:(double)hv LoanYear:(NSInteger)ly LoanPercent:(double)lp LoanRate:(double)lr{
    homeValue = hv;
    loanYear = ly;
    loanPercent = lp;
    loanRate = lr;
}

#pragma marks
#pragma marks - NSCopying
-(id)copyWithZone:(NSZone *)zone{
    MortgageInput* copy = [[[self class] allocWithZone:zone] init];
    if(copy){
        copy->homeValue = homeValue;
        copy->loanPercent = loanPercent;
        copy->loanRate = loanRate;
        copy->loanYear = loanYear;
    }
    return copy;
}

-(id)copy{
    MortgageInput* copy = [[[self class] alloc] init];
    if(copy){
        copy->homeValue = homeValue;
        copy->loanPercent = loanPercent;
        copy->loanRate = loanRate;
        copy->loanYear = loanYear;
    }
    return copy;
}

@end

@implementation MortgageOutput
-(id)init{
    self = [super init];
    if(self){
        comission = 0.0;
        firstExpence = 0.0;
        firstPay = 0.0;
        loanAmount = 0.0;
        loanTerms = 0;
        monthlyPay = 0.0;
        tax = 0.0;
        totalExpence = 0.0;
        totoalPay = 0.0;
        totalInterest = 0.0;
    }
    return self;
}

-(void)getOutput:(MortgageOutput*)output{
    output->comission = comission;
    output->firstExpence = firstExpence;
    output->firstPay = firstPay;
    output->loanAmount = loanAmount;
    output->loanTerms = loanTerms;
    output->monthlyPay = monthlyPay;
    output->tax = tax;
    output->totalExpence = totalExpence;
    output->totoalPay = totoalPay;
    output->totalInterest = totalInterest;
}

#pragma marks
#pragma marks - NSCopying
-(id)copyWithZone:(NSZone *)zone{
    MortgageOutput* copy = [[[self class] allocWithZone:zone] init];
    if(copy){
        copy->comission = comission;
        copy->firstExpence = firstExpence;
        copy->firstPay = firstPay;
        copy->loanAmount = loanAmount;
        copy->loanTerms = loanTerms;
        copy->monthlyPay = monthlyPay;
        copy->tax = tax;
        copy->totalExpence = totalExpence;
        copy->totoalPay = totoalPay;
        copy->totalInterest = totalInterest;
    }
    return copy;
}

-(id)copy{
    MortgageOutput* copy = [[[self class] alloc] init];
    if(copy){
        copy->comission = comission;
        copy->firstExpence = firstExpence;
        copy->firstPay = firstPay;
        copy->loanAmount = loanAmount;
        copy->loanTerms = loanTerms;
        copy->monthlyPay = monthlyPay;
        copy->tax = tax;
        copy->totalExpence = totalExpence;
        copy->totoalPay = totoalPay;
        copy->totalInterest = totalInterest;
    }
    return copy;
}

@end

@implementation MortgageRecord

-(id)init{
    self = [super init];
    if(self){
        input = [[MortgageInput alloc] initWithHomeValue:0 LoanYear:0 LoanPercent:0 LoanRate:0];
        recordId = -1;
        name = @"";
        date = [NSDate date];
        bankId = 0;
    }
    return self;
}

-(id)initWithNSStringRecordId:(NSString*)rid Name:(NSString*)nm BankId:(NSString*)bid Date:(NSString*)dt HomeValue:(NSString*)hv LoanYear:(NSString*)ly LoanPercent:(NSString*)lp LoanRate:(NSString*)lr{
    self = [self init];
    if(self){
        recordId = [rid integerValue];
        [input setHomeValue:[hv doubleValue] LoanYear:[ly integerValue] LoanPercent:[lp doubleValue] LoanRate:[lr doubleValue]];
        name = nm;
        bankId = [bid integerValue];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];  
        [dateFormatter setDateFormat: @"yyyy-MM-dd"];
        date = [dateFormatter dateFromString:dt];
    }
    
    return self;
}

-(id)initWithName:(NSString*)nm BankId:(NSInteger)bid Date:(NSDate*)dt HomeValue:(double)hv LoanYear:(NSInteger)ly LoanPercent:(double)lp LoanRate:(double)lr{
    self = [self init];
    if(self){
        [input setHomeValue:hv LoanYear:ly LoanPercent:lp LoanRate:lr];
        name = nm;
        bankId = bid;
        date = dt;
    }
    return self;
}

-(void) updateRecord:(MortgageRecord*)record{
    recordId = record->recordId;
    name = [NSString stringWithString:record->name];
    bankId = record->bankId;
    date = [[NSDate alloc] initWithTimeInterval:0 sinceDate:record->date];
    
    [input setInput:record->input];
}

#pragma marks
#pragma marks - NSCopying
-(id)copy{
    MortgageRecord* copy = [[[self class] alloc] init];
    if (copy)
    {
        copy->name = [NSString stringWithString:name];
        copy->bankId = bankId;
        copy->date = [[NSDate alloc] initWithTimeInterval:0 sinceDate:date];
        copy->recordId = recordId;
        copy->input = [input copy];
    }
    
    return copy;
}

-(id)copyWithZone:(NSZone *)zone{
    MortgageRecord* copy = [[[self class] allocWithZone:zone] init];
    if (copy)
    {
        copy->name = [NSString stringWithString:name];
        copy->bankId = bankId;
        copy->date = [[NSDate alloc] initWithTimeInterval:0 sinceDate:date];
        copy->recordId = recordId;
        copy->input = [input copyWithZone:zone];
    }
    
    return copy;
}



@end