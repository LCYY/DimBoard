//
//  ViewController.m
//  DimBoard
//
//  Created by conicacui on 30/1/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import "ViewController.h"
#define MIN_HOME_VALUE 1.00         // 1,0000
#define MAX_HOME_VALUE 5000.00      // 5000,0000
#define MIN_LOANRATE_VALUE 0.1      // 0.1%
#define MAX_LOANRATE_VALUE 15.00    // 15%
#define MIN_LOANYEAR_VALUE 1        // 1 years
#define MAX_LOANYEAR_VALUE 50       // 50 years
#define MIN_LOANPERCENT_VALUE 1     // 1%
#define MAX_LOANPERCENT_VALUE 95    // 95%

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
    
    [self.HomeValue_slid setMinimumValue:MIN_HOME_VALUE]; //int terms of 10-thousand
    [self.HomeValue_slid setMaximumValue:MAX_HOME_VALUE];
    [self.HomeValue_slid addTarget:self action:@selector(onSlidValueChanged:) forControlEvents:UIControlEventValueChanged];
        
    [self.LoanRate_slid setMinimumValue:MIN_LOANRATE_VALUE]; //in terms of %
    [self.LoanRate_slid setMaximumValue:MAX_LOANRATE_VALUE];
    [self.LoanRate_slid addTarget:self action:@selector(onSlidValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    [self.LoanYear_slid setMinimumValue:MIN_LOANYEAR_VALUE];  // in terms of year
    [self.LoanYear_slid setMaximumValue:MAX_LOANYEAR_VALUE];
    [self.LoanYear_slid addTarget:self action:@selector(onSlidValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    [self.LoanPercent_slid setMinimumValue:MIN_LOANPERCENT_VALUE]; // in terms of %
    [self.LoanPercent_slid setMaximumValue:MAX_LOANPERCENT_VALUE];
    [self.LoanPercent_slid addTarget:self action:@selector(onSlidValueChanged:) forControlEvents:UIControlEventValueChanged];

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

//notifications
- (void)onSlidValueChanged:(id) sender{
    UISlider* slider = (UISlider*)sender;
    float sliderValue = slider.value;
    
    if(sender == HomeValue_slid){
        HomeValue_input.text = [NSString stringWithFormat:@"%0.2f",sliderValue];
    }else if(sender == LoanPercent_slid){
        LoanPercent_input.text = [NSString stringWithFormat:@"%0.2f",sliderValue];
    }else if(sender == LoanYear_slid){
        LoanYear_input.text = [NSString stringWithFormat:@"%d",(int)sliderValue];
    }else if(sender == LoanRate_slid){
        LoanRate_input.text = [NSString stringWithFormat:@"%0.2f",sliderValue];
    }
}

@end
