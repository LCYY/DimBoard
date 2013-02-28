//
//  AddRecordViewController.m
//  DimBoard
//
//  Created by conicacui on 7/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import "AddRecordViewController.h"

@interface AddRecordViewController ()

@end

@implementation AddRecordViewController
@synthesize m_section0,m_section1,m_section2,m_section3,m_record;
@synthesize m_delegate;

-(id)init{
    self = [super init];
    if (self) {
        // Custom initialization
        m_record = [[MortgageRecord alloc] init];
        
        m_section0 = KEY_MORTGAGE_NAME; //input cell
        m_section1 = KEY_MORTGAGE_BANKID; //input cell
        NSArray *value1 = [[NSArray alloc] initWithObjects:KEY_MORTGAGE_HOMEVALUE,@"萬元",nil];
        NSArray *value2 = [[NSArray alloc] initWithObjects:KEY_MORTGAGE_LOANPERCENT,@"%",nil];
        NSArray *value3 = [[NSArray alloc] initWithObjects:KEY_MORTGAGE_LOANYEAR,@"年",nil];
        NSArray *value4 = [[NSArray alloc] initWithObjects:KEY_MORTGAGE_INTERESTRATE,@"%",nil];
        m_section2 = [[NSArray alloc] initWithObjects:value1,value2,value3,value4,nil];
        
        m_section3 = KEY_MORTGAGE_LOANDATE; //input cell
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
        // Custom initialization
        m_record = [record copy];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UITapGestureRecognizer* tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)];
    tapRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapRecognizer];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [self setM_delegate:nil];
    [self setM_record:nil];
    [self setM_section0:nil];
    [self setM_section1:nil];
    [self setM_section2:nil];
    [self setM_section3:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)hideKeyboard:(id)sender{
    [self.view endEditing:YES];
}

-(void)onCancel:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)onSaveNewRecord:(id)sender{
    [m_delegate addNewRecord:m_record];
    [self dismissModalViewControllerAnimated:YES];
}

- (void)onSaveRecord:(id)sender{
    [m_delegate updateRecord:m_record];
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark-
#pragma mark UITableViewDelegate

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = [indexPath section];
    if(section == 1){
        BankPickerViewController* rootController = [[BankPickerViewController alloc] initWithBankId:m_record->bankId];
        [rootController setM_delegate:self];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:rootController];
        
        navController.navigationBar.topItem.title = m_section1;
        navController.navigationBar.barStyle = UIBarStyleBlackOpaque;
        UIBarButtonItem *cacelButton = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonSystemItemDone target:self action:@selector(onCancel:)];
        navController.navigationBar.topItem.leftBarButtonItem = cacelButton;
        UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonSystemItemDone target:rootController action:@selector(onSave:)];
        navController.navigationBar.topItem.rightBarButtonItem = saveButton;
        
        [navController setWantsFullScreenLayout:YES];
        [navController.view setAutoresizesSubviews:NO];
        navController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        navController.visibleViewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.modalPresentationStyle = UIModalPresentationCurrentContext;
        
        [self presentModalViewController:navController animated:YES];
    }else if(section == 3){
        DatePickerViewController* rootController = [[DatePickerViewController alloc] initWithDate:m_record.input.date];
        [rootController setM_delegate:self];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:rootController];
        
        navController.navigationBar.topItem.title = m_section3;
        navController.navigationBar.barStyle = UIBarStyleBlackOpaque;
        UIBarButtonItem *cacelButton = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonSystemItemDone target:self action:@selector(onCancel:)];
        navController.navigationBar.topItem.leftBarButtonItem = cacelButton;
        UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonSystemItemDone target:rootController action:@selector(onSave:)];
        navController.navigationBar.topItem.rightBarButtonItem = saveButton;
        
        [navController setWantsFullScreenLayout:YES];
        [navController.view setAutoresizesSubviews:NO];
        navController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        navController.visibleViewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.modalPresentationStyle = UIModalPresentationCurrentContext;
        
        [self presentModalViewController:navController animated:YES];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 2)
        return 65;
    else
        return 45;
}

#pragma mark UITableViewDataSource

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *AddNormalRecordCell = @"AddNormalRecordCell";
    static NSString *AddInputRecordCell = @"AddInputRecordCell";
    static NSString *AddSliderRecordCell = @"AddSliderRecordCell";
    
    NSInteger row = [indexPath row];
    NSInteger section = [indexPath section];
    UITableViewCell *cell = nil;
    
    if(section == 0){ // input cell
        cell = [tableView dequeueReusableCellWithIdentifier:AddInputRecordCell];
    }else if(section == 1 || section == 3){ // normal cell
        cell = [tableView dequeueReusableCellWithIdentifier:AddNormalRecordCell];
    }else if(section == 2){ //slider cell
        cell = [tableView dequeueReusableCellWithIdentifier:AddSliderRecordCell];
    }
    
    if(cell == nil){
        if(section == 0){ // input cell
            cell = [[InputCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:AddInputRecordCell Name:m_section0 Value:m_record.name];
            [((InputCell*)cell) setCellControllerDelegate:self];
        }else if(section == 1){ // normal cell
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:AddNormalRecordCell];
            cell.textLabel.text = m_section1;
            cell.detailTextLabel.text = [[[BankTypes alloc] init] getBankNameById:m_record->bankId];
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        }
        else if(section == 2){ // slider cell
            NSString *name = [[m_section2 objectAtIndex:row] objectAtIndex:0];
            NSString *unit = [[m_section2 objectAtIndex:row] objectAtIndex:1];
            NSString *value = nil;
            if(row == 0){
                value = [NSString stringWithFormat:@"%0.4f",m_record.input->homeValue];
            }else if(row == 1){
                value = [NSString stringWithFormat:@"%0.2f",m_record.input->loanPercent];
            }else if(row == 2){
                value = [NSString stringWithFormat:@"%d",m_record.input->loanYear];
            }else if(row == 3){
                value = [NSString stringWithFormat:@"%0.2f",m_record.input->interestRate];
            }
            cell = [[SliderCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:AddSliderRecordCell Name:name Value:value Unit:unit];
            [((SliderCell*)cell) setCellControllerDelegate:self];
        }else if(section == 3){ // normal cell
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:AddNormalRecordCell];
            cell.textLabel.text = m_section3;
            NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:DATEFORMAT];
            cell.detailTextLabel.text = [formatter stringFromDate:m_record.input.date];
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        }
    }else{
        if(section == 0){ // input cell
            [((InputCell *)cell) setName:m_section0 Value:m_record.name];
            [((InputCell*)cell) setCellControllerDelegate:self];
        }else if(section == 1){ //normal cell
            cell.textLabel.text = m_section1;
            cell.detailTextLabel.text = [[[BankTypes alloc] init] getBankNameById:m_record->bankId];
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        }
        else if(section == 2){ // slider cell
            NSString *name = [[m_section2 objectAtIndex:row] objectAtIndex:0];
            NSString *unit = [[m_section2 objectAtIndex:row] objectAtIndex:1];
            NSString *value = nil;
            if(row == 0){
                value = [NSString stringWithFormat:@"%0.4f",m_record.input->homeValue];
            }else if(row == 1){
                value = [NSString stringWithFormat:@"%0.2f",m_record.input->loanPercent];
            }else if(row == 2){
                value = [NSString stringWithFormat:@"%d",m_record.input->loanYear];
            }else if(row == 3){
                value = [NSString stringWithFormat:@"%0.2f",m_record.input->interestRate];
            }
            [((SliderCell *)cell) setName:name Value:value Unit:unit];
            [((SliderCell *)cell) setCellControllerDelegate:self];
        }else if(section == 3){ //normal cell
            cell.textLabel.text = m_section3;
            NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:DATEFORMAT];
            cell.detailTextLabel.text = [formatter stringFromDate:m_record.input.date];

            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        }
    }
    [cell setEditing:YES animated:NO];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return 1;
    }else if(section == 1){
        return 1;
    }else if(section == 2){
        return [m_section2 count];
    }else if(section == 3){
        return 1;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return ADDRECORDSECTIONCOUNT;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return @"命名";
    }else if (section == 1){
        return @"按揭銀行";
    }else if (section == 2){
        return @"按揭資料";
    }else if (section == 3){
        return @"按揭日期";
    }
    return @"";
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
    if([key isEqualToString:KEY_MORTGAGE_BANKID]){
        m_record->bankId = [((NSNumber*)value) integerValue];
        [((UITableView*)self.view) reloadData];
    }else if([key isEqualToString:KEY_MORTGAGE_LOANDATE]){
        m_record.input.date = (NSDate*)[value copy];
        [((UITableView*)self.view) reloadData];
    }else if([key isEqualToString:KEY_MORTGAGE_HOMEVALUE]){
        m_record.input->homeValue = [((NSString*)value) doubleValue];
    }else if([key isEqualToString:KEY_MORTGAGE_LOANPERCENT]){
        m_record.input->loanPercent = [((NSString*)value) doubleValue];
    }else if([key isEqualToString:KEY_MORTGAGE_INTERESTRATE]){
        m_record.input->interestRate = [((NSString*)value) doubleValue];
    }else if([key isEqualToString:KEY_MORTGAGE_LOANYEAR]){
        m_record.input->loanYear = [((NSNumber*)value) integerValue];
    }else if([key isEqualToString:KEY_MORTGAGE_NAME]){
        m_record.name = (NSString*)[value copy];
        self.title = m_record.name;
    }
}

@end
