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
@synthesize m_dict;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id) initWithValues:(NSMutableDictionary *)dict{
    self = [self init];
    
    if(self){
        m_dict = [[NSMutableDictionary alloc] initWithDictionary:dict copyItems:YES];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [HomeValue_ouput setText:[m_dict objectForKey:@"homevalue"]];
    [LoanPercent_output setText:[m_dict objectForKey:@"loanpercent"]];
    [LoanYear_output setText:[m_dict objectForKey:@"loanyear"]];
    [LoanRate_output setText:[m_dict objectForKey:@"loanrate"]];
    [LoanAmount_output setText:[m_dict objectForKey:@"loanamount"]];
    [LoanTerms_output setText:[m_dict objectForKey:@"loanterms"]];
    [MonthlyPay_output setText:[m_dict objectForKey:@"monthlypay"]];
    [FirstPay_output setText:[m_dict objectForKey:@"firstpay"]];
    [Commision_output setText:[m_dict objectForKey:@"commision"]];
    [Tax_output setText:[m_dict objectForKey:@"tax"]];
    [FirstExpence_output setText:[m_dict objectForKey:@"firstexpence"]];
    [OveralExpence_output setText:[m_dict objectForKey:@"overalexpence"]];
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
