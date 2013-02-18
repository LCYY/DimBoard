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

#pragma mark
#pragma mark - UITableViewDlegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    NSString *name = @"";
    NSString *unit = @"";
    double value = 100;
    if(section == 0){
        name = @"物業價值";
    }
    else if(section == 1){
        name = [m_mortgageItems objectAtIndex:row];
    }
    else if(section == 2){
        name = [m_expenceItems objectAtIndex:row];
    }
    EditNumberViewController * editController = [[EditNumberViewController alloc] initWithName:name Value:value Unit:unit];
    [self.navigationController pushViewController:editController animated:YES];
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
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    if(indexPath.section == 0){
        cell.textLabel.text = @"物業價值";
        cell.detailTextLabel.text = @"value";
    }else if(indexPath.section == 1){
        cell.textLabel.text = [m_mortgageItems objectAtIndex:indexPath.row];
    }else if(indexPath.section == 2){
        cell.textLabel.text = [m_expenceItems objectAtIndex:indexPath.row];
    }

    return cell;
}
@end
