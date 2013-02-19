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
@synthesize m_mortgageItems;
@synthesize m_expenceItems;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setTitle:@"供款"];
        [self setM_mortgageItems:[[NSArray alloc] initWithObjects:
                                @"按揭成數",
                                @"按揭金額",
                                @"按揭利率",
                                @"按揭年限",
                                @"每月供款",
                                @"供款日期",
                                nil]];
        
        [self setM_expenceItems: [[NSArray alloc] initWithObjects:
                               @"首付金額",
                               @"印花稅",
                               @"代理佣金",
                               @"剩餘金額",
                               @"貸款利息",
                               @"總額",
                               nil]];
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
    [self setM_expenceItems:nil];
    [self setM_mortgageItems:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)onEdit:(id)sender{
    AddRecordViewController* rootController = [[AddRecordViewController alloc] init];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:rootController];
    
    navController.navigationBar.topItem.title = self.navigationController.navigationBar.topItem.title;
    navController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"存儲" style:UIBarButtonSystemItemDone target:self action:@selector(onChangeReocrd:)];
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

- (void)onChangeReocrd:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark
#pragma mark - UITableViewDlegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0)
        return 1;
    else if(section == 1)
        return m_mortgageItems.count;
    else if(section == 2)
        return m_expenceItems.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* MortgageRecordDetails = @"MortgageRecordDetails";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MortgageRecordDetails];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:MortgageRecordDetails];
    }
    if(indexPath.section == 0){
        cell.textLabel.text = @"物業價值";
        cell.detailTextLabel.text = @"value";
    }else if(indexPath.section == 1){
        cell.textLabel.text = [m_mortgageItems objectAtIndex:indexPath.row];
    }else if(indexPath.section == 2){
        cell.textLabel.text = [m_expenceItems objectAtIndex:indexPath.row];
    }
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    return cell;
}
@end
