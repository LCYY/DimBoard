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
    
    [InterLabel setText:@"請輸入"];
    [InterLabel setFont:[UIFont boldSystemFontOfSize:15]];
    
    self.title = KEY_MORTGAGE_CAL;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    UIBarButtonItem *detailButton = [[UIBarButtonItem alloc] initWithTitle:@"支出一覽" style:UIBarButtonItemStyleDone target:self action:@selector(onShowMortgageDetails:)];

    self.navigationItem.rightBarButtonItem = detailButton;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onViewRotation:) name:NOTI_SCREENROTATION object:nil];
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
        frame = InterLabel.frame;
        frame.origin.x = 10;
        frame.origin.y = 174;
        [InterLabel setFrame:frame];
        
        frame = InterLabelBG.frame;
        frame.origin.x = 0;
        frame.origin.y = 174;
        [InterLabelBG setFrame:frame];
    }
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
