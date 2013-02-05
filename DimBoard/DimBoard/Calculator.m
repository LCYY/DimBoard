//
//  Calculator.m
//  DimBoard
//
//  Created by conicacui on 4/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import "Calculator.h"

@implementation Calculator

@synthesize m_principals;

- (id)initVarirables{
    self = [self init];
    
    if(self){
        m_input = [[MortgageInput alloc] initVariables];
        m_output = [[MortgageOutput alloc] initVariables];
        m_principals = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)setInput:(MortgageInput*) input{
    [m_input setInput:input];
    [self calculateResult];
}

-(void)getOutput:(MortgageOutput*) output{
    [m_output getOutput:output];
}

-(void)getMonthlyPrincipals:(NSMutableArray*) arry{
    for(int i=0; i<m_output->loanTerms; i++){
        [arry addObject: [m_principals objectAtIndex:i]];
    }
}

-(double)calculateTax{
    return 100;
}

-(double)calculateComission{
    return 10000*m_input->homeValue*0.01;
}

-(void)calculateResult{
    if(m_input->homeValue == 0)
        return;
    m_output->loanAmount = m_input->homeValue*m_input->loanPercent/100.0;
    m_output->loanTerms = 12*m_input->loanYear;
    
    //monthlypay
    double rate_per_month = m_input->loanRate/12.0/100.0;
    double interest_term_1 = 10000*m_output->loanAmount*rate_per_month;
    double principle_term_1 = interest_term_1/(pow(1+rate_per_month,m_output->loanTerms) - 1);
    
    //calculate principal in each term
    for(int i=0; i<m_output->loanTerms; i++){
        NSNumber* number = [NSNumber numberWithDouble:(interest_term_1*pow(1+rate_per_month,i))];
        [self.m_principals addObject:number];
    }
    
    m_output->monthlyPay = interest_term_1 + principle_term_1;

    m_output->totoalPay = m_output->monthlyPay/10000.0*m_output->loanTerms;
    
    m_output->firstPay = m_input->homeValue - m_output->loanAmount;
    m_output->comission = [self calculateComission];  // in terms of 1
    m_output->tax = [self calculateTax]; // in terms of 1
    
    m_output->firstExpence = m_output->firstPay + (m_output->comission + m_output->tax)/10000.0;
    m_output->totalExpence = m_output->firstExpence + m_output->totoalPay;
    
}


@end

