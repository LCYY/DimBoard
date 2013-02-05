//
//  MortgageDataType.m
//  DimBoard
//
//  Created by conicacui on 5/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import "MortgageDataType.h"

@implementation MortgageInput

-(id)initVariables{
    self = [self init];
    
    if(self){
        homeValue = 0.0;
        loanYear = 0;
        loanPercent = 0.0;
        loanRate = 0.0;
    }
    return self;
}

-(id)initWithInput:(MortgageInput*) input{
    self = [self initVariables];
    if(self){
        homeValue = input->homeValue;
        loanYear = input->loanYear;
        loanPercent = input->loanPercent;
        loanRate = input->loanRate;
    }
    return self;
}

-(id)initWithHomeValue:(double)hv LoanYear:(NSInteger)ly LoanPercent:(double)lp LoanRate:(double)lr{
    self = [self initVariables];
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

@end

@implementation MortgageOutput
-(id)initVariables{
    self = [self init];
    
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
    }
    return self;
}

-(id)initWithOutput:(MortgageOutput*) output{
    self = [self initVariables];
    if(self){
        comission = output->comission;
        firstExpence = output->firstExpence;
        firstPay = output->firstPay;
        loanAmount = output->loanAmount;
        loanTerms = output->loanTerms;
        monthlyPay = output->monthlyPay;
        tax = output->tax;
        totalExpence = output->totalExpence;
        totoalPay = output->totoalPay;
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
}

@end