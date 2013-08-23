//
//  MortgageCalViewController.m
//  DimBoard
//
//  Created by conicacui on 1/3/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import "MortgageCalViewController.h"

@interface MortgageCalViewController ()

@end

@implementation MortgageCalViewController
@synthesize InputTableView, ResultTableView, InterLabel, InterLabelBG;
@synthesize m_input,m_output,m_calculator,m_inputRows,m_outputRows;
@synthesize m_recordViewController;

-(id)init{
    self = [super init];
    if(self){
        m_input = [[MortgageInput alloc] initWithHomeValue:1000000 LoanYear:30 LoanPercent:30.0 LoanRate:2.0 LoanDate:nil];
        m_output = [[MortgageOutput alloc] init];
        m_calculator = [[Calculator alloc] init];
        m_inputRows = [[NSMutableArray alloc] init];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [InputTableView setDataSource:self];
    [InputTableView setDelegate:self];
    [ResultTableView setDataSource:self];
    [ResultTableView setDelegate:self];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    UIBarButtonItem *detailButton = [[UIBarButtonItem alloc] initWithTitle:DimBoardLocalizedString(@"TotalExpensesInfo") style:UIBarButtonItemStyleBordered target:self action:@selector(onShowMortgageDetails:)];
    self.navigationItem.rightBarButtonItem = detailButton;
    
    UITapGestureRecognizer* tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)];
    tapRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapRecognizer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onViewRotation:) name:NOTI_SCREENROTATION object:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [m_inputRows removeAllObjects];
    NSArray *value01 = [[NSArray alloc] initWithObjects:DimBoardLocalizedString(@"HomeValue"),@" ＄",nil];
    NSArray *value02 = [[NSArray alloc] initWithObjects:DimBoardLocalizedString(@"LoanRatio"),@"%",nil];
    NSArray *value03 = [[NSArray alloc] initWithObjects:DimBoardLocalizedString(@"MortYear"),DimBoardLocalizedString(@"Year"),nil];
    NSArray *value04 = [[NSArray alloc] initWithObjects:DimBoardLocalizedString(@"InterestRate"),@"%",nil];
    [m_inputRows addObject:value01];
    [m_inputRows addObject:value02];
    [m_inputRows addObject:value03];
    [m_inputRows addObject:value04];

    [InterLabel setText:DimBoardLocalizedString(@"PleaseInput")];
    [InterLabel setFont:[UIFont boldSystemFontOfSize:15]];
    
    self.title = DimBoardLocalizedString(@"Calculator");
    self.navigationItem.rightBarButtonItem.title = DimBoardLocalizedString(@"TotalExpensesInfo");
    
    [self updateResult];
    [InputTableView reloadData];
    [ResultTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setInputTableView:nil];
    [self setResultTableView:nil];
    [self setInterLabel:nil];
    [self setInterLabelBG:nil];
    [super viewDidUnload];
}

-(void)onViewRotation:(NSNotification*)noti{
    NSString* orientation = noti.object;
   
   CGRect frame;
    if(UIInterfaceOrientationIsLandscape([orientation integerValue])){
        //NSLog(@"received notification for landscape widthchange = %d",widthchange);
        frame = InterLabel.frame;
        frame.origin.x = 10;
        frame.origin.y = 88;
        [InterLabel setFrame:frame];
        
        frame = InterLabelBG.frame;
        frame.origin.x = 0;
        frame.origin.y = 88;
        [InterLabelBG setFrame:frame];
    }else{
        CGRect screen = [[UIScreen mainScreen] bounds];

 
        frame = InterLabel.frame;
        frame.origin.x = 10;
        if(screen.size.height == 480){
            frame.origin.y = 174; 
        }else if(screen.size.height == 568){
            frame.origin.y = 214;
        }
        [InterLabel setFrame:frame];
        
        frame = InterLabelBG.frame;
        frame.origin.x = 0;
        if(screen.size.height == 480){
            frame.origin.y = 174;
        }else if(screen.size.height == 568){
            frame.origin.y = 214;
        }
        [InterLabelBG setFrame:frame];
    }
}

-(void)setRecordViewController:(id)controller{
    m_recordViewController = controller;
}

- (void) updateResult{
    [m_calculator setInput:m_input];
    m_output = [[m_calculator getOutput] copy];
    
    NSArray *value11 = [[NSArray alloc] initWithObjects:DimBoardLocalizedString(@"LoanAmount"),[NSString stringWithFormat:@"%@ ＄",[self getFormattedString:m_output->loanAmount]],nil];
    NSArray *value12 = [[NSArray alloc] initWithObjects:DimBoardLocalizedString(@"LoanTerm"),[NSString stringWithFormat:@"%d %@",m_output->loanTerms, DimBoardLocalizedString(@"Term")],nil];
    NSArray *value13 = [[NSArray alloc] initWithObjects:DimBoardLocalizedString(@"MonthlyPay"),[NSString stringWithFormat:@"%@ ＄",[self getFormattedString:m_output->monthlyPay]],nil];
    NSArray *value14 = [[NSArray alloc] initWithObjects:DimBoardLocalizedString(@"TotalRepayment"),[NSString stringWithFormat:@"%@ ＄",[self getFormattedString:m_output->rePayment]],nil];
    m_outputRows = [[NSArray alloc] initWithObjects:value11,value12,value13,value14,nil];
}

- (void)hideKeyboard:(id)sender{
    [self.view endEditing:YES];
}

-(void)onShowMortgageDetails:(id)sender{
    MortgageDetailViewController* rootController = [[MortgageDetailViewController alloc] initWithMortgageRecord:[[MortgageRecord alloc] initWithMortgageInput:m_input]];
    [rootController setRecordViewController:m_recordViewController];
    [self setHidesBottomBarWhenPushed:YES];
    self.navigationItem.title = self.title;
    [self.navigationController pushViewController:rootController animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == InputTableView){
        return 44;
    }else if(tableView == ResultTableView){
        return 44;
    }
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == InputTableView){
        return [m_inputRows count];
    }else if(tableView == ResultTableView){
        return [m_outputRows count];
    }
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(tableView == InputTableView){
        return 1;
    }else if(tableView == ResultTableView){
        return 1;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = nil;
    NSInteger row = indexPath.row;
    NSString* cellIdentifier = nil;
    if(tableView == InputTableView){
        cellIdentifier = @"SliderCellIdentifier";

        NSString *name = [[m_inputRows objectAtIndex:row] objectAtIndex:0];
        NSString *unit = [[m_inputRows objectAtIndex:row] objectAtIndex:1];
        NSString *value = nil;
        if(row == 0){
            value = [NSString stringWithFormat:@"%0.0f",m_input->homeValue];
        }else if(row == 1){
            value = [NSString stringWithFormat:@"%0.0f",m_input->loanPercent];
        }else if(row == 2){
            value = [NSString stringWithFormat:@"%d",m_input->loanYear];
        }else if(row == 3){
            value = [NSString stringWithFormat:@"%0.2f",m_input->interestRate];
        }
        
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil){
            cell = [[SliderCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier Name:name Value:value Unit:unit];
            [((SliderCell*)cell) setCellControllerDelegate:self];
        }else{
            [((SliderCell *)cell) setName:name Value:value Unit:unit];
            [((SliderCell *)cell) setCellControllerDelegate:self];
        }
    }else if(tableView == ResultTableView){
        cellIdentifier = @"NormalCellIdentifier";
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        }
        cell.textLabel.text = [[m_outputRows objectAtIndex:row] objectAtIndex:0];
        cell.detailTextLabel.text = [[m_outputRows objectAtIndex:row] objectAtIndex:1];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    return cell;
}

- (NSString*) getFormattedString:(double)indouble{
    NSString* instr = [NSString stringWithFormat:@"%0.2f",indouble];
    NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber* innum = [NSNumber numberWithDouble:[instr doubleValue]];
    return [formatter stringFromNumber:innum];
}

#pragma mark - UpdateRecordItemProtocol
-(void)updateRecordKey:(NSString *)key withValue:(id)value{
    if([key isEqualToString:DimBoardLocalizedString(KEY_MORTGAGE_HOMEVALUE)]){
        m_input->homeValue = [((NSString*)value) doubleValue];
    }else if([key isEqualToString:DimBoardLocalizedString(KEY_MORTGAGE_LOANPERCENT)]){
        m_input->loanPercent = [((NSString*)value) doubleValue];
    }else if([key isEqualToString:DimBoardLocalizedString(KEY_MORTGAGE_INTERESTRATE)]){
        m_input->interestRate = [((NSString*)value) doubleValue];
    }else if([key isEqualToString:DimBoardLocalizedString(KEY_MORTGAGE_LOANYEAR)]){
        m_input->loanYear = [((NSNumber*)value) integerValue];
    }
    [self updateResult];
    //[InputTableView reloadData];
    [ResultTableView reloadData];
}
@end
