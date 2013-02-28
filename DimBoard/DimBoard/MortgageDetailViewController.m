//
//  MortgageDetailViewController.m
//  DimBoard
//
//  Created by conicacui on 26/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import "MortgageDetailViewController.h"

@interface MortgageDetailViewController ()

@end

@implementation MortgageDetailViewController

@synthesize m_record, m_output;
@synthesize m_sections;
@synthesize m_pieChartDesps,m_pieChartSlices;
@synthesize m_pieChartCells;
@synthesize m_recordViewController;

-(id)init{
    self = [super init];
    if(self){
        // Custom initialization
        m_sections = [[NSMutableArray alloc] init];
        m_record = [[MortgageRecord alloc] init];
        m_output = [[MortgageOutput alloc] init];
        m_pieChartSlices = [[NSMutableArray alloc] init];
        m_pieChartDesps = [[NSMutableArray alloc] init];
        m_pieChartCells = [[NSMutableDictionary alloc] init];
        m_recordViewController = nil;
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
        [self setSectionWithRecord:record];
        if(m_record.input.date == nil){
            m_record.input.date = [NSDate date];
        }
    }
    return self;
}

-(void)setRecordViewController:(id)recordViewController{
    m_recordViewController = recordViewController;
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
    [self setM_pieChartDesps:nil];
    [self setM_pieChartSlices:nil];
    [self setM_pieChartCells:nil];
}

-(void)setSectionWithRecord:(MortgageRecord*)record{
    [m_sections removeAllObjects];
    [m_pieChartDesps removeAllObjects];
    [m_pieChartSlices removeAllObjects];
    
    m_record = [record copy];
    m_output = [[self getOutput] copy];
    
    self.title = m_record.name;
        
    NSArray* sectionkeys0 = [[NSArray alloc] initWithObjects:
                             KEY_MORTGAGE_HOMEVALUE,
                             KEY_MORTGAGE_LOANPERCENT,
                             KEY_MORTGAGE_LOANYEAR,
                             KEY_MORTGAGE_INTERESTRATE,
                             nil];
    NSArray* sectionValues0 = [[NSArray alloc] initWithObjects:
                               [NSString stringWithFormat:@"%0.4f 萬元",m_record.input->homeValue],
                               [NSString stringWithFormat:@"%0.2f %%",m_record.input->loanPercent],
                               [NSString stringWithFormat:@"%d 年",m_record.input->loanYear],
                               [NSString stringWithFormat:@"%0.2f %%",m_record.input->interestRate],
                               nil];
    
    NSArray* sectionkeys1 = [[NSArray alloc] initWithObjects:
                             KEY_MORTGAGE_LOANTERM,
                             KEY_MORTGAGE_MONTHLYPAYMENT,
                             nil];
    
    NSArray* sectionValues1 = [[NSArray alloc] initWithObjects:
                               [NSString stringWithFormat:@"%d 期",m_output->loanTerms],
                               [NSString stringWithFormat:@"%0.2f 元",m_output->monthlyPay],
                               nil];
    
    NSArray* sectionkeys2 = [[NSArray alloc] initWithObjects:
                             KEY_MORTGAGE_FIRSTPAYMENT,
                             KEY_MORTGAGE_TAX,
                             KEY_MORTGAGE_COMISSION,
                             KEY_MORTGAGE_FIRSTTOTALEXP,
                             nil];
    NSArray* sectionValues2 = [[NSArray alloc] initWithObjects:
                               [NSString stringWithFormat:@"%0.4f 萬元",m_output->firstPayment],
                               [NSString stringWithFormat:@"%0.2f 元",m_output->tax],
                               [NSString stringWithFormat:@"%0.2f 元",m_output->comission],
                               [NSString stringWithFormat:@"%0.4f 萬元",m_output->firstTotalExp],
                               nil];
    
    NSArray* sectionkeys3 = [[NSArray alloc] initWithObjects:
                             KEY_MORTGAGE_LOANAMOUNT,
                             KEY_MORTGAGE_REPAYMENT_INTEREST,
                             KEY_MORTGAGE_REPAYMENT,
                             nil];
    
    NSArray* sectionValues3 = [[NSArray alloc] initWithObjects:
                               [NSString stringWithFormat:@"%0.4f 萬元",m_output->loanAmount],
                               [NSString stringWithFormat:@"%0.4f 萬元",m_output->rePaymentInterest],
                               [NSString stringWithFormat:@"%0.4f 萬元",m_output->rePayment],
                               nil];
    
    NSArray* sectionkeys4 = [[NSArray alloc] initWithObjects:
                             KEY_MORTGAGE_TOTALEXP,
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
    
    
    //slices for section 2 pie chart
    NSArray *s2Slices = [[NSArray alloc] initWithObjects:
                         [NSString stringWithFormat:@"%0.4f",m_output->firstPayment/m_output->firstTotalExp],
                         [NSString stringWithFormat:@"%0.4f",m_output->tax/m_output->firstTotalExp/10000.0],
                         [NSString stringWithFormat:@"%0.4f",m_output->comission/m_output->firstTotalExp/10000.0],
                         nil];
    NSArray *s2Desps = [[NSArray alloc] initWithObjects:
                        [KEY_MORTGAGE_FIRSTPAYMENT stringByAppendingString:[NSString stringWithFormat:@": %0.4f 萬元",m_output->firstPayment]],
                        [KEY_MORTGAGE_TAX stringByAppendingString:[NSString stringWithFormat:@": %0.4f 元",m_output->tax]],
                        [KEY_MORTGAGE_COMISSION stringByAppendingString:[NSString stringWithFormat:@": %0.4f 元",m_output->comission]],
                        [KEY_MORTGAGE_FIRSTTOTALEXP stringByAppendingString:[NSString stringWithFormat:@": %0.4f 萬元",m_output->firstTotalExp]],
                        nil];
    
    //slices for section 3 pie chart
    NSArray *s3Slices = [[NSArray alloc] initWithObjects:
                         [NSString stringWithFormat:@"%0.4f",m_output->loanAmount/m_output->rePayment],
                         [NSString stringWithFormat:@"%0.4f",m_output->rePaymentInterest/m_output->rePayment],
                         nil];
    NSArray *s3Desps = [[NSArray alloc] initWithObjects:
                        [KEY_MORTGAGE_LOANAMOUNT stringByAppendingString:[NSString stringWithFormat:@": %0.4f 萬元",m_output->loanAmount]],
                        [KEY_MORTGAGE_REPAYMENT_INTEREST stringByAppendingString:[NSString stringWithFormat:@": %0.4f 萬元",m_output->rePaymentInterest]],
                        [KEY_MORTGAGE_REPAYMENT stringByAppendingString:[NSString stringWithFormat:@": %0.4f 萬元",m_output->rePayment]],
                        nil];
    
    //slices for section 4 pie chart
    NSArray *s4Slices = [[NSArray alloc] initWithObjects:
                         [NSString stringWithFormat:@"%0.4f",m_output->firstPayment/m_output->totalExpence],
                         [NSString stringWithFormat:@"%0.4f",m_output->tax/m_output->totalExpence/10000.0],
                         [NSString stringWithFormat:@"%0.4f",m_output->comission/m_output->totalExpence/10000.0],
                         [NSString stringWithFormat:@"%0.4f",m_output->rePayment/m_output->totalExpence],
                         [NSString stringWithFormat:@"%0.4f",m_output->rePaymentInterest/m_output->totalExpence],
                         nil];
    NSArray *s4Desps = [[NSArray alloc] initWithObjects:
                        [KEY_MORTGAGE_FIRSTPAYMENT stringByAppendingString:[NSString stringWithFormat:@": %0.4f 萬元",m_output->firstPayment]],
                        [KEY_MORTGAGE_TAX stringByAppendingString:[NSString stringWithFormat:@": %0.4f 元",m_output->tax]],
                        [KEY_MORTGAGE_COMISSION stringByAppendingString:[NSString stringWithFormat:@": %0.4f 元",m_output->comission]],
                        [KEY_MORTGAGE_LOANAMOUNT stringByAppendingString:[NSString stringWithFormat:@": %0.4f 萬元",m_output->loanAmount]],
                        [KEY_MORTGAGE_REPAYMENT_INTEREST stringByAppendingString:[NSString stringWithFormat:@": %0.4f 萬元",m_output->rePaymentInterest]],
                        [KEY_MORTGAGE_TOTALEXP stringByAppendingString:[NSString stringWithFormat:@": %0.4f 萬元",m_output->totalExpence]],
                        nil];
    
    [m_pieChartSlices addObject:s2Slices];
    [m_pieChartSlices addObject:s3Slices];
    [m_pieChartSlices addObject:s4Slices];
    
    [m_pieChartDesps addObject:s2Desps];
    [m_pieChartDesps addObject:s3Desps];
    [m_pieChartDesps addObject:s4Desps];
    
    
    for(NSInteger section = 2; section < [m_sections count]; section++){
        NSIndexPath* indexpath = [NSIndexPath indexPathForRow:[[[m_sections objectAtIndex:section] objectAtIndex:0] count] inSection:section];
        NSString* key = [NSString stringWithFormat:@"%d-%d", indexpath.section, indexpath.row];
        
        NSArray* slices = [m_pieChartSlices objectAtIndex:(section - 2)];
        NSArray* desps = [m_pieChartDesps objectAtIndex:(section - 2)];
        
        PieChartCell* cell = [m_pieChartCells objectForKey:key];
        if(cell == nil){
            cell = [[PieChartCell alloc] initWithSlices:slices Descriptions:desps Colors:nil IndexPath:indexpath];
        }else{
            [cell setSlices:slices Descriptions:desps Colors:nil IndexPath:indexpath];
        }
        [((PieChartCell*)cell) setM_delegate:self];
        
        [m_pieChartCells setObject:cell forKey:key];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(NSInteger)getRecordId{
    return m_record->recordId;
}

- (MortgageOutput*)getOutput{
    Calculator* cal = [[Calculator alloc] init];
    [cal setInput:m_record.input];
    return [cal getOutput];
}

- (void)onBack:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
}

-(void)onAddMortgageToRecord:(id)sender{
    AddRecordViewController* rootController = [[AddRecordViewController alloc] initWithMortgageRecord:m_record];
    [rootController setM_delegate:m_recordViewController];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:rootController];
    navController.navigationBar.topItem.title = @"新增供款";
    navController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"存儲" style:UIBarButtonSystemItemSave target:rootController action:@selector(onSaveNewRecord:)];
    navController.navigationBar.topItem.rightBarButtonItem = saveButton;
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonSystemItemCancel target:self action:@selector(onBack:)];
    navController.navigationBar.topItem.leftBarButtonItem = cancelButton;
    
    [navController setWantsFullScreenLayout:YES];
    [navController.view setAutoresizesSubviews:NO];
    navController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    navController.visibleViewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    
    [self presentModalViewController:navController animated:YES];
}


#pragma mark
#pragma mark - UITableViewDlegate

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section != 0 && section != 1){
        return [[[m_sections objectAtIndex:section] objectAtIndex:0] count] + 1;
    }
    return [[[m_sections objectAtIndex:section] objectAtIndex:0] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [m_sections count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* MortgageRecordDetailsNormalCell = @"MortgageRecordDetailsNormalCell";
    
    UITableViewCell *cell = nil;
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if(section != 0 && section != 1 && row == [[[m_sections objectAtIndex:section] objectAtIndex:0] count]){
        NSString* key = [NSString stringWithFormat:@"%d-%d", section, row];
        cell = (PieChartCell*)[m_pieChartCells objectForKey:key];
        
        [((PieChartCell*)cell) setSlices:[m_pieChartSlices objectAtIndex:(section - 2)] Descriptions:[m_pieChartDesps objectAtIndex:(section - 2)] Colors:nil IndexPath:indexPath];
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:MortgageRecordDetailsNormalCell];
        if(cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:MortgageRecordDetailsNormalCell];
        }
        cell.textLabel.text = [[[m_sections objectAtIndex:indexPath.section] objectAtIndex:0] objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [[[m_sections objectAtIndex:indexPath.section] objectAtIndex:1] objectAtIndex:indexPath.row];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return @"物業資料";
    }else if (section == 1){
        return @"按揭資料";
    }else if (section == 2){
        return @"首付金額分析";
    }else if (section == 3){
        return @"貸款金額分析";
    }else if (section == 4){
        return @"費用總額分析";
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if(section != 0 && section != 1 && row == [[[m_sections objectAtIndex:section] objectAtIndex:0] count]){
        NSString* key = [NSString stringWithFormat:@"%d-%d", section, row];
        PieChartCell* cell = [m_pieChartCells objectForKey:key];
        return [cell getHeight];
    }
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

#pragma mark - PieChartCellExtendDelegate
-(void)extendPieChartCell:(BOOL)extend atIndexPath:(NSIndexPath *)indexpath{
    [self.tableView reloadData];
}
@end

