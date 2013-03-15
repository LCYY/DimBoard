//
//  MortgageDataType.h
//  DimBoard
//
//  Created by conicacui on 5/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MIN_HOME_VALUE 0.00         // 0
#define MAX_HOME_VALUE 500000000.00      // 5000,0000
#define STEP_HOME_VALUE 1
#define COEFF_HOME_VALUE 0.1
#define MIN_LOANRATE_VALUE 0.0      // 0.0%
#define MAX_LOANRATE_VALUE 15.00    // 15%
#define STEP_LOANRATE_VALUE 0.01
#define COEFF_LOANRATE_VALUE 0.01
#define MIN_LOANYEAR_VALUE 0        // 0 years
#define MAX_LOANYEAR_VALUE 50       // 50 years
#define STEP_LOANYEAR_VALUE 1
#define COEFF_LOANYEAR_VALUE 0.01
#define MIN_LOANPERCENT_VALUE 0     // 0%
#define MAX_LOANPERCENT_VALUE 100    // 100%
#define STEP_LOANPERCENT_VALUE 1
#define COEFF_LOANPERCENT_VALUE 0.01

#define KEY_MORTGAGE_RECORDID @"mortgage_recordid"
#define KEY_MORTGAGE_NAME NSLocalizedString(@"Name",nil)
#define KEY_MORTGAGE_BANKID NSLocalizedString(@"Bank",nil)
#define KEY_MORTGAGE_HOMEVALUE NSLocalizedString(@"HomeValue",nil)
#define KEY_MORTGAGE_LOANPERCENT NSLocalizedString(@"LoanRatio",nil)
#define KEY_MORTGAGE_LOANYEAR NSLocalizedString(@"MortYear",nil)
#define KEY_MORTGAGE_LOANTERM NSLocalizedString(@"LoanTerm",nil)
#define KEY_MORTGAGE_INTERESTRATE NSLocalizedString(@"InterestRate",nil)
#define KEY_MORTGAGE_LOANDATE NSLocalizedString(@"StartDate",nil)
#define KEY_MORTGAGE_MONTHLYPAYMENT NSLocalizedString(@"MonthlyPay",nil)
#define KEY_MORTGAGE_FIRSTPAYMENT NSLocalizedString(@"FirstPay",nil)
#define KEY_MORTGAGE_COMISSION NSLocalizedString(@"Commission",nil)
#define KEY_MORTGAGE_TAX NSLocalizedString(@"Tax",nil)
#define KEY_MORTGAGE_FIRSTTOTALEXP NSLocalizedString(@"FirstTotalExpence",nil)
#define KEY_MORTGAGE_LOANAMOUNT NSLocalizedString(@"LoanAmount",nil)
#define KEY_MORTGAGE_REPAYMENT NSLocalizedString(@"TotalRepayment",nil)
#define KEY_MORTGAGE_REPAYMENT_INTEREST NSLocalizedString(@"TotalInterestAmount",nil)
#define KEY_MORTGAGE_TOBEPAIDPRINCIPAL NSLocalizedString(@"TotalLoanLeft",nil)
#define KEY_MORTGAGE_PAIDPRINCIPAL NSLocalizedString(@"TotalLoanPaid",nil)
#define KEY_MORTGAGE_TOBEPAIDINTEREST NSLocalizedString(@"TotalInterestLeft",nil)
#define KEY_MORTGAGE_PAIDINTEREST NSLocalizedString(@"TotalInterestPaid",nil)
#define KEY_MORTGAGE_PAIDTERM NSLocalizedString(@"NoTermsPaid",nil)
#define KEY_MORTGAGE_TOTALEXP NSLocalizedString(@"TotalExpences",nil)
#define KEY_MORTGAGE_TABLE NSLocalizedString(@"RepaymentSchedule",nil)
#define KEY_MY_MORTGAGE NSLocalizedString(@"MortgageRecord",nil)
#define KEY_MORTGAGE_DETAILS  NSLocalizedString(@"TotalExpensesInfo",nil)
#define KEY_MORTGAGE_NEW NSLocalizedString(@"NewMortgagePlan",nil)
#define KEY_MORTGAGE_CAL NSLocalizedString(@"Calculator",nil)
#define DATEFORMAT @"yyyy-MM-dd"


@interface BankTypes : NSObject
@property(retain,nonatomic) NSArray* m_banks;
-(NSString*)getBankNameById:(NSInteger)bid;
-(NSInteger)getBankCount;
@end


@interface MortgageInput : NSObject<NSCopying>{
    @public
    double homeValue; // in terms of 10-thoudsands
    double loanPercent; // in terms of %
    NSInteger loanYear; // integer
    double interestRate; // in terms of %, loan rate per year
}
@property (retain, nonatomic) NSDate* date;
-(id)initWithHomeValue:(double)hv LoanYear:(NSInteger)ly LoanPercent:(double)lp LoanRate:(double)lr LoanDate:(NSDate*)dt;
@end


@interface MortgageOutput : NSObject<NSCopying>{
    @public
    double loanAmount; // in terms of 10-thousands (repaymentPricipal)
    double monthlyPay; // in terms of 1
    NSInteger loanTerms;
    double rePayment; // in terms of 10-thousands
    double firstPayment; // in terms of 10-thousands
    double firstTotalExp; // in terms of 10-thousands
    double totalExpence; // in terms of 10-thousands
    double comission; // in terms of 1
    double tax; // in terms of 1
    double rePaymentInterest; // in terms of 10-thousands
    double paidPrincipal; // in terms of 10-thousands
    double toPayPrincipal; //in terms of 10-thousands
    double paidInterest; // in terms of 10-thousands
    double toPayInterest; //in terms of 10-thousands
    NSInteger paidTerms;
}
@property (retain, nonatomic) NSMutableArray* principals; // in terms of 1
@property (retain, nonatomic) NSMutableArray* leftLoanAmounts; // in terms of 1
@end;


@interface MortgageRecord : NSObject<NSCopying>{
    @public
    NSInteger recordId;
    NSInteger bankId;  
}

@property (retain, nonatomic) NSString* name;
@property (retain, nonatomic) MortgageInput* input;

-(id)initWithRecordId:(NSString*)rid Name:(NSString*)name BankId:(NSString*)bid Date:(NSString*)date HomeValue:(NSString*)hv LoanYear:(NSString*)ly LoanPercent:(NSString*)lp LoanRate:(NSString*)lr;
-(id)initWithName:(NSString*)name BankId:(NSInteger)bid Date:(NSDate*)date HomeValue:(double)hv LoanYear:(NSInteger)ly LoanPercent:(double)lp LoanRate:(double)lr;
-(id)initWithMortgageInput:(MortgageInput*)input;
@end
