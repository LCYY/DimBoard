//
//  MortgageRecordViewController.m
//  DimBoard
//
//  Created by conicacui on 7/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import "MortgageRecordViewController.h"

@interface MortgageRecordViewController ()

@end

@implementation MortgageRecordViewController

@synthesize m_controllerList;
@synthesize m_recordIO;

-(void)testRecordIO{
    MortgageRecordIO* recordIO = [[MortgageRecordIO alloc] initWithLoadRecords];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:DATEFORMAT];
    NSDate* date = [formatter dateFromString:@"2012-02-05"];
    MortgageRecord* newRecord = [[MortgageRecord alloc] initWithName:@"name_0" BankId:2 Date:date HomeValue:1000 LoanYear:20 LoanPercent:30 LoanRate:2.05];
    
    [recordIO addRecord:newRecord];
    
    newRecord.name = @"name_1";
    [recordIO addRecord:newRecord];
    
    newRecord.name = @"name_2";
    [recordIO addRecord:newRecord];
    
    newRecord.name = @"name_3";
    [recordIO addRecord:newRecord];
    
//    [recordIO save];
//    newRecord->recordId = 0;
//    newRecord->name = @"testupdatename";
//    newRecord->input->homeValue = 20000;
//    [recordIO updateRecord:newRecord];
//    
//    NSArray* records = [recordIO getRecords];
//    if(records){
//        for(NSInteger i = 0; i< [records count]; i++){
//            if(i == 1){
//                MortgageRecord* record = [records objectAtIndex:i];
//                [recordIO deleteRecordbyId:record->recordId];
//            }
//        }
//    }
    
    [recordIO save];
}

- (id)init{
    self = [super init];
    if (self) {
        // Custom initialization
        m_controllerList = [[NSMutableArray alloc] init];       
        m_recordIO = [[MortgageRecordIO alloc] initWithLoadRecords];
        
        //get records from stored plist
        NSArray* records = [m_recordIO getRecords];
        
        for(NSInteger i = 0; i< [records count]; i++){
            MortgageRecord* record = [records objectAtIndex:i];
            RecordDetailViewController* controller = [[RecordDetailViewController alloc] initWithMortgageRecord:record];
            [controller setM_delegate:self];
            [self.m_controllerList addObject:controller];
        }
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

    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onAddNewMortgageRecord:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    [self rotateToOrientation:self.interfaceOrientation];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onViewRotation:) name:NOTI_SCREENROTATION object:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = KEY_MY_MORTGAGE;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [self setM_controllerList:nil];
    [self setM_recordIO:nil];
    self.view.backgroundColor = [UIColor colorWithRed:39/255.0 green:64/255.0 blue:139/255.0 alpha:0.8];
}

- (void)onAddNewMortgageRecord:(id)sender{   
    AddRecordViewController* rootController = [[AddRecordViewController alloc] init];
    [rootController setM_delegate:self];
    
    [self setHidesBottomBarWhenPushed:YES];
    self.navigationItem.title = self.title;
    [self.navigationController pushViewController:rootController animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}

-(void)onViewRotation:(NSNotification*) noti{
    NSString* orientation = noti.object;
    [self rotateToOrientation:[orientation integerValue]];
}

-(void)rotateToOrientation:(UIInterfaceOrientation) orientation{
}

#pragma mark - UITableViewDelegate

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger row = [indexPath row];
    UITableViewController *rootController = [m_controllerList objectAtIndex:row];
    
    [self setHidesBottomBarWhenPushed:YES];
    self.navigationItem.title = self.title;
    [self.navigationController pushViewController:rootController animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}

#pragma mark UITableViewDataSource

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *MortgageRecordCell = @"MortgageRecordCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MortgageRecordCell];
    if(cell == nil){
        cell = [[RecordCell alloc] init];
    }
    NSUInteger row = [indexPath row];
    RecordDetailViewController *controller = [m_controllerList objectAtIndex:row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [((RecordCell*)cell) setName:[controller getName] Term:[controller getTermDsp] MonthlyPay:[controller getMonthlyPay] Progress:[controller getPayProgress]];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return m_controllerList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        NSInteger rid = [[m_controllerList objectAtIndex:indexPath.row] getRecordId];
        [m_recordIO deleteRecordbyId:rid];
        [m_recordIO save];
        [m_controllerList removeObjectAtIndex:indexPath.row];
        [((UITableView*)self.view) reloadData];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 95;
}

#pragma mark - UpdateRecordProtocol
-(void)updateRecord:(MortgageRecord *)record{
    [m_recordIO updateRecord:record];
    [((UITableView*)self.view) reloadData];
}

-(void)addNewRecord:(MortgageRecord *)record{
    [m_recordIO addRecord:record];
    [m_recordIO save];
    RecordDetailViewController* controller = [[RecordDetailViewController alloc] initWithMortgageRecord:record];
    [controller setM_delegate:self];
    [self.m_controllerList addObject:controller];
    [((UITableView*)self.view) reloadData];
}

@end
