//
//  MortgageDataType.h
//  DimBoard
//
//  Created by conicacui on 5/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocalizeHelper.h"

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
#define KEY_MORTGAGE_NAME DimBoardLocalizedString(@"Name")
#define KEY_MORTGAGE_BANKID DimBoardLocalizedString(@"Bank")
#define KEY_MORTGAGE_HOMEVALUE DimBoardLocalizedString(@"HomeValue")
#define KEY_MORTGAGE_LOANPERCENT DimBoardLocalizedString(@"LoanRatio")
#define KEY_MORTGAGE_LOANYEAR DimBoardLocalizedString(@"MortYear")
#define KEY_MORTGAGE_LOANTERM DimBoardLocalizedString(@"LoanTerm")
#define KEY_MORTGAGE_INTERESTRATE DimBoardLocalizedString(@"InterestRate")
#define KEY_MORTGAGE_LOANDATE DimBoardLocalizedString(@"StartDate")
#define KEY_MORTGAGE_MONTHLYPAYMENT DimBoardLocalizedString(@"MonthlyPay")
#define KEY_MORTGAGE_FIRSTPAYMENT DimBoardLocalizedString(@"FirstPay")
#define KEY_MORTGAGE_COMISSION DimBoardLocalizedString(@"Commission")
#define KEY_MORTGAGE_TAX DimBoardLocalizedString(@"Tax")
#define KEY_MORTGAGE_FIRSTTOTALEXP DimBoardLocalizedString(@"FirstTotalExpence")
#define KEY_MORTGAGE_LOANAMOUNT DimBoardLocalizedString(@"LoanAmount")
#define KEY_MORTGAGE_REPAYMENT DimBoardLocalizedString(@"TotalRepayment")
#define KEY_MORTGAGE_REPAYMENT_INTEREST DimBoardLocalizedString(@"TotalInterestAmount")
#define KEY_MORTGAGE_TOBEPAIDPRINCIPAL DimBoardLocalizedString(@"TotalLoanLeft")
#define KEY_MORTGAGE_PAIDPRINCIPAL DimBoardLocalizedString(@"TotalLoanPaid")
#define KEY_MORTGAGE_TOBEPAIDINTEREST DimBoardLocalizedString(@"TotalInterestLeft")
#define KEY_MORTGAGE_PAIDINTEREST DimBoardLocalizedString(@"TotalInterestPaid")
#define KEY_MORTGAGE_PAIDTERM DimBoardLocalizedString(@"NoTermsPaid")
#define KEY_MORTGAGE_TOTALEXP DimBoardLocalizedString(@"TotalExpences")
#define KEY_MORTGAGE_TABLE DimBoardLocalizedString(@"RepaymentSchedule")
#define KEY_MY_MORTGAGE DimBoardLocalizedString(@"MortgageRecord")
#define KEY_MORTGAGE_DETAILS  DimBoardLocalizedString(@"TotalExpensesInfo")
#define KEY_MORTGAGE_NEW DimBoardLocalizedString(@"NewMortgagePlan")
#define KEY_MORTGAGE_CAL DimBoardLocalizedString(@"Calculator")
#define DATEFORMAT @"yyyy-MM-dd"

#define KEY_SETTING_LANG DimBoardLocalizedString(@"Language")

#define LANG_CHINESE_T DimBoardLocalizedString(@"TChinese")
#define LANG_CHINESE_S DimBoardLocalizedString(@"SChinese")
#define LANG_ENG DimBoardLocalizedString(@"English")

@interface BankTypes : NSObject
@property(retain,nonatomic) NSArray* m_banks;
-(NSString*)getBankNameById:(NSInteger)bid;
-(NSInteger)getBankCount;
@end

@interface LangTypes : NSObject
@property(strong, nonatomic) NSArray* m_langs;
-(NSString*)getLangNameById:(NSInteger)lid;
-(NSInteger)getLangCount;
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
