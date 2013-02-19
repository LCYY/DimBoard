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
@synthesize ScrollView;
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
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard)];
    tapRecognizer.cancelsTouchesInView = NO;
    [ScrollView addGestureRecognizer:tapRecognizer];
    
    m_input = [[MortgageInput alloc] initWithHomeValue:100.0 LoanYear:30 LoanPercent:30.0 LoanRate:2.0];
    m_output = [[MortgageOutput alloc] initVariables];
    m_calculator = [[Calculator alloc] initVarirables];
    
    [self initUI];
    [m_calculator setInput:m_input];
    [m_calculator getOutput:m_output];
    [self updateResult];
}

- (void)viewDidUnload {
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
    [self setScrollView:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return TRUE;
}

- (void)initUI{
    // set input
    HomeValue_input.text = [NSString stringWithFormat:@"%0.4f", m_input->homeValue];
    LoanPercent_input.text = [NSString stringWithFormat:@"%0.2f",m_input->loanPercent];
    LoanYear_input.text = [NSString stringWithFormat:@"%d", m_input->loanYear];
    LoanRate_input.text = [NSString stringWithFormat:@"%0.2f",m_input->loanRate];
    
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
    [HomeValue_slid setValue:m_input->homeValue];
    [LoanPercent_slid setValue:m_input->loanPercent];
    [LoanYear_slid setValue:m_input->loanYear];
    [LoanRate_slid setValue:m_input->loanRate];
}

-(void)updateResult{    
    LoanAmount_output.text = [NSString stringWithFormat:@"%0.4f 萬元", m_output->loanAmount];
    LoanTerms_output.text = [NSString stringWithFormat:@"%d 期",m_output->loanTerms];
    TotalPay_output.text = [NSString stringWithFormat:@"%0.4f 萬元",m_output->totoalPay];
    MonthlyPay_output.text = [NSString stringWithFormat:@"%0.2f 元",m_output->monthlyPay];
}

- (IBAction)onShowOveralInfo:(id)sender {
    OveralInfoViewController *rootController = [[OveralInfoViewController alloc] initWithInput:m_input Output:m_output];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:rootController];
    
    navController.navigationBar.topItem.title = ((UIButton*)sender).titleLabel.text;
    navController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonSystemItemDone target:self action:@selector(onBack:)];
    navController.navigationBar.topItem.leftBarButtonItem = doneButton;
    [navController setWantsFullScreenLayout:YES];
    [navController.view setAutoresizesSubviews:NO];
    navController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    navController.visibleViewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    
    [self presentModalViewController:navController animated:YES];
}

- (IBAction)onShowMortgageRecord:(id)sender {
    MortgageRecordViewController *rootController = [[MortgageRecordViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:rootController];
    
    navController.navigationBar.topItem.title = ((UIButton*)sender).titleLabel.text;
    navController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonSystemItemDone target:self action:@selector(onBack:)];
    navController.navigationBar.topItem.leftBarButtonItem = doneButton;
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:rootController action:@selector(onAddNewMortgageRecord:)];
    navController.navigationBar.topItem.rightBarButtonItem = addButton;
    [navController setWantsFullScreenLayout:YES];
    [navController.view setAutoresizesSubviews:NO];
    navController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    navController.visibleViewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    
    [self presentModalViewController:navController animated:YES];
}

- (IBAction)onShowDetails:(id)sender {
    
}

- (void)onBack:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
}

// for hide keyboard when touch background
- (void)hideKeyBoard{
    [HomeValue_input resignFirstResponder];
    [LoanRate_input resignFirstResponder];
    [LoanPercent_input resignFirstResponder];
    [LoanYear_input resignFirstResponder];
}

//notifications
- (void)onSlidValueChanged:(id) sender{
    UISlider* slider = (UISlider*)sender;
    float sliderValue = slider.value;
    if(sender == HomeValue_slid){
        HomeValue_input.text = [NSString stringWithFormat:@"%0.4f",sliderValue];
        m_input->homeValue = [HomeValue_input.text doubleValue];
    }else if(sender == LoanPercent_slid){
        LoanPercent_input.text = [NSString stringWithFormat:@"%0.2f",sliderValue];
        m_input->loanPercent = [LoanPercent_input.text doubleValue];
    }else if(sender == LoanYear_slid){
        LoanYear_input.text = [NSString stringWithFormat:@"%d",(int)sliderValue];
        m_input->loanYear = [LoanYear_input.text intValue];
    }else if(sender == LoanRate_slid){
        LoanRate_input.text = [NSString stringWithFormat:@"%0.2f",sliderValue];
        m_input->loanRate = [LoanRate_input.text doubleValue];
    }
    
    [m_calculator setInput:m_input];
    [m_calculator getOutput:m_output];
    [self updateResult];
}

#pragma mark
#pragma mark - UITextFieldDelegate
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
        m_input->homeValue = [HomeValue_input.text doubleValue];
        [HomeValue_slid setValue:m_input->homeValue];
    }else if(textField == LoanPercent_input){
        m_input->loanPercent = [LoanPercent_input.text doubleValue];
        [LoanPercent_slid setValue:m_input->loanPercent];
    }else if(textField == LoanYear_input){
        m_input->loanYear = [LoanYear_input.text intValue];
        [LoanYear_slid setValue:m_input->loanYear];
    }else if(textField == LoanRate_input){
        m_input->loanRate = [LoanRate_input.text doubleValue];
        [LoanRate_slid setValue:m_input->loanRate];
    }
    
    [m_calculator setInput:m_input];
    [m_calculator getOutput:m_output];
    [self updateResult];
    
    return YES;
}
@end
