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

-(id)init{
    self = [super init];
    if(self){
        // Custom initialization
        m_sections = [[NSMutableArray alloc] init];
        m_record = [[MortgageRecord alloc] init];
        m_output = [[MortgageOutput alloc] init];
        m_pieChartSlices = [[NSMutableArray alloc] init];
        m_pieChartDesps = [[NSMutableArray alloc] init];
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
    [self setM_delegate:nil];
    [self setM_pieChartDesps:nil];
    [self setM_pieChartSlices:nil];
}

-(void)setSectionWithRecord:(MortgageRecord*)record{
    m_record = [record copy];
    m_output = [[self getOutput] copy];
    
    self.title = m_record.name;
    [m_sections removeAllObjects];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: DATEFORMAT];
    NSString* datestring = [dateFormatter stringFromDate:record.input.date];
    
    NSArray* sectionkeys0 = [[NSArray alloc] initWithObjects:
                             KEY_MORTGAGE_HOMEVALUE,
                             KEY_MORTGAGE_LOANPERCENT,
                             KEY_MORTGAGE_LOANYEAR,
                             KEY_MORTGAGE_LOANRATE,
                             nil];
    NSArray* sectionValues0 = [[NSArray alloc] initWithObjects:
                               [NSString stringWithFormat:@"%0.4f 萬元",m_record.input->homeValue],
                               [NSString stringWithFormat:@"%0.2f %%",m_record.input->loanPercent],
                               [NSString stringWithFormat:@"%d 年",m_record.input->loanYear],
                               [NSString stringWithFormat:@"%0.2f %%",m_record.input->loanRate],
                               nil];
    
    NSArray* sectionkeys1 = [[NSArray alloc] initWithObjects:
                             KEY_MORTGAGE_BANKID,
                             KEY_MORTGAGE_LOANTERM,
                             KEY_MORTGAGE_LOANDATE,
                             KEY_MORTGAGE_MONTHLYPAY,
                             KEY_MORTGAGE_ALREADYPAIDAMOUNT,
                             KEY_MORTGAGE_TOBEPAIDAMOUNT,
                             nil];
    
    NSArray* sectionValues1 = [[NSArray alloc] initWithObjects:
                               [[[BankTypes alloc] init] getBankNameById:m_record->bankId],
                               [NSString stringWithFormat:@"%d 期",m_output->loanTerms],
                               datestring,
                               [NSString stringWithFormat:@"%0.2f 元",m_output->monthlyPay],
                               [NSString stringWithFormat:@"%0.4f 萬元",m_output->alreadyPaidAmount],
                               [NSString stringWithFormat:@"%0.4f 萬元",m_output->toBePaidAmount],
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
                             KEY_MORTGAGE_TOTALPAY,
                             nil];

    NSArray* sectionValues3 = [[NSArray alloc] initWithObjects:
                               [NSString stringWithFormat:@"%0.4f 萬元",m_output->loanAmount],
                               [NSString stringWithFormat:@"%0.4f 萬元",m_output->totalInterest],
                               [NSString stringWithFormat:@"%0.4f 萬元",m_output->totalPay],
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
    
    //slices for section 1 pie chart
    NSArray *s1Slices = [[NSArray alloc] initWithObjects:
                         [NSString stringWithFormat:@"%0.4f",m_output->alreadyPaidAmount/m_output->totalPay],
                         [NSString stringWithFormat:@"%0.4f",m_output->toBePaidAmount/m_output->totalPay],
                         nil];
    NSArray *s1Desps = [[NSArray alloc] initWithObjects:
                        [KEY_MORTGAGE_ALREADYPAIDAMOUNT stringByAppendingString:[NSString stringWithFormat:@": %0.4f 萬元",m_output->alreadyPaidAmount]],
                        [KEY_MORTGAGE_TOBEPAIDAMOUNT stringByAppendingString:[NSString stringWithFormat:@": %0.4f 萬元",m_output->toBePaidAmount]],
                        [KEY_MORTGAGE_TOTALPAY stringByAppendingString:[NSString stringWithFormat:@": %0.4f 萬元",m_output->totalPay]],
                        nil];
    
    //slices for section 2 pie chart
    NSArray *s2Slices = [[NSArray alloc] initWithObjects:
                         [NSString stringWithFormat:@"%0.4f",m_output->firstPay/m_output->firstExpence],
                         [NSString stringWithFormat:@"%0.4f",m_output->tax/m_output->firstExpence/10000.0],
                         [NSString stringWithFormat:@"%0.4f",m_output->comission/m_output->firstExpence/10000.0],
                         nil];
    NSArray *s2Desps = [[NSArray alloc] initWithObjects:
                        [KEY_MORTGAGE_FIRSTPAY stringByAppendingString:[NSString stringWithFormat:@": %0.4f 萬元",m_output->firstPay]],
                        [KEY_MORTGAGE_TAX stringByAppendingString:[NSString stringWithFormat:@": %0.4f 元",m_output->tax]],
                        [KEY_MORTGAGE_COMISSION stringByAppendingString:[NSString stringWithFormat:@": %0.4f 元",m_output->comission]],
                        [KEY_MORTGAGE_FIRSTEXPENCE stringByAppendingString:[NSString stringWithFormat:@": %0.4f 萬元",m_output->firstExpence]],
                        nil];
    
    //slices for section 3 pie chart
    NSArray *s3Slices = [[NSArray alloc] initWithObjects:
                         [NSString stringWithFormat:@"%0.4f",m_output->loanAmount/m_output->totalPay],
                         [NSString stringWithFormat:@"%0.4f",m_output->totalInterest/m_output->totalPay],
                         nil];
    NSArray *s3Desps = [[NSArray alloc] initWithObjects:
                        [KEY_MORTGAGE_LOANAMOUNT stringByAppendingString:[NSString stringWithFormat:@": %0.4f 萬元",m_output->loanAmount]],
                        [KEY_MORTGAGE_TOTALINTEREST stringByAppendingString:[NSString stringWithFormat:@": %0.4f 萬元",m_output->totalInterest]],
                        [KEY_MORTGAGE_TOTALPAY stringByAppendingString:[NSString stringWithFormat:@": %0.4f 萬元",m_output->totalPay]],
                        nil];
    
    //slices for section 4 pie chart
    NSArray *s4Slices = [[NSArray alloc] initWithObjects:
                         [NSString stringWithFormat:@"%0.4f",m_output->firstPay/m_output->totalExpence],
                         [NSString stringWithFormat:@"%0.4f",m_output->tax/m_output->totalExpence/10000.0],
                         [NSString stringWithFormat:@"%0.4f",m_output->comission/m_output->totalExpence/10000.0],
                         [NSString stringWithFormat:@"%0.4f",m_output->totalPay/m_output->totalExpence],
                         [NSString stringWithFormat:@"%0.4f",m_output->totalInterest/m_output->totalExpence],
                         nil];
    NSArray *s4Desps = [[NSArray alloc] initWithObjects:
                        [KEY_MORTGAGE_FIRSTPAY stringByAppendingString:[NSString stringWithFormat:@": %0.4f 萬元",m_output->firstPay]],
                        [KEY_MORTGAGE_TAX stringByAppendingString:[NSString stringWithFormat:@": %0.4f 元",m_output->tax]],
                        [KEY_MORTGAGE_COMISSION stringByAppendingString:[NSString stringWithFormat:@": %0.4f 元",m_output->comission]],
                        [KEY_MORTGAGE_LOANAMOUNT stringByAppendingString:[NSString stringWithFormat:@": %0.4f 萬元",m_output->loanAmount]],
                        [KEY_MORTGAGE_TOTALINTEREST stringByAppendingString:[NSString stringWithFormat:@": %0.4f 萬元",m_output->totalInterest]],
                        [KEY_MORTGAGE_TOTALEXPENCE stringByAppendingString:[NSString stringWithFormat:@": %0.4f 萬元",m_output->totalExpence]],
                        nil];
    
    [m_pieChartSlices addObject:s1Slices];
    [m_pieChartSlices addObject:s2Slices];
    [m_pieChartSlices addObject:s3Slices];
    [m_pieChartSlices addObject:s4Slices];
    
    [m_pieChartDesps addObject:s1Desps];
    [m_pieChartDesps addObject:s2Desps];
    [m_pieChartDesps addObject:s3Desps];
    [m_pieChartDesps addObject:s4Desps];
    
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

- (void)onEdit:(id)sender{
    AddRecordViewController* rootController = [[AddRecordViewController alloc] initWithMortgageRecord:m_record];
    [rootController setM_delegate:self];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:rootController];
    
    navController.navigationBar.topItem.title = self.navigationController.navigationBar.topItem.title;
    navController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"存儲" style:UIBarButtonSystemItemDone target:rootController action:@selector(onSaveRecord:)];
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

#pragma mark
#pragma mark - UITableViewDlegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section != 0){
        return [[[m_sections objectAtIndex:section] objectAtIndex:0] count] + 1;
    }
    return [[[m_sections objectAtIndex:section] objectAtIndex:0] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [m_sections count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* MortgageRecordDetailsNormalCell = @"MortgageRecordDetailsNormalCell";
    NSString* MortgageRecordDetailsPieChartCell = @"MortgageRecordDetailsPieChartCell";
    
    UITableViewCell *cell = nil;
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if(section != 0 && row == [[[m_sections objectAtIndex:section] objectAtIndex:0] count]){
        cell = [tableView dequeueReusableCellWithIdentifier:MortgageRecordDetailsPieChartCell];
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:MortgageRecordDetailsNormalCell];
    }
    
    if(cell == nil){
        if(section != 0 && row == [[[m_sections objectAtIndex:section] objectAtIndex:0] count]){
            NSArray* slices = [m_pieChartSlices objectAtIndex:(section - 1)];
            NSArray* desps = [m_pieChartDesps objectAtIndex:(section - 1)];
            cell = [[PieChartCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:MortgageRecordDetailsPieChartCell Slices:slices Descriptions:desps Colors:nil];
        }else{
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:MortgageRecordDetailsNormalCell];
            cell.textLabel.text = [[[m_sections objectAtIndex:indexPath.section] objectAtIndex:0] objectAtIndex:indexPath.row];
            cell.detailTextLabel.text = [[[m_sections objectAtIndex:indexPath.section] objectAtIndex:1] objectAtIndex:indexPath.row];
            [cell setAccessoryType:UITableViewCellAccessoryNone];
        }
    }else{
        if(section != 0 && row == [[[m_sections objectAtIndex:section] objectAtIndex:0] count]){
            // show pie chart for section 1, row 6
            NSArray* slices = [m_pieChartSlices objectAtIndex:(section - 1)];
            NSArray* desps = [m_pieChartDesps objectAtIndex:(section - 1)];
            [(PieChartCell*)cell setSlices:slices Descriptions:desps Colors:nil];
        }else{
            cell.textLabel.text = [[[m_sections objectAtIndex:indexPath.section] objectAtIndex:0] objectAtIndex:indexPath.row];
            cell.detailTextLabel.text = [[[m_sections objectAtIndex:indexPath.section] objectAtIndex:1] objectAtIndex:indexPath.row];
            [cell setAccessoryType:UITableViewCellAccessoryNone];
        }

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
    if(indexPath.section != 0 && indexPath.row == [[[m_sections objectAtIndex:indexPath.section] objectAtIndex:0] count]){
        return 310;
    }
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

#pragma mark - UpdateRecordProtocl
-(void)updateRecord:(MortgageRecord *)record{
    [self setSectionWithRecord:record];
    [((UITableView*)self.view) reloadData];
    [m_delegate updateRecord:m_record];
}
@end
