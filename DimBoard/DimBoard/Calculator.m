//
//  Calculator.m
//  DimBoard
//
//  Created by conicacui on 4/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import "Calculator.h"

@implementation Calculator

@synthesize m_input, m_output;

- (id)init{
    self = [super init];
    if(self){
    }
    return self;
}

-(void)setInput:(MortgageInput*) input{
    m_input = [input copy];
    m_output = [[MortgageOutput alloc] init];
    [self calculateResult];
}

-(MortgageOutput*)getOutput{
    return m_output;
}

-(double)calculateTax{
    double homevalue = m_input->homeValue*10000;
    if(homevalue <= 2000000){ //20,0000
        return 100;
    }else if(homevalue <= 2351760){
        return 100+ (homevalue - 2000000)*0.1;
    }else if(homevalue <= 3000000){
        return homevalue*0.015;
    }else if(homevalue <= 3290320){
        return 45000 + (homevalue - 3000000)*0.1;
    }else if(homevalue <= 4000000){
        return homevalue*0.0225;
    }else if(homevalue <= 4428570){
        return 90000 + (homevalue - 4000000)*0.1;
    }else if(homevalue <= 6000000){
        return homevalue*0.03;
    }else if(homevalue <= 6720000){
        return 180000 + (homevalue - 6000000)*0.1;
    }else if(homevalue <= 20000000){
        return homevalue*0.0375;
    }else if(homevalue <= 21739120){
        return 750000 + (homevalue - 20000000)*0.1;
    }else{
        return homevalue*0.0425;
    }
    return 100;
}

-(double)calculateComission{
    return 10000*m_input->homeValue*0.01;
}

-(void)calculateCurrentStatus{
    NSDate* startdate = m_input.date;
    NSInteger pastMonths = 0;
    if(startdate == nil){
        pastMonths = 0;
    }else{
        NSDate* currentdate = [NSDate date];

        if([[startdate laterDate:currentdate] isEqualToDate:startdate]){
            //currentdate is earlier
            pastMonths = 0;;
        }else{
            NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
            NSDateComponents* start_comps = [calendar components:(NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit) fromDate:startdate];
            NSDateComponents* current_comps = [calendar components:(NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit) fromDate:currentdate];
            
            pastMonths = ([current_comps year] - [start_comps year])*12 + ([current_comps month] - [start_comps month]);
            if([current_comps day] - [start_comps day] >= 0){
                pastMonths += 1;
            }
        }
    }
    for(NSInteger i = 0; i < pastMonths; i++){
        m_output->alreadyPaidAmount += [[m_input.principals objectAtIndex:i] doubleValue];
    }
    m_output->alreadyPaidAmount /= 10000.0;
    m_output->toBePaidAmount = m_output->loanAmount - m_output->alreadyPaidAmount;
}

-(void)calculateResult{
    if(m_input->homeValue == 0)
        return;
    m_output->loanAmount = m_input->homeValue*m_input->loanPercent/100.0;
    m_output->loanTerms = 12*m_input->loanYear;
    
    m_output->firstPay = m_input->homeValue - m_output->loanAmount;
    m_output->comission = [self calculateComission];  // in terms of 1
    m_output->tax = [self calculateTax]; // in terms of 1
    m_output->firstExpence = m_output->firstPay + (m_output->comission + m_output->tax)/10000.0;
    
    if(m_output->loanAmount == 0){
        return;
    }
    
    //monthlypay
    double rate_per_month = m_input->loanRate/12.0/100.0;
    double interest_term_1 = 10000*m_output->loanAmount*rate_per_month;
    double principle_term_1 = interest_term_1/(pow(1+rate_per_month,m_output->loanTerms) - 1);
       
    m_output->monthlyPay = interest_term_1 + principle_term_1;
    m_output->totalPay = m_output->monthlyPay/10000.0*m_output->loanTerms;
    m_output->totalInterest = m_output->totalPay - m_output->loanAmount;
    m_output->totalExpence = m_output->firstExpence + m_output->totalPay;
    
    //calculate principal in each term
    for(int i=0; i<m_output->loanTerms; i++){
        NSNumber* number = [NSNumber numberWithDouble:(m_output->monthlyPay-interest_term_1*pow(1+rate_per_month,i))];
        [m_input.principals addObject:number];
    }
    
    [self calculateCurrentStatus];
}


@end

