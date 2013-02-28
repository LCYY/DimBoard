//
//  MortgageQuickCalViewController.m
//  DimBoard
//
//  Created by conicacui on 28/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import "MortgageQuickCalViewController.h"

@interface MortgageQuickCalViewController ()

@end

@implementation MortgageQuickCalViewController
@synthesize TableView;
@synthesize m_section0,m_section1;
@synthesize m_input,m_output,m_calculator;
@synthesize m_recordViewController;
@synthesize ShowDetailsButton,ShowMonthlyPayButton,ShowMyRecordButton;

-(id)init{
    self = [super init];
    if(self){
        m_input = [[MortgageInput alloc] initWithHomeValue:100.0 LoanYear:30 LoanPercent:30.0 LoanRate:2.0 LoanDate:nil];
        m_output = [[MortgageOutput alloc] init];
        m_calculator = [[Calculator alloc] init];
               
        m_recordViewController = [[MortgageRecordViewController alloc] init];
        
        NSArray *value01 = [[NSArray alloc] initWithObjects:KEY_MORTGAGE_HOMEVALUE,@"萬元",nil];
        NSArray *value02 = [[NSArray alloc] initWithObjects:KEY_MORTGAGE_LOANPERCENT,@"%",nil];
        NSArray *value03 = [[NSArray alloc] initWithObjects:KEY_MORTGAGE_LOANYEAR,@"年",nil];
        NSArray *value04 = [[NSArray alloc] initWithObjects:KEY_MORTGAGE_INTERESTRATE,@"%",nil];
        m_section0 = [[NSArray alloc] initWithObjects:value01,value02,value03,value04,nil];

        [self updateResult];
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
    [TableView setDataSource:self];
    [TableView setDelegate:self];
    
    [ShowMyRecordButton setBackgroundColor:[UIColor colorWithRed:39/255.0 green:64/255.0 blue:139/255.0 alpha:1]];
    [ShowDetailsButton setBackgroundColor:[UIColor colorWithRed:39/255.0 green:64/255.0 blue:139/255.0 alpha:1]];
    [ShowMonthlyPayButton setBackgroundColor:[UIColor colorWithRed:39/255.0 green:64/255.0 blue:139/255.0 alpha:1]];
    
    [ShowMonthlyPayButton setFont:[UIFont boldSystemFontOfSize:17]];
    [ShowDetailsButton setFont:[UIFont boldSystemFontOfSize:17]];
    [ShowMonthlyPayButton setFont:[UIFont boldSystemFontOfSize:17]];
    
    UITapGestureRecognizer* tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)];
    tapRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapRecognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTableView:nil];
    [self setM_calculator:nil];
    [self setM_input:nil];
    [self setM_output:nil];
    [self setM_recordViewController:nil];
    [self setM_section0:nil];
    [self setM_section1:nil];
    [self setShowMyRecordButton:nil];
    [self setShowDetailsButton:nil];
    [self setShowMonthlyPayButton:nil];
    [super viewDidUnload];
}

- (void) updateResult{
    [m_calculator setInput:m_input];
    m_output = [[m_calculator getOutput] copy];
    
    NSArray *value11 = [[NSArray alloc] initWithObjects:KEY_MORTGAGE_LOANAMOUNT,[NSString stringWithFormat:@"%0.4f 萬元",m_output->loanAmount],nil];
    NSArray *value12 = [[NSArray alloc] initWithObjects:KEY_MORTGAGE_LOANTERM,[NSString stringWithFormat:@"%d 期",m_output->loanTerms],nil];
    NSArray *value13 = [[NSArray alloc] initWithObjects:KEY_MORTGAGE_MONTHLYPAYMENT,[NSString stringWithFormat:@"%0.2f 元",m_output->monthlyPay],nil];
    NSArray *value14 = [[NSArray alloc] initWithObjects:KEY_MORTGAGE_REPAYMENT,[NSString stringWithFormat:@"%0.4f 萬元",m_output->rePayment],nil];
    m_section1 = [[NSArray alloc] initWithObjects:value11,value12,value13,value14,nil];
}

- (void)hideKeyboard:(id)sender{
    [self.view endEditing:YES];
}

- (void)onBack:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark-
#pragma mark UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0)
        return 65;
    else
        return 35;
}

#pragma mark UITableViewDataSource

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *AddNormalRecordCell = @"AddNormalRecordCell";
    static NSString *AddSliderRecordCell = @"AddSliderRecordCell";
    
    NSInteger row = [indexPath row];
    NSInteger section = [indexPath section];
    UITableViewCell *cell = nil;
    
    if(section == 0){ // slider cell
        cell = [tableView dequeueReusableCellWithIdentifier:AddSliderRecordCell];
    }else{ // normal cell
        cell = [tableView dequeueReusableCellWithIdentifier:AddNormalRecordCell];
    }
    
    if(cell == nil){
        if(section == 0){ // slider cell
            NSString *name = [[m_section0 objectAtIndex:row] objectAtIndex:0];
            NSString *unit = [[m_section0 objectAtIndex:row] objectAtIndex:1];
            NSString *value = nil;
            if(row == 0){
                value = [NSString stringWithFormat:@"%0.4f",m_input->homeValue];
            }else if(row == 1){
                value = [NSString stringWithFormat:@"%0.2f",m_input->loanPercent];
            }else if(row == 2){
                value = [NSString stringWithFormat:@"%d",m_input->loanYear];
            }else if(row == 3){
                value = [NSString stringWithFormat:@"%0.2f",m_input->interestRate];
            }
            cell = [[SliderCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:AddSliderRecordCell Name:name Value:value Unit:unit];
            [((SliderCell*)cell) setCellControllerDelegate:self];
        }else if(section == 1){ // normal cell
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:AddNormalRecordCell];
            cell.textLabel.text = [[m_section1 objectAtIndex:row] objectAtIndex:0];
            cell.detailTextLabel.text = [[m_section1 objectAtIndex:row] objectAtIndex:1];
            [cell setAccessoryType:UITableViewCellAccessoryNone];
        }
    }else{
        if(section == 0){ // slider cell
            NSString *name = [[m_section0 objectAtIndex:row] objectAtIndex:0];
            NSString *unit = [[m_section0 objectAtIndex:row] objectAtIndex:1];
            NSString *value = nil;
            if(row == 0){
                value = [NSString stringWithFormat:@"%0.4f",m_input->homeValue];
            }else if(row == 1){
                value = [NSString stringWithFormat:@"%0.2f",m_input->loanPercent];
            }else if(row == 2){
                value = [NSString stringWithFormat:@"%d",m_input->loanYear];
            }else if(row == 3){
                value = [NSString stringWithFormat:@"%0.2f",m_input->interestRate];
            }
            [((SliderCell *)cell) setName:name Value:value Unit:unit];
            [((SliderCell *)cell) setCellControllerDelegate:self];
        }else if(section == 1){ //normal cell
            cell.textLabel.text = [[m_section1 objectAtIndex:row] objectAtIndex:0];
            cell.detailTextLabel.text = [[m_section1 objectAtIndex:row] objectAtIndex:1];
            [cell setAccessoryType:UITableViewCellAccessoryNone];
        }
    }
    [cell setEditing:YES animated:NO];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return [m_section0 count];
    }else if(section == 1){
        return [m_section1 count];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0){
        return @"按揭資料";
    }else if (section == 1){
        return @"計算結果";
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

#pragma mark - UpdateRecordItemProtocol
-(void)updateRecordKey:(NSString *)key withValue:(id)value{
    if([key isEqualToString:KEY_MORTGAGE_HOMEVALUE]){
        m_input->homeValue = [((NSString*)value) doubleValue];
    }else if([key isEqualToString:KEY_MORTGAGE_LOANPERCENT]){
        m_input->loanPercent = [((NSString*)value) doubleValue];
    }else if([key isEqualToString:KEY_MORTGAGE_INTERESTRATE]){
        m_input->interestRate = [((NSString*)value) doubleValue];
    }else if([key isEqualToString:KEY_MORTGAGE_LOANYEAR]){
        m_input->loanYear = [((NSNumber*)value) integerValue];
    }
    [self updateResult];
    [TableView reloadData];
}
- (IBAction)onShowMyRecord:(id)sender {
    MortgageRecordViewController *rootController = m_recordViewController;
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
    MortgageDetailViewController* rootController = [[MortgageDetailViewController alloc] initWithMortgageRecord:[[MortgageRecord alloc] initWithMortgageInput:m_input]];
    [rootController setRecordViewController:m_recordViewController];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:rootController];
    
    navController.navigationBar.topItem.title = ((UIButton*)sender).titleLabel.text;
    navController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonSystemItemDone target:self action:@selector(onBack:)];
    navController.navigationBar.topItem.leftBarButtonItem = doneButton;
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:rootController action:@selector(onAddMortgageToRecord:)];
    navController.navigationBar.topItem.rightBarButtonItem = addButton;
    [navController setWantsFullScreenLayout:YES];
    [navController.view setAutoresizesSubviews:NO];
    navController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    navController.visibleViewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    
    [self presentModalViewController:navController animated:YES];
}

- (IBAction)onShowMonthlyPay:(id)sender {
    MortgageMonthlyPayViewController* rootController = [[MortgageMonthlyPayViewController alloc] init];
    [rootController setPricipals:m_output.principals LeftAmount:m_output.leftLoanAmounts MonthlyPay:m_output->monthlyPay];
    
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
@end
