//
//  MortgageDataType.m
//  DimBoard
//
//  Created by conicacui on 5/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import "MortgageDataType.h"

@implementation LangTypes
@synthesize m_langs;
-(id)init{
    self = [super init];
    if(self){
        m_langs = [[NSArray alloc] initWithObjects:
                   DimBoardLocalizedString(@"English"),
                   DimBoardLocalizedString(@"TChinese"),
                   DimBoardLocalizedString(@"SChinese"),
                   nil];
    }
    return self;
}

-(NSInteger)getLangCount{
    return [m_langs count];
}

-(NSString *)getLangNameById:(NSInteger)lid{
    return [m_langs objectAtIndex:lid];
}
@end

@implementation BankTypes
@synthesize m_banks;

-(id)init{
    self = [super init];
    if(self){
        m_banks = [[NSArray alloc] initWithObjects:
                   DimBoardLocalizedString(@"StandardBank"),
                   DimBoardLocalizedString(@"HongkongShanghaiBankigCorp"),
                   DimBoardLocalizedString(@"ChinaConstructionBank"),
                   DimBoardLocalizedString(@"ChinaBank"),
                   DimBoardLocalizedString(@"AsiaBank"),
                   DimBoardLocalizedString(@"HangSengBank"),
                   DimBoardLocalizedString(@"DahSingBank"),
                   DimBoardLocalizedString(@"ChinaIndustrialBank"),
                   DimBoardLocalizedString(@"CitiBank"),
                   DimBoardLocalizedString(@"CITICBank"),
                   DimBoardLocalizedString(@"DBSBank"),
                   DimBoardLocalizedString(@"FubonBank"),
                   DimBoardLocalizedString(@"ChongHingBank"),
                   DimBoardLocalizedString(@"MEVASBank"),
                   DimBoardLocalizedString(@"NanyangBank"),
                   DimBoardLocalizedString(@"PublicBank"),
                   DimBoardLocalizedString(@"ShanghaiCommercialBank"),
                   DimBoardLocalizedString(@"WingHangBank"),
                   DimBoardLocalizedString(@"WingLungBank"),
//
//                   
//                    @"渣打銀行",
//                    @"匯豐銀行",
//                    @"中國建設銀行",
//                    @"中國銀行",
//                    @"東亞銀行",
//                    @"恆生銀行",
//                    @"大新銀行",
//                    @"中國工商銀行",
//                    @"花旗銀行",
//                    @"中信銀行",
//                    @"星展銀行",
//                    @"富邦銀行",
//                    @"創興銀行",
//                    @"豐明銀行",
//                    @"南洋商業銀行",
//                    @"大眾銀行",
//                    @"上海商業銀行",
//                    @"永亨銀行",
//                    @"永隆銀行",
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
@synthesize date;

-(id)init{
    self = [super init];
    if(self){
        homeValue = 0.0;
        loanYear = 0;
        loanPercent = 0.0;
        interestRate = 0.0;
        date = [NSDate date];
    }
    return self;
}

-(id)initWithHomeValue:(double)hv LoanYear:(NSInteger)ly LoanPercent:(double)lp LoanRate:(double)lr LoanDate:(NSDate*)dt{
    self = [self init];
    if(self){
        homeValue = hv;
        loanYear = ly;
        loanPercent = lp;
        interestRate = lr;
        date = [dt copy];
    }
    return self;
}

#pragma mark - NSCopying
-(id)copyWithZone:(NSZone *)zone{
    MortgageInput* copy = [[[self class] allocWithZone:zone] init];
    if(copy){
        copy->homeValue = homeValue;
        copy->loanPercent = loanPercent;
        copy->interestRate = interestRate;
        copy->loanYear = loanYear;
        copy->date = [date copyWithZone:zone];
    }
    return copy;
}

-(id)copy{
    MortgageInput* copy = [[[self class] alloc] init];
    if(copy){
        copy->homeValue = homeValue;
        copy->loanPercent = loanPercent;
        copy->interestRate = interestRate;
        copy->loanYear = loanYear;
        copy->date = [date copy];
    }
    return copy;
}

@end

@implementation MortgageOutput
@synthesize principals, leftLoanAmounts;

-(id)init{
    self = [super init];
    if(self){
        comission = 0.0;
        firstTotalExp = 0.0;
        firstPayment = 0.0;
        loanAmount = 0.0;
        loanTerms = 0;
        monthlyPay = 0.0;
        tax = 0.0;
        totalExpence = 0.0;
        rePayment = 0.0;
        rePaymentInterest = 0.0;
        paidPrincipal = 0.0;
        toPayPrincipal = 0.0;
        paidTerms = 0;
        paidInterest = 0.0;
        toPayInterest = 0.0;
        principals = [[NSMutableArray alloc] init];
        leftLoanAmounts = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark - NSCopying
-(id)copyWithZone:(NSZone *)zone{
    MortgageOutput* copy = [[[self class] allocWithZone:zone] init];
    if(copy){
        copy->comission = comission;
        copy->firstTotalExp = firstTotalExp;
        copy->firstPayment = firstPayment;
        copy->loanAmount = loanAmount;
        copy->loanTerms = loanTerms;
        copy->monthlyPay = monthlyPay;
        copy->tax = tax;
        copy->totalExpence = totalExpence;
        copy->rePayment = rePayment;
        copy->rePaymentInterest = rePaymentInterest;
        copy->paidPrincipal = paidPrincipal;
        copy->toPayPrincipal = toPayPrincipal;
        copy->paidTerms = paidTerms;
        copy->paidInterest = paidInterest;
        copy->toPayInterest = toPayInterest;
        copy->principals = [principals mutableCopyWithZone:zone];
        copy->leftLoanAmounts = [leftLoanAmounts mutableCopyWithZone:zone];
    }
    return copy;
}

-(id)copy{
    MortgageOutput* copy = [[[self class] alloc] init];
    if(copy){
        copy->comission = comission;
        copy->firstTotalExp = firstTotalExp;
        copy->firstPayment = firstPayment;
        copy->loanAmount = loanAmount;
        copy->loanTerms = loanTerms;
        copy->monthlyPay = monthlyPay;
        copy->tax = tax;
        copy->totalExpence = totalExpence;
        copy->rePayment = rePayment;
        copy->rePaymentInterest = rePaymentInterest;
        copy->paidPrincipal = paidPrincipal;
        copy->toPayPrincipal = toPayPrincipal;
        copy->paidTerms = paidTerms;
        copy->paidInterest = paidInterest;
        copy->toPayInterest = toPayInterest;
        copy->principals = [principals mutableCopy];
        copy->leftLoanAmounts = [leftLoanAmounts mutableCopy];
    }
    return copy;
}

@end

@implementation MortgageRecord
@synthesize input, name;

-(id)init{
    self = [super init];
    if(self){
        input = [[MortgageInput alloc] init];
        recordId = -1;
        name = @"";
        bankId = 0;
    }
    return self;
}

-(id)initWithRecordId:(NSString*)rid Name:(NSString*)nm BankId:(NSString*)bid Date:(NSString*)dt HomeValue:(NSString*)hv LoanYear:(NSString*)ly LoanPercent:(NSString*)lp LoanRate:(NSString*)lr{
    self = [self init];
    if(self){
        recordId = [rid integerValue];
        bankId = [bid integerValue];
        name = [nm copy];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat: DATEFORMAT];
        
        input = [[MortgageInput alloc] initWithHomeValue:[hv doubleValue] LoanYear:[ly integerValue] LoanPercent:[lp doubleValue] LoanRate:[lr doubleValue] LoanDate:[dateFormatter dateFromString:dt]];
    }
    
    return self;
}

-(id)initWithName:(NSString*)nm BankId:(NSInteger)bid Date:(NSDate*)dt HomeValue:(double)hv LoanYear:(NSInteger)ly LoanPercent:(double)lp LoanRate:(double)lr{
    self = [self init];
    if(self){
        bankId = bid;
        input = [[MortgageInput alloc] initWithHomeValue:hv LoanYear:ly LoanPercent:lp LoanRate:lr LoanDate:dt];
        name = [nm copy];
    }
    return self;
}

-(id)initWithMortgageInput:(MortgageInput *)in{
    self = [self init];
    if(self){
        input = [in copy];
    }
    return self;
}

#pragma mark - NSCopying
-(id)copy{
    MortgageRecord* copy = [[[self class] alloc] init];
    if (copy)
    {
        copy->bankId = bankId;
        copy->recordId = recordId;
        copy->name = [name copy];
        copy->input = [input copy];
    }
    return copy;
}

-(id)copyWithZone:(NSZone *)zone{
    MortgageRecord* copy = [[[self class] allocWithZone:zone] init];
    if (copy)
    {
        copy->bankId = bankId;
        copy->recordId = recordId;
        copy->name = [name copyWithZone:zone];
        copy->input = [input copyWithZone:zone];
    }
    return copy;
}

@end