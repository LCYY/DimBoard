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

-(id)init{
    self = [super init];
    if(self){
        // Custom initialization
        m_sections = [[NSMutableArray alloc] init];
        m_record = [[MortgageRecord alloc] init];
        m_output = [[MortgageOutput alloc] init];
    }
    return self;
}

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
    self = [self init];
    if (self) {
        [m_record updateRecord:record];
        [self getOutput];
        [self setTitle:m_record->name];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat: @"yyyy-MM-dd"];
        NSString* datestring = [dateFormatter stringFromDate:record->date];
        
        NSArray* sectionkeys0 = [[NSArray alloc] initWithObjects:
                                    KEY_MORTGAGE_HOMEVALUE,
                                    KEY_MORTGAGE_LOANPERCENT,
                                    KEY_MORTGAGE_LOANYEAR,
                                    KEY_MORTGAGE_LOANRATE,
                                    nil];
        NSArray* sectionValues0 = [[NSArray alloc] initWithObjects:
                                    [NSString stringWithFormat:@"%0.4f 萬元",m_record->input->homeValue],
                                    [NSString stringWithFormat:@"%0.2f %%",m_record->input->loanPercent],
                                    [NSString stringWithFormat:@"%d 年",m_record->input->loanYear],
                                    [NSString stringWithFormat:@"%0.2f %%",m_record->input->loanRate],
                                    nil];
        
        NSArray* sectionkeys1 = [[NSArray alloc] initWithObjects:
                                    KEY_MORTGAGE_BANKID,
                                    KEY_MORTGAGE_LOANTERM,
                                    KEY_MORTGAGE_LOANDATE,
                                    KEY_MORTGAGE_MONTHLYPAY,
                                    nil];
        NSArray* sectionValues1 = [[NSArray alloc] initWithObjects:
                                    [[[BankTypes alloc] init] getBankNameById:m_record->bankId],
                                    [NSString stringWithFormat:@"%d 期",m_output->loanTerms],
                                    datestring,
                                    [NSString stringWithFormat:@"%0.2f 元",m_output->monthlyPay],
                                    nil];

        NSArray* sectionkeys2 = [[NSArray alloc] initWithObjects:
                                    KEY_MORTGAGE_FIRSTPAY,
                                    KEY_MORTGAGE_TAX,
                                    KEY_MORTGAGE_COMISSION,
                                    KEY_MORTGAGE_FIRSTEXPENCE,
                                    nil];
        NSArray* sectionValues2 = [[NSArray alloc] initWithObjects:
                                    [NSString stringWithFormat:@"%0.4f 萬元",m_output->firstPay],
                                    [NSString stringWithFormat:@"%0.2f 元",m_output->tax],
                                    [NSString stringWithFormat:@"%0.2f 元",m_output->comission],
                                    [NSString stringWithFormat:@"%0.4f 萬元",m_output->firstExpence],
                                    nil];
        
        NSArray* sectionkeys3 = [[NSArray alloc] initWithObjects:
                                    KEY_MORTGAGE_LOANAMOUNT,
                                    KEY_MORTGAGE_TOTALINTEREST,
                                    KEY_MORTGAGE_TOTALEXPENCE,
                                    nil];

        NSArray* sectionValues3 = [[NSArray alloc] initWithObjects:
                                    [NSString stringWithFormat:@"%0.4f 萬元",m_output->loanAmount],
                                    [NSString stringWithFormat:@"%0.4f 萬元",m_output->totalInterest],
                                    [NSString stringWithFormat:@"%0.4f 萬元",m_output->totalExpence],
                                    nil];

        NSArray* sectionkeys4 = [[NSArray alloc] initWithObjects:
                                    KEY_MORTGAGE_TOTALEXPENCE,
                                    nil];

        NSArray* sectionValues4 = [[NSArray alloc] initWithObjects:
                                    [NSString stringWithFormat:@"%0.4f 萬元",m_output->totalExpence],
                                    nil];
        
        NSArray* sectionPair0 = [[NSMutableArray alloc] initWithObjects:sectionkeys0, sectionValues0, nil];
        NSArray* sectionPair1 = [[NSMutableArray alloc] initWithObjects:sectionkeys1, sectionValues1, nil];
        NSArray* sectionPair2 = [[NSMutableArray alloc] initWithObjects:sectionkeys2, sectionValues2, nil];
        NSArray* sectionPair3 = [[NSMutableArray alloc] initWithObjects:sectionkeys3, sectionValues3, nil];
        NSArray* sectionPair4 = [[NSMutableArray alloc] initWithObjects:sectionkeys4, sectionValues4, nil];
        
        [m_sections addObject:sectionPair0];
        [m_sections addObject:sectionPair1];
        [m_sections addObject:sectionPair2];
        [m_sections addObject:sectionPair3];
        [m_sections addObject:sectionPair4];
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

-(NSInteger)getRecordId{
    return m_record->recordId;
}

- (void)getOutput{
    Calculator* cal = [[Calculator alloc] init];
    [cal setInput:m_record->input];
    [cal getOutput:m_output];
}

- (void)onEdit:(id)sender{
    AddRecordViewController* rootController = [[AddRecordViewController alloc] initWithMortgageRecord:m_record];
    
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
    return [[[m_sections objectAtIndex:section] objectAtIndex:0] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [m_sections count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* MortgageRecordDetails = @"MortgageRecordDetails";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MortgageRecordDetails];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:MortgageRecordDetails];
    }
    cell.textLabel.text = [[[m_sections objectAtIndex:indexPath.section] objectAtIndex:0] objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [[[m_sections objectAtIndex:indexPath.section] objectAtIndex:1] objectAtIndex:indexPath.row];
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    return cell;
}
@end
