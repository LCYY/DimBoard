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

-(void)testRecordIO{
    MortgageRecordIO* recordIO = [[MortgageRecordIO alloc] initWithLoadRecords];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate* date = [formatter dateFromString:@"2012-02-05"];
    MortgageRecord* newRecord = [[MortgageRecord alloc] initWithName:@"name_0" BankId:2 Date:date HomeValue:1000 LoanYear:20 LoanPercent:30 LoanRate:2.05];
    
    [recordIO addRecord:newRecord];
    
    newRecord->name = @"name_1";
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


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization      
        NSMutableArray * array = [[NSMutableArray alloc] init];
        self.m_controllerList = array;
        
        RecordDetailViewController *controller_1 = [[RecordDetailViewController alloc] init];
        RecordDetailViewController *controller_2 = [[RecordDetailViewController alloc] init];
        [self.m_controllerList addObject:controller_1];
        [self.m_controllerList addObject:controller_2];
        [self testRecordIO];
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style{
    //set style as UITableViewStyleGrouped
    self = [super initWithStyle:UITableViewStyleGrouped];
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
    [self setM_controllerList:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)onAddNewMortgageRecord:(id)sender{   
    AddRecordViewController* rootController = [[AddRecordViewController alloc] init];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:rootController];
    
    navController.navigationBar.topItem.title = @"新增供款";
    navController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"存儲" style:UIBarButtonSystemItemDone target:self action:@selector(onSaveNewReocrd:)];
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

- (void)onSaveNewReocrd:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark-
#pragma mark UITableViewDelegate

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger row = [indexPath row];
    UITableViewController *rootController = [m_controllerList objectAtIndex:row];

    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:rootController];
    
    navController.navigationBar.topItem.title = rootController.title;
    navController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:self.navigationController.navigationBar.topItem.title style:UIBarButtonSystemItemDone target:self action:@selector(onBack:)];
    navController.navigationBar.topItem.leftBarButtonItem = backButton;
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithTitle:@"編輯" style:UIBarButtonSystemItemDone target:rootController action:@selector(onEdit:)];
    navController.navigationBar.topItem.rightBarButtonItem = editButton;
    
    [navController setWantsFullScreenLayout:YES];
    [navController.view setAutoresizesSubviews:NO];
    navController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    navController.visibleViewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    
    [self presentModalViewController:navController animated:YES];
    
    //[self.navigationController pushViewController:controller animated:YES];
}

#pragma mark UITableViewDataSource

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *MortgageRecordCell = @"MortgageRecordCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MortgageRecordCell];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:MortgageRecordCell];
    }
    NSUInteger row = [indexPath row];
    UITableViewController *controller = [m_controllerList objectAtIndex:row];
    cell.textLabel.text = controller.title;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return m_controllerList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

@end
