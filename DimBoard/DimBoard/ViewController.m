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
    [self updateOutput];
    [self calculateResult];
}

- (void)initVarirables{    
    m_homeValue = 100;
    m_loanPercent = 30;
    m_loanYear = 30;
    m_loanRate = 2;
    
    m_loanAmount = 0;
    m_monthlyPay = 0;
    m_loanTerms = 0;
    m_totoalPay = 0;
    
    // set input
    HomeValue_input.text = [NSString stringWithFormat:@"%0.2f", m_homeValue];
    LoanPercent_input.text = [NSString stringWithFormat:@"%0.2f",m_loanPercent];
    LoanYear_input.text = [NSString stringWithFormat:@"%d", m_loanYear];
    LoanRate_input.text = [NSString stringWithFormat:@"%0.2f",m_loanRate];
    
    //set input delegate to self
    [HomeValue_input setDelegate:self];
    [LoanPercent_input setDelegate:self];
    [LoanRate_input setDelegate:self];
    [LoanYear_input setDelegate:self];
             
    //set slid range and callback
    [HomeValue_slid setMinimumValue:MIN_HOME_VALUE]; //int terms of 10-thousand
    [HomeValue_slid setMaximumValue:MAX_HOME_VALUE];
    [HomeValue_slid addTarget:self action:@selector(onSlidValueChanged:) forControlEvents:UIControlEventValueChanged];
        
    [LoanRate_slid setMinimumValue:MIN_LOANRATE_VALUE]; //in terms of %
    [LoanRate_slid setMaximumValue:MAX_LOANRATE_VALUE];
    [LoanRate_slid addTarget:self action:@selector(onSlidValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    [LoanYear_slid setMinimumValue:MIN_LOANYEAR_VALUE];  // in terms of year
    [LoanYear_slid setMaximumValue:MAX_LOANYEAR_VALUE];
    [LoanYear_slid addTarget:self action:@selector(onSlidValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    [LoanPercent_slid setMinimumValue:MIN_LOANPERCENT_VALUE]; // in terms of %
    [LoanPercent_slid setMaximumValue:MAX_LOANPERCENT_VALUE];
    [LoanPercent_slid addTarget:self action:@selector(onSlidValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    //set slider
    [HomeValue_slid setValue:m_homeValue];
    [LoanPercent_slid setValue:m_loanPercent];
    [LoanYear_slid setValue:m_loanYear];
    [LoanRate_slid setValue:m_loanRate];

}

-(void)updateOutput{
    //set result
    LoanAmount_output.text = [NSString stringWithFormat:@"%0.2f 萬元", m_loanAmount];
    LoanTerms_output.text = [NSString stringWithFormat:@"%d 期",m_loanTerms];
    TotalPay_output.text = [NSString stringWithFormat:@"%0.2f 萬元",m_totoalPay];
    MonthlyPay_output.text = [NSString stringWithFormat:@"%0.2f 元",m_monthlyPay];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return TRUE;
}

- (IBAction)onShowOveralInfo:(id)sender {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                           [HomeValue_input.text stringByAppendingString:@" 萬元"],@"homevalue",
                           [LoanPercent_input.text stringByAppendingString:@" %"],@"loanpercent",
                           [LoanYear_input.text stringByAppendingString:@" 年"],@"loanyear",
                           [LoanRate_input.text stringByAppendingString:@" %"],@"loanrate",
                           LoanAmount_output.text,@"loanamount",
                           LoanTerms_output.text,@"loanterms",
                           MonthlyPay_output.text,@"monthlypay",
                           [NSString stringWithFormat:@"%0.2f 萬元",m_firstPay],@"firstpay",
                           [NSString stringWithFormat:@"%0.2f 元",m_comission],@"commision",
                           [NSString stringWithFormat:@"%0.2f 元",m_tax],@"tax",
                           [NSString stringWithFormat:@"%0.2f 萬元",m_firstExpence],@"firstexpence",
                           [NSString stringWithFormat:@"%0.2f 萬元",m_totalExpence],@"overalexpence",
                           nil];

    m_overalInfoViewController = [[OveralInfoViewController alloc] initWithValues:dict];
    [self.view addSubview:m_overalInfoViewController.view];
}

- (IBAction)onShowDetails:(id)sender {
}

// for hide keyboard when touch background
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

//UITextField Delegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string {
    if(string.length == 0)
        return YES;
    //can only input number and one dot
    NSRange hasDot = [textField.text rangeOfString:@"."];
    NSCharacterSet* filterSet;
    NSString* afterFilter;
    if(hasDot.location < textField.text.length || hasDot.location == 0 ){
        filterSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
        afterFilter = [string stringByTrimmingCharactersInSet:filterSet];
    }else{
        filterSet = [[NSCharacterSet characterSetWithCharactersInString:@".0123456789"] invertedSet];
        afterFilter = [string stringByTrimmingCharactersInSet:filterSet];
    }
    if(afterFilter.length > 0){
        return YES;
    }else{
        return NO;
    }
    //? need range handling???
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if(textField == HomeValue_input){
        m_homeValue = [HomeValue_input.text doubleValue];
        [HomeValue_slid setValue:m_homeValue];
    }else if(textField == LoanPercent_input){
        m_loanPercent = [LoanPercent_input.text doubleValue];
        [LoanPercent_slid setValue:m_loanPercent];
    }else if(textField == LoanRate_input){
        m_loanRate = [LoanRate_input.text doubleValue];
        [LoanRate_slid setValue:m_loanRate];
    }else if(textField == LoanYear_input){
        m_loanYear = [LoanYear_input.text intValue];
        [LoanYear_slid setValue:m_loanYear];
    }
    
    [self calculateResult];
}

//notifications
- (void)onSlidValueChanged:(id) sender{
    UISlider* slider = (UISlider*)sender;
    float sliderValue = slider.value;
    
    if(sender == HomeValue_slid){
        HomeValue_input.text = [NSString stringWithFormat:@"%0.2f",sliderValue];
        m_homeValue = [HomeValue_input.text doubleValue];
    }else if(sender == LoanPercent_slid){
        LoanPercent_input.text = [NSString stringWithFormat:@"%0.2f",sliderValue];
        m_loanPercent = [LoanPercent_input.text doubleValue];
    }else if(sender == LoanYear_slid){
        LoanYear_input.text = [NSString stringWithFormat:@"%d",(int)sliderValue];
        m_loanYear = [LoanYear_input.text intValue];
    }else if(sender == LoanRate_slid){
        LoanRate_input.text = [NSString stringWithFormat:@"%0.2f",sliderValue];
        m_loanRate = [LoanRate_input.text doubleValue];
    }
    
    [self calculateResult];
}

-(void)calculateResult{
    m_loanAmount = m_homeValue*m_loanPercent/100.0;
    m_loanTerms = 12*m_loanYear;
    
    double rate_per_month = m_loanRate/12.0/100.0;
    double interest_term_1 = 10000*m_loanAmount*rate_per_month;
    double principle_term_1 = interest_term_1/(pow(1+rate_per_month,m_loanTerms) - 1);
    
    m_monthlyPay = interest_term_1 + principle_term_1;
    m_totoalPay = m_monthlyPay/10000.0*m_loanTerms;
    
    m_firstPay = m_homeValue - m_loanAmount;
    m_comission = 10000*m_homeValue*0.01;  // in terms of 1
    m_tax = 100; // in terms of 1
    m_firstExpence = m_firstPay + (m_comission + m_tax)/10000.0;
    m_totalExpence = m_firstExpence + m_totoalPay;
    
    
    for(int i=0; i<m_loanTerms; i++){
        [m_principals addObject:[NSNumber numberWithDouble:(interest_term_1*pow(1+rate_per_month,i))]];
    }
      
    [self updateOutput];
}

- (void)viewDidUnload {
    [self setHomeValue_slid:nil];
    [super viewDidUnload];
}
@end
