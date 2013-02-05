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
@synthesize PieChart;
@synthesize m_sliceColors;
@synthesize m_slices;

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
        m_slices = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    [self showMortgageData];
    [self calculatePieCharSlices];
    [self showPieChar];
}

-(void)showMortgageData{
    [HomeValue_ouput setText:[NSString stringWithFormat:@"%0.2f 萬元",m_input->homeValue]];
    [LoanPercent_output setText:[NSString stringWithFormat:@"%0.2f %%",m_input->loanPercent]];
    [LoanYear_output setText:[NSString stringWithFormat:@"%d 年",m_input->loanYear]];
    [LoanRate_output setText:[NSString stringWithFormat:@"%0.2f %%",m_input->loanRate]];
    [LoanAmount_output setText:[NSString stringWithFormat:@"%0.2f 萬元",m_output->loanAmount]];
    [LoanTerms_output setText:[NSString stringWithFormat:@"%d 期",m_output->loanTerms]];
    [MonthlyPay_output setText:[NSString stringWithFormat:@"%0.2f 元",m_output->monthlyPay]];
    [FirstPay_output setText:[NSString stringWithFormat:@"%0.2f 萬元",m_output->firstPay]];
    [Commision_output setText:[NSString stringWithFormat:@"%0.2f 元",m_output->comission]];
    [Tax_output setText:[NSString stringWithFormat:@"%0.2f 元",m_output->tax]];
    [FirstExpence_output setText:[NSString stringWithFormat:@"%0.2f 萬元",m_output->firstExpence]];
    [OveralExpence_output setText:[NSString stringWithFormat:@"%0.2f 萬元",m_output->totalExpence]];
}

-(void)calculatePieCharSlices{
    double homevalue_percent = m_input->homeValue/m_output->totalExpence;
    double comission_percent = m_output->comission/m_output->totalExpence/10000.0;
    double tax_percent = m_output->tax/m_output->totalExpence/10000.0;
    double interest_percent = 1 - homevalue_percent - comission_percent - tax_percent;
    
    [m_slices addObject:[NSNumber numberWithDouble:homevalue_percent]];
    [m_slices addObject:[NSNumber numberWithDouble:comission_percent]];
    [m_slices addObject:[NSNumber numberWithDouble:tax_percent]];
    [m_slices addObject:[NSNumber numberWithDouble:interest_percent]];
}

-(void)showPieChar{
    //set piechart
    [PieChart setDelegate:self];
    [PieChart setDataSource:self];
    [PieChart setShowPercentage:YES];
    [PieChart setShowLabel:YES];
    [PieChart setLabelColor:[UIColor blackColor]];
    [PieChart setLabelFont:[UIFont systemFontOfSize:13.0]];
    
    m_sliceColors = [NSArray arrayWithObjects:
                     [UIColor colorWithRed:246/255.0 green:155/255.0 blue:0/255.0 alpha:1],
                     [UIColor colorWithRed:129/255.0 green:195/255.0 blue:29/255.0 alpha:1],
                     [UIColor colorWithRed:62/255.0 green:173/255.0 blue:219/255.0 alpha:1],
                     [UIColor colorWithRed:229/255.0 green:66/255.0 blue:115/255.0 alpha:1],
                     [UIColor colorWithRed:148/255.0 green:141/255.0 blue:139/255.0 alpha:1],nil];
    [PieChart reloadData];
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
    [self setPieChart:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [PieChart reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    CGRect screen = [[UIScreen mainScreen] applicationFrame];
    if(interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown){
        self.view.frame = CGRectMake(0, 0, screen.size.width, screen.size.height);
    }else if(interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight){
        self.view.frame = CGRectMake(0, 0, screen.size.height, screen.size.height);
    }
    return TRUE;
}

- (IBAction)onBack:(id)sender {
    [self.view removeFromSuperview];
}

#pragma mark - XYPieChart Data Source

- (NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)pieChart
{
    return m_slices.count;
}

- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index
{
    CGFloat value = [[m_slices objectAtIndex:index] doubleValue];
    return value;
}

- (UIColor *)pieChart:(XYPieChart *)pieChart colorForSliceAtIndex:(NSUInteger)index
{
    if(pieChart == PieChart) return nil;
    UIColor* color =  [m_sliceColors objectAtIndex:(index % m_sliceColors.count)];
    return color;
}

#pragma mark - XYPieChart Delegate
- (void)pieChart:(XYPieChart *)pieChart didSelectSliceAtIndex:(NSUInteger)index
{
    NSLog(@"did select slice at index %d",index);
}

@end
