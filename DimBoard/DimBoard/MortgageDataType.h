//
//  MortgageDataType.h
//  DimBoard
//
//  Created by conicacui on 5/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MIN_HOME_VALUE 1.00         // 1,0000
#define MAX_HOME_VALUE 5000.00      // 5000,0000
#define MIN_LOANRATE_VALUE 0.1      // 0.1%
#define MAX_LOANRATE_VALUE 15.00    // 15%
#define MIN_LOANYEAR_VALUE 1        // 1 years
#define MAX_LOANYEAR_VALUE 50       // 50 years
#define MIN_LOANPERCENT_VALUE 1     // 1%
#define MAX_LOANPERCENT_VALUE 95    // 95%


@interface MortgageInput : NSObject<NSCopying>{
    @public
    double homeValue; // in terms of 10-thoudsands
    double loanPercent; // in terms of %
    NSInteger loanYear; // integer
    double loanRate; // in terms of %, loan rate per year
}

-(id)initVariables;
-(id)initWithHomeValue:(double)hv LoanYear:(NSInteger)ly LoanPercent:(double)lp LoanRate:(double)lr;
-(void)setInput:(MortgageInput*) input;
@end

@interface MortgageOutput : NSObject<NSCopying>{
    @public
    double loanAmount; // in terms of 10-thousands
    double monthlyPay; // in terms of 1
    NSInteger loanTerms;
    double totoalPay; // in terms of 10-thousands
    double firstPay;
    double firstExpence;
    double totalExpence;
    double comission;
    double tax;
    double totalInterest;
}
-(id)initVariables;
-(void)getOutput:(MortgageOutput*) output;
@end;

@interface MortgageRecord : NSObject<NSCopying>{
    @public
    NSInteger recordId;
    
    MortgageInput *input;
    
    NSString *name;
    NSInteger bankId;
    NSDate *date;    
}

-(id)initWithNSStringRecordId:(NSString*)rid Name:(NSString*)name BankId:(NSString*)bid Date:(NSString*)date HomeValue:(NSString*)hv LoanYear:(NSString*)ly LoanPercent:(NSString*)lp LoanRate:(NSString*)lr;

-(id)initWithName:(NSString*)name BankId:(NSInteger)bid Date:(NSDate*)date HomeValue:(double)hv LoanYear:(NSInteger)ly LoanPercent:(double)lp LoanRate:(double)lr;

-(void) updateRecord:(MortgageRecord*)record;

@end
