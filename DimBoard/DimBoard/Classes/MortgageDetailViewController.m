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
@synthesize m_pieChartKeys;
@synthesize m_tableView, m_adBannerView;

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

- (id)initWithMortgageRecord:(MortgageRecord*)record{
    self = [self init];
    if (self) {
        m_record = [record copy];
        m_output = [[self getOutput] copy];
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
    
    [m_tableView setDataSource:self];
    [m_tableView setDelegate:self];
    [m_adBannerView setDelegate:self];
    
    UIBarButtonItem* addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onAddMortgageToRecord:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    self.navigationController.delegate = self;
    
    [self rotateToOrientation:self.interfaceOrientation];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onViewRotation:) name:NOTI_SCREENROTATION object:nil];

    
    [self setSectionWithRecord];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = DimBoardLocalizedString(@"TotalExpensesInfo");
    [self setSectionWithRecord];
}

- (void)viewDidUnload
{
    [self setM_tableView:nil];
    [self setM_tableView:nil];
    [self setM_adBannerView:nil];
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

-(void)setSectionWithRecord{
    [m_sections removeAllObjects];
    [m_pieChartDesps removeAllObjects];
    [m_pieChartSlices removeAllObjects];

    self.title = m_record.name;
        
    NSArray* sectionkeys0 = [[NSArray alloc] initWithObjects:
                             DimBoardLocalizedString(@"HomeValue"),
                             DimBoardLocalizedString(@"LoanRatio"),
                             DimBoardLocalizedString(@"MortYear"),
                             DimBoardLocalizedString(@"InterestRate"),
                             nil];
    NSArray* sectionValues0 = [[NSArray alloc] initWithObjects:
                               [NSString stringWithFormat:@"%@ ＄",[self getFormattedString:m_record.input->homeValue]],
                               [NSString stringWithFormat:@"%0.0f %%",m_record.input->loanPercent],
                               [NSString stringWithFormat:@"%d 年",m_record.input->loanYear],
                               [NSString stringWithFormat:@"%0.2f %%",m_record.input->interestRate],
                               nil];
    
    NSArray* sectionkeys1 = [[NSArray alloc] initWithObjects:
                             DimBoardLocalizedString(@"LoanTerm"),
                             DimBoardLocalizedString(@"MonthlyPay"),
                             nil];
    
    NSArray* sectionValues1 = [[NSArray alloc] initWithObjects:
                               [NSString stringWithFormat:@"%d %@",m_output->loanTerms, DimBoardLocalizedString(@"Term")],
                               [NSString stringWithFormat:@"%@ ＄",[self getFormattedString:m_output->monthlyPay]],
                               nil];
    
    NSArray* sectionkeys2 = [[NSArray alloc] initWithObjects:
                             DimBoardLocalizedString(@"FirstPay"),
                             DimBoardLocalizedString(@"Tax"),
                             DimBoardLocalizedString(@"Comission"),
                             DimBoardLocalizedString(@"FirstTotalExpence"),
                             nil];
    NSArray* sectionValues2 = [[NSArray alloc] initWithObjects:
                               [NSString stringWithFormat:@"%@ ＄",[self getFormattedString:m_output->firstPayment]],
                               [NSString stringWithFormat:@"%@ ＄",[self getFormattedString:m_output->tax]],
                               [NSString stringWithFormat:@"%@ ＄",[self getFormattedString:m_output->comission]],
                               [NSString stringWithFormat:@"%@ ＄",[self getFormattedString:m_output->firstTotalExp]],
                               nil];
    
    NSArray* sectionkeys3 = [[NSArray alloc] initWithObjects:
                             DimBoardLocalizedString(@"LoanAmount"),
                             DimBoardLocalizedString(@"TotalInterestAmount"),
                             DimBoardLocalizedString(@"TotalRepayment"),
                             nil];
    
    NSArray* sectionValues3 = [[NSArray alloc] initWithObjects:
                               [NSString stringWithFormat:@"%@ ＄",[self getFormattedString:m_output->loanAmount]],
                               [NSString stringWithFormat:@"%@ ＄",[self getFormattedString:m_output->rePaymentInterest]],
                               [NSString stringWithFormat:@"%@ ＄",[self getFormattedString:m_output->rePayment]],
                               nil];
    
    NSArray* sectionkeys4 = [[NSArray alloc] initWithObjects:
                             DimBoardLocalizedString(@"TotalExpences"),
                             nil];
    
    NSArray* sectionValues4 = [[NSArray alloc] initWithObjects:
                               [NSString stringWithFormat:@"%@ ＄",[self getFormattedString:m_output->totalExpence]],
                               nil];
    
    NSArray* sectionkeys5 = [[NSArray alloc] initWithObjects:
                             DimBoardLocalizedString(@"RepaymentSchedule"),
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
    
    
    //slices for section 2 pie chart
    NSArray *s2Slices = [[NSArray alloc] initWithObjects:
                         [NSString stringWithFormat:@"%@",[self getFormattedString:m_output->firstPayment/m_output->firstTotalExp]],
                         [NSString stringWithFormat:@"%@",[self getFormattedString:m_output->tax/m_output->firstTotalExp]],
                         [NSString stringWithFormat:@"%@",[self getFormattedString:m_output->comission/m_output->firstTotalExp]],
                         nil];
    NSArray *s2Desps = [[NSArray alloc] initWithObjects:
                        [DimBoardLocalizedString(@"FirstPay") stringByAppendingString:[NSString stringWithFormat:@": %@ ＄",[self getFormattedString:m_output->firstPayment]]],
                        [DimBoardLocalizedString(@"Tax") stringByAppendingString:[NSString stringWithFormat:@": %@ ＄",[self getFormattedString:m_output->tax]]],
                        [DimBoardLocalizedString(@"Comission") stringByAppendingString:[NSString stringWithFormat:@": %@ ＄",[self getFormattedString:m_output->comission]]],
                        [DimBoardLocalizedString(@"FirstTotalExpence") stringByAppendingString:[NSString stringWithFormat:@": %@ ＄",[self getFormattedString:m_output->firstTotalExp]]],
                        nil];
    
    //slices for section 3 pie chart
    NSArray *s3Slices = [[NSArray alloc] initWithObjects:
                         [NSString stringWithFormat:@"%@",[self getFormattedString:m_output->loanAmount/m_output->rePayment]],
                         [NSString stringWithFormat:@"%@",[self getFormattedString:m_output->rePaymentInterest/m_output->rePayment]],
                         nil];
    NSArray *s3Desps = [[NSArray alloc] initWithObjects:
                        [DimBoardLocalizedString(@"LoanAmount") stringByAppendingString:[NSString stringWithFormat:@": %@ ＄",[self getFormattedString:m_output->loanAmount]]],
                        [DimBoardLocalizedString(@"TotalInterestAmount") stringByAppendingString:[NSString stringWithFormat:@": %@ ＄",[self getFormattedString:m_output->rePaymentInterest]]],
                        [DimBoardLocalizedString(@"TotalRepayment") stringByAppendingString:[NSString stringWithFormat:@": %@ ＄",[self getFormattedString:m_output->rePayment]]],
                        nil];
    
    //slices for section 4 pie chart
    NSArray *s4Slices = [[NSArray alloc] initWithObjects:
                         [NSString stringWithFormat:@"%@",[self getFormattedString:m_output->firstPayment/m_output->totalExpence]],
                         [NSString stringWithFormat:@"%@",[self getFormattedString:m_output->tax/m_output->totalExpence]],
                         [NSString stringWithFormat:@"%@",[self getFormattedString:m_output->comission/m_output->totalExpence]],
                         [NSString stringWithFormat:@"%@",[self getFormattedString:m_output->rePayment/m_output->totalExpence]],
                         [NSString stringWithFormat:@"%@",[self getFormattedString:m_output->rePaymentInterest/m_output->totalExpence]],
                         nil];
    NSArray *s4Desps = [[NSArray alloc] initWithObjects:
                        [DimBoardLocalizedString(@"FirstPay") stringByAppendingString:[NSString stringWithFormat:@": %@ ＄",[self getFormattedString:m_output->firstPayment]]],
                        [DimBoardLocalizedString(@"Tax") stringByAppendingString:[NSString stringWithFormat:@": %@ ＄",[self getFormattedString:m_output->tax]]],
                        [DimBoardLocalizedString(@"Comission") stringByAppendingString:[NSString stringWithFormat:@": %@ ＄",[self getFormattedString:m_output->comission]]],
                        [DimBoardLocalizedString(@"LoanAmount") stringByAppendingString:[NSString stringWithFormat:@": %@ ＄",[self getFormattedString:m_output->loanAmount]]],
                        [DimBoardLocalizedString(@"TotalInterestAmount") stringByAppendingString:[NSString stringWithFormat:@": %@ ＄",[self getFormattedString:m_output->rePaymentInterest]]],
                        [DimBoardLocalizedString(@"TotalExpences") stringByAppendingString:[NSString stringWithFormat:@": %@ ＄",[self getFormattedString:m_output->totalExpence]]],
                        nil];
    
    [m_pieChartSlices addObject:s2Slices];
    [m_pieChartSlices addObject:s3Slices];
    [m_pieChartSlices addObject:s4Slices];
    
    [m_pieChartDesps addObject:s2Desps];
    [m_pieChartDesps addObject:s3Desps];
    [m_pieChartDesps addObject:s4Desps];
    
    NSString* key2 = [NSString stringWithFormat:@"%d-%d", 2, [[[m_sections objectAtIndex:2] objectAtIndex:0] count]];
    NSString* key3 = [NSString stringWithFormat:@"%d-%d", 3, [[[m_sections objectAtIndex:3] objectAtIndex:0] count]];
    NSString* key4 = [NSString stringWithFormat:@"%d-%d", 4, [[[m_sections objectAtIndex:4] objectAtIndex:0] count]];
    m_pieChartKeys = [[NSSet alloc] initWithObjects:key2,key3,key4,nil];

    for(NSInteger section = 0; section < [m_sections count]; section++){
        NSString* key = [NSString stringWithFormat:@"%d-%d", section, [[[m_sections objectAtIndex:section] objectAtIndex:0] count]];
        if([m_pieChartKeys containsObject:key]){
            NSIndexPath* indexpath = [NSIndexPath indexPathForRow:[[[m_sections objectAtIndex:section] objectAtIndex:0] count] inSection:section];
            
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
}

-(NSInteger)getRecordId{
    return m_record->recordId;
}

- (MortgageOutput*)getOutput{
    Calculator* cal = [[Calculator alloc] init];
    [cal setInput:m_record.input];
    return [cal getOutput];
}

-(void)onViewRotation:(NSNotification*) noti{
    NSString* orientation = noti.object;
    [self rotateToOrientation:[orientation integerValue]];
}

-(void)rotateToOrientation:(UIInterfaceOrientation) orientation{
    CGRect frame = m_tableView.frame;
    CGRect bannerframe = m_adBannerView.frame;
    CGRect layout = self.view.frame;
    if(m_adBannerView.isHidden){
        frame.size.height = layout.size.height;
    }else{
        frame.size.height = layout.size.height - bannerframe.size.height;
    }
    [m_tableView setFrame:frame];
    bannerframe.origin.y = frame.origin.y + frame.size.height;
    bannerframe.origin.x = frame.origin.x;
    [m_adBannerView setFrame:bannerframe];
}

-(void)onAddMortgageToRecord:(id)sender{
    AddRecordViewController* rootController = [[AddRecordViewController alloc] initWithMortgageRecord:m_record Mode:ADDMODE];
    [rootController setM_delegate:m_recordViewController];
    [self setHidesBottomBarWhenPushed:YES];
    self.navigationItem.title = self.title;
    [self.navigationController pushViewController:rootController animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}

- (NSString*) getFormattedString:(double)indouble{
    NSString* instr = [NSString stringWithFormat:@"%0.2f",indouble];
    NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber* innum = [NSNumber numberWithDouble:[instr doubleValue]];
    return [formatter stringFromNumber:innum];
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
        if(section == 5){
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        }else{
            [cell setAccessoryType:UITableViewCellAccessoryNone];
        }
    }
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return DimBoardLocalizedString(@"PropertyInfo");
    }else if (section == 1){
        return DimBoardLocalizedString(@"MortInfo");
    }else if (section == 2){
        return DimBoardLocalizedString(@"FirstPaymentDetails");
    }else if (section == 3){
        return DimBoardLocalizedString(@"RepaymentDetails");
    }else if (section == 4){
        return DimBoardLocalizedString(@"TotalExpensesDetails");
    }else if (section == 5){
        return DimBoardLocalizedString(@"RepaymentSchedule");
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
    return TABLE_CELL_HEIGHT;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 5 && indexPath.row == 0){
        MortgageMonthlyPayViewController* rootController = [[MortgageMonthlyPayViewController alloc] init];
        [rootController setPricipals:m_output.principals LeftAmount:m_output.leftLoanAmounts MonthlyPay:m_output->monthlyPay];
        [self setHidesBottomBarWhenPushed:YES];
        self.navigationItem.title = self.title;
        [self.navigationController pushViewController:rootController animated:YES];
        [self setHidesBottomBarWhenPushed:NO];
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
    return TABLE_SECTION_HEADER_HEIGHT;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

#pragma mark - PieChartCellExtendDelegate
-(void)extendPieChartCell:(BOOL)extend atIndexPath:(NSIndexPath *)indexpath{
    [self.m_tableView reloadData];
}

#pragma mark - ADBannerView
- (void)bannerViewDidLoadAd:(ADBannerView *)banner{
    CGRect frame = m_tableView.frame;
    CGRect bannerframe = m_adBannerView.frame;
    CGRect layout = self.view.frame;
    frame.size.height = layout.size.height - bannerframe.size.height;
    [m_tableView setFrame:frame];
    
    bannerframe.origin.y = frame.origin.y + frame.size.height;
    bannerframe.origin.x = frame.origin.x;
    [m_adBannerView setFrame:bannerframe];
    [m_adBannerView setHidden:false];
}

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error{
    CGRect frame = m_tableView.frame;
    frame.size.height = self.view.frame.size.height;
    [m_tableView setFrame:frame];
    [m_tableView setFrame:frame];
    [m_adBannerView setHidden:true];
}
@end

