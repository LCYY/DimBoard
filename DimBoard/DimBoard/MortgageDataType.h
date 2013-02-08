//
//  MortgageDataType.h
//  DimBoard
//
//  Created by conicacui on 5/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MortgageInput : NSObject{
    @public
    double homeValue; // in terms of 10-thoudsands
    double loanPercent; // in terms of %
    NSInteger loanYear; // integer
    double loanRate; // in terms of %, loan rate per year
}

-(id)initVariables;
-(id)initWithInput:(MortgageInput*) input;
-(id)initWithHomeValue:(double)hv LoanYear:(NSInteger)ly LoanPercent:(double)lp LoanRate:(double)lr;
-(void)setInput:(MortgageInput*) input;
@end

@interface MortgageOutput : NSObject{
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
-(id) initVariables;
-(id)initWithOutput:(MortgageOutput*) output;
-(void)getOutput:(MortgageOutput*) output;
@end;
