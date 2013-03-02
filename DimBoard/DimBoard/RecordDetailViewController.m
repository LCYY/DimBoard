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
@synthesize m_delegate;
@synthesize m_pieChartDesps,m_pieChartSlices;
@synthesize m_pieChartCells;
@synthesize m_pieChartKeys;

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
        m_pieChartKeys = [[NSSet alloc] init];
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

- (id)initWithMortgageRecord:(MortgageRecord*)record{
    self = [self init];
    if (self) {
        [self setSectionWithRecord:record];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(onEdit:)];
    self.navigationItem.rightBarButtonItem = editButton;
    self.title = m_record.name;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [self setM_record:nil];
    [self setM_output:nil];
    [self setM_sections:nil];
    [self setM_delegate:nil];
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
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: DATEFORMAT];
    NSString* datestring = [dateFormatter stringFromDate:record.input.date];
    
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
                             KEY_MORTGAGE_BANKID,
                             KEY_MORTGAGE_LOANAMOUNT,
                             KEY_MORTGAGE_LOANTERM,
                             KEY_MORTGAGE_LOANDATE,
                             KEY_MORTGAGE_MONTHLYPAYMENT,
                             KEY_MORTGAGE_PAIDTERM,
                             KEY_MORTGAGE_PAIDPRINCIPAL,
                             KEY_MORTGAGE_TOBEPAIDPRINCIPAL,
                             KEY_MORTGAGE_PAIDINTEREST,
                             KEY_MORTGAGE_TOBEPAIDINTEREST,
                             nil];
    
    NSArray* sectionValues1 = [[NSArray alloc] initWithObjects:
                               [[[BankTypes alloc] init] getBankNameById:m_record->bankId],
                               [NSString stringWithFormat:@"%0.4f 萬元",m_output->loanAmount],
                               [NSString stringWithFormat:@"%d 期",m_output->loanTerms],
                               datestring,
                               [NSString stringWithFormat:@"%0.2f 元",m_output->monthlyPay],
                               [NSString stringWithFormat:@"%d 期",m_output->paidTerms],
                               [NSString stringWithFormat:@"%0.4f 萬元",m_output->paidPrincipal],
                               [NSString stringWithFormat:@"%0.4f 萬元",m_output->toPayPrincipal],
                               [NSString stringWithFormat:@"%0.4f 萬元",m_output->paidInterest],
                               [NSString stringWithFormat:@"%0.4f 萬元",m_output->toPayInterest],
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
    
    NSArray* sectionkeys5 = [[NSArray alloc] initWithObjects:
                             KEY_MORTGAGE_TABLE,
                             nil];
    
    NSArray* sectionValues5 = [[NSArray alloc] initWithObjects:
                               @"",
                               nil];
    
    NSArray* sectionPair0 = [[NSMutableArray alloc] initWithObjects:sectionkeys0, sectionValues0, nil];
    NSArray* sectionPair1 = [[NSMutableArray alloc] initWithObjects:sectionkeys1, sectionValues1, nil];
    NSArray* sectionPair2 = [[NSMutableArray alloc] initWithObjects:sectionkeys2, sectionValues2, nil];
    NSArray* sectionPair3 = [[NSMutableArray alloc] initWithObjects:sectionkeys3, sectionValues3, nil];
    NSArray* sectionPair4 = [[NSMutableArray alloc] initWithObjects:sectionkeys4, sectionValues4, nil];
    NSArray* sectionPair5 = [[NSMutableArray alloc] initWithObjects:sectionkeys5, sectionValues5, nil];
    
    [m_sections addObject:sectionPair0];
    [m_sections addObject:sectionPair1];
    [m_sections addObject:sectionPair2];
    [m_sections addObject:sectionPair3];
    [m_sections addObject:sectionPair4];
    [m_sections addObject:sectionPair5];
    
    //slices for section 1 pie chart
    NSArray *s1Slices = [[NSArray alloc] initWithObjects:
                         [NSString stringWithFormat:@"%0.4f",m_output->paidPrincipal/m_output->rePayment],
                         [NSString stringWithFormat:@"%0.4f",m_output->paidInterest/m_output->rePayment],
                         [NSString stringWithFormat:@"%0.4f",m_output->toPayPrincipal/m_output->rePayment],
                         [NSString stringWithFormat:@"%0.4f",m_output->toPayInterest/m_output->rePayment],
                         nil];
    NSArray *s1Desps = [[NSArray alloc] initWithObjects:
                        [KEY_MORTGAGE_PAIDPRINCIPAL stringByAppendingString:[NSString stringWithFormat:@": %0.4f 萬元",m_output->paidPrincipal]],
                        [KEY_MORTGAGE_PAIDINTEREST stringByAppendingString:[NSString stringWithFormat:@": %0.4f 萬元",m_output->paidInterest]],
                        [KEY_MORTGAGE_TOBEPAIDPRINCIPAL stringByAppendingString:[NSString stringWithFormat:@": %0.4f 萬元",m_output->toPayPrincipal]],
                        [KEY_MORTGAGE_TOBEPAIDINTEREST stringByAppendingString:[NSString stringWithFormat:@": %0.4f 萬元",m_output->toPayInterest]],
                        [KEY_MORTGAGE_REPAYMENT stringByAppendingString:[NSString stringWithFormat:@": %0.4f 萬元",m_output->rePayment]],
                        nil];
    
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
                         [NSString stringWithFormat:@"%0.4f",m_output->loanAmount/m_output->totalExpence],
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
    
    [m_pieChartSlices addObject:s1Slices];
    [m_pieChartSlices addObject:s2Slices];
    [m_pieChartSlices addObject:s3Slices];
    [m_pieChartSlices addObject:s4Slices];
    
    [m_pieChartDesps addObject:s1Desps];
    [m_pieChartDesps addObject:s2Desps];
    [m_pieChartDesps addObject:s3Desps];
    [m_pieChartDesps addObject:s4Desps];
    
    NSString* key1 = [NSString stringWithFormat:@"%d-%d", 1, [[[m_sections objectAtIndex:1] objectAtIndex:0] count]];
    NSString* key2 = [NSString stringWithFormat:@"%d-%d", 2, [[[m_sections objectAtIndex:2] objectAtIndex:0] count]];
    NSString* key3 = [NSString stringWithFormat:@"%d-%d", 3, [[[m_sections objectAtIndex:3] objectAtIndex:0] count]];
    NSString* key4 = [NSString stringWithFormat:@"%d-%d", 4, [[[m_sections objectAtIndex:4] objectAtIndex:0] count]];
    m_pieChartKeys = [[NSSet alloc] initWithObjects:key1,key2,key3,key4,nil];
    
    for(NSInteger section = 0; section < [m_sections count]; section++){
        NSString* key = [NSString stringWithFormat:@"%d-%d", section, [[[m_sections objectAtIndex:section] objectAtIndex:0] count]];
        if([m_pieChartKeys containsObject:key]){ 
            NSIndexPath* indexpath = [NSIndexPath indexPathForRow:[[[m_sections objectAtIndex:section] objectAtIndex:0] count] inSection:section];       
            NSArray* slices = [m_pieChartSlices objectAtIndex:(section - 1)];
            NSArray* desps = [m_pieChartDesps objectAtIndex:(section - 1)];
            
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
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(NSInteger)getRecordId{
    return m_record->recordId;
}

-(NSString *)getName{
    return m_record.name;
}

-(NSString *)getTermDsp{
    return [NSString stringWithFormat:@"第%d期 %0.2f元", m_output->paidTerms + 1, m_output->monthlyPay];
}

-(NSString *)getNextPayDate{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: DATEFORMAT];
    NSString* datestring = [dateFormatter stringFromDate:m_record.input.date];
    return datestring;
}

-(float)getPayProgress{
    return m_output->paidPrincipal/m_output->loanAmount;
}

- (MortgageOutput*)getOutput{
    Calculator* cal = [[Calculator alloc] init];
    [cal setInput:m_record.input];
    return [cal getOutput];
}

- (void)onEdit:(id)sender{
    AddRecordViewController* rootController = [[AddRecordViewController alloc] initWithMortgageRecord:m_record Mode:EDITMODE];
    [rootController setM_delegate:self];
    [self setHidesBottomBarWhenPushed:YES];
    self.navigationItem.title = self.title;
    [self.navigationController pushViewController:rootController animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}

#pragma mark
#pragma mark - UITableViewDlegate

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSString* key = [NSString stringWithFormat:@"%d-%d", section, [[[m_sections objectAtIndex:section] objectAtIndex:0] count]];
    if([m_pieChartKeys containsObject:key]){
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
    NSString* key = [NSString stringWithFormat:@"%d-%d", section, row];
    if([m_pieChartKeys containsObject:key]){
        cell = (PieChartCell*)[m_pieChartCells objectForKey:key];
        [((PieChartCell*)cell) setSlices:[m_pieChartSlices objectAtIndex:(section - 1)] Descriptions:[m_pieChartDesps objectAtIndex:(section - 1)] Colors:nil IndexPath:indexPath];
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:MortgageRecordDetailsNormalCell];
        if(cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:MortgageRecordDetailsNormalCell];
        }
        cell.textLabel.text = [[[m_sections objectAtIndex:indexPath.section] objectAtIndex:0] objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [[[m_sections objectAtIndex:indexPath.section] objectAtIndex:1] objectAtIndex:indexPath.row];
        if(section == [m_sections count] - 1){
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        }
        else
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
    }else if (section == 5){
        return @"供款表";
    }
    return @"";
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    NSString* key = [NSString stringWithFormat:@"%d-%d", section, row];
    if([m_pieChartKeys containsObject:key]){
        NSString* key = [NSString stringWithFormat:@"%d-%d", section, row];
        PieChartCell* cell = [m_pieChartCells objectForKey:key];
        return [cell getHeight];
    }
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 5 && indexPath.row == 0){
        MortgageMonthlyPayViewController* rootController = [[MortgageMonthlyPayViewController alloc] init];
        [rootController setPricipals:m_output.principals LeftAmount:m_output.leftLoanAmounts MonthlyPay:m_output->monthlyPay];
        [self.navigationController pushViewController:rootController animated:YES];
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    view.backgroundColor = [UIColor colorWithRed:39/255.0 green:64/255.0 blue:139/255.0 alpha:1];
    
    UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 320, 30)];
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = [UIColor whiteColor];
    label.text = [self tableView:tableView titleForHeaderInSection:section];
    label.font = [UIFont boldSystemFontOfSize:16];
    label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
    [view addSubview:label];    
    return view;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    view.backgroundColor = [UIColor colorWithRed:39/255.0 green:64/255.0 blue:139/255.0 alpha:1];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

#pragma mark - UpdateRecordProtocl
-(void)updateRecord:(MortgageRecord *)record{
    [self setSectionWithRecord:record];
    [((UITableView*)self.view) reloadData];
    [m_delegate updateRecord:m_record];
}
#pragma mark - PieChartCellExtendDelegate
-(void)extendPieChartCell:(BOOL)extend atIndexPath:(NSIndexPath *)indexpath{
    [self.tableView reloadData];
}

@end
