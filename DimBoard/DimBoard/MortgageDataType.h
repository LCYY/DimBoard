//
//  MortgageDataType.h
//  DimBoard
//
//  Created by conicacui on 5/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MIN_HOME_VALUE 0.00         // 0
#define MAX_HOME_VALUE 5000.00      // 5000,0000
#define MIN_LOANRATE_VALUE 0.0      // 0.0%
#define MAX_LOANRATE_VALUE 15.00    // 15%
#define MIN_LOANYEAR_VALUE 0        // 0 years
#define MAX_LOANYEAR_VALUE 50       // 50 years
#define MIN_LOANPERCENT_VALUE 0     // 0%
#define MAX_LOANPERCENT_VALUE 100    // 100%

#define KEY_MORTGAGE_RECORDID @"mortgage_recordid"
#define KEY_MORTGAGE_NAME @"按揭名稱"
#define KEY_MORTGAGE_BANKID @"按揭銀行"
#define KEY_MORTGAGE_HOMEVALUE @"物業樓價"
#define KEY_MORTGAGE_LOANPERCENT @"按揭成數"
#define KEY_MORTGAGE_LOANYEAR @"按揭年數"
#define KEY_MORTGAGE_LOANTERM @"按揭期數"
#define KEY_MORTGAGE_INTERESTRATE @"按揭利率"
#define KEY_MORTGAGE_LOANDATE @"按揭日期"
#define KEY_MORTGAGE_MONTHLYPAYMENT @"每月供款"
#define KEY_MORTGAGE_FIRSTPAYMENT @"首付金額"
#define KEY_MORTGAGE_COMISSION @"代理佣金"
#define KEY_MORTGAGE_TAX @"印花稅額"
#define KEY_MORTGAGE_FIRSTTOTALEXP @"首次支出總額"
#define KEY_MORTGAGE_LOANAMOUNT @"按揭金額"
#define KEY_MORTGAGE_REPAYMENT @"還款總額"
#define KEY_MORTGAGE_REPAYMENT_INTEREST @"利息金額"
#define KEY_MORTGAGE_TOBEPAIDPRINCIPAL @"待還本金金額"
#define KEY_MORTGAGE_PAIDPRINCIPAL @"已還本金金額"
#define KEY_MORTGAGE_TOBEPAIDINTEREST @"待還利息金額"
#define KEY_MORTGAGE_PAIDINTEREST @"已還利息金額"
#define KEY_MORTGAGE_PAIDTERM @"已還期數"
#define KEY_MORTGAGE_TOTALEXP @"費用總額"
#define KEY_MORTGAGE_TABLE @"供款表"
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
