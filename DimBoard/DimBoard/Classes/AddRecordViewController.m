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
@synthesize m_bankViewController, m_dataPickerViewController;
@synthesize m_adBannerView,m_tableView;

-(id)init{
    self = [super init];
    if (self) {
        // Custom initialization
        m_record = [[MortgageRecord alloc] init];
        
        m_section0 = DimBoardLocalizedString(KEY_MORTGAGE_NAME); //input cell
        m_section1 = DimBoardLocalizedString(KEY_MORTGAGE_BANKID); //input cell
        NSArray *value1 = [[NSArray alloc] initWithObjects:DimBoardLocalizedString(KEY_MORTGAGE_HOMEVALUE),@" $",nil];
        NSArray *value2 = [[NSArray alloc] initWithObjects:DimBoardLocalizedString(KEY_MORTGAGE_LOANPERCENT),@"%",nil];
        NSArray *value3 = [[NSArray alloc] initWithObjects:DimBoardLocalizedString(KEY_MORTGAGE_LOANYEAR),DimBoardLocalizedString(@"Year"),nil];
        NSArray *value4 = [[NSArray alloc] initWithObjects:DimBoardLocalizedString(KEY_MORTGAGE_INTERESTRATE),@"%",nil];
        m_section2 = [[NSArray alloc] initWithObjects:value1,value2,value3,value4,nil];
        
        m_section3 = DimBoardLocalizedString(KEY_MORTGAGE_LOANDATE); //input cell
        
        m_bankViewController = [[BankPickerViewController alloc] initWithBankId:m_record->bankId];
        [m_bankViewController setM_delegate:self];
        m_dataPickerViewController = [[DatePickerViewController alloc] initWithDate:m_record.input.date];
        [m_dataPickerViewController setM_delegate:self];
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

- (id)initWithMortgageRecord:(MortgageRecord*)record Mode:(NSInteger)mode{
    self = [self init];
    if (self) {
        // Custom initialization
        m_record = [record copy];
        m_mode = mode;
        [m_bankViewController setBankId:m_record->bankId];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [m_adBannerView setHidden:true];
    
    [m_tableView setDelegate:self];
    [m_tableView setDataSource:self];
    [m_adBannerView setDelegate:self];
    
    [self rotateToOrientation:self.interfaceOrientation];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onViewRotation:) name:NOTI_SCREENROTATION object:nil];
    
    UITapGestureRecognizer* tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)];
    tapRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapRecognizer];
    
    UIBarButtonItem *saveButton = nil;
    if(m_mode == ADDMODE){
        self.title = DimBoardLocalizedString(@"NewMortgagePlan");
        saveButton = [[UIBarButtonItem alloc] initWithTitle:DimBoardLocalizedString(@"Save") style:UIBarButtonItemStyleDone target:self action:@selector(onSaveNewRecord:)];
    }else{
        self.title = m_record.name;
        saveButton = [[UIBarButtonItem alloc] initWithTitle:DimBoardLocalizedString(@"Save") style:UIBarButtonItemStyleDone target:self action:@selector(onSaveRecord:)];
    }
    self.navigationItem.rightBarButtonItem = saveButton;
}

- (void)viewDidUnload
{
    [self setM_tableView:nil];
    [self setM_adBannerView:nil];
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

- (void)hideKeyboard:(id)sender{
    [self.view endEditing:YES];
}

- (void)onSaveNewRecord:(id)sender{
    [m_delegate addNewRecord:m_record];
    [self.navigationController popViewControllerAnimated: YES];
}

- (void)onSaveRecord:(id)sender{
    [m_delegate updateRecord:m_record];
    [self.navigationController popViewControllerAnimated: YES];
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

#pragma mark-
#pragma mark UITableViewDelegate

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = [indexPath section];
    if(section == 1){
        [self.navigationController.view addSubview:m_bankViewController.view];
        [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }else if(section == 3){
        [self.navigationController.view addSubview:m_dataPickerViewController.view];
        m_tableView.contentInset = UIEdgeInsetsMake(0, 0, m_tableView.frame.size.height - 170, 0);
        [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return TABLE_CELL_HEIGHT;
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
                value = [NSString stringWithFormat:@"%0.0f",m_record.input->homeValue];
            }else if(row == 1){
                value = [NSString stringWithFormat:@"%0.0f",m_record.input->loanPercent];
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
                value = [NSString stringWithFormat:@"%0.0f",m_record.input->homeValue];
            }else if(row == 1){
                value = [NSString stringWithFormat:@"%0.0f",m_record.input->loanPercent];
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
        return DimBoardLocalizedString(@"Name");
    }else if (section == 1){
        return DimBoardLocalizedString(@"Bank");
    }else if (section == 2){
        return DimBoardLocalizedString(@"MortInfo");
    }else if (section == 3){
        return DimBoardLocalizedString(@"StartDate");
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
    return TABLE_SECTION_HEADER_HEIGHT;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

#pragma mark - UpdateRecordItemProtocol
-(void)updateRecordKey:(NSString *)key withValue:(id)value{
    [m_tableView setContentOffset:CGPointMake(0, 0)];
    if([key isEqualToString:DimBoardLocalizedString(KEY_MORTGAGE_BANKID)]){
        m_record->bankId = [((NSNumber*)value) integerValue];
        [m_tableView reloadData];
    }else if([key isEqualToString:DimBoardLocalizedString(KEY_MORTGAGE_LOANDATE)]){
        m_record.input.date = (NSDate*)[value copy];
        m_tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        [m_tableView reloadData];
    }else if([key isEqualToString:DimBoardLocalizedString(KEY_MORTGAGE_HOMEVALUE)]){
        m_record.input->homeValue = [((NSString*)value) doubleValue];
    }else if([key isEqualToString:DimBoardLocalizedString(KEY_MORTGAGE_LOANPERCENT)]){
        m_record.input->loanPercent = [((NSString*)value) doubleValue];
    }else if([key isEqualToString:DimBoardLocalizedString(KEY_MORTGAGE_INTERESTRATE)]){
        m_record.input->interestRate = [((NSString*)value) doubleValue];
    }else if([key isEqualToString:DimBoardLocalizedString(KEY_MORTGAGE_LOANYEAR)]){
        m_record.input->loanYear = [((NSNumber*)value) integerValue];
    }else if([key isEqualToString:DimBoardLocalizedString(KEY_MORTGAGE_NAME)]){
        m_record.name = (NSString*)[value copy];
        self.title = m_record.name;
    }
}

-(void)startEditRecordKey:(NSString *)key{
    if([key isEqualToString:DimBoardLocalizedString(KEY_MORTGAGE_HOMEVALUE)]){
        [m_tableView setContentOffset:CGPointMake(0, TABLE_SECTION_HEADER_HEIGHT*2 + TABLE_CELL_HEIGHT*2)];
    }else if([key isEqualToString:DimBoardLocalizedString(KEY_MORTGAGE_LOANPERCENT)]){
        [m_tableView setContentOffset:CGPointMake(0, TABLE_SECTION_HEADER_HEIGHT*2 + TABLE_CELL_HEIGHT*3)];
    }else if([key isEqualToString:DimBoardLocalizedString(KEY_MORTGAGE_INTERESTRATE)]){
        [m_tableView setContentOffset:CGPointMake(0, TABLE_SECTION_HEADER_HEIGHT*2 + TABLE_CELL_HEIGHT*5)];
    }else if([key isEqualToString:DimBoardLocalizedString(KEY_MORTGAGE_LOANYEAR)]){
        [m_tableView setContentOffset:CGPointMake(0, TABLE_SECTION_HEADER_HEIGHT*2 + TABLE_CELL_HEIGHT*4)];
    }
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
    [m_adBannerView setHidden:true];
}

@end
