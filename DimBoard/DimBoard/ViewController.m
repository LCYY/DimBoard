//
//  ViewController.m
//  DimBoard
//
//  Created by conicacui on 30/1/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize ShowOveralInfo;
@synthesize ShowDetails;
@synthesize HomeValue_input;
@synthesize LoanPercent_input;
@synthesize LoanYear_input;
@synthesize LoanRate_input;
@synthesize HomeValue_slid;
@synthesize LoanPercent_slid;
@synthesize LoanYear_slid;
@synthesize LoanRate_slid;
@synthesize LoanAmount_output;
@synthesize TotalPay_output;
@synthesize LoanTerms_output;
@synthesize MonthlyPay_output;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self initVarirables];
    [self updateInput];
    [self updateOutput];
}

- (void)initVarirables{
    m_homeValue = 100;
    m_loanPercent = 0.3;
    m_loanYear = 30;
    m_loanRate = 0.02;
    
    m_loanAmount = 0;
    m_monthlyPay = 0;
    m_loanTerms = 0;
    m_totoalPay = 0;
}

-(void)updateInput{
    // set input
    self.HomeValue_input.text = [NSString stringWithFormat:@"%0.2f", m_homeValue];
    self.LoanPercent_input.text = [NSString stringWithFormat:@"%0.2f",m_loanPercent*100];
    self.LoanYear_input.text = [NSString stringWithFormat:@"%d", m_loanYear];
    self.LoanRate_input.text = [NSString stringWithFormat:@"%0.2f",m_loanRate*100];
    
    //set slidbar
    self.HomeValue_slid.value = m_homeValue;
    self.LoanPercent_slid.value = m_loanPercent;
    self.LoanYear_slid.value = m_loanYear;
    self.LoanRate_slid.value = m_loanRate;
}

-(void)updateOutput{
    //set result
    self.LoanAmount_output.text = [NSString stringWithFormat:@"%0.2f", m_loanAmount];
    self.LoanTerms_output.text = [NSString stringWithFormat:@"%d",m_loanTerms];
    self.TotalPay_output.text = [NSString stringWithFormat:@"%0.2f",m_totoalPay];
    self.MonthlyPay_output.text = [NSString stringWithFormat:@"%0.2f",m_monthlyPay];
}

- (void)viewDidUnload
{
    [self setHomeValue_input:nil];
    [self setLoanPercent_input:nil];
    [self setLoanYear_input:nil];
    [self setLoanRate_input:nil];
    [self setHomeValue_slid:nil];
    [self setLoanPercent_slid:nil];
    [self setLoanYear_slid:nil];
    [self setLoanRate_slid:nil];
    [self setLoanAmount_output:nil];
    [self setTotalPay_output:nil];
    [self setLoanTerms_output:nil];
    [self setShowOveralInfo:nil];
    [self setShowDetails:nil];
    [self setMonthlyPay_output:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)OnShowOveralInfo:(id)sender {
}

- (IBAction)OnShowDetails:(id)sender {
}

// for hide keyboard when touch background
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
@end
