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
@synthesize InputTableView, ResultTableView;
@synthesize m_input,m_output,m_calculator,m_inputRows,m_outputRows;
@synthesize m_recordViewController;

-(id)init{
    self = [super init];
    if(self){
        m_input = [[MortgageInput alloc] initWithHomeValue:100.0 LoanYear:30 LoanPercent:30.0 LoanRate:2.0 LoanDate:nil];
        m_output = [[MortgageOutput alloc] init];
        m_calculator = [[Calculator alloc] init];
        
        NSArray *value01 = [[NSArray alloc] initWithObjects:KEY_MORTGAGE_HOMEVALUE,@"萬元",nil];
        NSArray *value02 = [[NSArray alloc] initWithObjects:KEY_MORTGAGE_LOANPERCENT,@"%",nil];
        NSArray *value03 = [[NSArray alloc] initWithObjects:KEY_MORTGAGE_LOANYEAR,@"年",nil];
        NSArray *value04 = [[NSArray alloc] initWithObjects:KEY_MORTGAGE_INTERESTRATE,@"%",nil];
        m_inputRows = [[NSArray alloc] initWithObjects:value01,value02,value03,value04,nil];
        
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
    [InputTableView setDataSource:self];
    [InputTableView setDelegate:self];
    [ResultTableView setDataSource:self];
    [ResultTableView setDelegate:self];
    
    self.title = KEY_MORTGAGE_CAL;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    UIBarButtonItem *detailButton = [[UIBarButtonItem alloc] initWithTitle:@"支出一覽" style:UIBarButtonSystemItemDone target:self action:@selector(onShowMortgageDetails:)];

    self.navigationItem.rightBarButtonItem = detailButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setInputTableView:nil];
    [self setResultTableView:nil];
    [super viewDidUnload];
}

-(void)setRecordViewController:(id)controller{
    m_recordViewController = controller;
}

- (void) updateResult{
    [m_calculator setInput:m_input];
    m_output = [[m_calculator getOutput] copy];
    
    NSArray *value11 = [[NSArray alloc] initWithObjects:KEY_MORTGAGE_LOANAMOUNT,[NSString stringWithFormat:@"%0.4f 萬元",m_output->loanAmount],nil];
    NSArray *value12 = [[NSArray alloc] initWithObjects:KEY_MORTGAGE_LOANTERM,[NSString stringWithFormat:@"%d 期",m_output->loanTerms],nil];
    NSArray *value13 = [[NSArray alloc] initWithObjects:KEY_MORTGAGE_MONTHLYPAYMENT,[NSString stringWithFormat:@"%0.2f 元",m_output->monthlyPay],nil];
    NSArray *value14 = [[NSArray alloc] initWithObjects:KEY_MORTGAGE_REPAYMENT,[NSString stringWithFormat:@"%0.4f 萬元",m_output->rePayment],nil];
    m_outputRows = [[NSArray alloc] initWithObjects:value11,value12,value13,value14,nil];
}

- (void)hideKeyboard:(id)sender{
    [self.view endEditing:YES];
}

-(void)onShowMortgageDetails:(id)sender{
    MortgageDetailViewController* rootController = [[MortgageDetailViewController alloc] initWithMortgageRecord:[[MortgageRecord alloc] initWithMortgageInput:m_input]];
    [rootController setRecordViewController:m_recordViewController];
    self.navigationItem.title = self.title;
    [self.navigationController pushViewController:rootController animated:YES];
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
            value = [NSString stringWithFormat:@"%0.4f",m_input->homeValue];
        }else if(row == 1){
            value = [NSString stringWithFormat:@"%0.2f",m_input->loanPercent];
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

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (tableView == InputTableView){
        return @"請輸入";
    }
    return @"";
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == InputTableView){
        UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 22)];
        view.backgroundColor = [UIColor colorWithRed:39/255.0 green:64/255.0 blue:139/255.0 alpha:1];
        
        UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 320, 22)];
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = [UIColor whiteColor];
        label.text = [self tableView:tableView titleForHeaderInSection:section];
        label.font = [UIFont boldSystemFontOfSize:16];
        label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
        [view addSubview:label];
        return view;
    }
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (tableView == InputTableView){
        UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
        view.backgroundColor = [UIColor colorWithRed:39/255.0 green:64/255.0 blue:139/255.0 alpha:1];
        return view;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == InputTableView){
        return 22;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(scrollView.contentOffset.y < 0){
        [scrollView setContentOffset:CGPointMake(0, 0)];
    }
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
    //[InputTableView reloadData];
    [ResultTableView reloadData];
}
@end
