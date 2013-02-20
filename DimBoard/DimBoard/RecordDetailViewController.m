//
//  RecordDetailViewController.m
//  DimBoard
//
//  Created by conicacui on 7/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import "RecordDetailViewController.h"

@interface RecordDetailViewController ()

@end

@implementation RecordDetailViewController
@synthesize m_record, m_output;
@synthesize m_sections;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style{
    //set style as UITableViewStyleGrouped
    self = [super initWithStyle:UITableViewStyleGrouped];
    return self;
}

- (id)initWithMortgageRecord:(MortgageRecord*)record{
    self = [super init];
    if (self) {
        // Custom initialization
        m_sections = [[NSMutableArray alloc] init];
        m_record = [record copy];
        m_output = [[MortgageOutput alloc] initVariables];
        [self getOutput];
        
        [self setTitle:m_record->name];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat: @"yyyy-MM-dd"];
        NSString* datestring = [dateFormatter stringFromDate:record->date];
        
        NSDictionary* section0 = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    [NSString stringWithFormat:@"%0.4f 萬元",m_record->input->homeValue],KEY_MORTGAGE_HOMEVALUE,
                                    [NSString stringWithFormat:@"%0.2f %%",m_record->input->loanPercent],KEY_MORTGAGE_LOANPERCENT,    
                                    [NSString stringWithFormat:@"%d 年",m_record->input->loanYear],KEY_MORTGAGE_LOANYEAR,
                                    [NSString stringWithFormat:@"%0.2f %%",m_record->input->loanRate],KEY_MORTGAGE_LOANRATE,     
                                    nil];
        
        NSDictionary* section1 = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    [[[BankTypes alloc] init] getBankNameById:m_record->bankId],KEY_MORTGAGE_BANKID,
                                    [NSString stringWithFormat:@"%d 期",m_output->loanTerms],KEY_MORTGAGE_LOANTERM,
                                    datestring,KEY_MORTGAGE_LOANDATE,
                                    [NSString stringWithFormat:@"%0.2f 元",m_output->totoalPay],KEY_MORTGAGE_MONTHLYPAY,
                                    nil];
        
        NSDictionary* section2 = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    [NSString stringWithFormat:@"%0.4f 萬元",m_output->firstPay],KEY_MORTGAGE_FIRSTPAY,
                                    [NSString stringWithFormat:@"%0.2f 元",m_output->tax],KEY_MORTGAGE_TAX,
                                    [NSString stringWithFormat:@"%0.2f 元",m_output->comission],KEY_MORTGAGE_COMISSION,
                                    [NSString stringWithFormat:@"%0.4f 萬元",m_output->firstExpence],KEY_MORTGAGE_FIRSTEXPENCE,
                                    nil];

        NSDictionary* section3 = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    [NSString stringWithFormat:@"%0.4f 萬元",m_output->loanAmount],KEY_MORTGAGE_LOANAMOUNT,
                                    [NSString stringWithFormat:@"%0.4f 萬元",m_output->totalInterest],KEY_MORTGAGE_TOTALINTEREST,
                                    [NSString stringWithFormat:@"%0.4f 萬元",m_output->totalExpence],KEY_MORTGAGE_TOTALEXPENCE,
                                    nil];
        
        NSDictionary* section4 = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    [NSString stringWithFormat:@"%0.4f 萬元",m_output->totalExpence],KEY_MORTGAGE_TOTALEXPENCE,
                                    nil];
        
        [m_sections addObject:section0];
        [m_sections addObject:section1];
        [m_sections addObject:section2];
        [m_sections addObject:section3];
        [m_sections addObject:section4];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [self setM_record:nil];
    [self setM_output:nil];
    [self setM_sections:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)getOutput{
    Calculator* cal = [[Calculator alloc] initVarirables];
    [cal setInput:m_record->input];
    [cal getOutput:m_output];
}

- (void)onEdit:(id)sender{
    AddRecordViewController* rootController = [[AddRecordViewController alloc] init];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:rootController];
    
    navController.navigationBar.topItem.title = self.navigationController.navigationBar.topItem.title;
    navController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"存儲" style:UIBarButtonSystemItemDone target:self action:@selector(onChangeReocrd:)];
    navController.navigationBar.topItem.rightBarButtonItem = saveButton;
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonSystemItemDone target:self action:@selector(onBack:)];
    navController.navigationBar.topItem.leftBarButtonItem = cancelButton;
    
    [navController setWantsFullScreenLayout:YES];
    [navController.view setAutoresizesSubviews:NO];
    navController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    navController.visibleViewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    
    [self presentModalViewController:navController animated:YES];
}

- (void)onBack:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)onChangeReocrd:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark
#pragma mark - UITableViewDlegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[m_sections objectAtIndex:section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* MortgageRecordDetails = @"MortgageRecordDetails";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MortgageRecordDetails];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:MortgageRecordDetails];
    }
    cell.textLabel.text = [[[m_sections objectAtIndex:indexPath.section] allKeys] objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [[[m_sections objectAtIndex:indexPath.section] allValues] objectAtIndex:indexPath.row];
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    return cell;
}
@end
