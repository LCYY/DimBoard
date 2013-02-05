//
//  OveralInfoViewController.m
//  DimBoard
//
//  Created by conicacui on 1/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import "OveralInfoViewController.h"

@interface OveralInfoViewController ()

@end

@implementation OveralInfoViewController
@synthesize HomeValue_ouput;
@synthesize LoanPercent_output;
@synthesize LoanYear_output;
@synthesize LoanRate_output;
@synthesize LoanAmount_output;
@synthesize LoanTerms_output;
@synthesize MonthlyPay_output;
@synthesize FirstPay_output;
@synthesize Commision_output;
@synthesize Tax_output;
@synthesize FirstExpence_output;
@synthesize OveralExpence_output;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithInput:(MortgageInput*)input Output:(MortgageOutput*)output{
    self = [self init];
    
    if(self){
        m_input = [[MortgageInput alloc] initWithInput:input];
        m_output = [[MortgageOutput alloc] initWithOutput:output];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
        
   
    [HomeValue_ouput setText:[NSString stringWithFormat:@"%0.2f 萬元",m_input->homeValue]];
    [LoanPercent_output setText:[NSString stringWithFormat:@"%0.2f %",m_input->loanPercent]];
    [LoanYear_output setText:[NSString stringWithFormat:@"%d 年",m_input->loanYear]];
    [LoanRate_output setText:[NSString stringWithFormat:@"%0.2f %",m_input->loanRate]];
    [LoanAmount_output setText:[NSString stringWithFormat:@"%0.2f 萬元",m_output->loanAmount]];
    [LoanTerms_output setText:[NSString stringWithFormat:@"%d 期",m_output->loanTerms]];
    [MonthlyPay_output setText:[NSString stringWithFormat:@"%0.2f 元",m_output->monthlyPay]];
    [FirstPay_output setText:[NSString stringWithFormat:@"%0.2f 萬元",m_output->firstPay]];
    [Commision_output setText:[NSString stringWithFormat:@"%0.2f 元",m_output->comission]];
    [Tax_output setText:[NSString stringWithFormat:@"%0.2f 元",m_output->tax]];
    [FirstExpence_output setText:[NSString stringWithFormat:@"%0.2f 萬元",m_output->firstExpence]];
    [OveralExpence_output setText:[NSString stringWithFormat:@"%0.2f 萬元",m_output->totalExpence]];
}

- (void)viewDidUnload
{
    [self setHomeValue_ouput:nil];
    [self setLoanPercent_output:nil];
    [self setLoanYear_output:nil];
    [self setLoanRate_output:nil];
    [self setLoanAmount_output:nil];
    [self setLoanTerms_output:nil];
    [self setMonthlyPay_output:nil];
    [self setFirstPay_output:nil];
    [self setCommision_output:nil];
    [self setTax_output:nil];
    [self setFirstExpence_output:nil];
    [self setOveralExpence_output:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)onBack:(id)sender {
    [self.view removeFromSuperview];
}
@end
